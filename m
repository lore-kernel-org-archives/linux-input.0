From: Pavel Machek <pavel@ucw.cz>
Subject: [PATCH] hid-sony: underscores are unneccessary for u8, u16
Date: Sat, 14 Mar 2015 21:54:45 +0100
Message-ID: <20150314205445.GB10997@amd>
References: <20150314191917.GA3680@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150314191917.GA3680@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: vojtech@suse.cz, mike-@cinci.rr.com, jslaby@suse.cz, dave@thedillows.org, jikos@suse.cz, colin.leitner@gmail.com, frank.praznik@gmail.com, kernel list <linux-kernel@vger.kernel.org>, linux-input@vger.kernel.org
Cc: trivial@kernel.org
List-Id: linux-input@vger.kernel.org


Usage of __uX types is unneccessary in the kernel, replace it with uX.
    
Signed-off-by: Pavel Machek <pavel@ucw.cz>

diff --git a/drivers/hid/hid-sony.c b/drivers/hid/hid-sony.c
index 1896c01..f65e334 100644
--- a/drivers/hid/hid-sony.c
+++ b/drivers/hid/hid-sony.c
@@ -57,7 +57,7 @@
 
 #define MAX_LEDS 4
 
-static __u8 sixaxis_rdesc[] = {
+static u8 sixaxis_rdesc[] = {
 	0x05, 0x01,         /*  Usage Page (Desktop),               */
 	0x09, 0x04,         /*  Usage (Joystik),                    */
 	0xA1, 0x01,         /*  Collection (Application),           */
@@ -605,7 +605,7 @@ static u8 dualshock4_bt_rdesc[] = {
 	0xC0                /*  End Collection                      */
 };
 
-static __u8 ps3remote_rdesc[] = {
+static u8 ps3remote_rdesc[] = {
 	0x05, 0x01,          /* GUsagePage Generic Desktop */
 	0x09, 0x05,          /* LUsage 0x05 [Game Pad] */
 	0xA1, 0x01,          /* MCollection Application (mouse, keyboard) */
@@ -769,33 +769,33 @@ static enum power_supply_property sony_battery_props[] = {
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
@@ -817,32 +817,32 @@ struct sony_sc {
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
 };
 
-static __u8 *sixaxis_fixup(struct hid_device *hdev, __u8 *rdesc,
+static u8 *sixaxis_fixup(struct hid_device *hdev, u8 *rdesc,
 			     unsigned int *rsize)
 {
 	*rsize = sizeof(sixaxis_rdesc);
 	return sixaxis_rdesc;
 }
 
-static __u8 *ps3remote_fixup(struct hid_device *hdev, __u8 *rdesc,
+static u8 *ps3remote_fixup(struct hid_device *hdev, u8 *rdesc,
 			     unsigned int *rsize)
 {
 	*rsize = sizeof(ps3remote_rdesc);
@@ -883,7 +883,7 @@ static int ps3remote_mapping(struct hid_device *hdev, struct hid_input *hi,
 	return 1;
 }
 
-static __u8 *sony_report_fixup(struct hid_device *hdev, __u8 *rdesc,
+static u8 *sony_report_fixup(struct hid_device *hdev, u8 *rdesc,
 		unsigned int *rsize)
 {
 	struct sony_sc *sc = hid_get_drvdata(hdev);
@@ -928,11 +928,11 @@ static __u8 *sony_report_fixup(struct hid_device *hdev, __u8 *rdesc,
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
@@ -945,7 +945,7 @@ static void sixaxis_parse_report(struct sony_sc *sc, __u8 *rd, int size)
 		battery_charging = !(rd[30] & 0x01);
 		cable_state = 1;
 	} else {
-		__u8 index = rd[30] <= 5 ? rd[30] : 5;
+		u8 index = rd[30] <= 5 ? rd[30] : 5;
 		battery_capacity = sixaxis_battery_capacity[index];
 		battery_charging = 0;
 		cable_state = 0;
@@ -958,14 +958,14 @@ static void sixaxis_parse_report(struct sony_sc *sc, __u8 *rd, int size)
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
@@ -1015,7 +1015,7 @@ static void dualshock4_parse_report(struct sony_sc *sc, __u8 *rd, int size)
 	 * follows the data for the first.
 	 */
 	for (n = 0; n < 2; n++) {
-		__u16 x, y;
+		u16 x, y;
 
 		x = rd[offset+1] | ((rd[offset+2] & 0xF) << 8);
 		y = ((rd[offset+2] & 0xF0) >> 4) | (rd[offset+3] << 4);
@@ -1031,7 +1031,7 @@ static void dualshock4_parse_report(struct sony_sc *sc, __u8 *rd, int size)
 }
 
 static int sony_raw_event(struct hid_device *hdev, struct hid_report *report,
-		__u8 *rd, int size)
+		u8 *rd, int size)
 {
 	struct sony_sc *sc = hid_get_drvdata(hdev);
 
@@ -1149,8 +1149,8 @@ static int sixaxis_set_operational_usb(struct hid_device *hdev)
 
 static int sixaxis_set_operational_bt(struct hid_device *hdev)
 {
-	static const __u8 report[] = { 0xf4, 0x42, 0x03, 0x00, 0x00 };
-	__u8 *buf;
+	static const u8 report[] = { 0xf4, 0x42, 0x03, 0x00, 0x00 };
+	u8 *buf;
 	int ret;
 
 	buf = kmemdup(report, sizeof(report), GFP_KERNEL);
@@ -1171,7 +1171,7 @@ static int sixaxis_set_operational_bt(struct hid_device *hdev)
  */
 static int dualshock4_set_operational_bt(struct hid_device *hdev)
 {
-	__u8 *buf;
+	u8 *buf;
 	int ret;
 
 	buf = kmalloc(DS4_REPORT_0x02_SIZE, GFP_KERNEL);
@@ -1186,9 +1186,9 @@ static int dualshock4_set_operational_bt(struct hid_device *hdev)
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
@@ -1210,10 +1210,10 @@ static void sixaxis_set_leds_from_id(int id, __u8 values[MAX_LEDS])
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
@@ -1232,7 +1232,7 @@ static void dualshock4_set_leds_from_id(int id, __u8 values[MAX_LEDS])
 	memcpy(values, color_code[id], sizeof(color_code[id]));
 }
 
-static void buzz_set_leds(struct hid_device *hdev, const __u8 *leds)
+static void buzz_set_leds(struct hid_device *hdev, const u8 *leds)
 {
 	struct list_head *report_list =
 		&hdev->report_enum[HID_OUTPUT_REPORT].report_list;
@@ -1250,7 +1250,7 @@ static void buzz_set_leds(struct hid_device *hdev, const __u8 *leds)
 	hid_hw_request(hdev, report, HID_REQ_SET_REPORT);
 }
 
-static void sony_set_leds(struct sony_sc *sc, const __u8 *leds, int count)
+static void sony_set_leds(struct sony_sc *sc, const u8 *leds, int count)
 {
 	int n;
 
@@ -1338,7 +1338,7 @@ static int sony_led_blink_set(struct led_classdev *led, unsigned long *delay_on,
 	struct hid_device *hdev = container_of(dev, struct hid_device, dev);
 	struct sony_sc *drv_data = hid_get_drvdata(hdev);
 	int n;
-	__u8 new_on, new_off;
+	u8 new_on, new_off;
 
 	if (!drv_data) {
 		hid_err(hdev, "No device data\n");
@@ -1409,9 +1409,9 @@ static int sony_leds_init(struct sony_sc *sc)
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
 
@@ -1548,7 +1548,7 @@ static void sixaxis_state_worker(struct work_struct *work)
 		}
 	}
 
-	hid_hw_raw_request(sc->hdev, report->report_id, (__u8 *)report,
+	hid_hw_raw_request(sc->hdev, report->report_id, (u8 *)report,
 			sizeof(struct sixaxis_output_report),
 			HID_OUTPUT_REPORT, HID_REQ_SET_REPORT);
 }
@@ -1557,7 +1557,7 @@ static void dualshock4_state_worker(struct work_struct *work)
 {
 	struct sony_sc *sc = container_of(work, struct sony_sc, state_worker);
 	struct hid_device *hdev = sc->hdev;
-	__u8 *buf = sc->output_report_dmabuf;
+	u8 *buf = sc->output_report_dmabuf;
 	int offset;
 
 	if (sc->quirks & DUALSHOCK4_CONTROLLER_USB) {
@@ -1809,7 +1809,7 @@ static int sony_get_bt_devaddr(struct sony_sc *sc)
 
 static int sony_check_add(struct sony_sc *sc)
 {
-	__u8 *buf = NULL;
+	u8 *buf = NULL;
 	int n, ret;
 
 	if ((sc->quirks & DUALSHOCK4_CONTROLLER_BT) ||

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
