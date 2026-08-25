Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82E817081E;
	Tue, 25 Aug 2026 17:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787677737; cv=none; b=WbdPV7DRv/CqQ0e6r1C+6PXl+DGgY20bCl+FT7NCgb7oILi3XZebPBmAr43lnvvZRm9t0paMigokm5ZCm/05y7yFznR5HTayggSr72lizqvqKZQCEsW8EyPPWcw+dAlBrBpwNcrYOss5rV5bG+AFYVhMzooTRnQxkDMrupl2IF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787677737; c=relaxed/simple;
	bh=SMCpSy+rzgnjxM70Nun12cenDkk8FgF+fwGAxRE7liw=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=EMUm+d8c05vVdgjs7HF9Uy6uQdNDkW1QbZ0bruHW+WkyNNJunS1G9z+E1rjwrTct5zbIZY+Gcb56pKAUNRla9+wfUHpWhC+0WicMrFgBo6LLZsEKrEE5R47y6LXZNoP7Yg0n86dRhbyML7RcbF5HEhs0fmWODZIeWEtaHC2Iju4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V4Vton85; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V4Vton85"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DA001F000E9;
	Tue, 25 Aug 2026 17:08:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787677736;
	bh=1xaCcJPU4npLaVGoFKsj/5HbaQFJDNZ9ngXN3B335B8=;
	h=From:To:Subject:Date;
	b=V4Vton85etlCKrJhVj21O9KBj2BjFcnVHX77wvtJFMr9uGOpE8c5Jv4fvs96Qwni+
	 i2K5WGVx/0BxzKpi0LVcvD9ZHW84gnIY+1mlEwyIegG82KRrhuQ4rUmEbLKFfvG1V/
	 VbNo8W1/urXrmnv7N0vjXfugbQhcsYO6+voaAjunIat5fBY4xhsqmIFTjJ7hrOzV6m
	 Li2byxahSLjooDkdhEwFcuXykTO9/4njYMRmLCo8W7hKcUtbrxS+fHgQH47/jQ1tNX
	 M4MiZnyjcLjNBd6O50SmeKOWozeWoaCmh2ZUKn421VBI9x7jBewJJsBFliWsh16Qtv
	 DOToPKRWWs0Wg==
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
Subject: [PATCH 1/5] HID: wacom: Use hdev->product in wacom_setup_touch_input_capabilities
Date: Tue, 25 Aug 2026 15:12:29 +0000
Message-ID: <20260825151242.576456-1-lee@kernel.org>
X-Mailer: git-send-email 2.55.0.887.g758fc8c411-goog
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace the lookup-dependent 'wacom_wac->shared->touch->product' references
with 'hdev->product' inside wacom_setup_touch_input_capabilities() since
'hdev' is already available (via container_of) and represents the touch
device itself.

Signed-off-by: Lee Jones <lee@kernel.org>
---

v7 -> v8: New patch

 drivers/hid/wacom_wac.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
index a29bf051ada7..4436faf2d2bb 100644
--- a/drivers/hid/wacom_wac.c
+++ b/drivers/hid/wacom_wac.c
@@ -3953,8 +3953,8 @@ int wacom_setup_pen_input_capabilities(struct input_dev *input_dev,
 int wacom_setup_touch_input_capabilities(struct input_dev *input_dev,
 					 struct wacom_wac *wacom_wac)
 {
+	struct hid_device *hdev = container_of(wacom_wac, struct wacom, wacom_wac)->hdev;
 	struct wacom_features *features = &wacom_wac->features;
-
 	if (!(features->device_type & WACOM_DEVICETYPE_TOUCH))
 		return -ENODEV;
 
@@ -3963,9 +3963,11 @@ int wacom_setup_touch_input_capabilities(struct input_dev *input_dev,
 	else
 		__set_bit(INPUT_PROP_POINTER, input_dev->propbit);
 
-	if (features->type == HID_GENERIC)
+	if (features->type == HID_GENERIC) {
+		hid_dbg(hdev, "generic touch setup\n");
 		/* setup has already been done */
 		return 0;
+	}
 
 	input_dev->evbit[0] |= BIT_MASK(EV_KEY) | BIT_MASK(EV_ABS);
 	__set_bit(BTN_TOUCH, input_dev->keybit);
@@ -3997,19 +3999,17 @@ int wacom_setup_touch_input_capabilities(struct input_dev *input_dev,
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
@@ -4039,8 +4039,8 @@ int wacom_setup_touch_input_capabilities(struct input_dev *input_dev,
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
2.55.0.887.g758fc8c411-goog

