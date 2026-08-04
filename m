Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10A0F444717;
	Tue,  4 Aug 2026 10:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785839440; cv=none; b=cDo8mXUNUDniA71m770XS8dGHXCEzvxw5j+NA/S5al7XCbsqcWw6Z861Yk9XG+8OkGbQONrmyUTF6vG4gsxa4y26rgVeO44gFQIxApzhqBP9nwmQYhInOgdHVV+26f6p3VUFzQ0NzTIsO14oR/Ciays+ySWFTkSseR7FtYBkRUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785839440; c=relaxed/simple;
	bh=+VUruKKX1vKZTWlLPpKfaIMKAcqir0gtLJT28fQYSZg=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=oPQ5bN8E+hHFfIQ+cDTjPoR29s6vmKWp8fQZW2KG3XEUaRsgc9umJI8sLwDNUdIALYP5kPiSovnraEfzJMxERhMlf+XIw35D9c2lj1PHA/GOEqKuwTk+EIsHpPpzP6V5GsmjUHk2xTcjPs7jMk7tAjgH0r8sPTA18tsMfUW49ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YYFiHfmt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YYFiHfmt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E84911F00A3A;
	Tue,  4 Aug 2026 10:30:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785839438;
	bh=vDKV0SW0yPDbELhfKxF/3QjSaxZT++50ZCNPalmfQDg=;
	h=From:To:Subject:Date;
	b=YYFiHfmtDP68jK7DpuoH1s2Gsw2XaNoUPqc4EDuAVBEYgTEBcYpXDrfENTQpqRnKT
	 JXL525MmSnj1Z1XYHXnFB//z1m5bU/SDCLFg+t2M1y63cx24A7pME7WtPv8eG9xoIk
	 KqdUPFACrl8HWaIewHh6sYPM3Hy2PH9+25qnYvS6rC/kd9mI/zoV2iSEZRm6VZRcgR
	 D97PYGZ+Jc8zsVLE3m4IQ11NjEtA7dPcN6LO1Pm01LBl3zt9dpDL/ZWZmtr5kxae+H
	 4dFqPE4zXV+IZVh1J1b/HnDuAOmiCPBsytN3SGPUvCOFOu+qfohSy8NcnWPph/AaX0
	 44cLYREzlx8yQ==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	Ping Cheng <ping.cheng@wacom.com>,
	Jason Gerecke <jason.gerecke@wacom.com>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Aaron Skomra <aaron.skomra@wacom.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Peter Hutterer <peter.hutterer@who-t.net>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] HID: wacom: Advertise SW_MUTE_DEVICE capability prior to registration
Date: Tue,  4 Aug 2026 10:30:07 +0000
Message-ID: <20260804103030.1491356-1-lee@kernel.org>
X-Mailer: git-send-email 2.55.0.571.g244d577d93-goog
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Input subsystem guidelines require that device capabilities are advertised
before the input device is registered.  The Wacom driver was violating
this by advertising the SW_MUTE_DEVICE capability post-registration in
wacom_set_shared_values() (and duplicating it in device-specific setup
cases).

Resolve this by moving the SW_MUTE_DEVICE capability setup to
wacom_setup_touch_input_capabilities() for all touch devices that support
it, including composite USB generic touch devices.

Additionally, replace the lookup-dependent
'wacom_wac->shared->touch->product' references with 'hdev->product'
inside wacom_setup_touch_input_capabilities() as 'hdev' is already
available and represents the touch device itself.

Fixes: d2ec58aee8b1 ("HID: wacom: generic: support generic touch switch")
Signed-off-by: Lee Jones <lee@kernel.org>
---

v4 -> v5: New patch used to split out SW_MUTE_DEVICE as per Jason's request
v5 -> v6: Unconditionally advertise SW_MUTE_DEVICE on generic touch devices
v6 -> v7: Only advertise SW_MUTE_DEVICE on composite USB generic touch devices

 drivers/hid/wacom_sys.c | 23 +++++++++++++++++------
 drivers/hid/wacom_wac.c | 19 +++++++++++--------
 2 files changed, 28 insertions(+), 14 deletions(-)

diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
index 0eafa483b7f7..92b73ed0028f 100644
--- a/drivers/hid/wacom_sys.c
+++ b/drivers/hid/wacom_sys.c
@@ -2359,12 +2359,6 @@ static void wacom_set_shared_values(struct wacom_wac *wacom_wac)
 			wacom_wac->shared->is_touch_on = true;
 	}
 
-	if (wacom_wac->shared->has_mute_touch_switch &&
-	    wacom_wac->shared->touch_input) {
-		set_bit(EV_SW, wacom_wac->shared->touch_input->evbit);
-		input_set_capability(wacom_wac->shared->touch_input, EV_SW,
-				     SW_MUTE_DEVICE);
-	}
 }
 
 static int wacom_parse_and_register(struct wacom *wacom, bool wireless)
@@ -2414,6 +2408,23 @@ static int wacom_parse_and_register(struct wacom *wacom, bool wireless)
 	wacom_retrieve_hid_descriptor(hdev, features);
 	wacom_setup_device_quirks(wacom);
 
+	if (features->type == HID_GENERIC &&
+	    (features->device_type & WACOM_DEVICETYPE_TOUCH)) {
+		if (wacom->usbdev && wacom->usbdev->actconfig &&
+		    wacom->usbdev->actconfig->desc.bNumInterfaces > 1) {
+			/*
+			 * Heuristic: Composite USB devices (like tablets with
+			 * pen/pad + touch) likely have a touch mute switch.
+			 * We flag it here to advertise the capability before
+			 * registration. We also set is_soft_touch_switch to
+			 * default touch to ON in case there is no physical
+			 * switch.
+			 */
+			wacom_wac->has_mute_touch_switch = true;
+			wacom_wac->is_soft_touch_switch = true;
+		}
+	}
+
 	if (features->device_type == WACOM_DEVICETYPE_NONE &&
 	    features->type != WIRELESS) {
 		error = features->type == HID_GENERIC ? -ENODEV : 0;
diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
index a29bf051ada7..afc82fcbb20b 100644
--- a/drivers/hid/wacom_wac.c
+++ b/drivers/hid/wacom_wac.c
@@ -3953,6 +3953,8 @@ int wacom_setup_pen_input_capabilities(struct input_dev *input_dev,
 int wacom_setup_touch_input_capabilities(struct input_dev *input_dev,
 					 struct wacom_wac *wacom_wac)
 {
+	struct wacom *wacom = container_of(wacom_wac, struct wacom, wacom_wac);
+	struct hid_device *hdev = wacom->hdev;
 	struct wacom_features *features = &wacom_wac->features;
 
 	if (!(features->device_type & WACOM_DEVICETYPE_TOUCH))
@@ -3963,9 +3965,12 @@ int wacom_setup_touch_input_capabilities(struct input_dev *input_dev,
 	else
 		__set_bit(INPUT_PROP_POINTER, input_dev->propbit);
 
-	if (features->type == HID_GENERIC)
+	if (features->type == HID_GENERIC) {
+		if (wacom_wac->has_mute_touch_switch)
+			input_set_capability(input_dev, EV_SW, SW_MUTE_DEVICE);
 		/* setup has already been done */
 		return 0;
+	}
 
 	input_dev->evbit[0] |= BIT_MASK(EV_KEY) | BIT_MASK(EV_ABS);
 	__set_bit(BTN_TOUCH, input_dev->keybit);
@@ -3997,19 +4002,17 @@ int wacom_setup_touch_input_capabilities(struct input_dev *input_dev,
 		input_dev->evbit[0] |= BIT_MASK(EV_SW);
 		__set_bit(SW_MUTE_DEVICE, input_dev->swbit);
 
-		if (wacom_wac->shared->touch->product == 0x361) {
+		if (hdev->product == 0x361) {
 			input_set_abs_params(input_dev, ABS_MT_POSITION_X,
 					     0, 12440, 4, 0);
 			input_set_abs_params(input_dev, ABS_MT_POSITION_Y,
 					     0, 8640, 4, 0);
-		}
-		else if (wacom_wac->shared->touch->product == 0x360) {
+		} else if (hdev->product == 0x360) {
 			input_set_abs_params(input_dev, ABS_MT_POSITION_X,
 					     0, 8960, 4, 0);
 			input_set_abs_params(input_dev, ABS_MT_POSITION_Y,
 					     0, 5920, 4, 0);
-		}
-		else if (wacom_wac->shared->touch->product == 0x393) {
+		} else if (hdev->product == 0x393) {
 			input_set_abs_params(input_dev, ABS_MT_POSITION_X,
 					     0, 6400, 4, 0);
 			input_set_abs_params(input_dev, ABS_MT_POSITION_Y,
@@ -4039,8 +4042,8 @@ int wacom_setup_touch_input_capabilities(struct input_dev *input_dev,
 		fallthrough;
 
 	case WACOM_27QHDT:
-		if (wacom_wac->shared->touch->product == 0x32C ||
-		    wacom_wac->shared->touch->product == 0xF6) {
+		if (hdev->product == 0x32C ||
+		    hdev->product == 0xF6) {
 			input_dev->evbit[0] |= BIT_MASK(EV_SW);
 			__set_bit(SW_MUTE_DEVICE, input_dev->swbit);
 			wacom_wac->has_mute_touch_switch = true;
-- 
2.55.0.571.g244d577d93-goog

