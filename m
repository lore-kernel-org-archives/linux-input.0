From: Simon Wood <simon-wM4F9T/ekXmXDw4h08c5KA@public.gmane.org>
Subject: [RFC] HID: hid-sony: Add basic iio-subsystem reading of SixAxis Accelerometers
Date: Thu, 11 Jun 2015 08:54:18 -0600
Message-ID: <1434034458-1968-1-git-send-email-simon@mungewell.org>
References: <195dff9bd065db7e618280cb7c6eb5a9.squirrel@mungewell.org>
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <195dff9bd065db7e618280cb7c6eb5a9.squirrel-wM4F9T/ekXmXDw4h08c5KA@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Frank Praznik <frank.praznik-oKii7tqusJgAvxtiuMwx3w@public.gmane.org>, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Simon Wood <simon-wM4F9T/ekXmXDw4h08c5KA@public.gmane.org>
List-Id: linux-input@vger.kernel.org

[resent as I screwed up addressing... sorry]

This patch is a RFC/POC for the idea of using the iio-subsystem as the
'proper' way to communicate the state of motion enabled controllers to
the Linux internals.

I have started with the hid-sony driver, with support for the SixAxis's
3 Accelerometers. Proper trigger/buffer support will follow shortly, along
with support for the DS4 and PSMove controllers (which have a much more
extensive set of motion hardware).

Once the sensor data is available (over iio) I envision that it will be
considerably easier to write motion tracking, flight control and AHRS
software in a consistant manner.

Hopefully this will become the standard way of connecting controllers,
motion controls and head mounted displays.
---
 drivers/hid/hid-sony.c | 175 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 175 insertions(+)

diff --git a/drivers/hid/hid-sony.c b/drivers/hid/hid-sony.c
index 6ca96ce..79afae6 100644
--- a/drivers/hid/hid-sony.c
+++ b/drivers/hid/hid-sony.c
@@ -36,6 +36,7 @@
 #include <linux/list.h>
 #include <linux/idr.h>
 #include <linux/input/mt.h>
+#include <linux/iio/iio.h>
 
 #include "hid-ids.h"
 
@@ -54,6 +55,7 @@
 				DUALSHOCK4_CONTROLLER)
 #define SONY_BATTERY_SUPPORT (SIXAXIS_CONTROLLER | DUALSHOCK4_CONTROLLER)
 #define SONY_FF_SUPPORT (SIXAXIS_CONTROLLER | DUALSHOCK4_CONTROLLER)
+#define SONY_IIO_SUPPORT SIXAXIS_CONTROLLER
 
 #define MAX_LEDS 4
 
@@ -835,6 +837,23 @@ struct sony_sc {
 	__u8 led_delay_on[MAX_LEDS];
 	__u8 led_delay_off[MAX_LEDS];
 	__u8 led_count;
+
+#if IS_BUILTIN(CONFIG_IIO) || \
+	(IS_MODULE(CONFIG_IIO) && IS_MODULE(CONFIG_HID_SONY))
+	struct iio_dev *indio_dev;
+	__u16 last_acc[3];
+	__u16 last_gyro[3];
+};
+
+enum sony_iio_axis {
+	AXIS_X,
+	AXIS_Y,
+	AXIS_Z,
+};
+
+struct sony_iio {
+	struct sony_sc *sc;
+#endif
 };
 
 static __u8 *sixaxis_fixup(struct hid_device *hdev, __u8 *rdesc,
@@ -1047,6 +1066,12 @@ static int sony_raw_event(struct hid_device *hdev, struct hid_report *report,
 		swap(rd[45], rd[46]);
 		swap(rd[47], rd[48]);
 
+#if IS_BUILTIN(CONFIG_IIO) || \
+	(IS_MODULE(CONFIG_IIO) && IS_MODULE(CONFIG_HID_SONY))
+		sc->last_acc[0] = (rd[42] << 8) + rd[41];
+		sc->last_acc[1] = (rd[44] << 8) + rd[43];
+		sc->last_acc[2] = (rd[46] << 8) + rd[45];
+#endif
 		sixaxis_parse_report(sc, rd, size);
 	} else if (((sc->quirks & DUALSHOCK4_CONTROLLER_USB) && rd[0] == 0x01 &&
 			size == 64) || ((sc->quirks & DUALSHOCK4_CONTROLLER_BT)
@@ -1769,6 +1794,136 @@ static void sony_battery_remove(struct sony_sc *sc)
 	sc->battery_desc.name = NULL;
 }
 
+#if IS_BUILTIN(CONFIG_IIO) || \
+	(IS_MODULE(CONFIG_IIO) && IS_MODULE(CONFIG_HID_SONY))
+
+static int sony_iio_read_raw(struct iio_dev *indio_dev,
+			      struct iio_chan_spec const *chan,
+			      int *val, int *val2,
+			      long mask)
+{
+	struct sony_iio *data = iio_priv(indio_dev);
+	int ret;
+	u32 temp;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		switch (chan->type) {
+		case IIO_ACCEL:
+			*val = data->sc->last_acc[chan->scan_index];
+			return IIO_VAL_INT;
+		case IIO_ANGL_VEL:
+			*val = data->sc->last_gyro[chan->scan_index];
+			return IIO_VAL_INT;
+		default:
+			return -EINVAL;
+		}
+	case IIO_CHAN_INFO_SCALE:
+		switch (chan->type) {
+		case IIO_ACCEL:
+			*val = 1;
+			return IIO_VAL_INT;
+		case IIO_ANGL_VEL:
+			*val = 1;
+			return IIO_VAL_INT;
+		default:
+			return -EINVAL;
+		}
+	case IIO_CHAN_INFO_OFFSET:
+		switch (chan->type) {
+		case IIO_ACCEL:
+			*val = 512;
+			return IIO_VAL_INT;
+		case IIO_ANGL_VEL:
+			*val = 512;
+			return IIO_VAL_INT;
+		default:
+			return -EINVAL;
+		}
+	}
+
+	return -EINVAL;
+}
+
+#define SONY_ACC_CHANNEL(_axis) {					\
+	.type = IIO_ACCEL,						\
+	.modified = 1,							\
+	.channel2 = IIO_MOD_##_axis,					\
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),			\
+	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE) |		\
+		BIT(IIO_CHAN_INFO_SCALE) |				\
+		BIT(IIO_CHAN_INFO_OFFSET),				\
+	.scan_index = AXIS_##_axis,					\
+}
+
+#define SONY_GYRO_CHANNEL(_axis) {					\
+	.type = IIO_ANGL_VEL,						\
+	.modified = 1,							\
+	.channel2 = IIO_MOD_##_axis,					\
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),			\
+	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE) |		\
+		BIT(IIO_CHAN_INFO_SCALE) |				\
+		BIT(IIO_CHAN_INFO_OFFSET),				\
+	.scan_index = AXIS_##_axis,					\
+}
+
+static const struct iio_chan_spec sony_sixaxis_channels[] = {
+	SONY_ACC_CHANNEL(X),
+	SONY_ACC_CHANNEL(Y),
+	SONY_ACC_CHANNEL(Z),
+};
+
+static const struct iio_info sony_iio_info = {
+	.read_raw = &sony_iio_read_raw,
+	.driver_module = THIS_MODULE,
+};
+
+static int sony_iio_probe(struct sony_sc *sc)
+{
+	struct hid_device *hdev = sc->hdev;
+	struct iio_dev *indio_dev;
+	struct sony_iio *data;
+	int ret;
+
+	indio_dev = iio_device_alloc(sizeof(*data));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	sc->indio_dev = indio_dev;
+	data = iio_priv(indio_dev);
+	data->sc = sc;
+
+	indio_dev->dev.parent = &hdev->dev;
+	indio_dev->name = dev_name(&hdev->dev);
+	indio_dev->modes = INDIO_DIRECT_MODE;
+	indio_dev->info = &sony_iio_info;
+	indio_dev->channels = sony_sixaxis_channels;
+	indio_dev->num_channels = 3;
+
+	ret = iio_device_register(indio_dev);
+	if (ret < 0) {
+		hid_err(hdev, "Unable to register iio device\n");
+		goto error_iio_probe;
+	}
+	return 0;
+
+error_iio_probe:
+	kfree(indio_dev);
+	sc->indio_dev = NULL;
+	return ret;
+}
+
+static void sony_iio_remove(struct sony_sc *sc)
+{
+	if (!sc->indio_dev)
+		return;
+
+	iio_device_unregister(sc->indio_dev);
+	kfree(sc->indio_dev);
+	sc->indio_dev = NULL;
+}
+#endif
+
 /*
  * If a controller is plugged in via USB while already connected via Bluetooth
  * it will show up as two devices. A global list of connected controllers and
@@ -2073,6 +2228,15 @@ static int sony_probe(struct hid_device *hdev, const struct hid_device_id *id)
 		}
 	}
 
+#if IS_BUILTIN(CONFIG_IIO) || \
+	(IS_MODULE(CONFIG_IIO) && IS_MODULE(CONFIG_HID_SONY))
+	if (sc->quirks & SONY_IIO_SUPPORT) {
+		ret = sony_iio_probe(sc);
+		if (ret < 0)
+			goto err_stop;
+	}
+#endif
+
 	if (sc->quirks & SONY_FF_SUPPORT) {
 		ret = sony_init_ff(sc);
 		if (ret < 0)
@@ -2087,6 +2251,11 @@ err_stop:
 		sony_leds_remove(sc);
 	if (sc->quirks & SONY_BATTERY_SUPPORT)
 		sony_battery_remove(sc);
+#if IS_BUILTIN(CONFIG_IIO) || \
+	(IS_MODULE(CONFIG_IIO) && IS_MODULE(CONFIG_HID_SONY))
+	if (sc->quirks & SONY_IIO_SUPPORT)
+		sony_iio_remove(sc);
+#endif
 	sony_cancel_work_sync(sc);
 	kfree(sc->output_report_dmabuf);
 	sony_remove_dev_list(sc);
@@ -2107,6 +2276,12 @@ static void sony_remove(struct hid_device *hdev)
 		sony_battery_remove(sc);
 	}
 
+#if IS_BUILTIN(CONFIG_IIO) || \
+	(IS_MODULE(CONFIG_IIO) && IS_MODULE(CONFIG_HID_SONY))
+	if (sc->quirks & SONY_IIO_SUPPORT)
+		sony_iio_remove(sc);
+#endif
+
 	sony_cancel_work_sync(sc);
 
 	kfree(sc->output_report_dmabuf);
-- 
2.1.4
