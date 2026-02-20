Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E0132BF00A
	for <linux-input@vger.kernel.org>; Fri, 20 Feb 2026 16:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771606250; cv=none; b=Lc21Y9U2bIbvZd0wSXAyOrgVr31iyk1zd85DZqUdg9EEhDnf/2ZHPyW/vcC4YLfN+zqxvJuphIGZzzblCK2+CrqwQWXyPHhzd6Gy/ZXpSGu8HyepX1bLC6azQthXlvQe3SpPn0cOFKFOrU/gqVXjEmn9llB3YjBHDl4Hx+Fy/Sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771606250; c=relaxed/simple;
	bh=MM3cVGIYhp6Q+2yxr7a1t4yWZVAwzaRMBYa/2WBKFec=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Xwj8miqOVYS6yMnr7FnUwWf++IHyjt524mhunWJiDJjqEVZlSeOHj6E1U9ULKaQDLOVJTogzoY/RbR52uwIzVbIn5mu7Z8yjGNnkFt7OXllPJaAslq4jLXZz/Y8tqDjpkMMyvHk2Kmw5vGqoHqZoNvU4OYtHkyoOhQU3TW0nQbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=appsforartists-gmr.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RjEPbndy; arc=none smtp.client-ip=209.85.216.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=appsforartists-gmr.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RjEPbndy"
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-354c0eb08ceso15061509a91.1
        for <linux-input@vger.kernel.org>; Fri, 20 Feb 2026 08:50:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771606249; x=1772211049; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=JajVi7/25WXtIKisVchrEIcxZrMcTPRCnNGhzkySJJ4=;
        b=RjEPbndymT0JONLWoGarQ19dUzO0nPXlMXiPnPuYdEBybfExqXsmkPGkktbUYlEWwe
         mc2RrCaXXEioAgF0lgMP19lUWdA5nQK2KZFg4C1fs92Q9hJa4phb8pckBDU9lQqy1h9z
         xmIaQgGlrWlDm1Or61urBOanNQiNfdxQuC+wO9W5WO9ttDg4cdvJSu+igeqZKcs4kq60
         fZUTZtFgMbdyj2Xuo+2yxJ1/7WY3wTR7pDavgQPguz5vb/M3C9DROIXz2xPq/2h0ZdzH
         HdrkvpfPHlp3crF71zOIcE3UNDBxIWMOQVow1AfsfA09CDa5UrzTkDCycghvmsFdGDGA
         xfSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771606249; x=1772211049;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JajVi7/25WXtIKisVchrEIcxZrMcTPRCnNGhzkySJJ4=;
        b=d7eLjebtUVUOHediE8/soNqrHXCceQyUlRaEoc80YAnwxiLmaVhegvhlN4WjDI4nLV
         YX6XMYR/x4v5ViQW9vl+OnGwmZWdkCTWJ7Zs1Wrddn3qdnWcZxdpzuRnSs+uoawSrPnp
         Ck6ocYP5UCJyr2cUJtV/+Q+xfDcxI4h7089g4qv7PPjAnqwC0mOb7cwCYLWpTackqBHo
         xnO+ZVfdz3vRDpTLAvJwvErCW3eTOBF8GQ5vPMh2LCKTBxxxfFjfk3xiNz7gvnT+vQpv
         zvQWvv8e/Xt7yKM8CkK2seWx7oTN+/z/xG83nChEpHAciFU1VSMfebdu6T9muYmGuNrR
         UFvg==
X-Gm-Message-State: AOJu0YxkP+uWiUiGsNeaJE+WJcLgmreuxC/G4Ll7LVjR8+AgGdwtTwRI
	4dya5HJQDutBCG0b6yCX1HVvCV6VCPD9gzKrGygyrGzqHTTLO74qlqd/VZpymHufKuVVqeu8Fmw
	irpma2t679RbzszNXIVunIT88aLk6SA==
X-Received: by 2002:a17:90b:35c8:b0:353:5595:3246 with SMTP id
 98e67ed59e1d1-358ae8b6672mr246636a91.21.1771606248594; Fri, 20 Feb 2026
 08:50:48 -0800 (PST)
Date: Fri, 20 Feb 2026 11:50:47 -0500
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.414.gf7e9f6c205-goog
Message-ID: <20260220165047.2844568-1-appsforartists@google.com>
Subject: [PATCH] HID: sony: add support for Rock Band 2 instruments
From: appsforartists@google.com
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Sanjay Govind <sanjay.govind9@gmail.com>, Rosalie Wanders <rosalie@mailbox.org>, 
	Antheas Kapenekakis <lkml@antheas.dev>, Vicki Pfau <vi@endrift.com>, 
	"=?UTF-8?q?N=C3=ADcolas=20F=20=2E=20R=20=2E=20A=20=2E=20Prado?=" <nfraprado@collabora.com>, Brenton Simpson <appsforartists@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Brenton Simpson <appsforartists@google.com>

Rock Band 2 for the Nintendo Wii and for the Sony PlayStation 3 use the
same mapping as later games:

    Green:              SOUTH   (A)
    Red:                EAST    (B)
    Yellow:             NORTH   (Y)
    Blue:               WEST    (X)
    Orange/pedal:       TL      (L1)
    Solo flag:          TL2     (L2)
    Tilt:               TR      (R1)
    Pad flag:           THUMBL  (L3)
    Instrument button:  MODE    (Steam/Xbox)
    Whammy bar:         ABS_Z   (Axis 4)
    Effects switch:     Z       (Axis 5)

As documented at https://github.com/TheNathannator/PlasticBand/blob/main/Docs/.

The guitar and drums both use the same mapping.  Tested using the Wii
versions of the instruments.

Signed-off-by: Brenton Simpson <appsforartists@google.com>
---
 drivers/hid/hid-ids.h  |  8 +++++++-
 drivers/hid/hid-sony.c | 45 +++++++++++++++++++++++++++++-------------
 2 files changed, 38 insertions(+), 15 deletions(-)

diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 3e299a30dcde..644d3c4df144 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -664,6 +664,10 @@
 #define USB_DEVICE_ID_UGCI_FLYING	0x0020
 #define USB_DEVICE_ID_UGCI_FIGHTING	0x0030
 
+#define USB_VENDOR_ID_HARMONIX		0x1bad
+#define USB_DEVICE_ID_HARMONIX_WII_RB2_GUITAR_DONGLE	0x3010
+#define USB_DEVICE_ID_HARMONIX_WII_RB2_DRUMS_DONGLE	0x3110
+
 #define USB_VENDOR_ID_HP		0x03f0
 #define USB_PRODUCT_ID_HP_ELITE_PRESENTER_MOUSE_464A		0x464a
 #define USB_PRODUCT_ID_HP_LOGITECH_OEM_USB_OPTICAL_MOUSE_0A4A	0x0a4a
@@ -1299,7 +1303,9 @@
 
 #define USB_VENDOR_ID_SONY_RHYTHM	0x12ba
 #define USB_DEVICE_ID_SONY_PS3WIIU_GHLIVE_DONGLE	0x074b
-#define USB_DEVICE_ID_SONY_PS3_GUITAR_DONGLE	0x0100
+#define USB_DEVICE_ID_SONY_PS3_GH_GUITAR_DONGLE		0x0100
+#define USB_DEVICE_ID_SONY_PS3_RB2_GUITAR_DONGLE	0x0200
+#define USB_DEVICE_ID_SONY_PS3_RB2_DRUMS_DONGLE		0x0210
 
 #define USB_VENDOR_ID_SINO_LITE			0x1345
 #define USB_DEVICE_ID_SINO_LITE_CONTROLLER	0x3008
diff --git a/drivers/hid/hid-sony.c b/drivers/hid/hid-sony.c
index a89af14e4acc..f6975f6ae882 100644
--- a/drivers/hid/hid-sony.c
+++ b/drivers/hid/hid-sony.c
@@ -62,9 +62,10 @@
 #define GH_GUITAR_CONTROLLER      BIT(14)
 #define GHL_GUITAR_PS3WIIU        BIT(15)
 #define GHL_GUITAR_PS4            BIT(16)
-#define RB4_GUITAR_PS4_USB        BIT(17)
-#define RB4_GUITAR_PS4_BT         BIT(18)
-#define RB4_GUITAR_PS5            BIT(19)
+#define RB2_INSTRUMENT            BIT(17)
+#define RB4_GUITAR_PS4_USB        BIT(18)
+#define RB4_GUITAR_PS4_BT         BIT(19)
+#define RB4_GUITAR_PS5            BIT(20)
 
 #define SIXAXIS_CONTROLLER (SIXAXIS_CONTROLLER_USB | SIXAXIS_CONTROLLER_BT)
 #define MOTION_CONTROLLER (MOTION_CONTROLLER_USB | MOTION_CONTROLLER_BT)
@@ -422,12 +423,12 @@ static const unsigned int sixaxis_keymap[] = {
 	[0x11] = BTN_MODE, /* PS */
 };
 
-static const unsigned int rb4_absmap[] = {
+static const unsigned int rb_absmap[] = {
 	[0x30] = ABS_X,
 	[0x31] = ABS_Y,
 };
 
-static const unsigned int rb4_keymap[] = {
+static const unsigned int rb_keymap[] = {
 	[0x1] = BTN_WEST, /* Square */
 	[0x2] = BTN_SOUTH, /* Cross */
 	[0x3] = BTN_EAST, /* Circle */
@@ -625,17 +626,17 @@ static int gh_guitar_mapping(struct hid_device *hdev, struct hid_input *hi,
 	return 0;
 }
 
-static int rb4_guitar_mapping(struct hid_device *hdev, struct hid_input *hi,
+static int rb_instrument_mapping(struct hid_device *hdev, struct hid_input *hi,
 			  struct hid_field *field, struct hid_usage *usage,
 			  unsigned long **bit, int *max)
 {
 	if ((usage->hid & HID_USAGE_PAGE) == HID_UP_BUTTON) {
 		unsigned int key = usage->hid & HID_USAGE;
 
-		if (key >= ARRAY_SIZE(rb4_keymap))
+		if (key >= ARRAY_SIZE(rb_keymap))
 			return 0;
 
-		key = rb4_keymap[key];
+		key = rb_keymap[key];
 		hid_map_usage_clear(hi, usage, bit, max, EV_KEY, key);
 		return 1;
 	} else if ((usage->hid & HID_USAGE_PAGE) == HID_UP_GENDESK) {
@@ -645,10 +646,10 @@ static int rb4_guitar_mapping(struct hid_device *hdev, struct hid_input *hi,
 		if (usage->hid == HID_GD_HATSWITCH)
 			return 0;
 
-		if (abs >= ARRAY_SIZE(rb4_absmap))
+		if (abs >= ARRAY_SIZE(rb_absmap))
 			return 0;
 
-		abs = rb4_absmap[abs];
+		abs = rb_absmap[abs];
 		hid_map_usage_clear(hi, usage, bit, max, EV_ABS, abs);
 		return 1;
 	}
@@ -1101,11 +1102,14 @@ static int sony_mapping(struct hid_device *hdev, struct hid_input *hi,
 	if (sc->quirks & GH_GUITAR_CONTROLLER)
 		return gh_guitar_mapping(hdev, hi, field, usage, bit, max);
 
+	if (sc->quirks & RB2_INSTRUMENT)
+		return rb_instrument_mapping(hdev, hi, field, usage, bit, max);
+
 	if (sc->quirks & (RB4_GUITAR_PS4_USB | RB4_GUITAR_PS4_BT))
-		return rb4_guitar_mapping(hdev, hi, field, usage, bit, max);
+		return rb_instrument_mapping(hdev, hi, field, usage, bit, max);
 
 	if (sc->quirks & RB4_GUITAR_PS5)
-		return rb4_guitar_mapping(hdev, hi, field, usage, bit, max);
+		return rb_instrument_mapping(hdev, hi, field, usage, bit, max);
 
 	/* Let hid-core decide for the others */
 	return 0;
@@ -2369,12 +2373,25 @@ static const struct hid_device_id sony_devices[] = {
 	/* Guitar Hero PC Guitar Dongle */
 	{ HID_USB_DEVICE(USB_VENDOR_ID_REDOCTANE, USB_DEVICE_ID_REDOCTANE_GUITAR_DONGLE),
 		.driver_data = GH_GUITAR_CONTROLLER },
-	/* Guitar Hero PS3 World Tour Guitar Dongle */
-	{ HID_USB_DEVICE(USB_VENDOR_ID_SONY_RHYTHM, USB_DEVICE_ID_SONY_PS3_GUITAR_DONGLE),
+	/* Guitar Hero World Tour PS3 Guitar Dongle */
+	{ HID_USB_DEVICE(USB_VENDOR_ID_SONY_RHYTHM, USB_DEVICE_ID_SONY_PS3_GH_GUITAR_DONGLE),
 		.driver_data = GH_GUITAR_CONTROLLER },
 	/* Guitar Hero Live PS4 guitar dongles */
 	{ HID_USB_DEVICE(USB_VENDOR_ID_REDOCTANE, USB_DEVICE_ID_REDOCTANE_PS4_GHLIVE_DONGLE),
 		.driver_data = GHL_GUITAR_PS4 | GH_GUITAR_CONTROLLER },
+	/* Rock Band 2 instruments
+	 * Nintendo Wii instruments are included in `hid-sony` because `hid-nintendo`
+	 * is for the newer Nintendo Switch, and the Wii instruments use the same
+	 * protocol as their Sony PlayStation 3 cousins.
+	 */
+	{ HID_USB_DEVICE(USB_VENDOR_ID_HARMONIX, USB_DEVICE_ID_HARMONIX_WII_RB2_GUITAR_DONGLE),
+		.driver_data = RB2_INSTRUMENT },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_HARMONIX, USB_DEVICE_ID_HARMONIX_WII_RB2_DRUMS_DONGLE),
+		.driver_data = RB2_INSTRUMENT },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_SONY_RHYTHM, USB_DEVICE_ID_SONY_PS3_RB2_GUITAR_DONGLE),
+		.driver_data = RB2_INSTRUMENT },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_SONY_RHYTHM, USB_DEVICE_ID_SONY_PS3_RB2_DRUMS_DONGLE),
+		.driver_data = RB2_INSTRUMENT },
 	/* Rock Band 4 PS4 guitars */
 	{ HID_USB_DEVICE(USB_VENDOR_ID_PDP, USB_DEVICE_ID_PDP_PS4_RIFFMASTER),
 		.driver_data = RB4_GUITAR_PS4_USB },
-- 
2.53.0.414.gf7e9f6c205-goog

