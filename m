From: Simon Wood <simon-wM4F9T/ekXmXDw4h08c5KA@public.gmane.org>
Subject: [RFC_v2 2/4] HID: hid-sony: Add IIO buffer support for SixAxis Controller
Date: Tue, 23 Jun 2015 18:30:28 -0600
Message-ID: <1435105830-2297-3-git-send-email-simon@mungewell.org>
References: <1435105830-2297-1-git-send-email-simon@mungewell.org>
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1435105830-2297-1-git-send-email-simon-wM4F9T/ekXmXDw4h08c5KA@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Frank Praznik <frank.praznik-oKii7tqusJgAvxtiuMwx3w@public.gmane.org>, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Simon Wood <simon-wM4F9T/ekXmXDw4h08c5KA@public.gmane.org>
List-Id: linux-input@vger.kernel.org

---
 drivers/hid/hid-sony.c | 50 +++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 47 insertions(+), 3 deletions(-)

diff --git a/drivers/hid/hid-sony.c b/drivers/hid/hid-sony.c
index c4686e3..b7a7f0d 100644
--- a/drivers/hid/hid-sony.c
+++ b/drivers/hid/hid-sony.c
@@ -37,6 +37,11 @@
 #include <linux/idr.h>
 #include <linux/input/mt.h>
 #include <linux/iio/iio.h>
+#include <linux/iio/sysfs.h>
+#include <linux/iio/buffer.h>
+#include <linux/iio/trigger_consumer.h>
+#include <linux/iio/triggered_buffer.h>
+#include <linux/interrupt.h>
 
 #include "hid-ids.h"
 
@@ -852,6 +857,7 @@ enum sony_iio_axis {
 
 struct sony_iio {
 	struct sony_sc *sc;
+	u8 buff[16];		/* 3x 16-bit + padding + timestamp */
 #endif
 };
 
@@ -861,6 +867,7 @@ static __u8 *sixaxis_fixup(struct hid_device *hdev, __u8 *rdesc,
 	*rsize = sizeof(sixaxis_rdesc);
 	return sixaxis_rdesc;
 }
+
 static __u8 *ps3remote_fixup(struct hid_device *hdev, __u8 *rdesc,
 			     unsigned int *rsize)
 {
@@ -1841,12 +1848,20 @@ static int sony_iio_read_raw(struct iio_dev *indio_dev,
 	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE) |          \
 		BIT(IIO_CHAN_INFO_OFFSET),                              \
 	.address = AXIS_ACC_##_axis,                                    \
+	.scan_index = AXIS_ACC_##_axis,                                 \
+	.scan_type = {                                                  \
+		.sign = 's',                                            \
+		.realbits = 16,                                         \
+		.storagebits = 16,                                      \
+		.shift = 0,                                             \
+	},                                                              \
 }
 
 static const struct iio_chan_spec sony_sixaxis_channels[] = {
 	SONY_ACC_CHANNEL(X),
 	SONY_ACC_CHANNEL(Y),
 	SONY_ACC_CHANNEL(Z),
+	IIO_CHAN_SOFT_TIMESTAMP(3),
 };
 
 static const struct iio_info sony_iio_info = {
@@ -1854,6 +1869,25 @@ static const struct iio_info sony_iio_info = {
 	.driver_module = THIS_MODULE,
 };
 
+static irqreturn_t sony_iio_trigger_handler(int irq, void *p)
+{
+	struct iio_poll_func *pf = p;
+	struct iio_dev *indio_dev = pf->indio_dev;
+	struct sony_iio *data = iio_priv(indio_dev);
+	int64_t time_ns = iio_get_time_ns();
+	int bit, i = 0;
+
+	for_each_set_bit(bit, indio_dev->active_scan_mask,
+			 indio_dev->masklength) {
+		((u16 *)data->buff)[i++] = data->sc->last_data[bit];
+	}
+
+	iio_push_to_buffers_with_timestamp(indio_dev, data->buff, time_ns);
+	iio_trigger_notify_done(indio_dev->trig);
+
+	return IRQ_HANDLED;
+}
+
 static int sony_iio_probe(struct sony_sc *sc)
 {
 	struct hid_device *hdev = sc->hdev;
@@ -1871,18 +1905,27 @@ static int sony_iio_probe(struct sony_sc *sc)
 
 	indio_dev->dev.parent = &hdev->dev;
 	indio_dev->name = dev_name(&hdev->dev);
-	indio_dev->modes = INDIO_DIRECT_MODE;
+	indio_dev->modes = INDIO_DIRECT_MODE | INDIO_BUFFER_TRIGGERED;
 	indio_dev->info = &sony_iio_info;
 	indio_dev->channels = sony_sixaxis_channels;
-	indio_dev->num_channels = 3;
+	indio_dev->num_channels = ARRAY_SIZE(sony_sixaxis_channels);
+
+	ret = iio_triggered_buffer_setup(indio_dev, NULL,
+			sony_iio_trigger_handler, NULL);
+	if (ret < 0) {
+		dev_err(&hdev->dev, "unable to setup iio triggered buffer\n");
+		goto err;
+	}
 
 	ret = iio_device_register(indio_dev);
 	if (ret < 0) {
 		hid_err(hdev, "Unable to register iio device\n");
-		goto err;
+		goto err_buffer_cleanup;
 	}
 	return 0;
 
+err_buffer_cleanup:
+	iio_triggered_buffer_cleanup(indio_dev);
 err:
 	kfree(indio_dev);
 	sc->indio_dev = NULL;
@@ -1895,6 +1938,7 @@ static void sony_iio_remove(struct sony_sc *sc)
 		return;
 
 	iio_device_unregister(sc->indio_dev);
+	iio_triggered_buffer_cleanup(sc->indio_dev);
 	kfree(sc->indio_dev);
 	sc->indio_dev = NULL;
 }
-- 
2.1.4
