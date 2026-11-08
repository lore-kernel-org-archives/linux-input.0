Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794122715;
	b=z2SN096XraT1QmPp8fcQs+XsxCJXoxopZ3chmMuB6Wp6K7HkvUvZe+vN17t9yiqq1pHs
	 k1te9GhvSCV/JGNd/xskgVy1PlMeqQSUVDAkyPj+3husxf+rPn5OqyBToCbciLlsTfzcP
	 lLLGpV31gEpX2REit2+mKkq3wnqh3YjE5mwqUerLOdFiYTdT1/WaPFpmsyWwlS/PpdVB5
	 NCBQ3O69TFfaFBTbj8B8+ECrlVpXpQ2QTy+caJUhixh0Q064azRhJ5E0Bf8mEVaiLISj+
	 03E71aCIRPJ8JCePIp1e/TihD2IeCwft1FwhT26ui8qIooFaJbKr2GPFNMAl5p3WvwA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794122715;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=htOg9/VGQUCTLzy6OXHbwOss9waJcFgQjjVbf80T4B8=;
	b=q62aAP7PNoidiWJsR2JuuaG4R21xO6KITz70xdlXEI1O+INbeWbmtQ4l3Nj9Pt8wVVYv
	 NLtFh2tfAB+z13lukHSDjnnbnp6eMK1kPQS+Znz0+EDxiFhaKj8Sbvd2uFztEqD1Ydjbk
	 mQ8cWs227ZCYOdYAfq5xu86BvcEbhsaPBzRKTl2dTxu9+9u+uW3vZ4ztXnBaUqEkxURf/
	 ITKms7NrxAQvRDqIVnW+ZEL7zeDxubhh3reTkkfyfx5kXzQQT2LBrWW289medaXxZHRfA
	 MSs80nrvLwjC9CYAC2MolMTFEp/jBImfdyuI+N/p4UKwo9QWp6p9W/0aFdqyad+iDgw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Qi1snFJo;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AC8D606A320;
	Sun,  8 Nov 2026 07:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Qi1snFJo
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794122715;
	b=OsVdGlrZCt80mNd7DrfpK8qPyjMIKNra0v+X58/+lvwSEvQZQYLioCvS1KsbyGmJxMdJ
	 SXDdmAudXVzibKp2xz+6UIPoqtD56viF4cg7KkgoZicD+a5RXKBEANVO8U5KllATMDU3g
	 dhEM8EwOPVeTywCdnXx+3pAtlMwzR3m1s2vxRL8HP6Y0AWSb/XcKflo+Vg1A46Kuy9hpk
	 Zl2M8GxZ3i90VbYqiLiTLql7h7bvQ51Zb7fKOAXM5o1pCJI4jLwLyODDZfFBK5LyDr7Sk
	 mRTo+gibwXRAVsLeAIFiv0Y5gCUrk+9xi9CyvLFdYiQ91UZH+ilqk2OtsBDxXiBF9SA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794122715;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=htOg9/VGQUCTLzy6OXHbwOss9waJcFgQjjVbf80T4B8=;
	b=EDMZhgU70EYlyD6chokQe76SHjaZhwAw37w3gkZXyTl0Yn3KbL0iqIYetcaTWwsgwid7
	 vKu4ZNHZ+fyx7Iee8xafjMbF2g6w5W2W3QrK+rQ+bm+7gjQWf7pDHZ/7rNu1tyFjmHtNI
	 E7g/az54JbQKw6foMZDOSqM5KirMzB0Ei2cj3MQak7PR5ul0YAa2ojhV673ua3ZQ79QU8
	 QDKZhP5COj1btXgGXYuiBo/fsm9T2M8VzMyJOBziZV+hsCjIv2E1d/wsiTAGWKROzlbOl
	 OkeX00HP6iM31suS2rbc8fqkG/JjBehCgpnxTiTQG9o4sLfThekp0T9yBaruPF2vdkw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id EBA9B1F008A7;
	Sun,  8 Nov 2026 07:25:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794122715;
	bh=htOg9/VGQUCTLzy6OXHbwOss9waJcFgQjjVbf80T4B8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=Qi1snFJoyAzAxMPg9LXrz+ZHw6lu2SfffM4Hb+3P/aejwt84WJc/M9Pgz1uvbPsdn
	 XVGqSdq9IBeOmrLnhKf9Ks0vO2VB5/54yqnWIlTSl1Of+bLFziFeESbN7ARMqisyEG
	 bK5D11o5sFTVco1yQwoN75YUxoB4UiqqQ7YmRFqVQ9Dtk0fcduHw9tVvfuces7sBfk
	 cxRQifLme6Ed/Q+oU3knfiqhCJ1Li0qS2S4sGquZQ5Vm3r8/MsdJSAVvt5ch7wMhEf
	 vzyoQ/NpseLDT7TV6p7QtHzuQVauUQOaa0Ik+H3RGg5+wpjBoi4+WygSueZXalETu5
	 yWF7bd9OwJ8iQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 5FA0F47E67;
	Sun,  8 Nov 2026 07:25:12 +0000 (UTC)
From: Michael Reeves via B4 Relay <devnull+michael.reeves077.gmail.com@kernel.org>
Date: Sun, 08 Nov 2026 07:25:10 +0000
Subject: [PATCH v5 5/8] HID: apple: Add support for DockChannel HID
 keyboards
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261108-b4-apple-mtp-keyboard-v5-5-e2c97b82669a@gmail.com>
References: <20261108-b4-apple-mtp-keyboard-v5-0-e2c97b82669a@gmail.com>
In-Reply-To: <20261108-b4-apple-mtp-keyboard-v5-0-e2c97b82669a@gmail.com>
To: Sven Peter <sven@kernel.org>, Janne Grunau <j@jannau.net>, 
 Neal Gompa <neal@gompa.dev>, Jassi Brar <jassisinghbrar@gmail.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jikos@kernel.org>, 
 Benjamin Tissoires <bentiss@kernel.org>, 
 Michael Reeves <michael.reeves077@gmail.com>
Cc: asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-input@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794122710; l=7544;
 i=michael.reeves077@gmail.com; s=20261107; h=from:subject:message-id;
 bh=HP89A6n+7GIQqAKevUYTWuk+TDk3pz2BQBYodbC7pwI=;
 b=GmYfAqU7IOtL2C3zOcCOZvw6Pff+ahsw0z9cyB3LFQw6yoM1hwVXiVZ0ldsz1cmpPQrmbKuUq
 OMfvRMqvLR7DrFtZeTWgvzdAxhXCqG7hcWL9lEZ14MTTkoa4i215pQo
X-Developer-Key: i=michael.reeves077@gmail.com; a=ed25519;
 pk=ykwkLcuByJYb/cdLc2UuoYP03pIzwrscEZg30+4tJL8=
X-Endpoint-Received: by B4 Relay for michael.reeves077@gmail.com/20261107
 with auth_id=1442
X-Original-From: Michael Reeves <michael.reeves077@gmail.com>
Reply-To: michael.reeves077@gmail.com
Content-Transfer-Encoding: 7bit

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
index 5b32fb8c77f3..d0059a3c0ac7 100644
--- a/drivers/hid/hid-apple.c
+++ b/drivers/hid/hid-apple.c
@@ -398,6 +398,12 @@ static bool apple_is_omoton_kb066(struct hid_device *hdev)
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
@@ -485,53 +491,57 @@ static int hidinput_apple_event(struct hid_device *hid, struct input_dev *input,
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
@@ -771,7 +781,7 @@ static int apple_input_configured(struct hid_device *hdev,
 	struct apple_sc *asc = hid_get_drvdata(hdev);
 
 	if (((asc->quirks & APPLE_HAS_FN) && !asc->fn_found) || apple_is_omoton_kb066(hdev)) {
-		hid_info(hdev, "Fn key not found (Apple Wireless Keyboard clone?), disabling Fn key handling\n");
+		hid_info(hdev, "Disabling function quirk for device without function key\n");
 		asc->quirks &= ~APPLE_HAS_FN;
 	}
 
@@ -1025,6 +1035,18 @@ static void apple_remove(struct hid_device *hdev)
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
@@ -1250,6 +1272,9 @@ static const struct hid_device_id apple_devices[] = {
 		.driver_data = APPLE_HAS_FN | APPLE_ISO_TILDE_QUIRK },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_TOUCHBAR_BACKLIGHT),
 		.driver_data = APPLE_MAGIC_BACKLIGHT },
+	{ HID_DEVICE(BUS_HOST, HID_GROUP_APPLE_DOCKCHANNEL,
+		     HID_ANY_ID, HID_ANY_ID),
+		.driver_data = APPLE_HAS_FN | APPLE_ISO_TILDE_QUIRK },
 
 	{ }
 };
@@ -1258,6 +1283,7 @@ MODULE_DEVICE_TABLE(hid, apple_devices);
 static struct hid_driver apple_driver = {
 	.name = "apple",
 	.id_table = apple_devices,
+	.match = apple_match,
 	.report_fixup = apple_report_fixup,
 	.probe = apple_probe,
 	.remove = apple_remove,
diff --git a/include/linux/hid.h b/include/linux/hid.h
index 8d17b741638c..40be5eabf481 100644
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
2.56.0


