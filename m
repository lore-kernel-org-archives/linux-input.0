From: SF Markus Elfring <elfring-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Subject: [PATCH 0/7] HID: Fine-tuning for some function implementations
Date: Mon, 24 Apr 2017 22:12:50 +0200
Message-ID: <2d526d72-a740-367b-04a9-ed698435f8ed@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Language: en-GB
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Benjamin Tissoires <benjamin.tissoires-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, =?UTF-8?Q?Bruno_Pr=c3=a9mont?= <bonbons-ud5FBsm0p/xEiooADzr8i9i2O/JbrIOy@public.gmane.org>, Henrik Rydberg <rydberg-FFUHeuDi6mxAfugRpC6u6w@public.gmane.org>, Jiri Kosina <jikos-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Srinivas Pandruvada <srinivas.pandruvada-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, kernel-janitors-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

From: Markus Elfring <elfring-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Date: Mon, 24 Apr 2017 22:00:22 +0200

Some update suggestions were taken into account
from static source code analysis.

Markus Elfring (7):
  Use devm_kcalloc() in sensor_hub_probe()
  Delete error messages for failed memory allocations in sensor_hub_probe()
  Adjust two checks for null pointers in sensor_hub_probe()
  Replace five seq_printf() calls by seq_putc()
  Replace 12 seq_printf() calls by seq_puts()
  Combine two seq_printf() calls into one call in hid_dump_device()
  Replace two seq_printf() calls by seq_puts() in picolcd_debug_reset_show()

 drivers/hid/hid-debug.c           | 38 +++++++++++++++++++-------------------
 drivers/hid/hid-picolcd_debugfs.c |  4 ++--
 drivers/hid/hid-sensor-hub.c      | 18 ++++++++----------
 3 files changed, 29 insertions(+), 31 deletions(-)

-- 
2.12.2
