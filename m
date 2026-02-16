Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 559BE2FF161
	for <linux-input@vger.kernel.org>; Mon, 16 Feb 2026 17:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771264551; cv=none; b=A7JY6AiiFFLADvZ7hVXrxRCPMq5V2KTM3aYbaIpwpRzGmob5W6baHKVmqrGYCS/gfUCzDzTGV05eXbGAymiT2rBLCkPiNfsGZmLT3IgoSau5Ni95NSO3ayIjHSJ0xyZoIfU9BM5Uw0u0NQb/deLk/N/MOkIEZgniBWfLwmwGWNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771264551; c=relaxed/simple;
	bh=LAziGp3ku2gDZxesq45OgsTrMK0y2ej6YzOVaPRugQk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mVOIrLZi4jtXEyLqMIBFw7GJUTZS3kUJ0fVdk1XmQA/3X5uzqyws1IjaGipjXZMQ5ML9glCBR5ZxFc6sVe7vSchZ9Fx5ykrlKElg2ye5mpiqyKSiYVr+TJpGDYXkfEOFhkMReMsVaupLRebdFGZQBEKRfy1nS9J6DfOZMiGbBr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=j3BoRvoq; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="j3BoRvoq"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1771264548;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WY7gt4sarrL/+q2Twzf+hso6QNVtlsbtYlgXT0JC8LY=;
	b=j3BoRvoqqsEujmPJemBfc+8tSwTsZkWqjqx/yU79gf6f5np+xYO8x3HGm/HPX4iuAEHEBF
	J3PqgYhT43Q029d2psrcdoOaJ2w3LNEpdf39uvSmjShusF22WxwpJS+4QIJhOs3Hr4b0W9
	qgm7+UQYVjP3ZWaBlgTdLObuWoMX6N0=
From: Denis Benato <denis.benato@linux.dev>
To: linux-kernel@vger.kernel.org
Cc: linux-input@vger.kernel.org,
	"Benjamin Tissoires" <bentiss@kernel.org>,
	"Jiri Kosina" <jikos@kernel.org>,
	"Luke D . Jones" <luke@ljones.dev>,
	"Mateusz Schyboll" <dragonn@op.pl>,
	"Denis Benato" <benato.denis96@gmail.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Denis Benato <denis.benato@linux.dev>
Subject: [PATCH 2/2] hid: asus: always fully initialize devices
Date: Mon, 16 Feb 2026 18:55:39 +0100
Message-ID: <20260216175539.12415-2-denis.benato@linux.dev>
In-Reply-To: <20260216175539.12415-1-denis.benato@linux.dev>
References: <20260216175539.12415-1-denis.benato@linux.dev>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

ASUS has more devices other than laptop keyboards which needs
to be initializated: the init sequence is the same as keyboards.

ID1 and ID2 are USB report IDs that are correctly enumerated:
send init commands to all devices that supports those reports IDs.

Signed-off-by: Denis Benato <denis.benato@linux.dev>
---
 drivers/hid/hid-asus.c | 46 ++++++++++++++++++++++++++++++++----------
 1 file changed, 35 insertions(+), 11 deletions(-)

diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
index 52efbf75a994..0a85b1ecdda6 100644
--- a/drivers/hid/hid-asus.c
+++ b/drivers/hid/hid-asus.c
@@ -102,7 +102,6 @@ MODULE_DESCRIPTION("Asus HID Keyboard and TouchPad");
 #define QUIRK_ROG_CLAYMORE_II_KEYBOARD BIT(12)
 #define QUIRK_ROG_ALLY_XPAD		BIT(13)
 #define QUIRK_HID_FN_LOCK		BIT(14)
-#define QUIRK_ROG_NKEY_ID1ID2_INIT		BIT(15)
 
 #define I2C_KEYBOARD_QUIRKS			(QUIRK_FIX_NOTEBOOK_REPORT | \
 						 QUIRK_NO_INIT_REPORTS | \
@@ -209,6 +208,12 @@ static const struct asus_touchpad_info medion_e1239t_tp = {
 	.report_size = 32 /* 2 byte header + 5 * 5 + 5 byte footer */,
 };
 
+static const u8 asus_report_id_init[] = {
+	FEATURE_KBD_REPORT_ID,
+	FEATURE_KBD_LED_REPORT_ID1,
+	FEATURE_KBD_LED_REPORT_ID2
+};
+
 static void asus_report_contact_down(struct asus_drvdata *drvdat,
 		int toolType, u8 *data)
 {
@@ -715,6 +720,21 @@ static void validate_mcu_fw_version(struct hid_device *hdev, int idProduct)
 	}
 }
 
+static bool asus_has_report_id(struct hid_device *hdev, u16 report_id)
+{
+	int t, f, u, err = 0;
+	struct hid_report *report;
+
+	for (t = HID_INPUT_REPORT; t <= HID_FEATURE_REPORT; t++) {
+		list_for_each_entry(report, &hdev->report_enum[t].report_list, list) {
+			if (report->id == report_id)
+				return true;
+		}
+	}
+
+	return false;
+}
+
 static int asus_kbd_register_leds(struct hid_device *hdev)
 {
 	struct asus_drvdata *drvdata = hid_get_drvdata(hdev);
@@ -723,9 +743,9 @@ static int asus_kbd_register_leds(struct hid_device *hdev)
 	unsigned char kbd_func;
 	int ret;
 
-	ret = asus_kbd_init(hdev, FEATURE_KBD_REPORT_ID);
-	if (ret < 0)
-		return ret;
+	/* Laptops keyboard backlight is always at 0x5a */
+	if (asus_has_report_id(hdev, FEATURE_KBD_REPORT_ID))
+		return -ENODEV;
 
 	/* Get keyboard functions */
 	ret = asus_kbd_get_functions(hdev, &kbd_func, FEATURE_KBD_REPORT_ID);
@@ -736,11 +756,6 @@ static int asus_kbd_register_leds(struct hid_device *hdev)
 	if (!(kbd_func & SUPPORT_KBD_BACKLIGHT))
 		return -ENODEV;
 
-	if (drvdata->quirks & QUIRK_ROG_NKEY_ID1ID2_INIT) {
-		asus_kbd_init(hdev, FEATURE_KBD_LED_REPORT_ID1);
-		asus_kbd_init(hdev, FEATURE_KBD_LED_REPORT_ID2);
-	}
-
 	if (dmi_match(DMI_PRODUCT_FAMILY, "ProArt P16")) {
 		ret = asus_kbd_disable_oobe(hdev);
 		if (ret < 0)
@@ -1287,6 +1302,15 @@ static int asus_probe(struct hid_device *hdev, const struct hid_device_id *id)
 		return ret;
 	}
 
+	for (int r = 0; r < ARRAY_SIZE(asus_report_id_init); r++) {
+		if (asus_has_report_id(hdev, asus_report_id_init[r])) {
+			ret = asus_kbd_init(hdev, asus_report_id_init[r]);
+			if (ret < 0)
+				hid_warn(hdev, "Failed to initialize 0x%x: %d.\n",
+					 asus_report_id_init[r], ret);
+		}
+	}
+
 	if (is_vendor && (drvdata->quirks & QUIRK_USE_KBD_BACKLIGHT) &&
 	    asus_kbd_register_leds(hdev))
 		hid_warn(hdev, "Failed to initialize backlight.\n");
@@ -1470,10 +1494,10 @@ static const struct hid_device_id asus_devices[] = {
 	  QUIRK_USE_KBD_BACKLIGHT },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_ASUSTEK,
 	    USB_DEVICE_ID_ASUSTEK_ROG_NKEY_KEYBOARD),
-	  QUIRK_USE_KBD_BACKLIGHT | QUIRK_ROG_NKEY_KEYBOARD | QUIRK_ROG_NKEY_ID1ID2_INIT },
+	  QUIRK_USE_KBD_BACKLIGHT | QUIRK_ROG_NKEY_KEYBOARD },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_ASUSTEK,
 	    USB_DEVICE_ID_ASUSTEK_ROG_NKEY_KEYBOARD2),
-	  QUIRK_USE_KBD_BACKLIGHT | QUIRK_ROG_NKEY_KEYBOARD | QUIRK_HID_FN_LOCK | QUIRK_ROG_NKEY_ID1ID2_INIT },
+	  QUIRK_USE_KBD_BACKLIGHT | QUIRK_ROG_NKEY_KEYBOARD | QUIRK_HID_FN_LOCK },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_ASUSTEK,
 	    USB_DEVICE_ID_ASUSTEK_ROG_Z13_LIGHTBAR),
 	  QUIRK_USE_KBD_BACKLIGHT | QUIRK_ROG_NKEY_KEYBOARD },
-- 
2.53.0

