From: SF Markus Elfring <elfring-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Subject: [PATCH 7/7] HID: picoLCD: Replace two seq_printf() calls by
 seq_puts() in picolcd_debug_reset_show()
Date: Mon, 24 Apr 2017 22:23:02 +0200
Message-ID: <ceee0ae6-fd37-66b6-116a-319f5e393327@users.sourceforge.net>
References: <2d526d72-a740-367b-04a9-ed698435f8ed@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <2d526d72-a740-367b-04a9-ed698435f8ed-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Language: en-GB
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Benjamin Tissoires <benjamin.tissoires-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, =?UTF-8?Q?Bruno_Pr=c3=a9mont?= <bonbons-ud5FBsm0p/xEiooADzr8i9i2O/JbrIOy@public.gmane.org>, Henrik Rydberg <rydberg-FFUHeuDi6mxAfugRpC6u6w@public.gmane.org>, Jiri Kosina <jikos-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Srinivas Pandruvada <srinivas.pandruvada-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, kernel-janitors-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

From: Markus Elfring <elfring-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Date: Mon, 24 Apr 2017 21:27:42 +0200

Strings which did not contain data format specifications should be put
into a sequence. Thus use the corresponding function "seq_puts".

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
---
 drivers/hid/hid-picolcd_debugfs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/hid-picolcd_debugfs.c b/drivers/hid/hid-picolcd_debugfs.c
index 3e0feb4bb538..975f36601d59 100644
--- a/drivers/hid/hid-picolcd_debugfs.c
+++ b/drivers/hid/hid-picolcd_debugfs.c
@@ -33,9 +33,9 @@
 static int picolcd_debug_reset_show(struct seq_file *f, void *p)
 {
 	if (picolcd_fbinfo((struct picolcd_data *)f->private))
-		seq_printf(f, "all fb\n");
+		seq_puts(f, "all fb\n");
 	else
-		seq_printf(f, "all\n");
+		seq_puts(f, "all\n");
 	return 0;
 }
 
-- 
2.12.2
