From: SF Markus Elfring <elfring-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Subject: [PATCH 6/7] HID: debug: Combine two seq_printf() calls into one call
 in hid_dump_device()
Date: Mon, 24 Apr 2017 22:22:07 +0200
Message-ID: <0364de83-2ff2-3309-ec38-1e4db66d8231@users.sourceforge.net>
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
Date: Mon, 24 Apr 2017 21:07:52 +0200

A bit of data was put into a sequence by two separate function calls.
Print the same data by a single function call instead.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
---
 drivers/hid/hid-debug.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/hid/hid-debug.c b/drivers/hid/hid-debug.c
index ce850f80d9e3..1e8ac6e569a2 100644
--- a/drivers/hid/hid-debug.c
+++ b/drivers/hid/hid-debug.c
@@ -646,8 +646,7 @@ void hid_dump_device(struct hid_device *device, struct seq_file *f)
 			seq_printf(f, "%s", table[i]);
 			if (report->id)
 				seq_printf(f, "(%d)", report->id);
-			seq_printf(f, "[%s]", table[report->type]);
-			seq_printf(f, "\n");
+			seq_printf(f, "[%s]\n", table[report->type]);
 			for (k = 0; k < report->maxfield; k++) {
 				tab(4, f);
 				seq_printf(f, "Field(%d)\n", k);
-- 
2.12.2
