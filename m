Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EA5D226CFE;
	Mon,  6 Apr 2026 02:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775443703; cv=none; b=aZucc1SYqKX20CasWiUMnlTQSP4ly56fNMZbbPkU1jt3NaItpIDIk6k9Htb6mT6hxvj04P0cEG6aq148x1IGQU54PoqP9Ip4XGq948WjuBd3m7KpiGCX7kwo+4fqEDfWagC0rBkFrSk/10AYhce0Uv606n1+nA/LWW66qzJvpp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775443703; c=relaxed/simple;
	bh=YLDjhjG7arH9wIgjQHDhpVUvqIrL+D/C7eqFQCU7+Lk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BrcaqdPTAjoU1kuLHVmN0pT3TsS7AmG9bDVb3Y8UWYJd4DNEo+p2NdavrKCWWxGjAKlBJobMzHUWpy5vEoPvz3uud/ISddTKD43tjaDUIGjw3XrQEx/ii3PN79dz8O2iEib/srbaNNGNMxPXv5TxW82cPYx0JlfTD6y1MFiRr8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=cEUn2u5B; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=dyREHZSF; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="cEUn2u5B";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="dyREHZSF"
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4fpv030Ykvz9tf6;
	Mon,  6 Apr 2026 04:48:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1775443699;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=01zFdvjJxU+rpXAIXw7QkBeKTlQafWLJYNleEAhKRmA=;
	b=cEUn2u5BRlx7rFBfhjyvYa8fcPA0dr5PbMlImAJxZKzIvw+79pjHix+vZID3wdLCD8M7Rk
	PB/duWkfWVfk1JZYLRo+sFu9Po53ZAeeNSejn+3CxM3tax/tX70xFC/9e9WCxgJGfbQdWy
	NcC4MCEq2Vbq+nysPWf1ep7/+dUVdZDfnLazNPlVVIT7VYGK7OAN65/ysckTNnQVhm7UJw
	3jc49z0QcLZU5wYQbAKnnTqRcbQ+wbspYin2UupMPvtsRrjFb/VgooyWsS1tmYksGWjqXe
	Dovm9fluEE+xxCktRx7D23MMEUMsCoXuGsaLm0RP8id0AG93fKpN8Pvo4jQiLA==
Authentication-Results: outgoing_mbo_mout;
	dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=dyREHZSF;
	spf=pass (outgoing_mbo_mout: domain of rosalie@mailbox.org designates 2001:67c:2050:b231:465::202 as permitted sender) smtp.mailfrom=rosalie@mailbox.org
From: Rosalie Wanders <rosalie@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1775443697;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=01zFdvjJxU+rpXAIXw7QkBeKTlQafWLJYNleEAhKRmA=;
	b=dyREHZSFD+VUhFdyJzn4/z5mmXsGfpui+DJovkqWYNqfoCvNgNT5cU2cTRXeyDqq46qNMj
	icWggZBJTUv/6QsMcoZTfbeRIzurRA6It9die0bkIo/KXPxeTiteNhlUqCVcpSz7vQOR2p
	xyUydNUk9ko1me1GoNS+MCph8M5xTzl31azKN2+cO9GNIAH9azY/Pfft9IFO3+m+ppdF9w
	slupPqZgmzTIwMckjdoz01MzM83GzAknwDYpQ5bu4Jv0L4qjA12avyAo1NZDv4oX/Eww7V
	orMoLBAB8JOWeuMqfya2j1jSJCSXhgpvh67VFS09r0sOvzL1eKMhZyGoy/SKOA==
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Henrik Rydberg <rydberg@bitmath.org>
Cc: Rosalie Wanders <rosalie@mailbox.org>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] HID: sony: fix style issues
Date: Mon,  6 Apr 2026 04:47:37 +0200
Message-ID: <20260406024737.20589-2-rosalie@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: b64a187d332a3aecea8
X-MBO-RS-META: 7y3rrneqgtp6mn8ibzpodhrz7frbotd1
X-Rspamd-Queue-Id: 4fpv030Ykvz9tf6

This commit fixes inconsistent quirk names and also fixes all the
checkpatch.pl issues alongside inconsistent code, it also adds static
asserts to assert struct sizes at compile time.

Signed-off-by: Rosalie Wanders <rosalie@mailbox.org>
---
 drivers/hid/hid-sony.c | 79 +++++++++++++++++++-----------------------
 1 file changed, 35 insertions(+), 44 deletions(-)

diff --git a/drivers/hid/hid-sony.c b/drivers/hid/hid-sony.c
index bd4b4a470869..695ca085b410 100644
--- a/drivers/hid/hid-sony.c
+++ b/drivers/hid/hid-sony.c
@@ -67,8 +67,8 @@
 #define RB4_GUITAR_PS4_USB        BIT(18)
 #define RB4_GUITAR_PS4_BT         BIT(19)
 #define RB4_GUITAR_PS5            BIT(20)
-#define RB3_PS3_PRO_INSTRUMENT    BIT(21)
-#define PS3_DJH_TURNTABLE         BIT(22)
+#define RB3_PRO_INSTRUMENT        BIT(21)
+#define DJH_TURNTABLE             BIT(22)
 
 #define SIXAXIS_CONTROLLER (SIXAXIS_CONTROLLER_USB | SIXAXIS_CONTROLLER_BT)
 #define MOTION_CONTROLLER (MOTION_CONTROLLER_USB | MOTION_CONTROLLER_BT)
@@ -110,13 +110,6 @@ static const char ghl_ps4_magic_data[] = {
 	0x30, 0x02, 0x08, 0x0A, 0x00, 0x00, 0x00, 0x00, 0x00
 };
 
-/* Rock Band 3 PS3 Pro Instruments require sending a report
- * once an instrument is connected to its dongle.
- * We need to retry sending these reports,
- * but to avoid doing this too often we delay the retries
- */
-#define RB3_PRO_INSTRUMENT_POKE_RETRY_INTERVAL 8 /* In seconds */
-
 /* PS/3 Motion controller */
 static const u8 motion_rdesc[] = {
 	0x05, 0x01,         /*  Usage Page (Desktop),               */
@@ -477,6 +470,7 @@ struct sixaxis_led {
 	u8 duty_off; /* % of duty_length the led is off (0xff means 100%) */
 	u8 duty_on;  /* % of duty_length the led is on (0xff mean 100%) */
 } __packed;
+static_assert(sizeof(struct sixaxis_led) == 5);
 
 struct sixaxis_rumble {
 	u8 padding;
@@ -485,6 +479,7 @@ struct sixaxis_rumble {
 	u8 left_duration;    /* Left motor duration (0xff means forever) */
 	u8 left_motor_force; /* left (large) motor, supports force values from 0 to 255 */
 } __packed;
+static_assert(sizeof(struct sixaxis_rumble) == 5);
 
 struct sixaxis_output_report {
 	u8 report_id;
@@ -494,11 +489,13 @@ struct sixaxis_output_report {
 	struct sixaxis_led led[4];    /* LEDx at (4 - x) */
 	struct sixaxis_led _reserved; /* LED5, not actually soldered */
 } __packed;
+static_assert(sizeof(struct sixaxis_output_report) == 36);
 
 union sixaxis_output_report_01 {
 	struct sixaxis_output_report data;
 	u8 buf[36];
 };
+static_assert(sizeof(union sixaxis_output_report_01) == 36);
 
 struct motion_output_report_02 {
 	u8 type, zero;
@@ -506,6 +503,7 @@ struct motion_output_report_02 {
 	u8 zero2;
 	u8 rumble;
 };
+static_assert(sizeof(struct motion_output_report_02) == 7);
 
 #define SIXAXIS_REPORT_0xF2_SIZE 17
 #define SIXAXIS_REPORT_0xF5_SIZE 8
@@ -536,7 +534,7 @@ struct sony_sc {
 	struct led_classdev *leds[MAX_LEDS];
 	unsigned long quirks;
 	struct work_struct state_worker;
-	void (*send_output_report)(struct sony_sc *);
+	void (*send_output_report)(struct sony_sc *sc);
 	struct power_supply *battery;
 	struct power_supply_desc battery_desc;
 	int device_id;
@@ -613,11 +611,11 @@ static int ghl_init_urb(struct sony_sc *sc, struct usb_device *usbdev,
 	pipe = usb_sndctrlpipe(usbdev, 0);
 
 	cr = devm_kzalloc(&sc->hdev->dev, sizeof(*cr), GFP_ATOMIC);
-	if (cr == NULL)
+	if (!cr)
 		return -ENOMEM;
 
 	databuf = devm_kzalloc(&sc->hdev->dev, poke_size, GFP_ATOMIC);
-	if (databuf == NULL)
+	if (!databuf)
 		return -ENOMEM;
 
 	cr->bRequestType =
@@ -952,6 +950,7 @@ static void sixaxis_parse_report(struct sony_sc *sc, u8 *rd, int size)
 	static const u8 sixaxis_battery_capacity[] = { 0, 1, 25, 50, 75, 100 };
 	unsigned long flags;
 	int offset;
+	u8 index;
 	u8 battery_capacity;
 	int battery_status;
 
@@ -967,7 +966,7 @@ static void sixaxis_parse_report(struct sony_sc *sc, u8 *rd, int size)
 		battery_capacity = 100;
 		battery_status = (rd[offset] & 0x01) ? POWER_SUPPLY_STATUS_FULL : POWER_SUPPLY_STATUS_CHARGING;
 	} else {
-		u8 index = rd[offset] <= 5 ? rd[offset] : 5;
+		index = rd[offset] <= 5 ? rd[offset] : 5;
 		battery_capacity = sixaxis_battery_capacity[index];
 		battery_status = POWER_SUPPLY_STATUS_DISCHARGING;
 	}
@@ -1005,7 +1004,7 @@ static void nsg_mrxu_parse_report(struct sony_sc *sc, u8 *rd, int size)
 	 *   the touch-related data starts at offset 2.
 	 * For the first byte, bit 0 is set when touchpad button is pressed.
 	 * Bit 2 is set when a touch is active and the drag (Fn) key is pressed.
-	 * This drag key is mapped to BTN_LEFT.  It is operational only when a 
+	 * This drag key is mapped to BTN_LEFT.  It is operational only when a
 	 *   touch point is active.
 	 * Bit 4 is set when only the first touch point is active.
 	 * Bit 6 is set when only the second touch point is active.
@@ -1152,11 +1151,10 @@ static int sony_raw_event(struct hid_device *hdev, struct hid_report *report,
 	/* Rock Band 3 PS3 Pro instruments set rd[24] to 0xE0 when they're
 	 * sending full reports, and 0x02 when only sending navigation.
 	 */
-	if ((sc->quirks & RB3_PS3_PRO_INSTRUMENT) && rd[24] == 0x02) {
-		/* Only attempt to enable report every 8 seconds */
+	if ((sc->quirks & RB3_PRO_INSTRUMENT) && rd[24] == 0x02) {
+		/* Only attempt to enable full report every 8 seconds */
 		if (time_after(jiffies, sc->rb3_pro_poke_jiffies)) {
-			sc->rb3_pro_poke_jiffies = jiffies +
-				(RB3_PRO_INSTRUMENT_POKE_RETRY_INTERVAL * HZ);
+			sc->rb3_pro_poke_jiffies = jiffies + secs_to_jiffies(8);
 			rb3_pro_instrument_enable_full_report(sc);
 		}
 	}
@@ -1218,7 +1216,7 @@ static int sony_mapping(struct hid_device *hdev, struct hid_input *hi,
 	if (sc->quirks & GH_GUITAR_TILT)
 		return gh_guitar_mapping(hdev, hi, field, usage, bit, max);
 
-	if (sc->quirks & PS3_DJH_TURNTABLE)
+	if (sc->quirks & DJH_TURNTABLE)
 		return djh_turntable_mapping(hdev, hi, field, usage, bit, max);
 
 	if (sc->quirks & (RB4_GUITAR_PS4_USB | RB4_GUITAR_PS4_BT))
@@ -1273,19 +1271,18 @@ static int sony_register_touchpad(struct sony_sc *sc, int touch_count,
 	input_set_abs_params(sc->touchpad, ABS_MT_POSITION_Y, 0, h, 0, 0);
 
 	if (touch_major > 0) {
-		input_set_abs_params(sc->touchpad, ABS_MT_TOUCH_MAJOR, 
+		input_set_abs_params(sc->touchpad, ABS_MT_TOUCH_MAJOR,
 			0, touch_major, 0, 0);
 		if (touch_minor > 0)
-			input_set_abs_params(sc->touchpad, ABS_MT_TOUCH_MINOR, 
+			input_set_abs_params(sc->touchpad, ABS_MT_TOUCH_MINOR,
 				0, touch_minor, 0, 0);
 		if (orientation > 0)
-			input_set_abs_params(sc->touchpad, ABS_MT_ORIENTATION, 
+			input_set_abs_params(sc->touchpad, ABS_MT_ORIENTATION,
 				0, orientation, 0, 0);
 	}
 
-	if (sc->quirks & NSG_MRXU_REMOTE) {
+	if (sc->quirks & NSG_MRXU_REMOTE)
 		__set_bit(EV_REL, sc->touchpad->evbit);
-	}
 
 	ret = input_mt_init_slots(sc->touchpad, touch_count, INPUT_MT_POINTER);
 	if (ret < 0)
@@ -1440,7 +1437,7 @@ static void sixaxis_set_leds_from_id(struct sony_sc *sc)
 
 	int id = sc->device_id;
 
-	BUILD_BUG_ON(MAX_LEDS < ARRAY_SIZE(sixaxis_leds[0]));
+	BUILD_BUG_ON(ARRAY_SIZE(sixaxis_leds[0]) > MAX_LEDS);
 
 	if (id < 0)
 		return;
@@ -1458,7 +1455,7 @@ static void buzz_set_leds(struct sony_sc *sc)
 		struct hid_report, list);
 	s32 *value = report->field[0]->value;
 
-	BUILD_BUG_ON(MAX_LEDS < 4);
+	BUILD_BUG_ON(4 > MAX_LEDS);
 
 	value[0] = 0x00;
 	value[1] = sc->led_state[0] ? 0xff : 0x00;
@@ -1655,15 +1652,12 @@ static int sony_leds_init(struct sony_sc *sc)
 			name_sz = strlen(dev_name(&hdev->dev)) + strlen(color_name_str[n]) + 2;
 
 		led = devm_kzalloc(&hdev->dev, sizeof(struct led_classdev) + name_sz, GFP_KERNEL);
-		if (!led) {
-			hid_err(hdev, "Couldn't allocate memory for LED %d\n", n);
+		if (!led)
 			return -ENOMEM;
-		}
 
 		name = (void *)(&led[1]);
 		if (use_color_names)
-			snprintf(name, name_sz, name_fmt, dev_name(&hdev->dev),
-			color_name_str[n]);
+			snprintf(name, name_sz, name_fmt, dev_name(&hdev->dev), color_name_str[n]);
 		else
 			snprintf(name, name_sz, name_fmt, dev_name(&hdev->dev), n + 1);
 		led->name = name;
@@ -2180,7 +2174,7 @@ static int sony_input_configured(struct hid_device *hdev,
 		}
 
 		sony_init_output_report(sc, sixaxis_send_output_report);
-	} else if (sc->quirks & RB3_PS3_PRO_INSTRUMENT) {
+	} else if (sc->quirks & RB3_PRO_INSTRUMENT) {
 		/*
 		 * Rock Band 3 PS3 Pro Instruments also do not handle HID Output
 		 * Reports on the interrupt EP like they should, so we need to force
@@ -2309,10 +2303,8 @@ static int sony_probe(struct hid_device *hdev, const struct hid_device_id *id)
 		quirks |= SHANWAN_GAMEPAD;
 
 	sc = devm_kzalloc(&hdev->dev, sizeof(*sc), GFP_KERNEL);
-	if (sc == NULL) {
-		hid_err(hdev, "can't alloc sony descriptor\n");
+	if (!sc)
 		return -ENOMEM;
-	}
 
 	spin_lock_init(&sc->lock);
 
@@ -2360,9 +2352,8 @@ static int sony_probe(struct hid_device *hdev, const struct hid_device_id *id)
 		goto err;
 	}
 
-	if (sc->quirks & RB3_PS3_PRO_INSTRUMENT) {
+	if (sc->quirks & RB3_PRO_INSTRUMENT)
 		sc->rb3_pro_poke_jiffies = 0;
-	}
 
 	if (sc->quirks & (GHL_GUITAR_PS3WIIU | GHL_GUITAR_PS4)) {
 		if (!hid_is_usb(hdev)) {
@@ -2514,7 +2505,7 @@ static const struct hid_device_id sony_devices[] = {
 		.driver_data = INSTRUMENT },
 	/* DJ Hero PS3 Guitar Dongle */
 	{ HID_USB_DEVICE(USB_VENDOR_ID_SONY_RHYTHM, USB_DEVICE_ID_SONY_PS3_DJH_TURNTABLE),
-		.driver_data = PS3_DJH_TURNTABLE | INSTRUMENT },
+		.driver_data = DJH_TURNTABLE | INSTRUMENT },
 	/* Guitar Hero Live PS4 guitar dongles */
 	{ HID_USB_DEVICE(USB_VENDOR_ID_REDOCTANE, USB_DEVICE_ID_REDOCTANE_PS4_GHLIVE_DONGLE),
 		.driver_data = GHL_GUITAR_PS4 | GH_GUITAR_TILT | INSTRUMENT },
@@ -2552,17 +2543,17 @@ static const struct hid_device_id sony_devices[] = {
 		.driver_data = INSTRUMENT },
 	/* Rock Band 3 PS3 Pro instruments */
 	{ HID_USB_DEVICE(USB_VENDOR_ID_SONY_RHYTHM, USB_DEVICE_ID_SONY_PS3_RB3_MUSTANG_GUITAR),
-		.driver_data = INSTRUMENT | RB3_PS3_PRO_INSTRUMENT },
+		.driver_data = INSTRUMENT | RB3_PRO_INSTRUMENT },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_SONY_RHYTHM, USB_DEVICE_ID_SONY_PS3_RB3_SQUIRE_GUITAR),
-		.driver_data = INSTRUMENT | RB3_PS3_PRO_INSTRUMENT },
+		.driver_data = INSTRUMENT | RB3_PRO_INSTRUMENT },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_SONY_RHYTHM, USB_DEVICE_ID_SONY_PS3_RB3_MPA_MUSTANG_MODE),
-		.driver_data = INSTRUMENT | RB3_PS3_PRO_INSTRUMENT },
+		.driver_data = INSTRUMENT | RB3_PRO_INSTRUMENT },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_SONY_RHYTHM, USB_DEVICE_ID_SONY_PS3_RB3_MPA_SQUIRE_MODE),
-		.driver_data = INSTRUMENT | RB3_PS3_PRO_INSTRUMENT },
+		.driver_data = INSTRUMENT | RB3_PRO_INSTRUMENT },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_SONY_RHYTHM, USB_DEVICE_ID_SONY_PS3_RB3_KEYBOARD),
-		.driver_data = INSTRUMENT | RB3_PS3_PRO_INSTRUMENT },
+		.driver_data = INSTRUMENT | RB3_PRO_INSTRUMENT },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_SONY_RHYTHM, USB_DEVICE_ID_SONY_PS3_RB3_MPA_KEYBOARD_MODE),
-		.driver_data = INSTRUMENT | RB3_PS3_PRO_INSTRUMENT },
+		.driver_data = INSTRUMENT | RB3_PRO_INSTRUMENT },
 	/* Rock Band 4 PS4 guitars */
 	{ HID_USB_DEVICE(USB_VENDOR_ID_PDP, USB_DEVICE_ID_PDP_PS4_RIFFMASTER),
 		.driver_data = RB4_GUITAR_PS4_USB | INSTRUMENT },
-- 
2.53.0

