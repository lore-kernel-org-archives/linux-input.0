Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=46.36.39.187
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795668764;
	b=xEIPW79vYgNai75FE3Xd8EbahAyO9xHXW6tbLsNG3FqKxY7Ix0aobQ4llbySsIWeBM24
	 7l9vc/jR6Ac+Yx2RtTq6rMssAChHNdLv6+LWHFlOjvtv7224E/jHVmertSoy9u2xaXWDv
	 vEIzcyCa8GasPQ79IUoRQx0Vubq/0GgnlfchgcbST7jxtMi59yq50GXK/ilhX3FM8n6zm
	 mjD543Rw1Bsl/Ey8ApJV8LXSsw1F3z8cUne45+BwURvaBJw4Gf8D/AQBhmc0yV/OrOssH
	 aiLGleWEXcEVkLIE5HzsuTRf7uaiwAXI5GtcffpfPmGLkBYP+Avd6Z4yP5mcpNm5S4g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795668764;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=oVU4CWb/QSB241xkVntdRJ444wset4yuz3M56N/GrMc=;
	b=Ik5YBpwTQu0tbFcqDqk9M/lbgBKmALVfbYw5E8ThUrL4SaKEps/WhyvoBYh+qXGUs8w1
	 M89BKHoqxzVUePDgbZ9pEFvDw0HKptjqdIYT25DP0CNcKRPyZ8JYQT/v2ioS+CcKcf4us
	 GYZKWvcyspwtflFCEvw8t2PjfoJF4p2oP0szgINtNVmNcwq+I3AQ5wD1605U4UP+9QKdK
	 p7I+GK/V9AQIOU9PtgifJCkH8dsFw2WFW9+7fzWficRnE9u7LOlGD5W1c1nKIoRfQZhs7
	 7/Pg+waak5tiIjs05XN2G78hQHnvO5+ZoGCL3+mTjaLhLK2H6BzgzSj3QME672LgwBA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=steils.org;
	spf=pass smtp.mailfrom=steils.org;
	dkim=pass header.d=steils.org header.i=@steils.org header.a=rsa-sha256 header.s=2019 header.b=jFEVYKxl;
	arc=none smtp.remote-ip=46.36.39.187
Received: from steils.org (steils.org [46.36.39.187])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B71E9606A31C
	for <linux-input@vger.kernel.org>; Thu, 26 Nov 2026 04:52:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B71E9606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=steils.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=steils.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=steils.org header.i=@steils.org header.a=rsa-sha256 header.s=2019 header.b=jFEVYKxl
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=steils.org; s=2019;
	t=1795668755; bh=oVU4CWb/QSB241xkVntdRJ444wset4yuz3M56N/GrMc=;
	h=From:To:Cc:Subject:Date:From;
	b=jFEVYKxlYtCjNSk/qvrmPjLEITbQHCCfGaMPQYpc6KOJBSlmx74YK1vTAGtYicRXg
	 4FHbIVTpnGnNp6tiGTos9o/nYtDFJoVFIX5dINvvn5yl80cf1Ah4lZj5h/noILHa4B
	 vF4UXU+xuMNbmPx6VvhcWn5MMSuOCCsKi+KmsrIyezdJVkTIcIEZjrF+7nHNBSiiHC
	 eOqm6P9L3Riw2y7fTm6V4YOtMy0jO0WVfKZtDR3NcB0gq2SZVD2rL12Ki82YqZ75BT
	 LddtlVQ19prxvJQhvB22N44JVL4LK+QIL3hZp6D0cZ+IQ6r2bGMbFjGRLCM0AVWXLr
	 OmoRQ0xw/OOwQ==
Received: by steils.org (Postfix) id 6C23D9F251;
	Thu, 26 Nov 2026 04:52:35 +0000 (UTC)
From: Stefan Strogin <stefan@steils.org>
To: linux-input@vger.kernel.org
Cc: Stefan Strogin <stefan@steils.org>,
	"Derek J . Clark" <derekjohn.clark@gmail.com>,
	Mark Pearson <mpearson-lenovo@squebb.ca>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Subject: [PATCH] HID: lenovo: add support for the X9 mouse side button
Date: Thu, 26 Nov 2026 04:52:13 +0000
Message-ID: <20261126045214.49445-1-stefan@steils.org>
X-Mailer: git-send-email 2.56.1
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Lenovo Multi-Device Wireless Mouse (X9 Edition) has one side button
which sends events in vendor-specific reports that hid-generic does not
map to input events.
The USB receiver and Bluetooth connection use different report formats.
In both formats, the button state field has different values for short
and long presses.

Decode both formats and report short presses as BTN_SIDE and long
presses as BTN_EXTRA.

Signed-off-by: Stefan Strogin <stefan@steils.org>
---
 drivers/hid/Kconfig      |   2 +
 drivers/hid/hid-ids.h    |   2 +
 drivers/hid/hid-lenovo.c | 116 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 120 insertions(+)

diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
index 2481bc01c435..87926d6958cc 100644
--- a/drivers/hid/Kconfig
+++ b/drivers/hid/Kconfig
@@ -630,6 +630,8 @@ config HID_LENOVO
 	- ThinkPad Compact Bluetooth Keyboard with TrackPoint (supports Fn keys)
 	- ThinkPad Compact USB Keyboard with TrackPoint (supports Fn keys)
 
+	This also supports the side button on the Lenovo X9 Edition mouse.
+
 config HID_LENOVO_GO
 	tristate "HID Driver for Lenovo Legion Go Series Controllers"
 	depends on USB_HID
diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 85902527f3cd..811e9da52d74 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -913,6 +913,8 @@
 #define USB_DEVICE_ID_LENOVO_LEGION_GO2_DINPUT		0x61ec
 #define USB_DEVICE_ID_LENOVO_LEGION_GO2_DUAL_DINPUT	0x61ed
 #define USB_DEVICE_ID_LENOVO_LEGION_GO2_FPS		0x61ee
+#define USB_DEVICE_ID_LENOVO_X9_MOUSE_RECEIVER	0x6207
+#define USB_DEVICE_ID_LENOVO_X9_MOUSE_BT	0x61cf
 
 #define USB_VENDOR_ID_LETSKETCH		0x6161
 #define USB_DEVICE_ID_WP9620N		0x4d15
diff --git a/drivers/hid/hid-lenovo.c b/drivers/hid/hid-lenovo.c
index e997d0cf2672..1af47a2cdd0b 100644
--- a/drivers/hid/hid-lenovo.c
+++ b/drivers/hid/hid-lenovo.c
@@ -785,9 +785,87 @@ static int lenovo_raw_event_TP_X12_tab(struct hid_device *hdev, u32 raw_data)
 	return 0;
 }
 
+enum {
+	X9_USB_RELEASE     = 0x00,
+	X9_USB_SHORT_PRESS = 0x01,
+	X9_USB_LONG_PRESS  = 0x02,
+};
+
+static const u8 lenovo_x9_side_button_reports[][32] = {
+	[X9_USB_RELEASE]     = { 0x06, 0x04, 0xe0, 0x00, [31] = 0x6b },
+	[X9_USB_SHORT_PRESS] = { 0x06, 0x04, 0xe0, 0x01, [31] = 0x6a },
+	[X9_USB_LONG_PRESS]  = { 0x06, 0x04, 0xe0, 0x02, [31] = 0x69 },
+};
+
+static void lenovo_x9_raw_event(struct hid_device *hdev,
+				struct hid_report *report, u8 *data, int size)
+{
+	struct hid_field *field = hid_get_drvdata(hdev);
+	struct input_dev *input;
+	u8 state;
+
+	if (!(hdev->claimed & HID_CLAIMED_INPUT) || !field || !field->hidinput ||
+	    report != field->report || size != sizeof(lenovo_x9_side_button_reports[0]))
+		return;
+
+	state = data[3];
+	if (state >= ARRAY_SIZE(lenovo_x9_side_button_reports) ||
+	    memcmp(data, lenovo_x9_side_button_reports[state], size))
+		return;
+
+	input = field->hidinput->input;
+	input_report_key(input, BTN_SIDE, state == X9_USB_SHORT_PRESS);
+	input_report_key(input, BTN_EXTRA, state == X9_USB_LONG_PRESS);
+	input_sync(input);
+}
+
+static void lenovo_x9_bt_raw_event(struct hid_device *hdev,
+				   struct hid_report *report, u8 *data, int size)
+{
+	struct hid_field *field = hid_get_drvdata(hdev);
+	struct input_dev *input;
+	unsigned short button;
+
+	if (report->type != HID_INPUT_REPORT || report->id != 0x39 ||
+	    report->application != (HID_UP_MSVENDOR | 0x01) ||
+	    !(hdev->claimed & HID_CLAIMED_INPUT) || !field || !field->hidinput)
+		return;
+
+	if (size != 8 || data[1] != 0x01 || memchr_inv(data + 3, 0, 5))
+		return;
+
+	switch (data[2]) {
+	case 0x00:
+		button = 0;
+		break;
+	case 0x1f:
+		button = BTN_SIDE;
+		break;
+	case 0x1e:
+		button = BTN_EXTRA;
+		break;
+	default:
+		return;
+	}
+
+	input = field->hidinput->input;
+	input_report_key(input, BTN_SIDE, button == BTN_SIDE);
+	input_report_key(input, BTN_EXTRA, button == BTN_EXTRA);
+	input_sync(input);
+}
+
 static int lenovo_raw_event(struct hid_device *hdev,
 			struct hid_report *report, u8 *data, int size)
 {
+	switch (hdev->product) {
+	case USB_DEVICE_ID_LENOVO_X9_MOUSE_RECEIVER:
+		lenovo_x9_raw_event(hdev, report, data, size);
+		return 0;
+	case USB_DEVICE_ID_LENOVO_X9_MOUSE_BT:
+		lenovo_x9_bt_raw_event(hdev, report, data, size);
+		return 0;
+	}
+
 	/*
 	 * Compact USB keyboard's Fn-F12 report holds down many other keys, and
 	 * its own key is outside the usage page range. Remove extra
@@ -1419,6 +1497,26 @@ static int lenovo_probe(struct hid_device *hdev,
 		goto err;
 	}
 
+	if (hdev->product == USB_DEVICE_ID_LENOVO_X9_MOUSE_BT) {
+		struct hid_field *field;
+
+		hdev->quirks |= HID_QUIRK_INPUT_PER_APP;
+		field = hid_find_field(hdev, HID_INPUT_REPORT, HID_GD_MOUSE, HID_UP_BUTTON | 1);
+		hid_set_drvdata(hdev, field);
+	} else if (hdev->product == USB_DEVICE_ID_LENOVO_X9_MOUSE_RECEIVER) {
+		struct hid_field *field;
+
+		/* Preserve hid-generic's per-application input devices */
+		hdev->quirks |= HID_QUIRK_INPUT_PER_APP;
+		field = hid_find_field(hdev, HID_INPUT_REPORT, 0xff0a0001,
+				       HID_UP_MSVENDOR | 0x03);
+		if (field && !field->report->id &&
+		    hid_report_len(field->report) == sizeof(lenovo_x9_side_button_reports[0])) {
+			hid_set_drvdata(hdev, field);
+			hdev->quirks |= HID_QUIRK_HIDINPUT_FORCE;
+		}
+	}
+
 	ret = hid_hw_start(hdev, HID_CONNECT_DEFAULT);
 	if (ret) {
 		hid_err(hdev, "hid_hw_start failed\n");
@@ -1461,6 +1559,10 @@ static int lenovo_probe(struct hid_device *hdev,
 static int lenovo_reset_resume(struct hid_device *hdev)
 {
 	switch (hdev->product) {
+	case USB_DEVICE_ID_LENOVO_X9_MOUSE_RECEIVER:
+		if (hdev->claimed & HID_CLAIMED_INPUT)
+			hidinput_reset_resume(hdev);
+		break;
 	case USB_DEVICE_ID_LENOVO_CUSBKBD:
 	case USB_DEVICE_ID_LENOVO_TPIIUSBKBD:
 		if (hdev->type == HID_TYPE_USBMOUSE)
@@ -1541,6 +1643,8 @@ static void lenovo_remove(struct hid_device *hdev)
 static int lenovo_input_configured(struct hid_device *hdev,
 		struct hid_input *hi)
 {
+	struct hid_field *field;
+
 	switch (hdev->product) {
 		case USB_DEVICE_ID_LENOVO_TPKBD:
 		case USB_DEVICE_ID_LENOVO_CUSBKBD:
@@ -1558,6 +1662,14 @@ static int lenovo_input_configured(struct hid_device *hdev,
 		case USB_DEVICE_ID_LENOVO_X13_TAB:
 			input_set_capability(hi->input, EV_KEY, KEY_PERFORMANCE);
 			break;
+		case USB_DEVICE_ID_LENOVO_X9_MOUSE_RECEIVER:
+		case USB_DEVICE_ID_LENOVO_X9_MOUSE_BT:
+			field = hid_get_drvdata(hdev);
+			if (field && field->hidinput == hi) {
+				input_set_capability(hi->input, EV_KEY, BTN_SIDE);
+				input_set_capability(hi->input, EV_KEY, BTN_EXTRA);
+			}
+			break;
 	}
 
 	return 0;
@@ -1565,6 +1677,10 @@ static int lenovo_input_configured(struct hid_device *hdev,
 
 
 static const struct hid_device_id lenovo_devices[] = {
+	{ HID_DEVICE(BUS_USB, HID_GROUP_GENERIC,
+		     USB_VENDOR_ID_LENOVO, USB_DEVICE_ID_LENOVO_X9_MOUSE_RECEIVER) },
+	{ HID_DEVICE(BUS_BLUETOOTH, HID_GROUP_GENERIC,
+		     USB_VENDOR_ID_LENOVO, USB_DEVICE_ID_LENOVO_X9_MOUSE_BT) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_LENOVO, USB_DEVICE_ID_LENOVO_TPKBD) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_LENOVO, USB_DEVICE_ID_LENOVO_CUSBKBD) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_LENOVO, USB_DEVICE_ID_LENOVO_TPIIUSBKBD) },
-- 
2.56.1

