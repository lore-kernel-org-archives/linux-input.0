Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794658676;
	b=nzJZlKN7a2/UHFMOlnD38SZJQpS2hUO9PW9StJIzs9ITjoTE/dVPAQaVwyO96ANxU4WG
	 peZQX39MECTCodgQ/Q/TkmRdYvasS0l+GDKB4aECB8zeXFvwNh9leZ7mfJXJPf+oxlEzg
	 a/Z2aCwmHo5YpYr0y/MqbX1nShZKt3MUW+0lfH765WQenKjKsJ4ksDPB4nwUNfrvY6fwH
	 MnCey6+ND9nA3hi5dw1O2WqpfHXs4YoKTEzYhbWq6MVMuSKAz2jD6A6MjFqBJb1thD7MO
	 GipS+638pnGtMC7TYi+TRV1bEbFG2tyR69WSK8DU0Q+h03AMJptgEouP/P+f97Cq3Hw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794658676;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=JyrMizB/h1su0FHvJptd3wPmMjqGExSS4FUHtj3sDcA=;
	b=iFnxm5a3HUKN/trckeXvvPWDpbjsEBUPdo6cySpvIKPu+BWEU36NgIXLbUGHZ8wdrKY0
	 cUgyNvVhl+kYxyNk3zg8U1SuOsYHvU9r1TObl+DY7Y+qCFv9jOCNhQHRKkhy0rlW0zajL
	 ClefQvUN63RYU6aUnx6Zpj7i6iVNYcJUvNRtJTSPH6AoAGPU5NGFelMFPaUvGp8nikKay
	 MGBmtzq0HqS/YkBLK16jfinraNShJm+XXAgWEWrXZ6+Myx6WxaAHKjjwoHGm0zg7dfUgF
	 3uCYQsXjB6nUU++I/CiNs/Z7npUFtnjbf5taWmEicjTZB4LuuEEr1lKJczROv78azKg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ut6XQpsu;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EB43606A323;
	Sat, 14 Nov 2026 12:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ut6XQpsu
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794658675;
	b=TTOX/XPyREjnGkuN00zrfr2DjKXoSmVxcyAq+UCvrHsFQ98wZx1UJz0nYBdEOCjUTg7/
	 TYoPq4F5MkAPmAlC7WVUjqmziTPRCvu822a/ETYDU+JvtqHraP+lF/1TjB6yhrKmogyjm
	 00zjZnihgxlfo2DY2Ix4VpvkaghZVcZV9JqiA3DLLkDKVsl6D82c9D5ievdFmqgKL221a
	 UUliG6H9f7rEl6hNwh40o3N0/9TvsXRvEvlwX4e+Yy4ZW6XuN80QHKfwLabmYvgeIWhw0
	 mVzzPFPCf0ZjShWgfShjjrrpOfbeP6PH1NO7ZFR+j5ZNUhUM6+MRqCuwR3N8zG5N+5Q==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794658675;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=JyrMizB/h1su0FHvJptd3wPmMjqGExSS4FUHtj3sDcA=;
	b=TGiBC588vXGzZ7HkNDDh6+JcCPxbusvc6n3+Yp5pT7kuMYYAlHxSd3iYTDTC41f+eR3i
	 9/CWCV5DovK8l6f3qvuNqSE3JRTN108vXP/+rBT8Pxr1ywCVsA+8g4854k9OEqLxComCO
	 GtL2ZkWECp8MuUbtFs0qKGsqX7Fb5qRtvfZ7q94irtA1/uS+D5AWm8tR68BcoOJ/jqL/N
	 QaACkq/u/Zw+7TO4A+9fnvPcd4JX8OybV3boVd3YajVmImzYM+7qPvCCY/f93mGOB9FeZ
	 etpQ/Hd+iTZoRqiFUHvicbgVqxZosT+G7VkTUUvqdsT1vmnUqUVU/5gFLMPK82in+Hw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 0E0D11F000C4;
	Sat, 14 Nov 2026 12:17:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794658675;
	bh=JyrMizB/h1su0FHvJptd3wPmMjqGExSS4FUHtj3sDcA=;
	h=From:Date:Subject:To:Cc:Reply-To;
	b=Ut6XQpsuMVVniQjB5YGpn+KZpCOkzj6WQ/3uVhx8Ywss4U8VDOyfcrc77mNWK+A4w
	 ZH6s7ESFUfBUPF+trYorxk3S09RLTsUmo2646mdNmiGXyrnmyuuh1iuk0s3mDBS5Yy
	 S6NjAqS85yd/Wa5dC/nxU0/XaHgcBLIJ+UCPyMcz9L6BPqxAh8a9GX3KGxKCgwHh2r
	 ZlSjFa8wYelTYuXfhsGeZGfp3P4RX3xF8YXR3Yc/3YKcjNb+AdQVwvRzqRRuxdp179
	 wNrfGxAig+VSU8JGADBzxCc1Npa2IQVBxSGwUabarWmvyxZ1PsFPllLjaTUAZgZoWY
	 48mXCrbBpT1gA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 7BAB449D73;
	Sat, 14 Nov 2026 12:17:54 +0000 (UTC)
From: Adolf Hirthe via B4 Relay <devnull+ohirthe.proton.me@kernel.org>
Date: Sat, 14 Nov 2026 13:17:49 +0100
Subject: [PATCH] HID: microsoft: normalize Xbox Series X|S controller axes
 over Bluetooth
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
Message-Id: <20261114-hid-ms-xbox-ble-v1-1-0b114dc5dcf3@proton.me>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQqDMBBG4avIrDvQEZHqVUoXSfytU6yWjC0B8
 e6muvwW761kiAqjtlgp4qem85Qhl4LC4KYnWLtsKq9lLSIVD9rx2zj5ObEfwU6qpscNrvGOcvW
 J6DUdx/vjtH39C2H5b2jbdmBj81RzAAAA
X-Change-ID: 20261114-hid-ms-xbox-ble-a149fe8ea9ba
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Adolf Hirthe <ohirthe@proton.me>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794658674; l=6231;
 i=ohirthe@proton.me; s=20261114; h=from:subject:message-id;
 bh=3KqYch9IC5KkG2VI5FWUeMfB/Y98raE9CsBxJbtB8cw=;
 b=OMPzsDF7Oz8RyR0R4c4uGU6xiefdA1aFmRFpk8jkOSmTslOY/bwCTCoqw0MDeip3NclDs71ih
 DUEoIO3A3PdBaXTib9VVgS7TIb2BSXcYU5WSauYLzg/LUdRGPz7NsNI
X-Developer-Key: i=ohirthe@proton.me; a=ed25519;
 pk=hZO8S9i4hCOzd2Whf3iGt3z8Wqt/A0bO/LLX2i7jWGs=
X-Endpoint-Received: by B4 Relay for ohirthe@proton.me/20261114 with
 auth_id=1523
X-Original-From: Adolf Hirthe <ohirthe@proton.me>
Reply-To: ohirthe@proton.me
Content-Transfer-Encoding: 7bit

From: Adolf Hirthe <ohirthe@proton.me>

When an Xbox Series X|S controller (045e:0b13) is connected over Bluetooth
LE, its report descriptor exposes the right stick as Z/Rz and the analog
triggers as Simulation Accelerator/Brake, with the sticks reported as
unsigned 0..65535 values centered on 32767. hid-input maps this 1:1, so
evdev consumers see:

  ABS_X/ABS_Y        left stick,  0..65535, idle ~32767
  ABS_Z/ABS_RZ       right stick, 0..65535, idle ~32767
  ABS_GAS/ABS_BRAKE  triggers,    0..1023

while the same controller over USB (xpad) reports the usual layout:
sticks on ABS_X/ABS_Y and ABS_RX/ABS_RY in -32767..32767 around 0,
triggers on ABS_Z/ABS_RZ. Software reading the plain evdev device therefore
picks up the right stick as triggers, finds no right stick, and sees the
sticks permanently deflected (characters walking in one direction).

Add a quirk that remaps these usages to the xpad-style layout and recenters
the stick values, and enable it for the Series X|S controller.

Tested by replaying reports through uhid with the report descriptor
captured from a real controller (firmware 5.09): before the change the
sticks idle at 32768 and the right stick/trigger axes are wrong, after the
change all axes match the xpad layout (sticks -32767..32767 centered on 0,
triggers 0..1023 on ABS_Z/ABS_RZ). Also checked with the real controller
over Bluetooth (buttons and stick values around center).

Note: this changes the evdev axis layout for this device. Userspace that
already special-cases the Bluetooth layout (e.g. SDL mappings for the
evdev backend) would need to follow; if a HID-BPF fixup is preferred over
an in-kernel quirk, I'm happy to rework it that way.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=222266
Assisted-by: LLM
Signed-off-by: Adolf Hirthe <ohirthe@proton.me>
---
Bug report with full analysis and the uhid replay test:
https://bugzilla.kernel.org/show_bug.cgi?id=222266

The replay test (Python, uses /dev/uhid with the report descriptor captured
from the real controller) is available on request or from the bugzilla
entry; 6 of 7 checks fail on the current driver, all pass with this patch.
---
 drivers/hid/hid-microsoft.c | 64 ++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 63 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/hid-microsoft.c b/drivers/hid/hid-microsoft.c
index a7d3493..0879602 100644
--- a/drivers/hid/hid-microsoft.c
+++ b/drivers/hid/hid-microsoft.c
@@ -27,6 +27,7 @@
 #define MS_DUPLICATE_USAGES	BIT(5)
 #define MS_SURFACE_DIAL		BIT(6)
 #define MS_QUIRK_FF		BIT(7)
+#define MS_QUIRK_BLE_XBOX_AXES	BIT(8)
 
 struct ms_data {
 	unsigned long quirks;
@@ -186,6 +187,41 @@ static int ms_input_mapping(struct hid_device *hdev, struct hid_input *hi,
 	struct ms_data *ms = hid_get_drvdata(hdev);
 	unsigned long quirks = ms->quirks;
 
+	/*
+	 * Xbox controllers over Bluetooth report the right stick as Z/Rz and
+	 * the analog triggers as Accelerator/Brake (ABS_GAS/ABS_BRAKE), and
+	 * expose the sticks in the 0..65535 range centered on 32767 instead
+	 * of the usual +-32767 around 0. Remap everything to the xpad-style
+	 * layout so that consumers get the same axes regardless of the
+	 * connection type.
+	 */
+	if (quirks & MS_QUIRK_BLE_XBOX_AXES) {
+		switch (usage->hid) {
+		case HID_GD_X:
+			hid_map_usage(hi, usage, bit, max, EV_ABS, ABS_X);
+			return 1;
+		case HID_GD_Y:
+			hid_map_usage(hi, usage, bit, max, EV_ABS, ABS_Y);
+			return 1;
+		case HID_GD_Z:
+			hid_map_usage(hi, usage, bit, max, EV_ABS, ABS_RX);
+			return 1;
+		case HID_GD_RZ:
+			hid_map_usage(hi, usage, bit, max, EV_ABS, ABS_RY);
+			return 1;
+		}
+		if ((usage->hid & HID_USAGE_PAGE) == HID_UP_SIMULATION) {
+			switch (usage->hid & HID_USAGE) {
+			case 0xc5: /* Brake -> right trigger */
+				hid_map_usage(hi, usage, bit, max, EV_ABS, ABS_RZ);
+				return 1;
+			case 0xc4: /* Accelerator -> left trigger */
+				hid_map_usage(hi, usage, bit, max, EV_ABS, ABS_Z);
+				return 1;
+			}
+		}
+	}
+
 	if (quirks & MS_ERGONOMY) {
 		int ret = ms_ergonomy_kb_quirk(hi, usage, bit, max);
 		if (ret)
@@ -232,6 +268,22 @@ static int ms_event(struct hid_device *hdev, struct hid_field *field,
 
 	input = field->hidinput->input;
 
+	/*
+	 * The sticks are reported as unsigned 0..65535 values centered on
+	 * 32767; convert them to the +-32767 range we advertise.
+	 */
+	if (quirks & MS_QUIRK_BLE_XBOX_AXES && usage->type == EV_ABS) {
+		switch (usage->code) {
+		case ABS_X:
+		case ABS_Y:
+		case ABS_RX:
+		case ABS_RY:
+			input_report_abs(input, usage->code,
+					 clamp(value - 32768, -32767, 32767));
+			return 1;
+		}
+	}
+
 	/* Handling MS keyboards special buttons */
 	if (quirks & MS_ERGONOMY && usage->hid == (HID_UP_MSVENDOR | 0xff00)) {
 		/* Special keypad keys */
@@ -328,6 +380,16 @@ static int ms_input_configured(struct hid_device *hdev, struct hid_input *hidinp
 	struct ms_data *ms = hid_get_drvdata(hdev);
 	struct input_dev *input_dev = hidinput->input;
 
+	if (ms->quirks & MS_QUIRK_BLE_XBOX_AXES) {
+		static const unsigned int sticks[] = { ABS_X, ABS_Y, ABS_RX, ABS_RY };
+		int i;
+
+		for (i = 0; i < ARRAY_SIZE(sticks); i++)
+			if (test_bit(sticks[i], input_dev->absbit))
+				input_set_abs_params(input_dev, sticks[i],
+						     -32767, 32767, 255, 4095);
+	}
+
 	if (!(ms->quirks & MS_QUIRK_FF))
 		return 0;
 
@@ -429,7 +491,7 @@ static const struct hid_device_id ms_devices[] = {
 	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_XBOX_CONTROLLER_MODEL_1708_BLE),
 		.driver_data = MS_QUIRK_FF },
 	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_XBOX_CONTROLLER_MODEL_1914),
-		.driver_data = MS_QUIRK_FF },
+		.driver_data = MS_QUIRK_FF | MS_QUIRK_BLE_XBOX_AXES },
 	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_XBOX_CONTROLLER_MODEL_1797),
 		.driver_data = MS_QUIRK_FF },
 	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_XBOX_CONTROLLER_MODEL_1797_BLE),

---
base-commit: b29833c4841e0ed8870a227c9a7c468b0cbfc906
change-id: 20261114-hid-ms-xbox-ble-a149fe8ea9ba

Best regards,
--  
Adolf Hirthe <ohirthe@proton.me>


