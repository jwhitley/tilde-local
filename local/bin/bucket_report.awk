#!/usr/bin/env awk -f
#
# Usage:
#
# s3cmd la | bucket_report.awk
#
# Produces a report of space used on S3, listing storage used per-bucket and a total
{
  if (NF>3) {
    split($4,ary,"(s3:/)?/");
    bucket[ary[2]] += $3;
  }
}
END {
  for (i in bucket) {
    printf("%40s:\t%8d\n", i, bucket[i]/1000000);
    sum += bucket[i]
  }
  printf("\ntotal (MiB): %8d\n", sum/1000000);
}

