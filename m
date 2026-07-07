Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 961433F7A8C;
	Tue,  7 Jul 2026 12:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783426265; cv=none; b=Tj5P/yf1EdFS2DWZVBWTCil/k5KLG3SZpaqjMJcz1ulhLW44P6Bh8eTnCVR/TyJHHFkfIAJSeTGn8h/AWG8J6FLdrJrrqcUaXUt1RSugHkn1WfH68iiu5YJDyAs6H4q1V5aMguzk469xdfhr3TB5GIQfPcGD83FVBr1hYBzflHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783426265; c=relaxed/simple;
	bh=we3dWvZ6t4prL6D3fCk7KzlaGURAK8hKm5WTRujuksU=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=WtjxTlrlPFI9TZoiNxrcWvyCerU47NsIGCr/wI/j9M59psYz/PQ2JVMhGga/Wzw4BsinY9kUvJpC6qk/0spRPw22Q1vWLPXY7Qs/L2VdczSTqxp1i72CDrVLyMwNLIVuHtv8fcGKWIYE3oxvmnjYH6cJ87cbmSK4YkxvM1qJOxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UhA/ENul; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UhA/ENul"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF1DB1F00A3A;
	Tue,  7 Jul 2026 12:11:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783426264;
	bh=ICLwcqgg0ppFN1EFNhSJVhwgVcJa5xSrY5nBlYJOmeU=;
	h=From:To:Subject:Date;
	b=UhA/ENulLP8nM/i7KjzUvbL50zLp8emg4/SsurkP9LEnjNXOuMAHoFqfWTFs0dI06
	 anFbRSu7nCKz+KbXdfgSAxin8DRtc8P2eeI6wG5uQaqvC6w5m479Xy8/TY4yTaEoUx
	 hy7yjCYRh9cH9Ku+WDwAxhFHh9tN61QzoGo4C43++TNJM9lLA4iD0swTz0cjUfFIAG
	 eVwoaoOMwS1hzBdKZ/XYlPJ9+o70Ujz8SMkkO0yP3fUJcfVc38ivMJY6t+td+cgsag
	 pZKqcP8Zsd/JDH4HEPxHnu+Nrks8QJyeUSV2bMzUKX4SAk1fIDftOp3FGs3MWknC9o
	 fcUnPpbS2zTIA==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	Ping Cheng <ping.cheng@wacom.com>,
	Jason Gerecke <jason.gerecke@wacom.com>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Aaron Skomra <aaron.skomra@wacom.com>,
	Peter Hutterer <peter.hutterer@who-t.net>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] HID: wacom: Advertise SW_MUTE_DEVICE capability prior to registration
Date: Tue,  7 Jul 2026 12:10:40 +0000
Message-ID: <20260707121051.1683937-1-lee@kernel.org>
X-Mailer: git-send-email 2.55.0.rc2.803.g1fd1e6609c-goog
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

drivers/hid/wacom_sys.c |  6 ------
 drivers/hid/wacom_wac.c | 21 +++++++++++++--------
 2 files changed, 13 insertions(+), 14 deletions(-)

diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
index 2220168bf116..60b380efdfb7 100644
--- a/drivers/hid/wacom_sys.c
+++ b/drivers/hid/wacom_sys.c
@@ -2361,12 +2361,6 @@ static void wacom_set_shared_values(struct wacom_wac *wacom_wac)
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
index da1f0ea85625..a31325be50f8 100644
--- a/drivers/hid/wacom_wac.c
+++ b/drivers/hid/wacom_wac.c
@@ -3951,6 +3951,8 @@ int wacom_setup_pen_input_capabilities(struct input_dev *input_dev,
 int wacom_setup_touch_input_capabilities(struct input_dev *input_dev,
 					 struct wacom_wac *wacom_wac)
 {
+	struct wacom *wacom = container_of(wacom_wac, struct wacom, wacom_wac);
+	struct hid_device *hdev = wacom->hdev;
 	struct wacom_features *features = &wacom_wac->features;
 
 	if (!(features->device_type & WACOM_DEVICETYPE_TOUCH))
@@ -3961,9 +3963,14 @@ int wacom_setup_touch_input_capabilities(struct input_dev *input_dev,
 	else
 		__set_bit(INPUT_PROP_POINTER, input_dev->propbit);
 
-	if (features->type == HID_GENERIC)
+	if (features->type == HID_GENERIC) {
+		if (wacom_wac->shared && wacom_wac->shared->has_mute_touch_switch) {
+			input_dev->evbit[0] |= BIT_MASK(EV_SW);
+			__set_bit(SW_MUTE_DEVICE, input_dev->swbit);
+		}
 		/* setup has already been done */
 		return 0;
+	}
 
 	input_dev->evbit[0] |= BIT_MASK(EV_KEY) | BIT_MASK(EV_ABS);
 	__set_bit(BTN_TOUCH, input_dev->keybit);
@@ -3995,19 +4002,17 @@ int wacom_setup_touch_input_capabilities(struct input_dev *input_dev,
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
@@ -4037,8 +4042,8 @@ int wacom_setup_touch_input_capabilities(struct input_dev *input_dev,
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
2.55.0.rc2.803.g1fd1e6609c-goog

