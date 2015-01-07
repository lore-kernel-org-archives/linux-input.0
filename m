From: Srinivas Pandruvada <srinivas.pandruvada-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [PATCH 0/2] Core driver enhancements
Date: Wed,  7 Jan 2015 10:24:09 -0800
Message-ID: <1420655051-6587-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: jkosina-AlSwsSmVLrQ@public.gmane.org, jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Cc: linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Srinivas Pandruvada <srinivas.pandruvada-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Id: linux-input@vger.kernel.org

Enhance core to support next generation of hub devices for fast response
and fusion sensors.

Srinivas Pandruvada (2):
  HID: hid-sensor-hub: Allow parallel synchronous reads
  HID: hid-sensor-hub: Add collection device

 drivers/hid/hid-sensor-hub.c   | 140 +++++++++++++++++++++++++----------------
 include/linux/hid-sensor-hub.h |  24 +++++++
 include/linux/hid-sensor-ids.h |   2 +
 3 files changed, 113 insertions(+), 53 deletions(-)

-- 
1.9.3
