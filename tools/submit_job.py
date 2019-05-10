import os
import sys

import boto3

from time import sleep

BATCH_SUCCESSFUL_STATUS = 'SUCCEEDED'
BATCH_FAILURE_STATUS = 'FAILED'
BATCH_PROCESSED_STATUSES = [BATCH_FAILURE_STATUS, BATCH_SUCCESSFUL_STATUS]

batch_client = boto3.client('batch', region_name=os.getenv('AWS_REGION', 'eu-west-2'))


def print_status(current_status, count):
    progress = '.' * count

    sys.stdout.write('Batch status: %s\n' % current_status.ljust(10))
    sys.stdout.write('%s' % progress)
    sys.stdout.write('\r\033[F')
    sys.stdout.flush()


def submit_job():
    env = os.environ['ENVIRONMENT']
    res = batch_client.submit_job(
        jobName='run-database-migrations',
        # These parameters would need to be dynamic based on a passed environment
        jobDefinition='{}-batch-database-migration-job-definition'.format(env),
        jobQueue='{}-batch-job-queue'.format(env)
    )
    job_id = res['jobId']
    count = 0
    current_status = ''

    while count < 150 and current_status not in BATCH_PROCESSED_STATUSES:
        current_status = get_job_status(job_id)
        count += 1
        print_status(current_status, count)
        sleep(10)

    sys.stdout.write('\n\nJob Complete!\n')

    return current_status


def get_job_status(job_id):
    res = batch_client.describe_jobs(jobs=[job_id])
    return res['jobs'][0]['status']


if __name__ == '__main__':
    status = submit_job()

    if status == BATCH_FAILURE_STATUS:
        sys.exit(1)
