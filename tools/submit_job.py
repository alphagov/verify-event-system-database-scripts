import os
import sys

import boto3

from time import sleep

BATCH_SUCCESSFUL_STATUS = 'SUCCEEDED'
BATCH_FAILURE_STATUS = 'FAILED'
BATCH_RUNNING_STATUS = 'RUNNING'

BATCH_PROCESSED_STATUSES = [BATCH_FAILURE_STATUS, BATCH_SUCCESSFUL_STATUS]

batch_client = boto3.client('batch', region_name=os.getenv('AWS_REGION', 'eu-west-2'))


def print_status(current_status, count):
    progress = '.' * count

    sys.stdout.write('Batch status: %s\n' % current_status.ljust(10))
    sys.stdout.write('%s' % progress)
    sys.stdout.write('\r\033[F')
    sys.stdout.flush()


def ok_to_continue(env):
    res = batch_client.list_jobs(
        jobStatus=BATCH_RUNNING_STATUS,
        jobQueue='{}-batch-job-queue'.format(env)
    )

    job_id = None
    for job in res['jobSummaryList']:
        if job['jobName'] == 'run-database-migrations':
            job_id = job['jobId']

    if job_id:
        sys.stdout.write('Waiting for previous job with ID %s to complete\n' % job_id)
        return wait_for_job(job_id) in BATCH_PROCESSED_STATUSES
    else:
        return True


def submit_job(env):
    res = batch_client.submit_job(
        jobName='run-database-migrations',
        jobDefinition='{}-batch-database-migration-job-definition'.format(env),
        jobQueue='{}-batch-job-queue'.format(env)
    )
    job_id = res['jobId']

    return wait_for_job(job_id)


def wait_for_job(job_id):
    count = 0
    current_status = ''

    while count < 150 and current_status not in BATCH_PROCESSED_STATUSES:
        current_status = get_job_status(job_id)
        count += 1
        print_status(current_status, count)
        sleep(10)

    return current_status


def get_job_status(job_id):
    res = batch_client.describe_jobs(jobs=[job_id])
    return res['jobs'][0]['status']


if __name__ == '__main__':
    environment = os.environ['ENVIRONMENT']

    if not ok_to_continue(environment):
        sys.stdout.write('\n\nJob cannot continue due to previous job still running!\n')
        sys.exit(1)
    else:
        status = submit_job(environment)

        if status != BATCH_SUCCESSFUL_STATUS:
            sys.stdout.write('\n\nJob did not complete with successful status!\n')

            sys.exit(1)

        sys.stdout.write('\n\nJob Complete!\n')
