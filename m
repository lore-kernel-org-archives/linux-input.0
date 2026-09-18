Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC8044F68D7;
	Fri, 18 Sep 2026 13:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789738120; cv=none; b=BMepowVKewGy+0Hvw1vXevtT6PMCjvxh5JRuxz1qNxxF0Z/s7wTlJyldrRO+zt6rMvc1pce8/ShN3p5rHyi0yStT4NsrCkVoCfbIHWidkAHuzFzWIphHquKOKVemcgDcKLzVQQtK7V6gefVc65LxgaeC0R9YxgrHmadlkC2VWHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789738120; c=relaxed/simple;
	bh=kshdd0UgoZdMmGyTQdR78b5BxL4LZLWUeh+/eMSqKDQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SUqA2rqC39ckKMcF0W5xWOBzGcejY7aZ0YyaLoxAHzIfIqdkrAz9mf+cKvOFCM/ziiLYm9PXUs+coZcGSmh75s8HYQs3lpS0VLU5glYKJkjRo+nb4h956CDF7tQxiYqyv15//jgj2Sd2+HV8YoKk72LmlcGQlhq51ds2sY5tqT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dgg69dyq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dgg69dyq"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5168DC4AF15;
	Fri, 18 Sep 2026 13:28:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1789738120;
	bh=kshdd0UgoZdMmGyTQdR78b5BxL4LZLWUeh+/eMSqKDQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=dgg69dyqPjDbJkCHJy86/caNLZe3SQEm0XwzcNvJhEwUB1xjAQkZU6TSApJVQhzbM
	 G4TpSZt4nDaIhgSQ0weihgl/k980sm+zCDKubw6Nji5HDWLZVnhYvmwt0zqJ4JpxXr
	 /8Mpj9RdVzQamQZdFxWWPQ1NWl/iW85zfswOQPujEeBoPMPHHT0r65l/Cd/lIkcUXx
	 s3p3xICge71MtwyxhQvbRZbm2FJrJCpCscrsAUJfd4yprVYAgZHI2WK+DNROraN+No
	 4H38MVp3oBMi/6JhwoXjQlfoCYpuJ427Z4rKShiGLAn1uLprka+e8yS9bV3TBDimcK
	 6vbnL01pvtyVw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CDBFC982D8;
	Fri, 18 Sep 2026 13:28:40 +0000 (UTC)
From: Michael Reeves via B4 Relay <devnull+michael.reeves077.gmail.com@kernel.org>
Date: Fri, 18 Sep 2026 23:28:37 +1000
Subject: [PATCH v3 07/10] HID: apple: Add support for DockChannel HID
 keyboards
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260918-apple-mtp-keyboard-final-v3-7-e356464e454b@gmail.com>
References: <20260918-apple-mtp-keyboard-final-v3-0-e356464e454b@gmail.com>
In-Reply-To: <20260918-apple-mtp-keyboard-final-v3-0-e356464e454b@gmail.com>
To: Sven Peter <sven@kernel.org>, Janne Grunau <j@jannau.net>, 
 Neal Gompa <neal@gompa.dev>, Jassi Brar <jassisinghbrar@gmail.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Hector Martin <marcan@marcan.st>, 
 Michael Reeves <michael.reeves077@gmail.com>, 
 "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
 Robin Murphy <robin.murphy@arm.com>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jikos@kernel.org>, 
 Benjamin Tissoires <bentiss@kernel.org>
Cc: asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 iommu@lists.linux.dev, linux-input@vger.kernel.org, 
 Yureka Lilian <yureka@cyberchaos.dev>, Julian Braha <julianbraha@gmail.com>, 
 Sasha Finkelstein <k@chaosmail.tech>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789738118; l=7532;
 i=michael.reeves077@gmail.com; s=fedora-20260918;
 h=from:subject:message-id;
 bh=Jn8V1WltiVnkawdzC5bVKS+cIf6Ev+2/cLas2bYpiBs=;
 b=CCaAE3SKILaat8IshUCCrbFZQu9WJgizsWYZDIJbVD8PTc6Cc1dh/F3s9FFcyCmmn9/ysQgB+
 CZQe16TorGVCjkpNzvMDacYVQqhti4SCS+kgkcspXLT/MVO4lsLb2uP
X-Developer-Key: i=michael.reeves077@gmail.com; a=ed25519;
 pk=VJ0TvyQ9TvfzYZa908YSE9kpkjFLLD5luv0bERu+boc=
X-Endpoint-Received: by B4 Relay for
 michael.reeves077@gmail.com/fedora-20260918 with auth_id=1035
X-Original-From: Michael Reeves <michael.reeves077@gmail.com>
Reply-To: michael.reeves077@gmail.com

From: Michael Reeves <michael.reeves077@gmail.com>

DockChannel keyboards are registered as host-bus Apple HID devices
instead of USB or Bluetooth devices.

Match them in hid-apple and use the modern Magic Keyboard function-key
table. Honor the per-device special-driver quirk when matching.

Signed-off-by: Michael Reeves <michael.reeves077@gmail.com>
---
 drivers/hid/hid-apple.c | 118 +++++++++++++++++++++++++++++-------------------
 include/linux/hid.h     |   1 +
 2 files changed, 73 insertions(+), 46 deletions(-)

diff --git a/drivers/hid/hid-apple.c b/drivers/hid/hid-apple.c
index f6134c582..524ac80cb 100644
--- a/drivers/hid/hid-apple.c
+++ b/drivers/hid/hid-apple.c
@@ -395,6 +395,12 @@ static bool apple_is_omoton_kb066(struct hid_device *hdev)
 		strcmp(hdev->name, "Bluetooth Keyboard") == 0;
 }
 
+static bool apple_is_dockchannel_keyboard(struct hid_device *hdev)
+{
+	return hdev->bus == BUS_HOST &&
+	       hdev->group == HID_GROUP_APPLE_DOCKCHANNEL;
+}
+
 static inline void apple_setup_key_translation(struct input_dev *input,
 		const struct apple_key_translation *table)
 {
@@ -482,53 +488,57 @@ static int hidinput_apple_event(struct hid_device *hid, struct input_dev *input,
 		asc->fn_on = !!value;
 
 	if (real_fnmode) {
-		switch (hid->product) {
-		case USB_DEVICE_ID_APPLE_ALU_WIRELESS_ANSI:
-		case USB_DEVICE_ID_APPLE_ALU_WIRELESS_ISO:
-		case USB_DEVICE_ID_APPLE_ALU_WIRELESS_JIS:
-		case USB_DEVICE_ID_APPLE_ALU_WIRELESS_2009_ANSI:
-		case USB_DEVICE_ID_APPLE_ALU_WIRELESS_2009_ISO:
-		case USB_DEVICE_ID_APPLE_ALU_WIRELESS_2009_JIS:
-		case USB_DEVICE_ID_APPLE_ALU_WIRELESS_2011_ANSI:
-		case USB_DEVICE_ID_APPLE_ALU_WIRELESS_2011_ISO:
-		case USB_DEVICE_ID_APPLE_ALU_WIRELESS_2011_JIS:
-			table = magic_keyboard_alu_fn_keys;
-			break;
-		case USB_DEVICE_ID_APPLE_MAGIC_KEYBOARD_2015:
-		case USB_DEVICE_ID_APPLE_MAGIC_KEYBOARD_NUMPAD_2015:
-			table = magic_keyboard_2015_fn_keys;
-			break;
-		case USB_DEVICE_ID_APPLE_MAGIC_KEYBOARD_2021:
-		case USB_DEVICE_ID_APPLE_MAGIC_KEYBOARD_FINGERPRINT_2021:
-		case USB_DEVICE_ID_APPLE_MAGIC_KEYBOARD_NUMPAD_2021:
-		case USB_DEVICE_ID_APPLE_MAGIC_KEYBOARD_2024:
-		case USB_DEVICE_ID_APPLE_MAGIC_KEYBOARD_FINGERPRINT_2024:
-		case USB_DEVICE_ID_APPLE_MAGIC_KEYBOARD_NUMPAD_2024:
+		if (apple_is_dockchannel_keyboard(hid)) {
 			table = magic_keyboard_2021_and_2024_fn_keys;
-			break;
-		case USB_DEVICE_ID_APPLE_WELLSPRINGT2_J132:
-		case USB_DEVICE_ID_APPLE_WELLSPRINGT2_J213:
-		case USB_DEVICE_ID_APPLE_WELLSPRINGT2_J680:
-		case USB_DEVICE_ID_APPLE_WELLSPRINGT2_J680_ALT:
-			table = macbookpro_no_esc_fn_keys;
-			break;
-		case USB_DEVICE_ID_APPLE_WELLSPRINGT2_J152F:
-		case USB_DEVICE_ID_APPLE_WELLSPRINGT2_J214K:
-		case USB_DEVICE_ID_APPLE_WELLSPRINGT2_J223:
-			table = macbookpro_dedicated_esc_fn_keys;
-			break;
-		case USB_DEVICE_ID_APPLE_WELLSPRINGT2_J140K:
-		case USB_DEVICE_ID_APPLE_WELLSPRINGT2_J230K:
-			table = apple_fn_keys;
-			break;
-		default:
-			if (hid->product >= USB_DEVICE_ID_APPLE_WELLSPRING4_ANSI &&
-			    hid->product <= USB_DEVICE_ID_APPLE_WELLSPRING4A_JIS)
-				table = macbookair_fn_keys;
-			else if (hid->product < 0x21d || hid->product >= 0x300)
-				table = powerbook_fn_keys;
-			else
+		} else {
+			switch (hid->product) {
+			case USB_DEVICE_ID_APPLE_ALU_WIRELESS_ANSI:
+			case USB_DEVICE_ID_APPLE_ALU_WIRELESS_ISO:
+			case USB_DEVICE_ID_APPLE_ALU_WIRELESS_JIS:
+			case USB_DEVICE_ID_APPLE_ALU_WIRELESS_2009_ANSI:
+			case USB_DEVICE_ID_APPLE_ALU_WIRELESS_2009_ISO:
+			case USB_DEVICE_ID_APPLE_ALU_WIRELESS_2009_JIS:
+			case USB_DEVICE_ID_APPLE_ALU_WIRELESS_2011_ANSI:
+			case USB_DEVICE_ID_APPLE_ALU_WIRELESS_2011_ISO:
+			case USB_DEVICE_ID_APPLE_ALU_WIRELESS_2011_JIS:
+				table = magic_keyboard_alu_fn_keys;
+				break;
+			case USB_DEVICE_ID_APPLE_MAGIC_KEYBOARD_2015:
+			case USB_DEVICE_ID_APPLE_MAGIC_KEYBOARD_NUMPAD_2015:
+				table = magic_keyboard_2015_fn_keys;
+				break;
+			case USB_DEVICE_ID_APPLE_MAGIC_KEYBOARD_2021:
+			case USB_DEVICE_ID_APPLE_MAGIC_KEYBOARD_FINGERPRINT_2021:
+			case USB_DEVICE_ID_APPLE_MAGIC_KEYBOARD_NUMPAD_2021:
+			case USB_DEVICE_ID_APPLE_MAGIC_KEYBOARD_2024:
+			case USB_DEVICE_ID_APPLE_MAGIC_KEYBOARD_FINGERPRINT_2024:
+			case USB_DEVICE_ID_APPLE_MAGIC_KEYBOARD_NUMPAD_2024:
+				table = magic_keyboard_2021_and_2024_fn_keys;
+				break;
+			case USB_DEVICE_ID_APPLE_WELLSPRINGT2_J132:
+			case USB_DEVICE_ID_APPLE_WELLSPRINGT2_J213:
+			case USB_DEVICE_ID_APPLE_WELLSPRINGT2_J680:
+			case USB_DEVICE_ID_APPLE_WELLSPRINGT2_J680_ALT:
+				table = macbookpro_no_esc_fn_keys;
+				break;
+			case USB_DEVICE_ID_APPLE_WELLSPRINGT2_J152F:
+			case USB_DEVICE_ID_APPLE_WELLSPRINGT2_J214K:
+			case USB_DEVICE_ID_APPLE_WELLSPRINGT2_J223:
+				table = macbookpro_dedicated_esc_fn_keys;
+				break;
+			case USB_DEVICE_ID_APPLE_WELLSPRINGT2_J140K:
+			case USB_DEVICE_ID_APPLE_WELLSPRINGT2_J230K:
 				table = apple_fn_keys;
+				break;
+			default:
+				if (hid->product >= USB_DEVICE_ID_APPLE_WELLSPRING4_ANSI &&
+				    hid->product <= USB_DEVICE_ID_APPLE_WELLSPRING4A_JIS)
+					table = macbookair_fn_keys;
+				else if (hid->product < 0x21d || hid->product >= 0x300)
+					table = powerbook_fn_keys;
+				else
+					table = apple_fn_keys;
+			}
 		}
 
 		trans = apple_find_translation(table, code);
@@ -768,7 +778,7 @@ static int apple_input_configured(struct hid_device *hdev,
 	struct apple_sc *asc = hid_get_drvdata(hdev);
 
 	if (((asc->quirks & APPLE_HAS_FN) && !asc->fn_found) || apple_is_omoton_kb066(hdev)) {
-		hid_info(hdev, "Fn key not found (Apple Wireless Keyboard clone?), disabling Fn key handling\n");
+		hid_info(hdev, "Disabling function quirk for device without function key\n");
 		asc->quirks &= ~APPLE_HAS_FN;
 	}
 
@@ -1019,6 +1029,18 @@ static void apple_remove(struct hid_device *hdev)
 	hid_hw_stop(hdev);
 }
 
+static bool apple_match(struct hid_device *hdev, bool ignore_special_driver)
+{
+	if (ignore_special_driver ||
+	    (hdev->quirks & HID_QUIRK_IGNORE_SPECIAL_DRIVER))
+		return false;
+
+	if (hdev->group == HID_GROUP_APPLE_DOCKCHANNEL)
+		return apple_is_dockchannel_keyboard(hdev);
+
+	return true;
+}
+
 static const struct hid_device_id apple_devices[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_MIGHTYMOUSE),
 		.driver_data = APPLE_MIGHTYMOUSE | APPLE_INVERT_HWHEEL },
@@ -1240,6 +1262,9 @@ static const struct hid_device_id apple_devices[] = {
 		.driver_data = APPLE_HAS_FN | APPLE_ISO_TILDE_QUIRK },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_TOUCHBAR_BACKLIGHT),
 		.driver_data = APPLE_MAGIC_BACKLIGHT },
+	{ HID_DEVICE(BUS_HOST, HID_GROUP_APPLE_DOCKCHANNEL,
+		     HID_ANY_ID, HID_ANY_ID),
+		.driver_data = APPLE_HAS_FN | APPLE_ISO_TILDE_QUIRK },
 
 	{ }
 };
@@ -1248,6 +1273,7 @@ MODULE_DEVICE_TABLE(hid, apple_devices);
 static struct hid_driver apple_driver = {
 	.name = "apple",
 	.id_table = apple_devices,
+	.match = apple_match,
 	.report_fixup = apple_report_fixup,
 	.probe = apple_probe,
 	.remove = apple_remove,
diff --git a/include/linux/hid.h b/include/linux/hid.h
index 8d17b7416..40be5eabf 100644
--- a/include/linux/hid.h
+++ b/include/linux/hid.h
@@ -441,6 +441,7 @@ struct hid_item {
 #define HID_GROUP_STEAM				0x0103
 #define HID_GROUP_LOGITECH_27MHZ_DEVICE		0x0104
 #define HID_GROUP_VIVALDI			0x0105
+#define HID_GROUP_APPLE_DOCKCHANNEL		0x0106
 
 /*
  * HID protocol status

-- 
2.55.0


