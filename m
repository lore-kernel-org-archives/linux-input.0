From: Pavel Machek <pavel@ucw.cz>
Subject: Re: Turn Sony motion controller into RGB led
Date: Fri, 24 Apr 2015 15:51:47 +0200
Message-ID: <20150424135147.GA13750@amd>
References: <20150314191917.GA3680@amd>
 <alpine.LNX.2.00.1503161354310.25438@pobox.suse.cz>
 <20150316130547.GA20976@amd>
 <20150409212536.GA1440@amd>
 <55271A53.6080505@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:49971 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751702AbbDXNvz (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 24 Apr 2015 09:51:55 -0400
Content-Disposition: inline
In-Reply-To: <55271A53.6080505@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Frank Praznik <frank.praznik@gmail.com>
Cc: Jiri Kosina <jkosina@suse.cz>, vojtech@suse.cz, mike-@cinci.rr.com, jslaby@suse.cz, dave@thedillows.org, colin.leitner@gmail.com, kernel list <linux-kernel@vger.kernel.org>, linux-input@vger.kernel.org

Hi!

> If you can send a version without all of the unrelated underscore changes
> I'll help clean it up.  I don't own one of these controllers
> though, so I can't help test the functionality.

I cleaned some of the (easy) comments, and tested that it still
works. Here's the updated version. Thanks,

Signed-off-by: Pavel Machek <pavel@ucw.cz>
									Pavel


diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index 722a925..1c5b515 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -1958,15 +1958,16 @@ static const struct hid_device_id hid_have_special_driver[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_SKYCABLE, USB_DEVICE_ID_SKYCABLE_WIRELESS_PRESENTER) },
 	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_SMK, USB_DEVICE_ID_SMK_PS3_BDREMOTE) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_SONY, USB_DEVICE_ID_SONY_BUZZ_CONTROLLER) },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_SONY, USB_DEVICE_ID_SONY_WIRELESS_BUZZ_CONTROLLER) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_SONY, USB_DEVICE_ID_SONY_NAVIGATION_CONTROLLER) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_SONY, USB_DEVICE_ID_SONY_MOTION_CONTROLLER) },
 	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_SONY, USB_DEVICE_ID_SONY_PS3_BDREMOTE) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_SONY, USB_DEVICE_ID_SONY_PS3_CONTROLLER) },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_SONY, USB_DEVICE_ID_SONY_NAVIGATION_CONTROLLER) },
 	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_SONY, USB_DEVICE_ID_SONY_PS3_CONTROLLER) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_SONY, USB_DEVICE_ID_SONY_PS4_CONTROLLER) },
 	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_SONY, USB_DEVICE_ID_SONY_PS4_CONTROLLER) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_SONY, USB_DEVICE_ID_SONY_VAIO_VGX_MOUSE) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_SONY, USB_DEVICE_ID_SONY_VAIO_VGP_MOUSE) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_SONY, USB_DEVICE_ID_SONY_WIRELESS_BUZZ_CONTROLLER) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_STEELSERIES, USB_DEVICE_ID_STEELSERIES_SRWS1) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_SUNPLUS, USB_DEVICE_ID_SUNPLUS_WDESKTOP) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_THINGM, USB_DEVICE_ID_BLINK1) },
diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 41f167e..d74243d 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -852,6 +852,7 @@
 #define USB_DEVICE_ID_SONY_PS3_CONTROLLER	0x0268
 #define USB_DEVICE_ID_SONY_PS4_CONTROLLER	0x05c4
 #define USB_DEVICE_ID_SONY_NAVIGATION_CONTROLLER	0x042f
+#define USB_DEVICE_ID_SONY_MOTION_CONTROLLER	0x03d5
 #define USB_DEVICE_ID_SONY_BUZZ_CONTROLLER		0x0002
 #define USB_DEVICE_ID_SONY_WIRELESS_BUZZ_CONTROLLER	0x1000
 
diff --git a/drivers/hid/hid-sony.c b/drivers/hid/hid-sony.c
index 6ca96ce..08f97e6 100644
--- a/drivers/hid/hid-sony.c
+++ b/drivers/hid/hid-sony.c
@@ -46,20 +46,22 @@
 #define PS3REMOTE                 BIT(4)
 #define DUALSHOCK4_CONTROLLER_USB BIT(5)
 #define DUALSHOCK4_CONTROLLER_BT  BIT(6)
+#define MOTION_CONTROLLER	  BIT(7)
 
 #define SIXAXIS_CONTROLLER (SIXAXIS_CONTROLLER_USB | SIXAXIS_CONTROLLER_BT)
 #define DUALSHOCK4_CONTROLLER (DUALSHOCK4_CONTROLLER_USB |\
 				DUALSHOCK4_CONTROLLER_BT)
 #define SONY_LED_SUPPORT (SIXAXIS_CONTROLLER | BUZZ_CONTROLLER |\
-				DUALSHOCK4_CONTROLLER)
+				DUALSHOCK4_CONTROLLER | MOTION_CONTROLLER)
 #define SONY_BATTERY_SUPPORT (SIXAXIS_CONTROLLER | DUALSHOCK4_CONTROLLER)
 #define SONY_FF_SUPPORT (SIXAXIS_CONTROLLER | DUALSHOCK4_CONTROLLER)
 
 #define MAX_LEDS 4
 
+/* PS/3 SixAxis and DualShock controllers */
 static __u8 sixaxis_rdesc[] = {
 	0x05, 0x01,         /*  Usage Page (Desktop),               */
-	0x09, 0x04,         /*  Usage (Joystik),                    */
+	0x09, 0x04,         /*  Usage (Joystick),                   */
 	0xA1, 0x01,         /*  Collection (Application),           */
 	0xA1, 0x02,         /*      Collection (Logical),           */
 	0x85, 0x01,         /*          Report ID (1),              */
@@ -134,6 +136,85 @@ static __u8 sixaxis_rdesc[] = {
 	0xC0                /*  End Collection                      */
 };
 
+/* PS/3 Motion controller */
+static __u8 motion_rdesc[] = {
+	0x05, 0x01,         /*  Usage Page (Desktop),               */
+	0x09, 0x04,         /*  Usage (Joystick),                   */
+	0xA1, 0x01,         /*  Collection (Application),           */
+	0xA1, 0x02,         /*      Collection (Logical),           */
+	0x85, 0x01,         /*          Report ID (1),              */
+	0x75, 0x08,         /*          Report Size (8),            */
+	0x95, 0x01,         /*          Report Count (1),           */
+	0x15, 0x00,         /*          Logical Minimum (0),        */
+	0x26, 0xFF, 0x00,   /*          Logical Maximum (255),      */
+	0x81, 0x03,         /*          Input (Constant, Variable), */
+	0x75, 0x01,         /*          Report Size (1),            */
+	0x95, 0x13,         /*          Report Count (19),          */
+	0x15, 0x00,         /*          Logical Minimum (0),        */
+	0x25, 0x01,         /*          Logical Maximum (1),        */
+	0x35, 0x00,         /*          Physical Minimum (0),       */
+	0x45, 0x01,         /*          Physical Maximum (1),       */
+	0x05, 0x09,         /*          Usage Page (Button),        */
+	0x19, 0x01,         /*          Usage Minimum (01h),        */
+	0x29, 0x13,         /*          Usage Maximum (13h),        */
+	0x81, 0x02,         /*          Input (Variable),           */
+	0x75, 0x01,         /*          Report Size (1),            */
+	0x95, 0x0D,         /*          Report Count (13),          */
+	0x06, 0x00, 0xFF,   /*          Usage Page (FF00h),         */
+	0x81, 0x03,         /*          Input (Constant, Variable), */
+	0x15, 0x00,         /*          Logical Minimum (0),        */
+	0x26, 0xFF, 0x00,   /*          Logical Maximum (255),      */
+	0x05, 0x01,         /*          Usage Page (Desktop),       */
+	0x09, 0x01,         /*          Usage (Pointer),            */
+	0xA1, 0x00,         /*          Collection (Physical),      */
+	0x75, 0x08,         /*              Report Size (8),        */
+	0x95, 0x04,         /*              Report Count (4),       */
+	0x35, 0x00,         /*              Physical Minimum (0),   */
+	0x46, 0xFF, 0x00,   /*              Physical Maximum (255), */
+	0x09, 0x30,         /*              Usage (X),              */
+	0x09, 0x31,         /*              Usage (Y),              */
+	0x09, 0x32,         /*              Usage (Z),              */
+	0x09, 0x35,         /*              Usage (Rz),             */
+	0x81, 0x02,         /*              Input (Variable),       */
+	0xC0,               /*          End Collection,             */
+	0x05, 0x01,         /*          Usage Page (Desktop),       */
+	0x95, 0x13,         /*          Report Count (19),          */
+	0x09, 0x01,         /*          Usage (Pointer),            */
+	0x81, 0x02,         /*          Input (Variable),           */
+	0x95, 0x0C,         /*          Report Count (12),          */
+	0x81, 0x01,         /*          Input (Constant),           */
+	0x75, 0x10,         /*          Report Size (16),           */
+	0x95, 0x04,         /*          Report Count (4),           */
+	0x26, 0xFF, 0x03,   /*          Logical Maximum (1023),     */
+	0x46, 0xFF, 0x03,   /*          Physical Maximum (1023),    */
+	0x09, 0x01,         /*          Usage (Pointer),            */
+	0x81, 0x02,         /*          Input (Variable),           */
+	0xC0,               /*      End Collection,                 */
+	0xA1, 0x02,         /*      Collection (Logical),           */
+	0x85, 0x02,         /*          Report ID (2),              */
+	0x75, 0x08,         /*          Report Size (8),            */
+	0x95, 0x30,         /*          Report Count (48),          */
+	0x09, 0x01,         /*          Usage (Pointer),            */
+	0xB1, 0x02,         /*          Feature (Variable),         */
+	0xC0,               /*      End Collection,                 */
+	0xA1, 0x02,         /*      Collection (Logical),           */
+	0x85, 0xEE,         /*          Report ID (238),            */
+	0x75, 0x08,         /*          Report Size (8),            */
+	0x95, 0x30,         /*          Report Count (48),          */
+	0x09, 0x01,         /*          Usage (Pointer),            */
+	0xB1, 0x02,         /*          Feature (Variable),         */
+	0xC0,               /*      End Collection,                 */
+	0xA1, 0x02,         /*      Collection (Logical),           */
+	0x85, 0xEF,         /*          Report ID (239),            */
+	0x75, 0x08,         /*          Report Size (8),            */
+	0x95, 0x30,         /*          Report Count (48),          */
+	0x09, 0x01,         /*          Usage (Pointer),            */
+	0xB1, 0x02,         /*          Feature (Variable),         */
+	0xC0,               /*      End Collection,                 */
+	0xC0                /*  End Collection                      */
+};
+
+
 /*
  * The default descriptor doesn't provide mapping for the accelerometers
  * or orientation sensors.  This fixed descriptor maps the accelerometers
@@ -837,6 +918,13 @@ struct sony_sc {
 	__u8 led_count;
 };
 
+struct motion_leds {
+	u8 type, zero;
+	u8 r, g, b;
+	u8 zero2;
+	u8 rumble;
+};
+
 static __u8 *sixaxis_fixup(struct hid_device *hdev, __u8 *rdesc,
 			     unsigned int *rsize)
 {
@@ -844,6 +932,31 @@ static __u8 *sixaxis_fixup(struct hid_device *hdev, __u8 *rdesc,
 	return sixaxis_rdesc;
 }
 
+static int motion_set_leds(struct hid_device *hdev, u8 r, u8 g, u8 b)
+{
+	int ret;
+	struct motion_leds *buf = kzalloc(sizeof(struct motion_leds), GFP_KERNEL);
+
+	BUILD_BUG_ON(sizeof(struct motion_leds) != 7);
+
+	buf->type = 0x02; /* set leds */
+	buf->r = r;
+	buf->g = g;
+	buf->b = b;
+
+	ret = hid_hw_output_report(hdev, buf, sizeof(struct motion_leds));
+	kfree(buf);
+
+	return ret;
+}
+
+static u8 *motion_fixup(struct hid_device *hdev, u8 *rdesc,
+			     unsigned int *rsize)
+{
+	*rsize = sizeof(motion_rdesc);
+	return motion_rdesc;
+}
+
 static __u8 *ps3remote_fixup(struct hid_device *hdev, __u8 *rdesc,
 			     unsigned int *rsize)
 {
@@ -890,6 +1003,8 @@ static __u8 *sony_report_fixup(struct hid_device *hdev, __u8 *rdesc,
 {
 	struct sony_sc *sc = hid_get_drvdata(hdev);
 
+	printk("Got report with rsize %d\n", *rsize);
+
 	/*
 	 * Some Sony RF receivers wrongly declare the mouse pointer as a
 	 * a constant non-data variable.
@@ -924,6 +1039,9 @@ static __u8 *sony_report_fixup(struct hid_device *hdev, __u8 *rdesc,
 	if (sc->quirks & SIXAXIS_CONTROLLER)
 		return sixaxis_fixup(hdev, rdesc, rsize);
 
+	if (sc->quirks & MOTION_CONTROLLER)
+		return motion_fixup(hdev, rdesc, rsize);
+
 	if (sc->quirks & PS3REMOTE)
 		return ps3remote_fixup(hdev, rdesc, rsize);
 
@@ -1037,6 +1155,8 @@ static int sony_raw_event(struct hid_device *hdev, struct hid_report *report,
 {
 	struct sony_sc *sc = hid_get_drvdata(hdev);
 
+	printk("sony_raw_event, size %d\n", size);
+
 	/*
 	 * Sixaxis HID report has acclerometers/gyro with MSByte first, this
 	 * has to be BYTE_SWAPPED before passing up to joystick interface
@@ -1280,11 +1400,12 @@ static void sony_set_leds(struct sony_sc *sc, const __u8 *leds, int count)
 
 	if (sc->quirks & BUZZ_CONTROLLER && count == 4) {
 		buzz_set_leds(sc->hdev, leds);
-	} else {
-		for (n = 0; n < count; n++)
-			sc->led_state[n] = leds[n];
-		schedule_work(&sc->state_worker);
+		return;
 	}
+
+	for (n = 0; n < count; n++)
+		sc->led_state[n] = leds[n];
+	schedule_work(&sc->state_worker);
 }
 
 static void sony_led_set_brightness(struct led_classdev *led,
@@ -1367,7 +1488,7 @@ static int sony_led_blink_set(struct led_classdev *led, unsigned long *delay_on,
 		return -EINVAL;
 	}
 
-	/* Max delay is 255 deciseconds or 2550 milliseconds */
+	/* Max delay is 2.55 seconds */
 	if (*delay_on > 2550)
 		*delay_on = 2550;
 	if (*delay_off > 2550)
@@ -1454,6 +1575,12 @@ static int sony_leds_init(struct sony_sc *sc)
 		use_ds4_names = 1;
 		name_len = 0;
 		name_fmt = "%s:%s";
+	} else if (sc->quirks & MOTION_CONTROLLER) {
+		sc->led_count = 3;
+		memset(max_brightness, 255, 3);
+		use_ds4_names = 1;
+		name_len = 0;
+		name_fmt = "%s:%s";
 	} else {
 		sixaxis_set_leds_from_id(sc->device_id, initial_values);
 		sc->led_count = 4;
@@ -1622,6 +1749,14 @@ static void dualshock4_state_worker(struct work_struct *work)
 				HID_OUTPUT_REPORT, HID_REQ_SET_REPORT);
 }
 
+static void motion_state_worker(struct work_struct *work)
+{
+	struct sony_sc *sc = container_of(work, struct sony_sc, state_worker);
+	struct hid_device *hdev = sc->hdev;
+
+	motion_set_leds(hdev, sc->led_state[0], sc->led_state[1], sc->led_state[2]);
+}
+
 static int sony_allocate_output_report(struct sony_sc *sc)
 {
 	if (sc->quirks & SIXAXIS_CONTROLLER)
@@ -1685,7 +1820,7 @@ static int sony_battery_get_property(struct power_supply *psy,
 	struct sony_sc *sc = power_supply_get_drvdata(psy);
 	unsigned long flags;
 	int ret = 0;
-	u8 battery_charging, battery_capacity, cable_state;
+	__u8 battery_charging, battery_capacity, cable_state;
 
 	spin_lock_irqsave(&sc->lock, flags);
 	battery_charging = sc->battery_charging;
@@ -2043,6 +2178,8 @@ static int sony_probe(struct hid_device *hdev, const struct hid_device_id *id)
 		}
 
 		sony_init_work(sc, dualshock4_state_worker);
+	} else if (sc->quirks & MOTION_CONTROLLER) {
+		sony_init_work(sc, motion_state_worker);
 	} else {
 		ret = 0;
 	}
@@ -2123,6 +2260,8 @@ static const struct hid_device_id sony_devices[] = {
 		.driver_data = SIXAXIS_CONTROLLER_USB },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_SONY, USB_DEVICE_ID_SONY_NAVIGATION_CONTROLLER),
 		.driver_data = SIXAXIS_CONTROLLER_USB },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_SONY, USB_DEVICE_ID_SONY_MOTION_CONTROLLER),
+		.driver_data = MOTION_CONTROLLER },
 	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_SONY, USB_DEVICE_ID_SONY_PS3_CONTROLLER),
 		.driver_data = SIXAXIS_CONTROLLER_BT },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_SONY, USB_DEVICE_ID_SONY_VAIO_VGX_MOUSE),
diff --git a/drivers/hid/hidraw.c b/drivers/hid/hidraw.c
index 9c2d7c2..1342b71 100644
--- a/drivers/hid/hidraw.c
+++ b/drivers/hid/hidraw.c
@@ -151,7 +151,14 @@ static ssize_t hidraw_send_report(struct file *file, const char __user *buffer,
 
 	if ((report_type == HID_OUTPUT_REPORT) &&
 	    !(dev->quirks & HID_QUIRK_NO_OUTPUT_REPORTS_ON_INTR_EP)) {
+		printk("hid_hw_output_report(dev, buf, %d_REPORT);\n", count);
 		ret = hid_hw_output_report(dev, buf, count);
+		{
+			int i;
+			for (i=0; i<count; i++)
+				printk("%02x ", buf[i]);
+			printk("\n");
+		}
 		/*
 		 * compatibility with old implementation of USB-HID and I2C-HID:
 		 * if the device does not support receiving output reports,
@@ -161,6 +168,15 @@ static ssize_t hidraw_send_report(struct file *file, const char __user *buffer,
 			goto out_free;
 	}
 
+	printk("hid_hw_raw_request(dev, %02x, buf, %d, %d, HID_REQ_SET_REPORT);\n",
+	       buf[0], count, report_type);
+	{
+		int i;
+		for (i=0; i<count; i++)
+			printk("%02x ", buf[i]);
+		printk("\n");
+	}
+
 	ret = hid_hw_raw_request(dev, buf[0], buf, count, report_type,
 				HID_REQ_SET_REPORT);
 

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
