Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D303377AAD;
	Thu, 16 Jul 2026 09:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784192854; cv=none; b=grKj5N0pC1/pNW2cLTrVVMHhOws2io4wxqTdq1VGeAP6TKefA8LmAWuxcz2n+Ry0goOObW61abqHB1nuBLMTa5mfZm3zMgvK4X4iPZmRf2jVWRlT+zaIk1y6I2ks4Y8guJjsN/r1avYbpt/t42LoRF/liQ75GOj/Qbh2OEDScrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784192854; c=relaxed/simple;
	bh=TxA737YgF+TSfY61DmlDbd65PJik2G2mKRn1ulUesVA=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=PjrHJn4BwY1yWqo1iV2IU7NTst7qN+GCTpBtbqtTYaMFpwh9ujf9bpdb/4U0s/dBmrHmGB+lnF4DTaYk5YILBy9X+S2YEWvXQ6eDrgEv/xYtcI2hcPht1nujsIKX0tbd+WEIAAGYS8Tu4t2a4YluaayNJ/dASCGMa6ntI6u68jA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TLZlLMwH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TLZlLMwH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E1631F000E9;
	Thu, 16 Jul 2026 09:07:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784192852;
	bh=WBGnBAhPilICcUqAGgw6+Tn7W0YFV0FLdQLV90DgwKw=;
	h=From:To:Subject:Date;
	b=TLZlLMwH297U0MnoyvFYYhkaU+DF0BaIOxRik5YHm1PXwza9elL+1yOZu8US5ijAD
	 BGgk+ny2Zpq5L3B5inORtcYTMYxusBk6IqYjeEAqe/JVcKCwmqX9RWRuxZirdqso/V
	 UrI6pueM72IVpUZ3aPgrJoK/wxDf6qOnv6aiNxvqUcBfA2wV7RbO/MGeemNw1eeQBz
	 Pc6D1cPUCLL78lCeuJcznkWGDyI9U6u9/fTOSf7zgJtkp0+u2EVEsc0vfBoS7DbwPn
	 jL7z1e8yOPAb5+P6anL3SQWy3v+taIYvWneJMPRNeQRjH6mOnL4DSul80hJG3CxWa6
	 yFWgrjXDbGxbA==
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
Subject: [PATCH v6 1/4] HID: wacom: Advertise SW_MUTE_DEVICE capability prior to registration
Date: Thu, 16 Jul 2026 09:07:12 +0000
Message-ID: <20260716090726.2711293-1-lee@kernel.org>
X-Mailer: git-send-email 2.55.0.141.g00534a21ce-goog
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
it, excluding TabletPC devices.

Additionally, replace the lookup-dependent
'wacom_wac->shared->touch->product' references with 'hdev->product'
inside wacom_setup_touch_input_capabilities() as 'hdev' is already
available and represents the touch device itself.

Fixes: d2ec58aee8b1 ("HID: wacom: generic: support generic touch switch")
Signed-off-by: Lee Jones <lee@kernel.org>
---

v4 -> v5: New patch used to split out SW_MUTE_DEVICE as per Jason's request
v5 -> v6: Unconditionally advertise SW_MUTE_DEVICE on generic touch devices

 drivers/hid/wacom_sys.c |  6 ------
 drivers/hid/wacom_wac.c | 19 +++++++++++--------
 2 files changed, 11 insertions(+), 14 deletions(-)

diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
index 0eafa483b7f7..6c2a3ddfe366 100644
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
diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
index a29bf051ada7..32c4fd03479e 100644
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
+		input_dev->evbit[0] |= BIT_MASK(EV_SW);
+		__set_bit(SW_MUTE_DEVICE, input_dev->swbit);
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
2.55.0.141.g00534a21ce-goog

