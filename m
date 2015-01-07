From: Srinivas Pandruvada <srinivas.pandruvada-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [PATCH 0/4] Enhance feature report APIs
Date: Wed,  7 Jan 2015 10:31:44 -0800
Message-ID: <1420655508-6736-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: jkosina-AlSwsSmVLrQ@public.gmane.org, jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Cc: linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Srinivas Pandruvada <srinivas.pandruvada-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Id: linux-input@vger.kernel.org

Current get and set feature report is enhanced to have multiple
values in get and set.

Srinivas Pandruvada (4):
  HID: hid-sensor-hub: Enhance feature report API
  iio: hid_sensor_hub: update parameters to get feature report
  HID: hid-sensor-hub: Enhance feature report set API
  iio: hid_sensor_hub: update parameters to set feature report

 drivers/hid/hid-sensor-hub.c                       | 38 +++++++++++++++++++---
 .../iio/common/hid-sensors/hid-sensor-attributes.c | 24 +++++++-------
 .../iio/common/hid-sensors/hid-sensor-trigger.c    | 13 ++++----
 include/linux/hid-sensor-hub.h                     | 13 +++++---
 4 files changed, 61 insertions(+), 27 deletions(-)

-- 
1.9.3
