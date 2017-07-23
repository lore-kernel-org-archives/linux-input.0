From: Jonathan Cameron <Jonathan.Cameron-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 37/45] input: tsc2007 - drop the driver_module assignment in iio interface.
Date: Sun, 23 Jul 2017 17:26:19 +0100
Message-ID: <20170723162627.22534-38-Jonathan.Cameron@huawei.com>
References: <20170723162627.22534-1-Jonathan.Cameron@huawei.com>
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170723162627.22534-1-Jonathan.Cameron-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Linux Input <linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Jonathan Cameron <Jonathan.Cameron-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
List-Id: linux-input@vger.kernel.org

From: Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>

This is now handled via some macro magic during the register.  The
field in iio_info will be removed shortly.

Cc: Linux Input <linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
Acked-by: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/input/touchscreen/tsc2007_iio.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/input/touchscreen/tsc2007_iio.c b/drivers/input/touchscreen/tsc2007_iio.c
index 27b25a9fce83..e27a956f5f2b 100644
--- a/drivers/input/touchscreen/tsc2007_iio.c
+++ b/drivers/input/touchscreen/tsc2007_iio.c
@@ -104,7 +104,6 @@ static int tsc2007_read_raw(struct iio_dev *indio_dev,
 
 static const struct iio_info tsc2007_iio_info = {
 	.read_raw = tsc2007_read_raw,
-	.driver_module = THIS_MODULE,
 };
 
 int tsc2007_iio_configure(struct tsc2007 *ts)
-- 
2.13.3
