Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA8BE443E53
	for <linux-input@vger.kernel.org>; Tue, 11 Aug 2026 12:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786453009; cv=none; b=lWIGF0Q/FJOcG+GEhhPjhBERcqF6uDLtHLI0UZ3lmIWdhHspC+cSYJc0xl0SCxQ1gILR/3kSzhbPHUSs+dnWJVRu71OC+jYa1RedzdsJ9+duZXwufjMIVMiWsZiiXQiF1kugK2FZd6xxJnVJiG3PJ4RABg8yyn/YZsczO9XdQt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786453009; c=relaxed/simple;
	bh=YAhy8lxh5tdqgIRKvKvpSXubReKf5fLpQVP2nwQAtQs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=LqRoemsK5mj4whdOHAtFky9IqAqP2fkI380LB2xDGMWc8FSjy1K52lCo9oaAjpS/Y4rkFfpWeMSK9BZ7HE2BTXWQ6uviYlPy//DFWjh0ruygxWzTnBMyPgWe5VxwO+C4dspC0aZuKLow4dIwvqAmPqKeCwPaKu8W2KAUJm7MR7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de; spf=pass smtp.mailfrom=posteo.de; dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b=l3ptxXQn; arc=none smtp.client-ip=185.67.36.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b="l3ptxXQn"
Received: from submission (posteo.de [185.67.36.169]) 
	by mout01.posteo.de (Postfix) with ESMTPS id 348AB240029
	for <linux-input@vger.kernel.org>; Tue, 11 Aug 2026 14:56:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.de;
	s=1984.8680eb; t=1786453003;
	bh=JbiAlbeUyspatE6oKXgJm8vWZtCxgVeBn+MtBzhBIBc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:From;
	b=l3ptxXQnrlZni29cX6nTzBNvYGw5oURnzGB5wtA58zGv9G3rHcXW+V3P5EOcNKnlu
	 ZX5wYwFcDfqspnbTAp4jh9KNAGjhd5ioZVBKg8FppRP6mMHwrG7afdftnrJ+NQYe9u
	 NssySe1+ZJ+5guJMUQ7rzBkn28PSeBA+IcYVtv0N5KYnxNO4S/vHeRJKfAsFNbiAA9
	 7jRyXgeZJncXPZh85j9JsluS6adxMZxnig6ycBxnVlsXY/VNcJCOXniQm+AJwlgS1T
	 4zD9oe8QUpZalbRMWzptHU/zkB8FQsnLJq76eMl6Rv52NTpxVqXKPGxVOshIAdLvx7
	 40rfdTvrYqqlQ==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4hKBTQ0ZXlz9rxG;
	Tue, 11 Aug 2026 14:56:41 +0200 (CEST)
From: =?UTF-8?q?Rebecca=20Mara=20M=C3=BCller?= <rebecca.mara@posteo.de>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Rebecca=20Mara=20M=C3=BCller?= <rebecca.mara@posteo.de>
Subject: [PATCH] HID: asus: add support for the ASUS Zenbook Duo built-in keyboard
Date: Tue, 11 Aug 2026 12:56:42 +0000
Message-ID: <20260811125548.1975748-1-rebecca.mara@posteo.de>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The detachable keyboard of the ASUS Zenbook Duo (2026, UX8407) is a
Primax-built combo device (USB 0b05:1cd7 when docked, Bluetooth
0b05:1cd8 when detached) whose hotkeys need several fixes to work:

- The hotkey interface wraps its vendor input report (ID 0x5a) in a
  single bogus usage 0x76, the same descriptor bug the T100CHI family
  fixup handles. Rewrite the usage into a usage range on both
  transports so the hotkey codes map to their key definitions.

- On USB the hotkey interface only exposes vendor usage collections,
  which do not count as input applications, so hid-input would not
  bind to it. Force the connect.

- When docked, the keyboard powers up in F-key mode and needs the
  well-known "ASUS Tech.Inc." handshake to emit hotkeys at all. The
  handshake sent from probe is lost again because configuring the
  touchpad on the sibling USB interface (handled by hid-multitouch)
  resets the keyboard to F-key mode. Re-send the handshake from
  delayed work two seconds after probe.

- Bind by group like the ROG Z13 Folio so hid-multitouch keeps
  handling the touchpad interfaces.

Tested on an ASUS Zenbook Duo UX8407AA in both docked (USB) and
detached (Bluetooth) modes: brightness keys emit BRIGHTNESSDOWN/UP,
the other hotkeys (volume, mute, print screen, display toggle) keep
working, and both keyboard typing and the touchpad are unaffected.

Signed-off-by: Rebecca Mara Müller <rebecca.mara@posteo.de>
---
Tested on an ASUS Zenbook Duo UX8407AA (Pop!_OS 24.04). The change was
validated as a backport on kernel 7.0.11 (repeated dock/undock cycles,
alternating brightness levels between mode switches to rule out
state-dependent behaviour) and compile-tested against this tree.

The failure analysis (raw HID captures, descriptor decoding, and the
discovery of the touchpad-init interaction) and the initial patch draft
were done with AI assistance; I reviewed the change and did all testing
on the real hardware myself.

 drivers/hid/hid-asus.c | 94 +++++++++++++++++++++++++++++++++++++++++-
 drivers/hid/hid-ids.h  |  2 +
 2 files changed, 95 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
index 3f5e96900..8c1e54a8c 100644
--- a/drivers/hid/hid-asus.c
+++ b/drivers/hid/hid-asus.c
@@ -99,6 +99,7 @@ MODULE_DESCRIPTION("Asus HID Keyboard and TouchPad");
 #define QUIRK_ROG_CLAYMORE_II_KEYBOARD	BIT(12)
 #define QUIRK_ROG_ALLY_XPAD		BIT(13)
 #define QUIRK_HID_FN_LOCK		BIT(14)
+#define QUIRK_ZENBOOK_DUO_KEYBOARD	BIT(15)
 
 #define I2C_KEYBOARD_QUIRKS			(QUIRK_FIX_NOTEBOOK_REPORT | \
 						 QUIRK_NO_INIT_REPORTS | \
@@ -143,6 +144,7 @@ struct asus_drvdata {
 	unsigned long battery_next_query;
 	struct work_struct fn_lock_sync_work;
 	bool fn_lock;
+	struct delayed_work reinit_work;
 };
 
 static int asus_report_battery(struct asus_drvdata *, u8 *, int);
@@ -1191,6 +1193,22 @@ static int __maybe_unused asus_reset_resume(struct hid_device *hdev)
 	return 0;
 }
 
+static void asus_reinit_work(struct work_struct *work)
+{
+	struct asus_drvdata *drvdata = container_of(work, struct asus_drvdata,
+						    reinit_work.work);
+	int ret;
+
+	/*
+	 * The Zenbook Duo keyboard drops out of hotkey mode when the
+	 * touchpad on its sibling USB interface is configured after us.
+	 * Re-send the handshake once the dust has settled.
+	 */
+	ret = asus_kbd_init(drvdata->hdev, FEATURE_KBD_REPORT_ID);
+	if (ret < 0)
+		hid_warn(drvdata->hdev, "Asus re-init failed: %d\n", ret);
+}
+
 static int asus_probe(struct hid_device *hdev, const struct hid_device_id *id)
 {
 	struct hid_report_enum *rep_enum;
@@ -1288,7 +1306,16 @@ static int asus_probe(struct hid_device *hdev, const struct hid_device_id *id)
 			is_vendor = true;
 	}
 
-	ret = hid_hw_start(hdev, HID_CONNECT_DEFAULT);
+	/*
+	 * The Zenbook Duo keyboard hotkey interface only exposes vendor
+	 * usage collections, which do not count as input applications.
+	 * Force hid-input to bind so the hotkeys reach userspace.
+	 */
+	if (drvdata->quirks & QUIRK_ZENBOOK_DUO_KEYBOARD)
+		ret = hid_hw_start(hdev, HID_CONNECT_DEFAULT |
+					 HID_CONNECT_HIDINPUT_FORCE);
+	else
+		ret = hid_hw_start(hdev, HID_CONNECT_DEFAULT);
 	if (ret) {
 		hid_err(hdev, "Asus hw start failed: %d\n", ret);
 		return ret;
@@ -1309,6 +1336,13 @@ static int asus_probe(struct hid_device *hdev, const struct hid_device_id *id)
 		(asus_kbd_register_leds(hdev)))
 		hid_warn(hdev, "Failed to initialize backlight.\n");
 
+	if (is_vendor && (drvdata->quirks & QUIRK_ZENBOOK_DUO_KEYBOARD) &&
+	    hdev->bus == BUS_USB) {
+		INIT_DELAYED_WORK(&drvdata->reinit_work, asus_reinit_work);
+		schedule_delayed_work(&drvdata->reinit_work,
+				      msecs_to_jiffies(2000));
+	}
+
 	/*
 	 * For ROG keyboards, skip rename for consistency and ->input check as
 	 * some devices do not have inputs.
@@ -1346,6 +1380,9 @@ static void asus_remove(struct hid_device *hdev)
 	struct asus_drvdata *drvdata = hid_get_drvdata(hdev);
 	unsigned long flags;
 
+	if (drvdata->quirks & QUIRK_ZENBOOK_DUO_KEYBOARD)
+		cancel_delayed_work_sync(&drvdata->reinit_work);
+
 	if (drvdata->kbd_backlight) {
 		asus_hid_unregister_listener(&drvdata->kbd_backlight->listener);
 
@@ -1384,6 +1421,51 @@ static const __u8 *asus_report_fixup(struct hid_device *hdev, __u8 *rdesc,
 		hid_info(hdev, "Fixing up Asus T100 keyb report descriptor\n");
 		rdesc[74] &= ~HID_MAIN_ITEM_CONSTANT;
 	}
+	/*
+	 * The Zenbook Duo keyboard uses the same bogus single-usage (0x76)
+	 * vendor input report as the T100CHI family, on both its USB and
+	 * Bluetooth interfaces. Rewrite the usage into a usage range so the
+	 * hotkey codes map to their key definitions.
+	 */
+	if (drvdata->quirks & QUIRK_ZENBOOK_DUO_KEYBOARD) {
+		static const __u8 bogus[] = {
+			0xa1, 0x01,		/* Collection (Application)  */
+			0x85, 0x5a,		/*  Report ID (0x5a)         */
+			0x09, 0x76,		/*  Usage (0x76)             */
+			0x15, 0x00,		/*  Logical Minimum (0)      */
+			0x26, 0xff, 0x00,	/*  Logical Maximum (255)    */
+			0x75, 0x08,		/*  Report Size (8)          */
+			0x95, 0x05,		/*  Report Count (5)         */
+			0x81, 0x02,		/*  Input (Data,Var,Abs)     */
+		};
+		__u8 *new_rdesc;
+		unsigned int i;
+
+		for (i = 0; *rsize >= sizeof(bogus) && i <= *rsize - sizeof(bogus); i++) {
+			if (memcmp(rdesc + i, bogus, sizeof(bogus)) != 0)
+				continue;
+
+			new_rdesc = devm_kzalloc(&hdev->dev, *rsize + 3, GFP_KERNEL);
+			if (!new_rdesc)
+				return rdesc;
+
+			hid_info(hdev, "Fixing up Zenbook Duo keyboard report descriptor\n");
+			memcpy(new_rdesc, rdesc, i + 4);
+			/* Usage (76h) -> Usage Minimum (00h), Usage Maximum (FFh) */
+			new_rdesc[i + 4] = 0x19;
+			new_rdesc[i + 5] = 0x00;
+			new_rdesc[i + 6] = 0x2a;
+			new_rdesc[i + 7] = 0xff;
+			new_rdesc[i + 8] = 0x00;
+			memcpy(new_rdesc + i + 9, rdesc + i + 6, *rsize - (i + 6));
+			/* Input (Data,Var,Abs) -> Input (Data,Arr,Abs) */
+			new_rdesc[i + 19] = 0x00;
+			*rsize += 3;
+			rdesc = new_rdesc;
+			break;
+		}
+	}
+
 	/* For the T100CHI/T90CHI keyboard dock */
 	if (drvdata->quirks & (QUIRK_T100CHI | QUIRK_T90CHI)) {
 		int rsize_orig;
@@ -1534,6 +1616,16 @@ static const struct hid_device_id asus_devices[] = {
 	  QUIRK_USE_KBD_BACKLIGHT | QUIRK_ROG_NKEY_KEYBOARD },
 	{ HID_DEVICE(BUS_USB, HID_GROUP_GENERIC,
 		USB_VENDOR_ID_ASUSTEK, USB_DEVICE_ID_ASUSTEK_T101HA_KEYBOARD) },
+	/*
+	 * The Zenbook Duo keyboard also binds by group so that
+	 * hid-multitouch.c keeps handling the touchpad interfaces.
+	 */
+	{ HID_DEVICE(BUS_USB, HID_GROUP_GENERIC,
+		USB_VENDOR_ID_ASUSTEK, USB_DEVICE_ID_ASUSTEK_ZENBOOK_DUO_KEYBOARD),
+	  QUIRK_USE_KBD_BACKLIGHT | QUIRK_ZENBOOK_DUO_KEYBOARD },
+	{ HID_DEVICE(BUS_BLUETOOTH, HID_GROUP_GENERIC,
+		USB_VENDOR_ID_ASUSTEK, USB_DEVICE_ID_ASUSTEK_ZENBOOK_DUO_KEYBOARD_BT),
+	  QUIRK_ZENBOOK_DUO_KEYBOARD },
 	{ }
 };
 MODULE_DEVICE_TABLE(hid, asus_devices);
diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 1059922ba..b030df014 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -225,6 +225,8 @@
 #define USB_DEVICE_ID_ASUSTEK_ROG_KEYBOARD2 0x1837
 #define USB_DEVICE_ID_ASUSTEK_ROG_KEYBOARD3 0x1822
 #define USB_DEVICE_ID_ASUSTEK_ROG_NKEY_KEYBOARD	0x1866
+#define USB_DEVICE_ID_ASUSTEK_ZENBOOK_DUO_KEYBOARD	0x1cd7
+#define USB_DEVICE_ID_ASUSTEK_ZENBOOK_DUO_KEYBOARD_BT	0x1cd8
 #define USB_DEVICE_ID_ASUSTEK_ROG_NKEY_KEYBOARD2	0x19b6
 #define USB_DEVICE_ID_ASUSTEK_ROG_Z13_FOLIO		0x1a30
 #define USB_DEVICE_ID_ASUSTEK_ROG_Z13_LIGHTBAR		0x18c6
-- 
2.43.0

