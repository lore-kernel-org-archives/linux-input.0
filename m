From: Srinivas Pandruvada <srinivas.pandruvada-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [PATCH v2 0/2] hid: sensor-hub: Enhance feature report APIs
Date: Fri, 16 Jan 2015 16:39:23 -0800
Message-ID: <1421455165-3944-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: jkosina-AlSwsSmVLrQ@public.gmane.org, jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Cc: linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, borneo.antonio-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, Srinivas Pandruvada <srinivas.pandruvada-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Id: linux-input@vger.kernel.org

Current get and set feature report is enhanced to have multiple
values in get and set.

v2
As suggested by Antonio Borneo, using DIV_ROUND_UP

v1
Squashed into two patches one for get and one for set feature report
for bisectability.

v0
Separate patches for each driver/modules

Srinivas Pandruvada (2):
  HID: hid-sensor-hub: Enhance get feature report API
  HID: hid-sensor-hub: Enhance feature report set API

 drivers/hid/hid-sensor-hub.c                       | 37 +++++++++++++++++++---
 .../iio/common/hid-sensors/hid-sensor-attributes.c | 24 +++++++-------
 .../iio/common/hid-sensors/hid-sensor-trigger.c    | 13 ++++----
 include/linux/hid-sensor-hub.h                     | 13 +++++---
 4 files changed, 60 insertions(+), 27 deletions(-)

-- 
1.9.1
