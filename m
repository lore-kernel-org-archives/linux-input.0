From: Andrew Deason <adeason@dson.org>
Subject: [PATCH 1/2] Input: synaptics_usb - Improve stick movement
Date: Sun, 15 Sep 2013 16:01:53 -0500
Message-ID: <20130915160153.6eb671d7caf02218172109e7@dson.org>
References: <20130915155755.946c17243cc33d621245138f@dson.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ye0-f175.google.com ([209.85.213.175]:50338 "EHLO
	mail-ye0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753365Ab3IOVBz (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 15 Sep 2013 17:01:55 -0400
Received: by mail-ye0-f175.google.com with SMTP id q8so1381511yen.34
        for <linux-input@vger.kernel.org>; Sun, 15 Sep 2013 14:01:54 -0700 (PDT)
In-Reply-To: <20130915155755.946c17243cc33d621245138f@dson.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Currently, for the pointing stick, we receive some (x, y) coordinates
from the usb device, and report those directly as relative movement to
the input subsystem. However, in order to behave similarly to other
trackpoint devices, these values need to be interpreted as readings
from the force sensor, and translated into cursor movement.

With this commit, we take the force readings and run them through
roughly the same translation as described by the "TrackPoint System
Version 4.0 Engineering Specification" (available via
<http://blogs.epfl.ch/icenet/documents/Ykt3Eext.pdf> and probably
other places). This adds the sysfs attributes 'inertia',
'sensitivity', and 'speed' to the input device, which behave similarly
to the sysfs attributes in other trackpoint devices (where the
translation occurs in hardware).

Note that the information provided by the trackpoint spec is sometimes
vague, and it is not certain if all of it also applies to synaptics
devices with trackpoints. Some of the specific values provided in this
commit are guesses, and partly based on experimentation for what
"feels" like other trackpoint devices. Specifically, this was tested
with an IBM model SK-8835 (FRU 02R0400, vendor/product id 06cb:0009).
The cursor movement was compared to the movement with the same device
under HID mode, as well as an IBM PS/2 model RT3200 (FRU 37L0888) and
a T60 trackpoint.

Signed-off-by: Andrew Deason <adeason@dson.org>
---
 drivers/input/mouse/synaptics_usb.c | 377 +++++++++++++++++++++++++++++++++++-
 1 file changed, 371 insertions(+), 6 deletions(-)

diff --git a/drivers/input/mouse/synaptics_usb.c b/drivers/input/mouse/synaptics_usb.c
index 64cf34e..8571005 100644
--- a/drivers/input/mouse/synaptics_usb.c
+++ b/drivers/input/mouse/synaptics_usb.c
@@ -27,8 +27,8 @@
 /*
  * There are three different types of Synaptics USB devices: Touchpads,
  * touchsticks (or trackpoints), and touchscreens. Touchpads are well supported
- * by this driver, touchstick support has not been tested much yet, and
- * touchscreens have not been tested at all.
+ * by this driver, touchstick support is tested but still involves guesswork,
+ * and touchscreens have not been tested at all.
  *
  * Up to three alternate settings are possible:
  *	setting 0: one int endpoint for relative movement (used by usbhid.ko)
@@ -90,8 +90,350 @@ struct synusb {
 
 	/* characteristics of the device */
 	unsigned long flags;
+
+	/* pointing stick user-visible options */
+	unsigned int stick_inertia;
+	unsigned int stick_sensitivity;
+	unsigned int stick_speed;
+
+	/* pointing stick data; only used for SYNUSB_STICK */
+	int64_t stick_last_mag;
+	int64_t stick_accum_x;
+	int64_t stick_accum_y;
 };
 
+/* Much of the following code deals with converting trackpoint force readings
+ * into cursor movements. Some of the comments reference the trackpoint
+ * engineering spec, which is the "TrackPoint System Version 4.0 Engineering
+ * Specification", and is where many of the constants in this code come from.
+ * This document be found, amongst other places, at
+ * <http://blogs.epfl.ch/icenet/documents/Ykt3Eext.pdf>. */
+
+static ssize_t synusb_attr_stick_inertia_show(struct device *dev,
+		struct device_attribute *attr,
+		char *buf)
+{
+	struct usb_interface *intf = to_usb_interface(dev->parent);
+	struct synusb *synusb = usb_get_intfdata(intf);
+
+	return snprintf(buf, PAGE_SIZE, "%u\n",
+	                synusb->stick_inertia);
+}
+
+static ssize_t synusb_attr_stick_inertia_store(struct device *dev,
+		struct device_attribute *attr,
+		const char *buf,
+		size_t count)
+{
+	struct usb_interface *intf = to_usb_interface(dev->parent);
+	struct synusb *synusb = usb_get_intfdata(intf);
+	unsigned int value;
+
+	if (kstrtouint(buf, 10, &value) || value > 255)
+		return -EINVAL;
+
+	synusb->stick_inertia = value;
+
+	return count;
+}
+
+static ssize_t synusb_attr_stick_sensitivity_show(struct device *dev,
+		struct device_attribute *attr,
+		char *buf)
+{
+	struct usb_interface *intf = to_usb_interface(dev->parent);
+	struct synusb *synusb = usb_get_intfdata(intf);
+
+	return snprintf(buf, PAGE_SIZE, "%u\n",
+	                synusb->stick_sensitivity);
+}
+
+static ssize_t synusb_attr_stick_sensitivity_store(struct device *dev,
+		struct device_attribute *attr,
+		const char *buf,
+		size_t count)
+{
+	struct usb_interface *intf = to_usb_interface(dev->parent);
+	struct synusb *synusb = usb_get_intfdata(intf);
+	unsigned int value;
+
+	if (kstrtouint(buf, 10, &value) || value > 255)
+		return -EINVAL;
+
+	synusb->stick_sensitivity = value;
+
+	return count;
+}
+
+static ssize_t synusb_attr_stick_speed_show(struct device *dev,
+		struct device_attribute *attr,
+		char *buf)
+{
+	struct usb_interface *intf = to_usb_interface(dev->parent);
+	struct synusb *synusb = usb_get_intfdata(intf);
+
+	return snprintf(buf, PAGE_SIZE, "%u\n",
+	                synusb->stick_speed);
+}
+
+static ssize_t synusb_attr_stick_speed_store(struct device *dev,
+		struct device_attribute *attr,
+		const char *buf,
+		size_t count)
+{
+	struct usb_interface *intf = to_usb_interface(dev->parent);
+	struct synusb *synusb = usb_get_intfdata(intf);
+	unsigned int value;
+
+	if (kstrtouint(buf, 10, &value) || value > 255)
+		return -EINVAL;
+
+	synusb->stick_speed = value;
+
+	return count;
+}
+
+/* sysfs attribute "inertia": Negative inertia factor. Increasing this means
+ * negative inertia plays a bigger role. */
+static struct device_attribute synusb_attr_stick_inertia =
+	__ATTR(inertia, S_IWUSR | S_IRUGO,
+	       synusb_attr_stick_inertia_show,
+	       synusb_attr_stick_inertia_store);
+
+/* sysfs attribute "sensitivity": Pointing stick sensitivity. We take the force
+ * readings from the stick, and multiply by the sensitivity value and divide by
+ * 128. So, setting this to 255 means you need to push about half as hard to
+ * get the same result. */
+static struct device_attribute synusb_attr_stick_sensitivity =
+	__ATTR(sensitivity, S_IWUSR | S_IRUGO,
+	       synusb_attr_stick_sensitivity_show,
+	       synusb_attr_stick_sensitivity_store);
+
+/* sysfs attribute "speed": Speed factor, aka "value6" in the trackpoint spec.
+ * Increasing this means the cursor will move faster when the stick sees more
+ * force, but at milder forces the cursor speed is unaffected. */
+static struct device_attribute synusb_attr_stick_speed =
+	__ATTR(speed, S_IWUSR | S_IRUGO,
+	       synusb_attr_stick_speed_show,
+	       synusb_attr_stick_speed_store);
+
+static struct attribute *synusb_stick_attrs[] = {
+	&synusb_attr_stick_inertia.attr,
+	&synusb_attr_stick_sensitivity.attr,
+	&synusb_attr_stick_speed.attr,
+	NULL
+};
+
+static struct attribute_group synusb_stick_attr_group = {
+	.attrs = synusb_stick_attrs,
+};
+
+/* For various calculations of pointer stick movement, we need sub-integer
+ * precision. So, STICK_PRECISION is our fixed-point multiplier, in order to
+ * perform some calculations with such precision. */
+#define STICK_PRECISION 128
+#define STICK_FMT "%ld.%03d"
+#define STICK_FMT_VAL(x) (long)(x / STICK_PRECISION), ((int)(x % STICK_PRECISION)*1000/STICK_PRECISION)
+
+static int stick_debug;
+#define stick_dprintk(format, arg...) if (stick_debug) printk(KERN_DEBUG format, ##arg)
+
+/* This function approximates the "TrackPoint Transfer Function" on page 43 of
+ * the trackpoint spec, which appears to be a simple piecewise linear function.
+ * Many of these constants are eyeballed or guessed, and are partially based on
+ * experimentation to see what feels similar to a PS/2 trackpoint device. They
+ * may be wrong. */
+static int64_t
+stick_transfer_function(struct synusb *synusb, uint64_t magnitude)
+{
+	/* The transfer function has approximately 6 different segments. Some of
+	 * these segments are constant, and others depend on the "speed" parameter.
+	 * Here we provide some constants for the various segments, which are
+	 * largely determined by looking at the trackpoint transfer function graph. */
+	static const int64_t STICK_XFER_0_X = 15 * STICK_PRECISION;
+	static const int64_t STICK_XFER_0_Y = 0;
+
+	static const int64_t STICK_XFER_1_X = 35 * STICK_PRECISION;
+	static const int64_t STICK_XFER_1_Y = 10 * STICK_PRECISION;
+
+	static const int64_t STICK_XFER_2_X = 55 * STICK_PRECISION;
+	static const int64_t STICK_XFER_2_Y = 22 * STICK_PRECISION;
+
+	static const int64_t STICK_XFER_3_X = 85 * STICK_PRECISION;
+
+	static const int64_t STICK_XFER_4_X = 115 * STICK_PRECISION;
+
+	int64_t slope;
+	int64_t yint;
+	int64_t plateau;
+	int64_t result;
+	int sect;
+
+	magnitude = magnitude * synusb->stick_sensitivity / 128;
+	stick_dprintk("post-sensitivity mag "STICK_FMT"\n", STICK_FMT_VAL(magnitude));
+
+	slope = 0;
+
+	if (magnitude < STICK_XFER_2_X) {
+		/* These lower ranges don't need to know the value of 'plateau'. */
+		if (magnitude < STICK_XFER_0_X) {
+			yint = STICK_XFER_0_Y;
+			sect = 0;
+
+		} else if (magnitude < STICK_XFER_1_X) {
+			yint = STICK_XFER_1_Y;
+			sect = 1;
+
+		} else {
+			yint = STICK_XFER_2_Y;
+			sect = 2;
+		}
+	} else {
+		/* Calculate the value of the plateau speed, from page 24 of the
+		 * trackpoint spec.
+		 * plateau = 22 + 4.3 * value6 */
+		plateau = 22*STICK_PRECISION + synusb->stick_speed * STICK_PRECISION * 43 / 10;
+
+		if (magnitude < STICK_XFER_3_X) {
+			/* Calculate the slope and y-intercept of a line going through the points
+			 * (STICK_XFER_2_X, STICK_XFER_2_Y) and (STICK_XFER_3_X, plateau)
+			 */
+			slope = STICK_PRECISION * (plateau - STICK_XFER_2_Y) / (STICK_XFER_3_X - STICK_XFER_2_X);
+			yint = STICK_XFER_2_Y - STICK_XFER_2_X / STICK_PRECISION * slope;
+			sect = 3;
+
+		} else if (magnitude < STICK_XFER_4_X) {
+			yint = plateau;
+			sect = 4;
+
+		} else {
+			/* Use the same slope as segment 3, but go through the point
+			 * (STICK_XFER_4_X, plateau) */
+			slope = STICK_PRECISION * (plateau - STICK_XFER_2_Y) / (STICK_XFER_3_X - STICK_XFER_2_X);
+			yint = plateau - STICK_XFER_4_X / STICK_PRECISION * slope;
+			sect = 5;
+		}
+	}
+
+	result = slope * magnitude / STICK_PRECISION + yint;
+	stick_dprintk("               slope "STICK_FMT"\n", STICK_FMT_VAL(slope));
+	stick_dprintk("      xfer func sect %d\n", sect);
+	stick_dprintk("           magnitude "STICK_FMT" -> "STICK_FMT"\n",
+	              STICK_FMT_VAL(magnitude),
+	              STICK_FMT_VAL(result));
+
+	return result;
+}
+
+static void
+synusb_stick_calculate_xy(struct synusb *synusb, int x, int y, int *a_x, int *a_y)
+{
+	int64_t magnitude;
+	int64_t magnitude_raw;
+	int64_t scale;
+	int64_t x_rate, y_rate;
+	int64_t x_grams, y_grams;
+
+	stick_dprintk("======================\n");
+	stick_dprintk("  raw stick reading (%d, %d)\n", x, y);
+
+	/* According to the trackpoint spec on page 6, each unit from the force
+	 * sensor is 0.8 grams. That seems to be roughly correct for here. */
+	x_grams = x * STICK_PRECISION * 4 / 5;
+	y_grams = y * STICK_PRECISION * 4 / 5;
+
+	stick_dprintk("              grams ("STICK_FMT", "STICK_FMT")\n", STICK_FMT_VAL(x_grams), STICK_FMT_VAL(y_grams));
+
+	/* First, get the magnitude of our input vector (x, y). */
+	magnitude_raw = int_sqrt(x_grams*x_grams + y_grams*y_grams);
+	magnitude = magnitude_raw;
+	stick_dprintk("           input mag "STICK_FMT"\n", STICK_FMT_VAL(magnitude_raw));
+
+
+	if (magnitude_raw == 0) {
+		/* If our input is 0, our output is definitely zero. (Even if applying
+		 * negative inertia to the input of the transfer function yields a
+		 * nonzero magnitude, applying negative inertia to the output of the
+		 * transfer function would yield a resultant magnitude of 0 anyway; try
+		 * calculating it yourself and see.) This needs to be addressed as a
+		 * special case in order to avoid dividing by zero when applying negative
+		 * inertia to the output of the transfer function. Skip some processing
+		 * while we're at it, since any further calculations are useless, since
+		 * we know the outcome. */
+		x = 0;
+		y = 0;
+
+	} else {
+		/* Apply negative inertia to the pre-transfer-function magnitude, from
+		 * page 44 of the trackpoint spec.
+		 * magnitude += I * (Z_1 - Z_0) */
+		magnitude += synusb->stick_inertia * (magnitude_raw - synusb->stick_last_mag);
+
+		stick_dprintk("        previous mag "STICK_FMT"\n", STICK_FMT_VAL(synusb->stick_last_mag));
+		stick_dprintk(" post-inertia in mag "STICK_FMT"\n", STICK_FMT_VAL(magnitude));
+
+		/* Apply the transfer function. It's possible to get a negative magnitude
+		 * here from the negative inertia function above. Normally that would give
+		 * us a result of 0 from the transfer function, since we're in the dead
+		 * zone. However, this seems to mean that instead the cursor should be
+		 * "pushed" back in the opposite direction. So take the absolute value of
+		 * the magnitude, apply the transfer function, and negate the result. */
+		if (magnitude < 0) {
+			magnitude = -1 * stick_transfer_function(synusb, -1 * magnitude);
+		} else {
+			magnitude = stick_transfer_function(synusb, magnitude);
+		}
+
+		BUG_ON(magnitude_raw == 0);
+
+		/* Apply negative inertia to the output of the transfer function, from
+		 * page 44 of the trackpoint spec.
+		 * magnitude *= 1/(1 + I*(1 - Z_0/Z_1)) */
+		magnitude = STICK_PRECISION * magnitude /
+		            (STICK_PRECISION + synusb->stick_inertia *
+		                                   (STICK_PRECISION - STICK_PRECISION * synusb->stick_last_mag / magnitude_raw));
+
+		/* How much do we scale our x and y components by in order to to achieve
+		 * a magnitude of 'magnitude' ?  */
+		scale = STICK_PRECISION * magnitude / magnitude_raw;
+
+		stick_dprintk("post-inertia out mag "STICK_FMT"\n", STICK_FMT_VAL(magnitude));
+		stick_dprintk("               scale "STICK_FMT"\n", STICK_FMT_VAL(scale));
+
+		x_rate = x_grams * scale / STICK_PRECISION;
+		y_rate = y_grams * scale / STICK_PRECISION;
+		/* x_rate and y_rate are now in units of mickeys per second, in fixed-point. */
+
+		stick_dprintk("       scaled coords ("STICK_FMT", "STICK_FMT") mickeys per sec\n", STICK_FMT_VAL(x_rate), STICK_FMT_VAL(y_rate));
+
+		/* Convert from 'mickeys per second' to 'mickeys per 10ms' */
+		x_rate = x_rate / 100;
+		y_rate = y_rate / 100;
+
+		stick_dprintk("       scaled coords ("STICK_FMT", "STICK_FMT") mickeys per 10ms\n", STICK_FMT_VAL(x_rate), STICK_FMT_VAL(y_rate));
+
+		synusb->stick_accum_x += x_rate;
+		synusb->stick_accum_y += y_rate;
+
+		/* Pull out a whole number from the accumulator, if a whole number has
+		 * built up. */
+		x = synusb->stick_accum_x / STICK_PRECISION;
+		y = synusb->stick_accum_y / STICK_PRECISION;
+
+		synusb->stick_accum_x -= x * STICK_PRECISION;
+		synusb->stick_accum_y -= y * STICK_PRECISION;
+	}
+
+	stick_dprintk("   reporting coords (%d, %d)\n", x, y);
+	stick_dprintk("              accum ("STICK_FMT", "STICK_FMT")\n",
+	              STICK_FMT_VAL(synusb->stick_accum_x), STICK_FMT_VAL(synusb->stick_accum_y));
+
+	synusb->stick_last_mag = magnitude_raw;
+
+	*a_x = x;
+	*a_y = y;
+}
+
 static void synusb_report_buttons(struct synusb *synusb)
 {
 	struct input_dev *input_dev = synusb->input;
@@ -108,12 +450,17 @@ static void synusb_report_stick(struct synusb *synusb)
 	unsigned int pressure;
 
 	pressure = synusb->data[6];
-	x = (s16)(be16_to_cpup((__be16 *)&synusb->data[2]) << 3) >> 7;
-	y = (s16)(be16_to_cpup((__be16 *)&synusb->data[4]) << 3) >> 7;
+	x = (s16)(be16_to_cpup((__be16 *)&synusb->data[2]) << 3) >> 3;
+	y = (s16)(be16_to_cpup((__be16 *)&synusb->data[4]) << 3) >> 3;
 
-	if (pressure > 0) {
+	/* Synaptics gives us the y axis such that positive is up, and negative
+	 * is down. We want positive y axis to be down, and negative to be up. */
+	y *= -1;
+
+	synusb_stick_calculate_xy(synusb, x, y, &x, &y);
+	if (x || y) {
 		input_report_rel(input_dev, REL_X, x);
-		input_report_rel(input_dev, REL_Y, -y);
+		input_report_rel(input_dev, REL_Y, y);
 	}
 
 	input_report_abs(input_dev, ABS_PRESSURE, pressure);
@@ -422,8 +769,20 @@ static int synusb_probe(struct usb_interface *intf,
 		goto err_stop_io;
 	}
 
+	if (synusb->flags & SYNUSB_STICK) {
+		synusb->stick_inertia = 6;
+		synusb->stick_sensitivity = 128;
+		synusb->stick_speed = 97;
+
+		error = sysfs_create_group(&synusb->input->dev.kobj, &synusb_stick_attr_group);
+		if (error)
+			goto err_unregister_device;
+	}
+
 	return 0;
 
+err_unregister_device:
+	input_unregister_device(input_dev);
 err_stop_io:
 	if (synusb->flags & SYNUSB_IO_ALWAYS)
 		synusb_close(synusb->input);
@@ -445,6 +804,9 @@ static void synusb_disconnect(struct usb_interface *intf)
 	struct synusb *synusb = usb_get_intfdata(intf);
 	struct usb_device *udev = interface_to_usbdev(intf);
 
+	if (synusb->flags & SYNUSB_STICK)
+		sysfs_remove_group(&synusb->input->dev.kobj, &synusb_stick_attr_group);
+
 	if (synusb->flags & SYNUSB_IO_ALWAYS)
 		synusb_close(synusb->input);
 
@@ -555,3 +917,6 @@ MODULE_AUTHOR("Rob Miller <rob@inpharmatica.co.uk>, "
               "Jan Steinhoff <cpad@jan-steinhoff.de>");
 MODULE_DESCRIPTION("Synaptics USB device driver");
 MODULE_LICENSE("GPL");
+
+module_param(stick_debug, int, 0644);
+MODULE_PARM_DESC(stick_debug, "Activate pointing stick movement debugging output");
-- 
1.8.4.rc3

