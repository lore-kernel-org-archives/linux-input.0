From: Benjamin Tissoires <benjamin.tissoires-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 0/2] more quirks for hid-sensor-hub
Date: Fri, 25 Nov 2016 11:03:42 +0100
Message-ID: <1480068224-32224-1-git-send-email-benjamin.tissoires@redhat.com>
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jiri Kosina <jikos-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Srinivas Pandruvada <srinivas.pandruvada-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

Hi Jiri,

here are 2 more quirks for the sensor-hub.

Srinivas, I am wondering if we can not detect those automatically.
Looking at the report_fixup, it looks like the buggy report descriptors have
a logical max of 5 (which would correspond to an enum of 0 to 5). But there
are 6 fields in the enum, so that means the report descriptor is just wrong.

Given that Microsoft's driver requires a min of 1, wouldn't it be too much
assumption to say that we need to fix the report descriptor anyway when we
see a range of 0..5 instead of 1..6?

Cheers,
Benjamin

Benjamin Tissoires (2):
  HID: sensor-hub add quirk for Microsoft Surface 3
  HID: sensor-hub: add quirk for Microchip MM7150

 drivers/hid/hid-sensor-hub.c | 6 ++++++
 1 file changed, 6 insertions(+)

-- 
2.7.4
