From: Pavel Machek <pavel@ucw.cz>
Subject: Turn Sony motion controller into RGB led
Date: Thu, 9 Apr 2015 23:25:36 +0200
Message-ID: <20150409212536.GA1440@amd>
References: <20150314191917.GA3680@amd>
 <alpine.LNX.2.00.1503161354310.25438@pobox.suse.cz>
 <20150316130547.GA20976@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:57080 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752688AbbDIVZj (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 9 Apr 2015 17:25:39 -0400
Content-Disposition: inline
In-Reply-To: <20150316130547.GA20976@amd>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: vojtech@suse.cz, mike-@cinci.rr.com, jslaby@suse.cz, dave@thedillows.org, colin.leitner@gmail.com, frank.praznik@gmail.com, kernel list <linux-kernel@vger.kernel.org>, linux-input@vger.kernel.org

Hi!

I did not yet figure out how to get sensor data from the controller,
but it works rather well as a RGB led.

And yes, this probably would need some more cleanup, but I'm out of
time now. Perhaps someone else can help...

BTW what happened to the __u8->u8 conversion patch? That should go in AFAICT.

Signed-off-by: Pavel Machek <pavel@ucw.cz>

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index 56ce8c2..a1c8b63 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -1941,6 +1941,7 @@ static const struct hid_device_id hid_have_special_driver[] = {
 	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_SONY, USB_DEVICE_ID_SONY_PS3_BDREMOTE) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_SONY, USB_DEVICE_ID_SONY_PS3_CONTROLLER) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_SONY, USB_DEVICE_ID_SONY_NAVIGATION_CONTROLLER) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_SONY, USB_DEVICE_ID_SONY_MOTION_CONTROLLER) },	
 	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_SONY, USB_DEVICE_ID_SONY_PS3_CONTROLLER) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_SONY, USB_DEVICE_ID_SONY_PS4_CONTROLLER) },
 	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_SONY, USB_DEVICE_ID_SONY_PS4_CONTROLLER) },
diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 9c47867..d94d2c3 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -843,6 +843,7 @@
 #define USB_DEVICE_ID_SONY_PS3_CONTROLLER	0x0268
 #define USB_DEVICE_ID_SONY_PS4_CONTROLLER	0x05c4
 #define USB_DEVICE_ID_SONY_NAVIGATION_CONTROLLER	0x042f
+#define USB_DEVICE_ID_SONY_MOTION_CONTROLLER	0x03d5
 #define USB_DEVICE_ID_SONY_BUZZ_CONTROLLER		0x0002
 #define USB_DEVICE_ID_SONY_WIRELESS_BUZZ_CONTROLLER	0x1000
 
diff --git a/drivers/hid/hid-sony.c b/drivers/hid/hid-sony.c
index 1896c01..6dec2a0 100644
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
 
-static __u8 sixaxis_rdesc[] = {
+/* PS/3 SixAxis and DualShock controllers */      
+static u8 sixaxis_rdesc[] = {
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
+static u8 motion_rdesc[] = {
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
@@ -605,7 +686,7 @@ static u8 dualshock4_bt_rdesc[] = {
 	0xC0                /*  End Collection                      */
 };
 
-static __u8 ps3remote_rdesc[] = {
+static u8 ps3remote_rdesc[] = {
 	0x05, 0x01,          /* GUsagePage Generic Desktop */
 	0x09, 0x05,          /* LUsage 0x05 [Game Pad] */
 	0xA1, 0x01,          /* MCollection Application (mouse, keyboard) */
@@ -769,33 +850,33 @@ static enum power_supply_property sony_battery_props[] = {
 };
 
 struct sixaxis_led {
-	__u8 time_enabled; /* the total time the led is active (0xff means forever) */
-	__u8 duty_length;  /* how long a cycle is in deciseconds (0 means "really fast") */
-	__u8 enabled;
-	__u8 duty_off; /* % of duty_length the led is off (0xff means 100%) */
-	__u8 duty_on;  /* % of duty_length the led is on (0xff mean 100%) */
+	u8 time_enabled; /* the total time the led is active (0xff means forever) */
+	u8 duty_length;  /* how long a cycle is in deciseconds (0 means "really fast") */
+	u8 enabled;
+	u8 duty_off; /* % of duty_length the led is off (0xff means 100%) */
+	u8 duty_on;  /* % of duty_length the led is on (0xff mean 100%) */
 } __packed;
 
 struct sixaxis_rumble {
-	__u8 padding;
-	__u8 right_duration; /* Right motor duration (0xff means forever) */
-	__u8 right_motor_on; /* Right (small) motor on/off, only supports values of 0 or 1 (off/on) */
-	__u8 left_duration;    /* Left motor duration (0xff means forever) */
-	__u8 left_motor_force; /* left (large) motor, supports force values from 0 to 255 */
+	u8 padding;
+	u8 right_duration; /* Right motor duration (0xff means forever) */
+	u8 right_motor_on; /* Right (small) motor on/off, only supports values of 0 or 1 (off/on) */
+	u8 left_duration;    /* Left motor duration (0xff means forever) */
+	u8 left_motor_force; /* left (large) motor, supports force values from 0 to 255 */
 } __packed;
 
 struct sixaxis_output_report {
-	__u8 report_id;
+	u8 report_id;
 	struct sixaxis_rumble rumble;
-	__u8 padding[4];
-	__u8 leds_bitmap; /* bitmap of enabled LEDs: LED_1 = 0x02, LED_2 = 0x04, ... */
+	u8 padding[4];
+	u8 leds_bitmap; /* bitmap of enabled LEDs: LED_1 = 0x02, LED_2 = 0x04, ... */
 	struct sixaxis_led led[4];    /* LEDx at (4 - x) */
 	struct sixaxis_led _reserved; /* LED5, not actually soldered */
 } __packed;
 
 union sixaxis_output_report_01 {
 	struct sixaxis_output_report data;
-	__u8 buf[36];
+	u8 buf[36];
 };
 
 #define DS4_REPORT_0x02_SIZE 37
@@ -817,32 +898,69 @@ struct sony_sc {
 	struct work_struct state_worker;
 	struct power_supply battery;
 	int device_id;
-	__u8 *output_report_dmabuf;
+	u8 *output_report_dmabuf;
 
 #ifdef CONFIG_SONY_FF
-	__u8 left;
-	__u8 right;
+	u8 left;
+	u8 right;
 #endif
 
-	__u8 mac_address[6];
-	__u8 worker_initialized;
-	__u8 cable_state;
-	__u8 battery_charging;
-	__u8 battery_capacity;
-	__u8 led_state[MAX_LEDS];
-	__u8 led_delay_on[MAX_LEDS];
-	__u8 led_delay_off[MAX_LEDS];
-	__u8 led_count;
+	u8 mac_address[6];
+	u8 worker_initialized;
+	u8 cable_state;
+	u8 battery_charging;
+	u8 battery_capacity;
+	u8 led_state[MAX_LEDS];
+	u8 led_delay_on[MAX_LEDS];
+	u8 led_delay_off[MAX_LEDS];
+	u8 led_count;
+};
+
+struct motion_leds {
+	u8 type, zero;
+	u8 r, g, b;
+	u8 zero2;
+	u8 rumble;
 };
 
-static __u8 *sixaxis_fixup(struct hid_device *hdev, __u8 *rdesc,
+static u8 *sixaxis_fixup(struct hid_device *hdev, u8 *rdesc,
 			     unsigned int *rsize)
 {
 	*rsize = sizeof(sixaxis_rdesc);
 	return sixaxis_rdesc;
 }
 
-static __u8 *ps3remote_fixup(struct hid_device *hdev, __u8 *rdesc,
+static int motion_set_leds(struct hid_device *hdev, u8 r, u8 g, u8 b)
+{
+	int ret;
+	struct motion_leds *buf = kzalloc(sizeof(struct motion_leds), GFP_KERNEL);
+
+	if (sizeof(struct motion_leds) != 7) {
+		printk("Struct has bad size\n");
+	}
+
+#define SET_LEDS 0x02
+	buf->type = SET_LEDS;
+	buf->r = r;
+	buf->g = g;
+	buf->b = b;	
+	
+	ret = hid_hw_output_report(hdev, buf, sizeof(struct motion_leds));
+	printk("motion: set leds %d\n", ret);
+	kfree(buf);
+
+	return ret;
+}
+
+static u8 *motion_fixup(struct hid_device *hdev, u8 *rdesc,
+			     unsigned int *rsize)
+{
+	printk("Fixup for motion\n");
+	*rsize = sizeof(motion_rdesc);
+	return motion_rdesc;
+}
+
+static u8 *ps3remote_fixup(struct hid_device *hdev, u8 *rdesc,
 			     unsigned int *rsize)
 {
 	*rsize = sizeof(ps3remote_rdesc);
@@ -883,11 +1001,13 @@ static int ps3remote_mapping(struct hid_device *hdev, struct hid_input *hi,
 	return 1;
 }
 
-static __u8 *sony_report_fixup(struct hid_device *hdev, __u8 *rdesc,
+static u8 *sony_report_fixup(struct hid_device *hdev, u8 *rdesc,
 		unsigned int *rsize)
 {
 	struct sony_sc *sc = hid_get_drvdata(hdev);
 
+	printk("Got report with rsize %d\n", *rsize);
+
 	/*
 	 * Some Sony RF receivers wrongly declare the mouse pointer as a
 	 * a constant non-data variable.
@@ -922,17 +1042,20 @@ static __u8 *sony_report_fixup(struct hid_device *hdev, __u8 *rdesc,
 	if (sc->quirks & SIXAXIS_CONTROLLER)
 		return sixaxis_fixup(hdev, rdesc, rsize);
 
+	if (sc->quirks & MOTION_CONTROLLER)
+		return motion_fixup(hdev, rdesc, rsize);
+	
 	if (sc->quirks & PS3REMOTE)
 		return ps3remote_fixup(hdev, rdesc, rsize);
 
 	return rdesc;
 }
 
-static void sixaxis_parse_report(struct sony_sc *sc, __u8 *rd, int size)
+static void sixaxis_parse_report(struct sony_sc *sc, u8 *rd, int size)
 {
-	static const __u8 sixaxis_battery_capacity[] = { 0, 1, 25, 50, 75, 100 };
+	static const u8 sixaxis_battery_capacity[] = { 0, 1, 25, 50, 75, 100 };
 	unsigned long flags;
-	__u8 cable_state, battery_capacity, battery_charging;
+	u8 cable_state, battery_capacity, battery_charging;
 
 	/*
 	 * The sixaxis is charging if the battery value is 0xee
@@ -945,7 +1068,7 @@ static void sixaxis_parse_report(struct sony_sc *sc, __u8 *rd, int size)
 		battery_charging = !(rd[30] & 0x01);
 		cable_state = 1;
 	} else {
-		__u8 index = rd[30] <= 5 ? rd[30] : 5;
+		u8 index = rd[30] <= 5 ? rd[30] : 5;
 		battery_capacity = sixaxis_battery_capacity[index];
 		battery_charging = 0;
 		cable_state = 0;
@@ -958,14 +1081,14 @@ static void sixaxis_parse_report(struct sony_sc *sc, __u8 *rd, int size)
 	spin_unlock_irqrestore(&sc->lock, flags);
 }
 
-static void dualshock4_parse_report(struct sony_sc *sc, __u8 *rd, int size)
+static void dualshock4_parse_report(struct sony_sc *sc, u8 *rd, int size)
 {
 	struct hid_input *hidinput = list_entry(sc->hdev->inputs.next,
 						struct hid_input, list);
 	struct input_dev *input_dev = hidinput->input;
 	unsigned long flags;
 	int n, offset;
-	__u8 cable_state, battery_capacity, battery_charging;
+	u8 cable_state, battery_capacity, battery_charging;
 
 	/*
 	 * Battery and touchpad data starts at byte 30 in the USB report and
@@ -1015,7 +1138,7 @@ static void dualshock4_parse_report(struct sony_sc *sc, __u8 *rd, int size)
 	 * follows the data for the first.
 	 */
 	for (n = 0; n < 2; n++) {
-		__u16 x, y;
+		u16 x, y;
 
 		x = rd[offset+1] | ((rd[offset+2] & 0xF) << 8);
 		y = ((rd[offset+2] & 0xF0) >> 4) | (rd[offset+3] << 4);
@@ -1031,10 +1154,12 @@ static void dualshock4_parse_report(struct sony_sc *sc, __u8 *rd, int size)
 }
 
 static int sony_raw_event(struct hid_device *hdev, struct hid_report *report,
-		__u8 *rd, int size)
+		u8 *rd, int size)
 {
 	struct sony_sc *sc = hid_get_drvdata(hdev);
 
+	printk("sony_raw_event, size %d\n", size);
+
 	/*
 	 * Sixaxis HID report has acclerometers/gyro with MSByte first, this
 	 * has to be BYTE_SWAPPED before passing up to joystick interface
@@ -1149,8 +1274,8 @@ static int sixaxis_set_operational_usb(struct hid_device *hdev)
 
 static int sixaxis_set_operational_bt(struct hid_device *hdev)
 {
-	static const __u8 report[] = { 0xf4, 0x42, 0x03, 0x00, 0x00 };
-	__u8 *buf;
+	static const u8 report[] = { 0xf4, 0x42, 0x03, 0x00, 0x00 };
+	u8 *buf;
 	int ret;
 
 	buf = kmemdup(report, sizeof(report), GFP_KERNEL);
@@ -1171,7 +1296,7 @@ static int sixaxis_set_operational_bt(struct hid_device *hdev)
  */
 static int dualshock4_set_operational_bt(struct hid_device *hdev)
 {
-	__u8 *buf;
+	u8 *buf;
 	int ret;
 
 	buf = kmalloc(DS4_REPORT_0x02_SIZE, GFP_KERNEL);
@@ -1186,9 +1311,9 @@ static int dualshock4_set_operational_bt(struct hid_device *hdev)
 	return ret;
 }
 
-static void sixaxis_set_leds_from_id(int id, __u8 values[MAX_LEDS])
+static void sixaxis_set_leds_from_id(int id, u8 values[MAX_LEDS])
 {
-	static const __u8 sixaxis_leds[10][4] = {
+	static const u8 sixaxis_leds[10][4] = {
 				{ 0x01, 0x00, 0x00, 0x00 },
 				{ 0x00, 0x01, 0x00, 0x00 },
 				{ 0x00, 0x00, 0x01, 0x00 },
@@ -1210,10 +1335,10 @@ static void sixaxis_set_leds_from_id(int id, __u8 values[MAX_LEDS])
 	memcpy(values, sixaxis_leds[id], sizeof(sixaxis_leds[id]));
 }
 
-static void dualshock4_set_leds_from_id(int id, __u8 values[MAX_LEDS])
+static void dualshock4_set_leds_from_id(int id, u8 values[MAX_LEDS])
 {
 	/* The first 4 color/index entries match what the PS4 assigns */
-	static const __u8 color_code[7][3] = {
+	static const u8 color_code[7][3] = {
 			/* Blue   */	{ 0x00, 0x00, 0x01 },
 			/* Red	  */	{ 0x01, 0x00, 0x00 },
 			/* Green  */	{ 0x00, 0x01, 0x00 },
@@ -1232,7 +1357,7 @@ static void dualshock4_set_leds_from_id(int id, __u8 values[MAX_LEDS])
 	memcpy(values, color_code[id], sizeof(color_code[id]));
 }
 
-static void buzz_set_leds(struct hid_device *hdev, const __u8 *leds)
+static void buzz_set_leds(struct hid_device *hdev, const u8 *leds)
 {
 	struct list_head *report_list =
 		&hdev->report_enum[HID_OUTPUT_REPORT].report_list;
@@ -1250,7 +1375,7 @@ static void buzz_set_leds(struct hid_device *hdev, const __u8 *leds)
 	hid_hw_request(hdev, report, HID_REQ_SET_REPORT);
 }
 
-static void sony_set_leds(struct sony_sc *sc, const __u8 *leds, int count)
+static void sony_set_leds(struct sony_sc *sc, const u8 *leds, int count)
 {
 	int n;
 
@@ -1258,11 +1383,12 @@ static void sony_set_leds(struct sony_sc *sc, const __u8 *leds, int count)
 
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
@@ -1338,14 +1464,14 @@ static int sony_led_blink_set(struct led_classdev *led, unsigned long *delay_on,
 	struct hid_device *hdev = container_of(dev, struct hid_device, dev);
 	struct sony_sc *drv_data = hid_get_drvdata(hdev);
 	int n;
-	__u8 new_on, new_off;
+	u8 new_on, new_off;
 
 	if (!drv_data) {
 		hid_err(hdev, "No device data\n");
 		return -EINVAL;
 	}
 
-	/* Max delay is 255 deciseconds or 2550 milliseconds */
+	/* Max delay is 2.55 seconds */
 	if (*delay_on > 2550)
 		*delay_on = 2550;
 	if (*delay_off > 2550)
@@ -1409,9 +1535,9 @@ static int sony_leds_init(struct sony_sc *sc)
 	const char *name_fmt;
 	static const char * const ds4_name_str[] = { "red", "green", "blue",
 						  "global" };
-	__u8 initial_values[MAX_LEDS] = { 0 };
-	__u8 max_brightness[MAX_LEDS] = { [0 ... (MAX_LEDS - 1)] = 1 };
-	__u8 use_hw_blink[MAX_LEDS] = { 0 };
+	u8 initial_values[MAX_LEDS] = { 0 };
+	u8 max_brightness[MAX_LEDS] = { [0 ... (MAX_LEDS - 1)] = 1 };
+	u8 use_hw_blink[MAX_LEDS] = { 0 };
 
 	BUG_ON(!(sc->quirks & SONY_LED_SUPPORT));
 
@@ -1432,6 +1558,12 @@ static int sony_leds_init(struct sony_sc *sc)
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
@@ -1548,7 +1680,7 @@ static void sixaxis_state_worker(struct work_struct *work)
 		}
 	}
 
-	hid_hw_raw_request(sc->hdev, report->report_id, (__u8 *)report,
+	hid_hw_raw_request(sc->hdev, report->report_id, (u8 *)report,
 			sizeof(struct sixaxis_output_report),
 			HID_OUTPUT_REPORT, HID_REQ_SET_REPORT);
 }
@@ -1557,7 +1689,7 @@ static void dualshock4_state_worker(struct work_struct *work)
 {
 	struct sony_sc *sc = container_of(work, struct sony_sc, state_worker);
 	struct hid_device *hdev = sc->hdev;
-	__u8 *buf = sc->output_report_dmabuf;
+	u8 *buf = sc->output_report_dmabuf;
 	int offset;
 
 	if (sc->quirks & DUALSHOCK4_CONTROLLER_USB) {
@@ -1600,6 +1732,16 @@ static void dualshock4_state_worker(struct work_struct *work)
 				HID_OUTPUT_REPORT, HID_REQ_SET_REPORT);
 }
 
+static void motion_state_worker(struct work_struct *work)
+{
+	struct sony_sc *sc = container_of(work, struct sony_sc, state_worker);
+	struct hid_device *hdev = sc->hdev;
+
+	motion_set_leds(hdev, sc->led_state[0], sc->led_state[1], sc->led_state[2]);
+
+//	schedule_delayed_work(&sc->state_worker, HZ*3);
+}
+
 static int sony_allocate_output_report(struct sony_sc *sc)
 {
 	if (sc->quirks & SIXAXIS_CONTROLLER)
@@ -1809,7 +1951,7 @@ static int sony_get_bt_devaddr(struct sony_sc *sc)
 
 static int sony_check_add(struct sony_sc *sc)
 {
-	__u8 *buf = NULL;
+	u8 *buf = NULL;
 	int n, ret;
 
 	if ((sc->quirks & DUALSHOCK4_CONTROLLER_BT) ||
@@ -1938,6 +2080,8 @@ static int sony_probe(struct hid_device *hdev, const struct hid_device_id *id)
 	struct sony_sc *sc;
 	unsigned int connect_mask = HID_CONNECT_DEFAULT;
 
+	printk("sony: probe\n");
+
 	sc = devm_kzalloc(&hdev->dev, sizeof(*sc), GFP_KERNEL);
 	if (sc == NULL) {
 		hid_err(hdev, "can't alloc sony descriptor\n");
@@ -1950,12 +2094,16 @@ static int sony_probe(struct hid_device *hdev, const struct hid_device_id *id)
 	hid_set_drvdata(hdev, sc);
 	sc->hdev = hdev;
 
+	printk("have device %lx\n", hdev);
+
 	ret = hid_parse(hdev);
 	if (ret) {
 		hid_err(hdev, "parse failed\n");
 		return ret;
 	}
 
+	printk("parsed %lx\n", hdev);	
+
 	if (sc->quirks & VAIO_RDESC_CONSTANT)
 		connect_mask |= HID_CONNECT_HIDDEV_FORCE;
 	else if (sc->quirks & SIXAXIS_CONTROLLER)
@@ -2017,6 +2165,8 @@ static int sony_probe(struct hid_device *hdev, const struct hid_device_id *id)
 		}
 
 		sony_init_work(sc, dualshock4_state_worker);
+	} else if (sc->quirks & MOTION_CONTROLLER) {
+		sony_init_work(sc, motion_state_worker);		
 	} else {
 		ret = 0;
 	}
@@ -2097,6 +2247,8 @@ static const struct hid_device_id sony_devices[] = {
 		.driver_data = SIXAXIS_CONTROLLER_USB },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_SONY, USB_DEVICE_ID_SONY_NAVIGATION_CONTROLLER),
 		.driver_data = SIXAXIS_CONTROLLER_USB },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_SONY, USB_DEVICE_ID_SONY_MOTION_CONTROLLER),
+		.driver_data = MOTION_CONTROLLER },
 	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_SONY, USB_DEVICE_ID_SONY_PS3_CONTROLLER),
 		.driver_data = SIXAXIS_CONTROLLER_BT },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_SONY, USB_DEVICE_ID_SONY_VAIO_VGX_MOUSE),
@@ -2142,6 +2294,8 @@ static int __init sony_init(void)
 {
 	dbg_hid("Sony:%s\n", __func__);
 
+	printk("Sony: init\n");
+
 	return hid_register_driver(&sony_driver);
 }
 
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
