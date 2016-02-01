From: Frank Praznik <frank.praznik@gmail.com>
Subject: Re: [PATCH 7/7] HID: sony: underscores are unnecessary for u8, u16, s32
Date: Mon, 1 Feb 2016 09:46:20 -0500
Message-ID: <A7513D0E-C365-46F3-99AF-30E0E42C7C81@gmail.com>
References: <1454001827-26732-1-git-send-email-ao2@ao2.it> <1454001827-26732-8-git-send-email-ao2@ao2.it>
Mime-Version: 1.0 (Mac OS X Mail 9.2 \(3112\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qg0-f65.google.com ([209.85.192.65]:35252 "EHLO
	mail-qg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932418AbcBAOqY convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 1 Feb 2016 09:46:24 -0500
Received: by mail-qg0-f65.google.com with SMTP id b35so10085588qge.2
        for <linux-input@vger.kernel.org>; Mon, 01 Feb 2016 06:46:23 -0800 (PST)
In-Reply-To: <1454001827-26732-8-git-send-email-ao2@ao2.it>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Antonio Ospite <ao2@ao2.it>
Cc: linux-input@vger.kernel.org, Jiri Kosina <jikos@kernel.org>, Pavel Machek <pavel@ucw.cz>


> On Jan 28, 2016, at 12:23, Antonio Ospite <ao2@ao2.it> wrote:
> 
> From: Pavel Machek <pavel@ucw.cz>
> 
> Double-underscore prefixed types are unnecessary in pure kernel code,
> replace them with the non prefixed equivalents.
> 
> Signed-off-by: Pavel Machek <pavel@ucw.cz>
> Signed-off-by: Antonio Ospite <ao2@ao2.it>
> ---
> 
> Changes since the original version from Pavel:
>  - Rebase on top of Jiri's for-4.6/sony branch
>  - Adjust commit message and fix a typo: s/unneccessary/unnecessary/
>  - Fix some new occurrences of the underscored types
> 
> 
> drivers/hid/hid-sony.c | 114 ++++++++++++++++++++++++-------------------------
> 1 file changed, 57 insertions(+), 57 deletions(-)
> 
> diff --git a/drivers/hid/hid-sony.c b/drivers/hid/hid-sony.c
> index eeea87e..229cc7b 100644
> --- a/drivers/hid/hid-sony.c
> +++ b/drivers/hid/hid-sony.c
> @@ -75,7 +75,7 @@
>  * axis values.  Additionally, the controller only has 20 actual, physical axes
>  * so there are several unused axes in between the used ones.
>  */
> -static __u8 sixaxis_rdesc[] = {
> +static u8 sixaxis_rdesc[] = {
> 	0x05, 0x01,         /*  Usage Page (Desktop),               */
> 	0x09, 0x04,         /*  Usage (Joystick),                   */
> 	0xA1, 0x01,         /*  Collection (Application),           */
> @@ -153,7 +153,7 @@ static __u8 sixaxis_rdesc[] = {
> };
> 
> /* PS/3 Motion controller */
> -static __u8 motion_rdesc[] = {
> +static u8 motion_rdesc[] = {
> 	0x05, 0x01,         /*  Usage Page (Desktop),               */
> 	0x09, 0x04,         /*  Usage (Joystick),                   */
> 	0xA1, 0x01,         /*  Collection (Application),           */
> @@ -250,7 +250,7 @@ static __u8 motion_rdesc[] = {
> };
> 
> /* PS/3 Navigation controller */
> -static __u8 navigation_rdesc[] = {
> +static u8 navigation_rdesc[] = {
> 	0x05, 0x01,         /*  Usage Page (Desktop),               */
> 	0x09, 0x04,         /*  Usage (Joystick),                   */
> 	0xA1, 0x01,         /*  Collection (Application),           */
> @@ -810,7 +810,7 @@ static u8 dualshock4_bt_rdesc[] = {
> 	0xC0                /*  End Collection                      */
> };
> 
> -static __u8 ps3remote_rdesc[] = {
> +static u8 ps3remote_rdesc[] = {
> 	0x05, 0x01,          /* GUsagePage Generic Desktop */
> 	0x09, 0x05,          /* LUsage 0x05 [Game Pad] */
> 	0xA1, 0x01,          /* MCollection Application (mouse, keyboard) */
> @@ -980,33 +980,33 @@ static enum power_supply_property sony_battery_props[] = {
> };
> 
> struct sixaxis_led {
> -	__u8 time_enabled; /* the total time the led is active (0xff means forever) */
> -	__u8 duty_length;  /* how long a cycle is in deciseconds (0 means "really fast") */
> -	__u8 enabled;
> -	__u8 duty_off; /* % of duty_length the led is off (0xff means 100%) */
> -	__u8 duty_on;  /* % of duty_length the led is on (0xff mean 100%) */
> +	u8 time_enabled; /* the total time the led is active (0xff means forever) */
> +	u8 duty_length;  /* how long a cycle is in deciseconds (0 means "really fast") */
> +	u8 enabled;
> +	u8 duty_off; /* % of duty_length the led is off (0xff means 100%) */
> +	u8 duty_on;  /* % of duty_length the led is on (0xff mean 100%) */
> } __packed;
> 
> struct sixaxis_rumble {
> -	__u8 padding;
> -	__u8 right_duration; /* Right motor duration (0xff means forever) */
> -	__u8 right_motor_on; /* Right (small) motor on/off, only supports values of 0 or 1 (off/on) */
> -	__u8 left_duration;    /* Left motor duration (0xff means forever) */
> -	__u8 left_motor_force; /* left (large) motor, supports force values from 0 to 255 */
> +	u8 padding;
> +	u8 right_duration; /* Right motor duration (0xff means forever) */
> +	u8 right_motor_on; /* Right (small) motor on/off, only supports values of 0 or 1 (off/on) */
> +	u8 left_duration;    /* Left motor duration (0xff means forever) */
> +	u8 left_motor_force; /* left (large) motor, supports force values from 0 to 255 */
> } __packed;
> 
> struct sixaxis_output_report {
> -	__u8 report_id;
> +	u8 report_id;
> 	struct sixaxis_rumble rumble;
> -	__u8 padding[4];
> -	__u8 leds_bitmap; /* bitmap of enabled LEDs: LED_1 = 0x02, LED_2 = 0x04, ... */
> +	u8 padding[4];
> +	u8 leds_bitmap; /* bitmap of enabled LEDs: LED_1 = 0x02, LED_2 = 0x04, ... */
> 	struct sixaxis_led led[4];    /* LEDx at (4 - x) */
> 	struct sixaxis_led _reserved; /* LED5, not actually soldered */
> } __packed;
> 
> union sixaxis_output_report_01 {
> 	struct sixaxis_output_report data;
> -	__u8 buf[36];
> +	u8 buf[36];
> };
> 
> struct motion_output_report_02 {
> @@ -1039,26 +1039,26 @@ struct sony_sc {
> 	struct power_supply *battery;
> 	struct power_supply_desc battery_desc;
> 	int device_id;
> -	__u8 *output_report_dmabuf;
> +	u8 *output_report_dmabuf;
> 
> #ifdef CONFIG_SONY_FF
> -	__u8 left;
> -	__u8 right;
> +	u8 left;
> +	u8 right;
> #endif
> 
> -	__u8 mac_address[6];
> -	__u8 worker_initialized;
> -	__u8 cable_state;
> -	__u8 battery_charging;
> -	__u8 battery_capacity;
> -	__u8 led_state[MAX_LEDS];
> -	__u8 resume_led_state[MAX_LEDS];
> -	__u8 led_delay_on[MAX_LEDS];
> -	__u8 led_delay_off[MAX_LEDS];
> -	__u8 led_count;
> +	u8 mac_address[6];
> +	u8 worker_initialized;
> +	u8 cable_state;
> +	u8 battery_charging;
> +	u8 battery_capacity;
> +	u8 led_state[MAX_LEDS];
> +	u8 resume_led_state[MAX_LEDS];
> +	u8 led_delay_on[MAX_LEDS];
> +	u8 led_delay_off[MAX_LEDS];
> +	u8 led_count;
> };
> 
> -static __u8 *sixaxis_fixup(struct hid_device *hdev, __u8 *rdesc,
> +static u8 *sixaxis_fixup(struct hid_device *hdev, u8 *rdesc,
> 			     unsigned int *rsize)
> {
> 	*rsize = sizeof(sixaxis_rdesc);
> @@ -1079,7 +1079,7 @@ static u8 *navigation_fixup(struct hid_device *hdev, u8 *rdesc,
> 	return navigation_rdesc;
> }
> 
> -static __u8 *ps3remote_fixup(struct hid_device *hdev, __u8 *rdesc,
> +static u8 *ps3remote_fixup(struct hid_device *hdev, u8 *rdesc,
> 			     unsigned int *rsize)
> {
> 	*rsize = sizeof(ps3remote_rdesc);
> @@ -1120,7 +1120,7 @@ static int ps3remote_mapping(struct hid_device *hdev, struct hid_input *hi,
> 	return 1;
> }
> 
> -static __u8 *sony_report_fixup(struct hid_device *hdev, __u8 *rdesc,
> +static u8 *sony_report_fixup(struct hid_device *hdev, u8 *rdesc,
> 		unsigned int *rsize)
> {
> 	struct sony_sc *sc = hid_get_drvdata(hdev);
> @@ -1174,12 +1174,12 @@ static __u8 *sony_report_fixup(struct hid_device *hdev, __u8 *rdesc,
> 	return rdesc;
> }
> 
> -static void sixaxis_parse_report(struct sony_sc *sc, __u8 *rd, int size)
> +static void sixaxis_parse_report(struct sony_sc *sc, u8 *rd, int size)
> {
> -	static const __u8 sixaxis_battery_capacity[] = { 0, 1, 25, 50, 75, 100 };
> +	static const u8 sixaxis_battery_capacity[] = { 0, 1, 25, 50, 75, 100 };
> 	unsigned long flags;
> 	int offset;
> -	__u8 cable_state, battery_capacity, battery_charging;
> +	u8 cable_state, battery_capacity, battery_charging;
> 
> 	/*
> 	 * The sixaxis is charging if the battery value is 0xee
> @@ -1194,7 +1194,7 @@ static void sixaxis_parse_report(struct sony_sc *sc, __u8 *rd, int size)
> 		battery_charging = !(rd[offset] & 0x01);
> 		cable_state = 1;
> 	} else {
> -		__u8 index = rd[offset] <= 5 ? rd[offset] : 5;
> +		u8 index = rd[offset] <= 5 ? rd[offset] : 5;
> 		battery_capacity = sixaxis_battery_capacity[index];
> 		battery_charging = 0;
> 		cable_state = 0;
> @@ -1207,14 +1207,14 @@ static void sixaxis_parse_report(struct sony_sc *sc, __u8 *rd, int size)
> 	spin_unlock_irqrestore(&sc->lock, flags);
> }
> 
> -static void dualshock4_parse_report(struct sony_sc *sc, __u8 *rd, int size)
> +static void dualshock4_parse_report(struct sony_sc *sc, u8 *rd, int size)
> {
> 	struct hid_input *hidinput = list_entry(sc->hdev->inputs.next,
> 						struct hid_input, list);
> 	struct input_dev *input_dev = hidinput->input;
> 	unsigned long flags;
> 	int n, offset;
> -	__u8 cable_state, battery_capacity, battery_charging;
> +	u8 cable_state, battery_capacity, battery_charging;
> 
> 	/*
> 	 * Battery and touchpad data starts at byte 30 in the USB report and
> @@ -1264,7 +1264,7 @@ static void dualshock4_parse_report(struct sony_sc *sc, __u8 *rd, int size)
> 	 * follows the data for the first.
> 	 */
> 	for (n = 0; n < 2; n++) {
> -		__u16 x, y;
> +		u16 x, y;
> 
> 		x = rd[offset+1] | ((rd[offset+2] & 0xF) << 8);
> 		y = ((rd[offset+2] & 0xF0) >> 4) | (rd[offset+3] << 4);
> @@ -1280,7 +1280,7 @@ static void dualshock4_parse_report(struct sony_sc *sc, __u8 *rd, int size)
> }
> 
> static int sony_raw_event(struct hid_device *hdev, struct hid_report *report,
> -		__u8 *rd, int size)
> +		u8 *rd, int size)
> {
> 	struct sony_sc *sc = hid_get_drvdata(hdev);
> 
> @@ -1404,7 +1404,7 @@ static int sixaxis_set_operational_usb(struct hid_device *hdev)
> {
> 	const int buf_size =
> 		max(SIXAXIS_REPORT_0xF2_SIZE, SIXAXIS_REPORT_0xF5_SIZE);
> -	__u8 *buf;
> +	u8 *buf;
> 	int ret;
> 
> 	buf = kmalloc(buf_size, GFP_KERNEL);
> @@ -1443,8 +1443,8 @@ out:
> 
> static int sixaxis_set_operational_bt(struct hid_device *hdev)
> {
> -	static const __u8 report[] = { 0xf4, 0x42, 0x03, 0x00, 0x00 };
> -	__u8 *buf;
> +	static const u8 report[] = { 0xf4, 0x42, 0x03, 0x00, 0x00 };
> +	u8 *buf;
> 	int ret;
> 
> 	buf = kmemdup(report, sizeof(report), GFP_KERNEL);
> @@ -1465,7 +1465,7 @@ static int sixaxis_set_operational_bt(struct hid_device *hdev)
>  */
> static int dualshock4_set_operational_bt(struct hid_device *hdev)
> {
> -	__u8 *buf;
> +	u8 *buf;
> 	int ret;
> 
> 	buf = kmalloc(DS4_REPORT_0x02_SIZE, GFP_KERNEL);
> @@ -1482,7 +1482,7 @@ static int dualshock4_set_operational_bt(struct hid_device *hdev)
> 
> static void sixaxis_set_leds_from_id(struct sony_sc *sc)
> {
> -	static const __u8 sixaxis_leds[10][4] = {
> +	static const u8 sixaxis_leds[10][4] = {
> 				{ 0x01, 0x00, 0x00, 0x00 },
> 				{ 0x00, 0x01, 0x00, 0x00 },
> 				{ 0x00, 0x00, 0x01, 0x00 },
> @@ -1509,7 +1509,7 @@ static void sixaxis_set_leds_from_id(struct sony_sc *sc)
> static void dualshock4_set_leds_from_id(struct sony_sc *sc)
> {
> 	/* The first 4 color/index entries match what the PS4 assigns */
> -	static const __u8 color_code[7][3] = {
> +	static const u8 color_code[7][3] = {
> 			/* Blue   */	{ 0x00, 0x00, 0x01 },
> 			/* Red	  */	{ 0x01, 0x00, 0x00 },
> 			/* Green  */	{ 0x00, 0x01, 0x00 },
> @@ -1537,7 +1537,7 @@ static void buzz_set_leds(struct sony_sc *sc)
> 		&hdev->report_enum[HID_OUTPUT_REPORT].report_list;
> 	struct hid_report *report = list_entry(report_list->next,
> 		struct hid_report, list);
> -	__s32 *value = report->field[0]->value;
> +	s32 *value = report->field[0]->value;
> 
> 	BUILD_BUG_ON(MAX_LEDS < 4);
> 
> @@ -1631,7 +1631,7 @@ static int sony_led_blink_set(struct led_classdev *led, unsigned long *delay_on,
> 	struct hid_device *hdev = to_hid_device(dev);
> 	struct sony_sc *drv_data = hid_get_drvdata(hdev);
> 	int n;
> -	__u8 new_on, new_off;
> +	u8 new_on, new_off;
> 
> 	if (!drv_data) {
> 		hid_err(hdev, "No device data\n");
> @@ -1702,8 +1702,8 @@ static int sony_leds_init(struct sony_sc *sc)
> 	const char *name_fmt;
> 	static const char * const ds4_name_str[] = { "red", "green", "blue",
> 						  "global" };
> -	__u8 max_brightness[MAX_LEDS] = { [0 ... (MAX_LEDS - 1)] = 1 };
> -	__u8 use_hw_blink[MAX_LEDS] = { 0 };
> +	u8 max_brightness[MAX_LEDS] = { [0 ... (MAX_LEDS - 1)] = 1 };
> +	u8 use_hw_blink[MAX_LEDS] = { 0 };
> 
> 	BUG_ON(!(sc->quirks & SONY_LED_SUPPORT));
> 
> @@ -1731,7 +1731,7 @@ static int sony_leds_init(struct sony_sc *sc)
> 		name_len = 0;
> 		name_fmt = "%s:%s";
> 	} else if (sc->quirks & NAVIGATION_CONTROLLER) {
> -		static const __u8 navigation_leds[4] = {0x01, 0x00, 0x00, 0x00};
> +		static const u8 navigation_leds[4] = {0x01, 0x00, 0x00, 0x00};
> 
> 		memcpy(sc->led_state, navigation_leds, sizeof(navigation_leds));
> 		sc->led_count = 1;
> @@ -1854,7 +1854,7 @@ static void sixaxis_send_output_report(struct sony_sc *sc)
> 		}
> 	}
> 
> -	hid_hw_raw_request(sc->hdev, report->report_id, (__u8 *)report,
> +	hid_hw_raw_request(sc->hdev, report->report_id, (u8 *)report,
> 			sizeof(struct sixaxis_output_report),
> 			HID_OUTPUT_REPORT, HID_REQ_SET_REPORT);
> }
> @@ -1862,7 +1862,7 @@ static void sixaxis_send_output_report(struct sony_sc *sc)
> static void dualshock4_send_output_report(struct sony_sc *sc)
> {
> 	struct hid_device *hdev = sc->hdev;
> -	__u8 *buf = sc->output_report_dmabuf;
> +	u8 *buf = sc->output_report_dmabuf;
> 	int offset;
> 
> 	if (sc->quirks & DUALSHOCK4_CONTROLLER_USB) {
> @@ -1922,7 +1922,7 @@ static void motion_send_output_report(struct sony_sc *sc)
> 	report->rumble = max(sc->right, sc->left);
> #endif
> 
> -	hid_hw_output_report(hdev, (__u8 *)report, MOTION_REPORT_0x02_SIZE);
> +	hid_hw_output_report(hdev, (u8 *)report, MOTION_REPORT_0x02_SIZE);
> }
> 
> static inline void sony_send_output_report(struct sony_sc *sc)
> @@ -2155,7 +2155,7 @@ static int sony_get_bt_devaddr(struct sony_sc *sc)
> 
> static int sony_check_add(struct sony_sc *sc)
> {
> -	__u8 *buf = NULL;
> +	u8 *buf = NULL;
> 	int n, ret;
> 
> 	if ((sc->quirks & DUALSHOCK4_CONTROLLER_BT) ||
> -- 
> 2.7.0
> 

3, 5, 6 and 7 look good to me, so

Acked-by: Frank Praznik <frank.praznik@gmail.com>