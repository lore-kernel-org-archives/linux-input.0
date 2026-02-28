Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D33F76BB5B;
	Sat, 28 Feb 2026 06:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772258879; cv=none; b=ieTLSWlP58W+Hthj3qfNHtWgo6eJkdKCVe/wpOKuL1B//TswtKL8+n2PPSXzaWeMHh4wp5F9N8CQ8J6GOj1ppUCSXKxiUI4clZk40IC+IC9yiAqycWauGTfpjg6sH7zIvB9DPEPtEvnVOSbdo+0P3iwqDTh3I2jrNYkNMTxf0tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772258879; c=relaxed/simple;
	bh=RyLfpWdDB3zXEjtT5ICp3sImAtlLVC++LTT/T1UGoK8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UBd/H1AO3/XqDw5bX8jZd+lLOGRifCyrz2gedH1nWG/v7rnlWc1yyEjlYbHW81HKbe0DqyE5hTJpPUsLZ7yhArP3xojkIwk29AZquV67ksvZ3blJmaU6ZWDzzJnr87lUncKwkxdi6gklqjXlTj4/fFLL4eGuGKuNLE8WaKf0JBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=Cu7iwXju; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=r64biTHg; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="Cu7iwXju";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="r64biTHg"
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4fNF9P4DNwz9tnB;
	Sat, 28 Feb 2026 07:07:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1772258873;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=kSmIZsSoVftJRe8Q6G6Pb2efg65AzI+eLlL8xYWudnA=;
	b=Cu7iwXjuOMGrMsjVn5C1NsBkvY3NfSi47Vc5MTdNiCh38AnQt/qYxDV9Jqsmy+5EuJ6YEh
	97ulQ8tC2jnkL1aikS04r+jIAJH8X+7tTMeH35Js8wxWRuv6eQjuh79lEEpGbC84XV0cGC
	QMw0mJwm+97IVDUJIjIkvPWuv0LKbU/FdldltpJeHS42vgZaGcvDTPNKrwdgufwTijMFSs
	ZF2ihWZMaLCGF9HGxcoekRxp2EHucGStyCqU1wXB8mddQF3rE/jEI4a39AJp2Ud1rD27RG
	6nHsjXzWOJD5Ps42Sst1P2WHSSyninrIWo4lTSJl5cTiQnD5dtpi5wrFCaxj9w==
Authentication-Results: outgoing_mbo_mout;
	dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=r64biTHg;
	spf=pass (outgoing_mbo_mout: domain of rosalie@mailbox.org designates 2001:67c:2050:b231:465::202 as permitted sender) smtp.mailfrom=rosalie@mailbox.org
From: Rosalie Wanders <rosalie@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1772258871;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=kSmIZsSoVftJRe8Q6G6Pb2efg65AzI+eLlL8xYWudnA=;
	b=r64biTHgtZCg7GQsdxbAx3bHKXJGQ/sYvLJ1c/co40fqPZFEyHwwrEpMNElGFQAxB9Fis5
	ncViAQWikWyOiLvop18ggHYuOB3Rpb5asXo2tbe3S3CyYORiRicWmTAXStdKcR+KrAjtDj
	tp1GM4OIMuvTOQUBp6jo2x/XlzJ1u89lHOls6xPze6pMWiY6+WWZ2qr8t/mt0TqP/+/bTi
	qhnhYpyZJ8QYi3nJ4CFj9CPw//BmNJi2BRmaUpNxitEdsqmlBskxT3VK2hI/eLVwrtdfYr
	V+SIKUP6syc8MAOrsnYFSyT2AbLUYCOWNJq5JxZ/zA9fxxCQjkDEHUDNdDyhnw==
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: Rosalie Wanders <rosalie@mailbox.org>,
	Sanjay Govind <sanjay.govind9@gmail.com>,
	Brenton Simpson <appsforartists@google.com>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] HID: sony: add support for more instruments
Date: Sat, 28 Feb 2026 07:05:52 +0100
Message-ID: <20260228060552.53741-2-rosalie@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: c8df882368ff027deef
X-MBO-RS-META: 5w3byn9k8jw6ufhjsyz68o5f1cdbtjuy
X-Rspamd-Queue-Id: 4fNF9P4DNwz9tnB

This patch adds support for the following instruments:

* Rock Band 1/2/3 Wii/PS3 instruments
* Rock Band 3 PS3 Pro instruments
* DJ Hero Turntable

Wii and PS3 instruments are the same besides the vendor and product ID.

This patch also fixes the mappings for the existing Guitar Hero
instruments.

Co-developed-by: Sanjay Govind <sanjay.govind9@gmail.com>
Signed-off-by: Sanjay Govind <sanjay.govind9@gmail.com>
Co-developed-by: Brenton Simpson <appsforartists@google.com>
Signed-off-by: Brenton Simpson <appsforartists@google.com>
Signed-off-by: Rosalie Wanders <rosalie@mailbox.org>
---
 drivers/hid/hid-ids.h  |  28 ++++-
 drivers/hid/hid-sony.c | 278 ++++++++++++++++++++++++++++++++++-------
 2 files changed, 259 insertions(+), 47 deletions(-)

diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 3e299a30dcde..b0bb34fe000b 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -664,6 +664,19 @@
 #define USB_DEVICE_ID_UGCI_FLYING	0x0020
 #define USB_DEVICE_ID_UGCI_FIGHTING	0x0030
 
+#define USB_VENDOR_ID_HARMONIX		0x1bad
+#define USB_DEVICE_ID_HARMONIX_WII_RB1_GUITAR	0x0004
+#define USB_DEVICE_ID_HARMONIX_WII_RB2_GUITAR	0x3010
+#define USB_DEVICE_ID_HARMONIX_WII_RB1_DRUMS	    0x0005
+#define USB_DEVICE_ID_HARMONIX_WII_RB2_DRUMS	    0x3110
+#define USB_DEVICE_ID_HARMONIX_WII_RB3_MPA_DRUMS_MODE	0x3138
+#define USB_DEVICE_ID_HARMONIX_WII_RB3_MUSTANG_GUITAR	0x3430
+#define USB_DEVICE_ID_HARMONIX_WII_RB3_SQUIRE_GUITAR	0x3530
+#define USB_DEVICE_ID_HARMONIX_WII_RB3_MPA_MUSTANG_MODE	0x3438
+#define USB_DEVICE_ID_HARMONIX_WII_RB3_MPA_SQUIRE_MODE	0x3538
+#define USB_DEVICE_ID_HARMONIX_WII_RB3_KEYBOARD	        0x3330
+#define USB_DEVICE_ID_HARMONIX_WII_RB3_MPA_KEYBOARD_MODE	0x3338
+
 #define USB_VENDOR_ID_HP		0x03f0
 #define USB_PRODUCT_ID_HP_ELITE_PRESENTER_MOUSE_464A		0x464a
 #define USB_PRODUCT_ID_HP_LOGITECH_OEM_USB_OPTICAL_MOUSE_0A4A	0x0a4a
@@ -1298,8 +1311,19 @@
 #define USB_DEVICE_ID_SONY_WIRELESS_BUZZ_CONTROLLER	0x1000
 
 #define USB_VENDOR_ID_SONY_RHYTHM	0x12ba
-#define USB_DEVICE_ID_SONY_PS3WIIU_GHLIVE_DONGLE	0x074b
-#define USB_DEVICE_ID_SONY_PS3_GUITAR_DONGLE	0x0100
+#define USB_DEVICE_ID_SONY_PS3WIIU_GHLIVE	0x074b
+#define USB_DEVICE_ID_SONY_PS3_GH_GUITAR	0x0100
+#define USB_DEVICE_ID_SONY_PS3_GH_DRUMS		0x0120
+#define USB_DEVICE_ID_SONY_PS3_DJH_TURNTABLE	0x0140
+#define USB_DEVICE_ID_SONY_PS3_RB_GUITAR	0x0200
+#define USB_DEVICE_ID_SONY_PS3_RB_DRUMS		0x0210
+#define USB_DEVICE_ID_SONY_PS3_RB3_MPA_DRUMS_MODE	0x0218
+#define USB_DEVICE_ID_SONY_PS3_RB3_MUSTANG_GUITAR	0x2430
+#define USB_DEVICE_ID_SONY_PS3_RB3_SQUIRE_GUITAR	0x2530
+#define USB_DEVICE_ID_SONY_PS3_RB3_MPA_MUSTANG_MODE	0x2438
+#define USB_DEVICE_ID_SONY_PS3_RB3_MPA_SQUIRE_MODE	0x2538
+#define USB_DEVICE_ID_SONY_PS3_RB3_KEYBOARD	        0x2330
+#define USB_DEVICE_ID_SONY_PS3_RB3_MPA_KEYBOARD_MODE	0x2338
 
 #define USB_VENDOR_ID_SINO_LITE			0x1345
 #define USB_DEVICE_ID_SINO_LITE_CONTROLLER	0x3008
diff --git a/drivers/hid/hid-sony.c b/drivers/hid/hid-sony.c
index a89af14e4acc..4b0992cfc8a7 100644
--- a/drivers/hid/hid-sony.c
+++ b/drivers/hid/hid-sony.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 /*
- *  HID driver for Sony / PS2 / PS3 / PS4 BD devices.
+ *  HID driver for Sony / PS2 / PS3 / PS4 / PS5 BD devices.
  *
  *  Copyright (c) 1999 Andreas Gal
  *  Copyright (c) 2000-2005 Vojtech Pavlik <vojtech@suse.cz>
@@ -12,9 +12,10 @@
  *  Copyright (c) 2014-2016 Frank Praznik <frank.praznik@gmail.com>
  *  Copyright (c) 2018 Todd Kelner
  *  Copyright (c) 2020-2021 Pascal Giard <pascal.giard@etsmtl.ca>
- *  Copyright (c) 2020 Sanjay Govind <sanjay.govind9@gmail.com>
+ *  Copyright (c) 2020-2026 Sanjay Govind <sanjay.govind9@gmail.com>
  *  Copyright (c) 2021 Daniel Nguyen <daniel.nguyen.1@ens.etsmtl.ca>
  *  Copyright (c) 2026 Rosalie Wanders <rosalie@mailbox.org>
+ *  Copyright (c) 2026 Brenton Simpson <appsforartists@google.com>
  */
 
 /*
@@ -59,12 +60,15 @@
 #define NSG_MR5U_REMOTE_BT        BIT(11)
 #define NSG_MR7U_REMOTE_BT        BIT(12)
 #define SHANWAN_GAMEPAD           BIT(13)
-#define GH_GUITAR_CONTROLLER      BIT(14)
-#define GHL_GUITAR_PS3WIIU        BIT(15)
-#define GHL_GUITAR_PS4            BIT(16)
-#define RB4_GUITAR_PS4_USB        BIT(17)
-#define RB4_GUITAR_PS4_BT         BIT(18)
-#define RB4_GUITAR_PS5            BIT(19)
+#define INSTRUMENT                BIT(14)
+#define GH_GUITAR_TILT            BIT(15)
+#define GHL_GUITAR_PS3WIIU        BIT(16)
+#define GHL_GUITAR_PS4            BIT(17)
+#define RB4_GUITAR_PS4_USB        BIT(18)
+#define RB4_GUITAR_PS4_BT         BIT(19)
+#define RB4_GUITAR_PS5            BIT(20)
+#define RB3_PS3_PRO_INSTRUMENT    BIT(21)
+#define PS3_DJH_TURNTABLE		  BIT(22)
 
 #define SIXAXIS_CONTROLLER (SIXAXIS_CONTROLLER_USB | SIXAXIS_CONTROLLER_BT)
 #define MOTION_CONTROLLER (MOTION_CONTROLLER_USB | MOTION_CONTROLLER_BT)
@@ -87,6 +91,10 @@
 #define GHL_GUITAR_POKE_INTERVAL 8 /* In seconds */
 #define GUITAR_TILT_USAGE 44
 
+#define TURNTABLE_EFFECTS_KNOB_USAGE 44
+#define TURNTABLE_PLATTER_BUTTONS_USAGE 45
+#define TURNTABLE_CROSS_FADER_USAGE 46
+
 /* Magic data taken from GHLtarUtility:
  * https://github.com/ghlre/GHLtarUtility/blob/master/PS3Guitar.cs
  * Note: The Wii U and PS3 dongles happen to share the same!
@@ -102,6 +110,13 @@ static const char ghl_ps4_magic_data[] = {
 	0x30, 0x02, 0x08, 0x0A, 0x00, 0x00, 0x00, 0x00, 0x00
 };
 
+/* Rock Band 3 PS3 Pro Instruments require sending a report
+ * once an instrument is connected to its dongle.
+ * We need to retry sending these reports,
+ * but to avoid doing this too often we delay the retries
+ */
+#define RB3_PRO_INSTRUMENT_POKE_RETRY_INTERVAL 8 /* In seconds */
+
 /* PS/3 Motion controller */
 static const u8 motion_rdesc[] = {
 	0x05, 0x01,         /*  Usage Page (Desktop),               */
@@ -427,20 +442,25 @@ static const unsigned int rb4_absmap[] = {
 	[0x31] = ABS_Y,
 };
 
-static const unsigned int rb4_keymap[] = {
-	[0x1] = BTN_WEST, /* Square */
-	[0x2] = BTN_SOUTH, /* Cross */
-	[0x3] = BTN_EAST, /* Circle */
-	[0x4] = BTN_NORTH, /* Triangle */
-	[0x5] = BTN_TL, /* L1 */
-	[0x6] = BTN_TR, /* R1 */
-	[0x7] = BTN_TL2, /* L2 */
-	[0x8] = BTN_TR2, /* R2 */
-	[0x9] = BTN_SELECT, /* Share */
-	[0xa] = BTN_START, /* Options */
-	[0xb] = BTN_THUMBL, /* L3 */
-	[0xc] = BTN_THUMBR, /* R3 */
-	[0xd] = BTN_MODE, /* PS */
+static const unsigned int ps3_turntable_absmap[] = {
+	[0x32] = ABS_X,
+	[0x35] = ABS_Y,
+};
+
+static const unsigned int instrument_keymap[] = {
+	[0x1] = BTN_WEST,
+	[0x2] = BTN_SOUTH,
+	[0x3] = BTN_EAST,
+	[0x4] = BTN_NORTH,
+	[0x5] = BTN_TL,
+	[0x6] = BTN_TR,
+	[0x7] = BTN_TL2,
+	[0x8] = BTN_TR2,
+	[0x9] = BTN_SELECT,
+	[0xa] = BTN_START,
+	[0xb] = BTN_THUMBL,
+	[0xc] = BTN_THUMBR,
+	[0xd] = BTN_MODE,
 };
 
 static enum power_supply_property sony_battery_props[] = {
@@ -490,6 +510,7 @@ struct motion_output_report_02 {
 #define SIXAXIS_REPORT_0xF2_SIZE 17
 #define SIXAXIS_REPORT_0xF5_SIZE 8
 #define MOTION_REPORT_0x02_SIZE 49
+#define PRO_INSTRUMENT_0x00_SIZE 8
 
 #define SENSOR_SUFFIX " Motion Sensors"
 #define TOUCHPAD_SUFFIX " Touchpad"
@@ -539,6 +560,9 @@ struct sony_sc {
 	/* GH Live */
 	struct urb *ghl_urb;
 	struct timer_list ghl_poke_timer;
+
+	/* Rock Band 3 Pro Instruments */
+	unsigned long rb3_pro_poke_jiffies;
 };
 
 static void sony_set_leds(struct sony_sc *sc);
@@ -610,35 +634,108 @@ static int ghl_init_urb(struct sony_sc *sc, struct usb_device *usbdev,
 	return 0;
 }
 
-static int gh_guitar_mapping(struct hid_device *hdev, struct hid_input *hi,
+
+
+/*
+ * Sending HID_REQ_SET_REPORT enables the full report. Without this
+ * Rock Band 3 Pro instruments only report navigation events
+ */
+static int rb3_pro_instrument_enable_full_report(struct sony_sc *sc)
+{
+	struct hid_device *hdev = sc->hdev;
+	static const u8 report[] = { 0x00, 0xE9, 0x00, 0x89, 0x1B,
+								 0x00, 0x00, 0x00, 0x02, 0x00,
+								 0x00, 0x00, 0x00, 0x00, 0x00,
+								 0x00, 0x00, 0x00, 0x00, 0x00,
+								 0x00, 0x00, 0x80, 0x00, 0x00,
+								 0x00, 0x00, 0x89, 0x00, 0x00,
+								 0x00, 0x00, 0x00, 0xE9, 0x01,
+								 0x00, 0x00, 0x00, 0x00, 0x00,
+								 0x00 };
+	u8 *buf;
+	int ret;
+
+	buf = kmemdup(report, sizeof(report), GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+
+	ret = hid_hw_raw_request(hdev, buf[0], buf, sizeof(report),
+				  HID_FEATURE_REPORT, HID_REQ_SET_REPORT);
+
+	kfree(buf);
+
+	return ret;
+}
+
+static int djh_turntable_mapping(struct hid_device *hdev, struct hid_input *hi,
 			  struct hid_field *field, struct hid_usage *usage,
 			  unsigned long **bit, int *max)
 {
 	if ((usage->hid & HID_USAGE_PAGE) == HID_UP_MSVENDOR) {
 		unsigned int abs = usage->hid & HID_USAGE;
 
-		if (abs == GUITAR_TILT_USAGE) {
+		if (abs == TURNTABLE_CROSS_FADER_USAGE) {
+			hid_map_usage_clear(hi, usage, bit, max, EV_ABS, ABS_RX);
+			return 1;
+		} else if (abs == TURNTABLE_EFFECTS_KNOB_USAGE) {
 			hid_map_usage_clear(hi, usage, bit, max, EV_ABS, ABS_RY);
 			return 1;
+		} else if (abs == TURNTABLE_PLATTER_BUTTONS_USAGE) {
+			hid_map_usage_clear(hi, usage, bit, max, EV_ABS, ABS_RZ);
+			return 1;
 		}
+	} else if ((usage->hid & HID_USAGE_PAGE) == HID_UP_GENDESK) {
+		unsigned int abs = usage->hid & HID_USAGE;
+
+		if (abs >= ARRAY_SIZE(ps3_turntable_absmap))
+			return -1;
+
+		abs = ps3_turntable_absmap[abs];
+
+		hid_map_usage_clear(hi, usage, bit, max, EV_ABS, abs);
+		return 1;
 	}
 	return 0;
 }
 
-static int rb4_guitar_mapping(struct hid_device *hdev, struct hid_input *hi,
+static int instrument_mapping(struct hid_device *hdev, struct hid_input *hi,
 			  struct hid_field *field, struct hid_usage *usage,
 			  unsigned long **bit, int *max)
 {
 	if ((usage->hid & HID_USAGE_PAGE) == HID_UP_BUTTON) {
 		unsigned int key = usage->hid & HID_USAGE;
 
-		if (key >= ARRAY_SIZE(rb4_keymap))
+		if (key >= ARRAY_SIZE(instrument_keymap))
 			return 0;
 
-		key = rb4_keymap[key];
+		key = instrument_keymap[key];
 		hid_map_usage_clear(hi, usage, bit, max, EV_KEY, key);
 		return 1;
-	} else if ((usage->hid & HID_USAGE_PAGE) == HID_UP_GENDESK) {
+	}
+
+	return 0;
+}
+
+static int gh_guitar_mapping(struct hid_device *hdev, struct hid_input *hi,
+			  struct hid_field *field, struct hid_usage *usage,
+			  unsigned long **bit, int *max)
+{
+	if ((usage->hid & HID_USAGE_PAGE) == HID_UP_MSVENDOR) {
+		unsigned int abs = usage->hid & HID_USAGE;
+
+		if (abs == GUITAR_TILT_USAGE) {
+			hid_map_usage_clear(hi, usage, bit, max, EV_ABS, ABS_RY);
+			return 1;
+		}
+	}
+	return 0;
+}
+
+static int rb4_guitar_mapping(struct hid_device *hdev, struct hid_input *hi,
+			  struct hid_field *field, struct hid_usage *usage,
+			  unsigned long **bit, int *max)
+{
+	if ((usage->hid & HID_USAGE_PAGE) == HID_UP_GENDESK) {
 		unsigned int abs = usage->hid & HID_USAGE;
 
 		/* Let the HID parser deal with the HAT. */
@@ -1052,6 +1149,18 @@ static int sony_raw_event(struct hid_device *hdev, struct hid_report *report,
 		return 1;
 	}
 
+	/* Rock Band 3 PS3 Pro instruments set rd[24] to 0xE0 when they're
+	 * sending full reports, and 0x02 when only sending navigation.
+	 */
+	if ((sc->quirks & RB3_PS3_PRO_INSTRUMENT) && rd[24] == 0x02) {
+		/* Only attempt to enable report every 8 seconds */
+		if (time_after(jiffies, sc->rb3_pro_poke_jiffies)) {
+			sc->rb3_pro_poke_jiffies = jiffies +
+				(RB3_PRO_INSTRUMENT_POKE_RETRY_INTERVAL * HZ);
+			rb3_pro_instrument_enable_full_report(sc);
+		}
+	}
+
 	if (sc->defer_initialization) {
 		sc->defer_initialization = 0;
 		sony_schedule_work(sc, SONY_WORKER_STATE);
@@ -1065,6 +1174,7 @@ static int sony_mapping(struct hid_device *hdev, struct hid_input *hi,
 			unsigned long **bit, int *max)
 {
 	struct sony_sc *sc = hid_get_drvdata(hdev);
+	int ret;
 
 	if (sc->quirks & BUZZ_CONTROLLER) {
 		unsigned int key = usage->hid & HID_USAGE;
@@ -1098,9 +1208,19 @@ static int sony_mapping(struct hid_device *hdev, struct hid_input *hi,
 	if (sc->quirks & SIXAXIS_CONTROLLER)
 		return sixaxis_mapping(hdev, hi, field, usage, bit, max);
 
-	if (sc->quirks & GH_GUITAR_CONTROLLER)
+	/* INSTRUMENT quirk is used as a base mapping for instruments */
+	if (sc->quirks & INSTRUMENT) {
+		ret = instrument_mapping(hdev, hi, field, usage, bit, max);
+		if (ret != 0)
+			return ret;
+	}
+
+	if (sc->quirks & GH_GUITAR_TILT)
 		return gh_guitar_mapping(hdev, hi, field, usage, bit, max);
 
+	if (sc->quirks & PS3_DJH_TURNTABLE)
+		return djh_turntable_mapping(hdev, hi, field, usage, bit, max);
+
 	if (sc->quirks & (RB4_GUITAR_PS4_USB | RB4_GUITAR_PS4_BT))
 		return rb4_guitar_mapping(hdev, hi, field, usage, bit, max);
 
@@ -2060,6 +2180,19 @@ static int sony_input_configured(struct hid_device *hdev,
 		}
 
 		sony_init_output_report(sc, sixaxis_send_output_report);
+	} else if (sc->quirks & RB3_PS3_PRO_INSTRUMENT) {
+		/*
+		 * Rock Band 3 PS3 Pro Instruments also do not handle HID Output
+		 * Reports on the interrupt EP like they should, so we need to force
+		 * HID output reports to use HID_REQ_SET_REPORT on the Control EP.
+		 *
+		 * There is also another issue about HID Output Reports via USB,
+		 * these instruments do not want the report_id as part of the data
+		 * packet, so we have to discard buf[0] when sending the actual
+		 * control message, even for numbered reports.
+		 */
+		hdev->quirks |= HID_QUIRK_NO_OUTPUT_REPORTS_ON_INTR_EP;
+		hdev->quirks |= HID_QUIRK_SKIP_OUTPUT_REPORT_ID;
 	} else if (sc->quirks & SIXAXIS_CONTROLLER_USB) {
 		/*
 		 * The Sony Sixaxis does not handle HID Output Reports on the
@@ -2227,6 +2360,10 @@ static int sony_probe(struct hid_device *hdev, const struct hid_device_id *id)
 		goto err;
 	}
 
+	if (sc->quirks & RB3_PS3_PRO_INSTRUMENT) {
+		sc->rb3_pro_poke_jiffies = 0;
+	}
+
 	if (sc->quirks & (GHL_GUITAR_PS3WIIU | GHL_GUITAR_PS4)) {
 		if (!hid_is_usb(hdev)) {
 			ret = -EINVAL;
@@ -2364,35 +2501,86 @@ static const struct hid_device_id sony_devices[] = {
 	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_SMK, USB_DEVICE_ID_SMK_NSG_MR7U_REMOTE),
 		.driver_data = NSG_MR7U_REMOTE_BT },
 	/* Guitar Hero Live PS3 and Wii U guitar dongles */
-	{ HID_USB_DEVICE(USB_VENDOR_ID_SONY_RHYTHM, USB_DEVICE_ID_SONY_PS3WIIU_GHLIVE_DONGLE),
-		.driver_data = GHL_GUITAR_PS3WIIU | GH_GUITAR_CONTROLLER },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_SONY_RHYTHM, USB_DEVICE_ID_SONY_PS3WIIU_GHLIVE),
+		.driver_data = GHL_GUITAR_PS3WIIU | GH_GUITAR_TILT | INSTRUMENT },
 	/* Guitar Hero PC Guitar Dongle */
 	{ HID_USB_DEVICE(USB_VENDOR_ID_REDOCTANE, USB_DEVICE_ID_REDOCTANE_GUITAR_DONGLE),
-		.driver_data = GH_GUITAR_CONTROLLER },
-	/* Guitar Hero PS3 World Tour Guitar Dongle */
-	{ HID_USB_DEVICE(USB_VENDOR_ID_SONY_RHYTHM, USB_DEVICE_ID_SONY_PS3_GUITAR_DONGLE),
-		.driver_data = GH_GUITAR_CONTROLLER },
+		.driver_data = GH_GUITAR_TILT | INSTRUMENT },
+	/* Guitar Hero PS3 Guitar Dongle */
+	{ HID_USB_DEVICE(USB_VENDOR_ID_SONY_RHYTHM, USB_DEVICE_ID_SONY_PS3_GH_GUITAR),
+		.driver_data = GH_GUITAR_TILT | INSTRUMENT },
+	/* Guitar Hero PS3 Drum Dongle */
+	{ HID_USB_DEVICE(USB_VENDOR_ID_SONY_RHYTHM, USB_DEVICE_ID_SONY_PS3_GH_DRUMS),
+		.driver_data = INSTRUMENT },
+	/* DJ Hero PS3 Guitar Dongle */
+	{ HID_USB_DEVICE(USB_VENDOR_ID_SONY_RHYTHM, USB_DEVICE_ID_SONY_PS3_DJH_TURNTABLE),
+		.driver_data = PS3_DJH_TURNTABLE | INSTRUMENT },
 	/* Guitar Hero Live PS4 guitar dongles */
 	{ HID_USB_DEVICE(USB_VENDOR_ID_REDOCTANE, USB_DEVICE_ID_REDOCTANE_PS4_GHLIVE_DONGLE),
-		.driver_data = GHL_GUITAR_PS4 | GH_GUITAR_CONTROLLER },
+		.driver_data = GHL_GUITAR_PS4 | GH_GUITAR_TILT | INSTRUMENT },
+	/* Rock Band 1 Wii instruments */
+	{ HID_USB_DEVICE(USB_VENDOR_ID_HARMONIX, USB_DEVICE_ID_HARMONIX_WII_RB1_GUITAR),
+		.driver_data = INSTRUMENT },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_HARMONIX, USB_DEVICE_ID_HARMONIX_WII_RB1_DRUMS),
+		.driver_data = INSTRUMENT },
+	/* Rock Band 2 Wii instruments */
+	{ HID_USB_DEVICE(USB_VENDOR_ID_HARMONIX, USB_DEVICE_ID_HARMONIX_WII_RB2_GUITAR),
+		.driver_data = INSTRUMENT },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_HARMONIX, USB_DEVICE_ID_HARMONIX_WII_RB2_DRUMS),
+		.driver_data = INSTRUMENT },
+	/* Rock Band 3 Wii instruments */
+	{ HID_USB_DEVICE(USB_VENDOR_ID_HARMONIX, USB_DEVICE_ID_HARMONIX_WII_RB3_MPA_DRUMS_MODE),
+		.driver_data = INSTRUMENT },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_HARMONIX, USB_DEVICE_ID_HARMONIX_WII_RB3_MUSTANG_GUITAR),
+		.driver_data = INSTRUMENT },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_HARMONIX, USB_DEVICE_ID_HARMONIX_WII_RB3_SQUIRE_GUITAR),
+		.driver_data = INSTRUMENT },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_HARMONIX, USB_DEVICE_ID_HARMONIX_WII_RB3_MPA_MUSTANG_MODE),
+		.driver_data = INSTRUMENT },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_HARMONIX, USB_DEVICE_ID_HARMONIX_WII_RB3_MPA_SQUIRE_MODE),
+		.driver_data = INSTRUMENT },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_HARMONIX, USB_DEVICE_ID_HARMONIX_WII_RB3_KEYBOARD),
+		.driver_data = INSTRUMENT },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_HARMONIX, USB_DEVICE_ID_HARMONIX_WII_RB3_MPA_KEYBOARD_MODE),
+		.driver_data = INSTRUMENT },
+	/* Rock Band 3 PS3 instruments */
+	{ HID_USB_DEVICE(USB_VENDOR_ID_SONY_RHYTHM, USB_DEVICE_ID_SONY_PS3_RB_GUITAR),
+		.driver_data = INSTRUMENT },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_SONY_RHYTHM, USB_DEVICE_ID_SONY_PS3_RB_DRUMS),
+		.driver_data = INSTRUMENT },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_SONY_RHYTHM, USB_DEVICE_ID_SONY_PS3_RB3_MPA_DRUMS_MODE),
+		.driver_data = INSTRUMENT },
+	/* Rock Band 3 PS3 Pro instruments */
+	{ HID_USB_DEVICE(USB_VENDOR_ID_SONY_RHYTHM, USB_DEVICE_ID_SONY_PS3_RB3_MUSTANG_GUITAR),
+		.driver_data = INSTRUMENT | RB3_PS3_PRO_INSTRUMENT },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_SONY_RHYTHM, USB_DEVICE_ID_SONY_PS3_RB3_SQUIRE_GUITAR),
+		.driver_data = INSTRUMENT | RB3_PS3_PRO_INSTRUMENT },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_SONY_RHYTHM, USB_DEVICE_ID_SONY_PS3_RB3_MPA_MUSTANG_MODE),
+		.driver_data = INSTRUMENT | RB3_PS3_PRO_INSTRUMENT },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_SONY_RHYTHM, USB_DEVICE_ID_SONY_PS3_RB3_MPA_SQUIRE_MODE),
+		.driver_data = INSTRUMENT | RB3_PS3_PRO_INSTRUMENT },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_SONY_RHYTHM, USB_DEVICE_ID_SONY_PS3_RB3_KEYBOARD),
+		.driver_data = INSTRUMENT | RB3_PS3_PRO_INSTRUMENT },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_SONY_RHYTHM, USB_DEVICE_ID_SONY_PS3_RB3_MPA_KEYBOARD_MODE),
+		.driver_data = INSTRUMENT | RB3_PS3_PRO_INSTRUMENT },
 	/* Rock Band 4 PS4 guitars */
 	{ HID_USB_DEVICE(USB_VENDOR_ID_PDP, USB_DEVICE_ID_PDP_PS4_RIFFMASTER),
-		.driver_data = RB4_GUITAR_PS4_USB },
+		.driver_data = RB4_GUITAR_PS4_USB | INSTRUMENT },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_CRKD, USB_DEVICE_ID_CRKD_PS4_GIBSON_SG),
-		.driver_data = RB4_GUITAR_PS4_USB },
+		.driver_data = RB4_GUITAR_PS4_USB | INSTRUMENT },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_CRKD, USB_DEVICE_ID_CRKD_PS4_GIBSON_SG_DONGLE),
-		.driver_data = RB4_GUITAR_PS4_USB },
+		.driver_data = RB4_GUITAR_PS4_USB | INSTRUMENT },
 	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_PDP, USB_DEVICE_ID_PDP_PS4_JAGUAR),
-		.driver_data = RB4_GUITAR_PS4_BT },
+		.driver_data = RB4_GUITAR_PS4_BT | INSTRUMENT },
 	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_MADCATZ, USB_DEVICE_ID_MADCATZ_PS4_STRATOCASTER),
-		.driver_data = RB4_GUITAR_PS4_BT },
+		.driver_data = RB4_GUITAR_PS4_BT | INSTRUMENT },
 	/* Rock Band 4 PS5 guitars */
 	{ HID_USB_DEVICE(USB_VENDOR_ID_PDP, USB_DEVICE_ID_PDP_PS5_RIFFMASTER),
-		.driver_data = RB4_GUITAR_PS5 },
+		.driver_data = RB4_GUITAR_PS5 | INSTRUMENT },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_CRKD, USB_DEVICE_ID_CRKD_PS5_GIBSON_SG),
-		.driver_data = RB4_GUITAR_PS5 },
+		.driver_data = RB4_GUITAR_PS5 | INSTRUMENT },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_CRKD, USB_DEVICE_ID_CRKD_PS5_GIBSON_SG_DONGLE),
-		.driver_data = RB4_GUITAR_PS5 },
+		.driver_data = RB4_GUITAR_PS5 | INSTRUMENT },
 	{ }
 };
 MODULE_DEVICE_TABLE(hid, sony_devices);
@@ -2428,5 +2616,5 @@ static void __exit sony_exit(void)
 module_init(sony_init);
 module_exit(sony_exit);
 
-MODULE_DESCRIPTION("HID driver for Sony / PS2 / PS3 / PS4 BD devices");
+MODULE_DESCRIPTION("HID driver for Sony / PS2 / PS3 / PS4 / PS5 BD devices");
 MODULE_LICENSE("GPL");
-- 
2.53.0

