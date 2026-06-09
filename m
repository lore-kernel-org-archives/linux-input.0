Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8E4C3D4103;
	Tue,  9 Jun 2026 12:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781007600; cv=none; b=QZpB48a4EVa6X8htGjENQzsnOVZ7/WophtHEH95La7aWE0FaHcMokrPwwKtQBuPAU8BhK8lw0aFh9+ib0oVgu5StMmtkuHTXGGdNJHRTwY0aYDSOVZwArk+8qPIe5CSk2tRr8c1us+YuP3Ls/qNbM5NeSVHPxaCbUe/pTgHnxt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781007600; c=relaxed/simple;
	bh=nUQPWzGEtU2UT1ZX+tsONnR/5G7tWsEfz/DWT6aGRLs=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=uneNKg2zMObNIoIquss6ua6aCalUOx3EQr4YvymR7vmOtZA/BRRCqwiiTn2QwKtYonSFdnw4xI78qLC2o7VkUWXSUdQ23LgSKfu1nniecn+5uoSjH+oJbIXkS6zJTCKIKfN1fYQt/5oxEx+bNIzV2QLEwjliHDK0DOLTEnnC/hY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MScAouar; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MScAouar"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEF981F00893;
	Tue,  9 Jun 2026 12:19:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781007598;
	bh=i3v4xUtVtZfzuNpHV/y20MuOwJ6FoSCP9P1p9Ko7AVQ=;
	h=From:To:Subject:Date;
	b=MScAouarOLeZxUqL7FCbDTiDa4Fgs1xMMuoom0VFLDMn5gwYqtwaU0llbELYxMZsU
	 qI7IXw4AblbAveOovcAL6qa5fypMlbabZZagVmgUiUWew36m4MimsNuPTxdJBTWjE5
	 6XGtXrrDVk2yI3RCGTVdtGF/rbG+c2oSr4TTmYxC3U2CKHWiaL66BU5x3wel9uBb4Q
	 WonoDuVI6DZE0HQvY7yCdqMlKqhEg6ddMcdhmXOJMlWMGytAn+R0AYnb6fkJ7VaEX0
	 l9ximHxpjAFRo0ZB0cCFrl/4d3bwuDq5rahmDfP8Lmvba3xCBRXI3M9yEVAAjOO+o+
	 DaB/Q7eE/fo7g==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	Ping Cheng <ping.cheng@wacom.com>,
	Jason Gerecke <jason.gerecke@wacom.com>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Peter Hutterer <peter.hutterer@who-t.net>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/4] HID: wacom: Fix Use-After-Free in wacom_intuos_pad
Date: Tue,  9 Jun 2026 13:13:37 +0100
Message-ID: <20260609121353.3743782-1-lee@kernel.org>
X-Mailer: git-send-email 2.54.0.1099.g489fc7bff1-goog
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

wacom_intuos_pad() accesses wacom->shared->touch_input locklessly
inside the interrupt handler context.  If the Touch sibling device
is disconnected, wacom_remove_shared_data() clears 'touch_input'
outside any lock, creating a Time-of-Check to Time-of-Use (TOCTOU)
race condition where a preempted reader in interrupt context
dereferences the freed pointer, leading to a Use-After-Free.

Resolve this by introducing RCU protection for the touch_input
pointer:

 - Annotate 'touch_input' in wacom_shared struct with __rcu
 - Wrap all lockless readers in wacom_wac.c with rcu_read_lock() and
   rcu_dereference() using a unified wacom_report_touch_mute()
   helper
 - Update writers in wacom_sys.c using rcu_assign_pointer()
 - Call synchronize_rcu() in wacom_remove_shared_data() to ensure
   all active RCU readers have finished before the input device is
   freed

Also wrap wacom_set_shared_values() and touch/pen assignments in
wacom_add_shared_data() inside the wacom_udev_list_lock to serialize
concurrent probe assignments, and verify that 'shared->touch == hdev'
before setting touch_input to prevent concurrent sibling probe state
desynchronization.

Finally, advertise the SW_MUTE_DEVICE capability on Touch input
devices prior to registration in wacom_setup_touch_input_capabilities()
to prevent invalid post-registration capability modifications.

Fixes: 961794a00eab ("Input: wacom - add reporting of SW_MUTE_DEVICE events")
Signed-off-by: Lee Jones <lee@kernel.org>
---

v1 -> v2: Split and use RCU as per Dmitry's review
v2 -> v3: Sashiko fixes

 drivers/hid/wacom_sys.c | 41 ++++++++++++++----------
 drivers/hid/wacom_wac.c | 70 ++++++++++++++++++++++-------------------
 drivers/hid/wacom_wac.h |  2 +-
 3 files changed, 63 insertions(+), 50 deletions(-)

diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
index 2220168bf116..7ba589826548 100644
--- a/drivers/hid/wacom_sys.c
+++ b/drivers/hid/wacom_sys.c
@@ -877,10 +877,16 @@ static void wacom_remove_shared_data(void *res)
 		data = container_of(wacom_wac->shared, struct wacom_hdev_data,
 				    shared);
 
-		if (wacom_wac->shared->touch == wacom->hdev)
-			wacom_wac->shared->touch = NULL;
-		else if (wacom_wac->shared->pen == wacom->hdev)
-			wacom_wac->shared->pen = NULL;
+		scoped_guard(mutex, &wacom_udev_list_lock) {
+			if (wacom_wac->shared->touch == wacom->hdev) {
+				wacom_wac->shared->touch = NULL;
+				rcu_assign_pointer(wacom_wac->shared->touch_input, NULL);
+			} else if (wacom_wac->shared->pen == wacom->hdev) {
+				wacom_wac->shared->pen = NULL;
+			}
+		}
+
+		synchronize_rcu();
 
 		kref_put(&data->kref, wacom_release_shared_data);
 		wacom_wac->shared = NULL;
@@ -909,6 +915,11 @@ static int wacom_add_shared_data(struct hid_device *hdev)
 		list_add_tail(&data->list, &wacom_udev_list);
 	}
 
+	if (wacom_wac->features.device_type & WACOM_DEVICETYPE_TOUCH)
+		data->shared.touch = hdev;
+	else if (wacom_wac->features.device_type & WACOM_DEVICETYPE_PEN)
+		data->shared.pen = hdev;
+
 	mutex_unlock(&wacom_udev_list_lock);
 
 	wacom_wac->shared = &data->shared;
@@ -917,11 +928,6 @@ static int wacom_add_shared_data(struct hid_device *hdev)
 	if (retval)
 		return retval;
 
-	if (wacom_wac->features.device_type & WACOM_DEVICETYPE_TOUCH)
-		wacom_wac->shared->touch = hdev;
-	else if (wacom_wac->features.device_type & WACOM_DEVICETYPE_PEN)
-		wacom_wac->shared->pen = hdev;
-
 	return retval;
 }
 
@@ -2345,9 +2351,15 @@ static void wacom_release_resources(struct wacom *wacom)
 
 static void wacom_set_shared_values(struct wacom_wac *wacom_wac)
 {
+	struct wacom *wacom = container_of(wacom_wac, struct wacom, wacom_wac);
+
+	mutex_lock(&wacom_udev_list_lock);
+
 	if (wacom_wac->features.device_type & WACOM_DEVICETYPE_TOUCH) {
-		wacom_wac->shared->type = wacom_wac->features.type;
-		wacom_wac->shared->touch_input = wacom_wac->touch_input;
+		if (wacom_wac->shared->touch == wacom->hdev) {
+			wacom_wac->shared->type = wacom_wac->features.type;
+			rcu_assign_pointer(wacom_wac->shared->touch_input, wacom_wac->touch_input);
+		}
 	}
 
 	if (wacom_wac->has_mute_touch_switch) {
@@ -2361,12 +2373,7 @@ static void wacom_set_shared_values(struct wacom_wac *wacom_wac)
 			wacom_wac->shared->is_touch_on = true;
 	}
 
-	if (wacom_wac->shared->has_mute_touch_switch &&
-	    wacom_wac->shared->touch_input) {
-		set_bit(EV_SW, wacom_wac->shared->touch_input->evbit);
-		input_set_capability(wacom_wac->shared->touch_input, EV_SW,
-				     SW_MUTE_DEVICE);
-	}
+	mutex_unlock(&wacom_udev_list_lock);
 }
 
 static int wacom_parse_and_register(struct wacom *wacom, bool wireless)
diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
index da1f0ea85625..495960227b8d 100644
--- a/drivers/hid/wacom_wac.c
+++ b/drivers/hid/wacom_wac.c
@@ -510,6 +510,22 @@ static void wacom_intuos_schedule_prox_event(struct wacom_wac *wacom_wac)
 	}
 }
 
+static void wacom_report_touch_mute(struct wacom_wac *wacom_wac, bool mute)
+{
+	struct input_dev *touch_input;
+
+	if (!wacom_wac->shared)
+		return;
+
+	rcu_read_lock();
+	touch_input = rcu_dereference(wacom_wac->shared->touch_input);
+	if (touch_input) {
+		input_report_switch(touch_input, SW_MUTE_DEVICE, mute);
+		input_sync(touch_input);
+	}
+	rcu_read_unlock();
+}
+
 static int wacom_intuos_pad(struct wacom_wac *wacom)
 {
 	struct wacom_features *features = &wacom->features;
@@ -650,12 +666,8 @@ static int wacom_intuos_pad(struct wacom_wac *wacom)
 	input_report_key(input, KEY_CONTROLPANEL, menu);
 	input_report_key(input, KEY_INFO, info);
 
-	if (wacom->shared && wacom->shared->touch_input) {
-		input_report_switch(wacom->shared->touch_input,
-				    SW_MUTE_DEVICE,
-				    !wacom->shared->is_touch_on);
-		input_sync(wacom->shared->touch_input);
-	}
+	if (wacom->shared)
+		wacom_report_touch_mute(wacom, !wacom->shared->is_touch_on);
 
 	input_report_abs(input, ABS_RX, strip1);
 	input_report_abs(input, ABS_RY, strip2);
@@ -2153,7 +2165,7 @@ static void wacom_wac_pad_event(struct hid_device *hdev, struct hid_field *field
 	 */
 	if ((equivalent_usage == WACOM_HID_WD_MUTE_DEVICE) ||
 	   (equivalent_usage == WACOM_HID_WD_TOUCHONOFF)) {
-		if (wacom_wac->shared->touch_input) {
+		if (wacom_wac->shared) {
 			bool *is_touch_on = &wacom_wac->shared->is_touch_on;
 
 			if (equivalent_usage == WACOM_HID_WD_MUTE_DEVICE && value)
@@ -2161,9 +2173,7 @@ static void wacom_wac_pad_event(struct hid_device *hdev, struct hid_field *field
 			else if (equivalent_usage == WACOM_HID_WD_TOUCHONOFF)
 				*is_touch_on = value;
 
-			input_report_switch(wacom_wac->shared->touch_input,
-					    SW_MUTE_DEVICE, !(*is_touch_on));
-			input_sync(wacom_wac->shared->touch_input);
+			wacom_report_touch_mute(wacom_wac, !(*is_touch_on));
 		}
 		return;
 	}
@@ -3381,11 +3391,8 @@ static int wacom_wireless_irq(struct wacom_wac *wacom, size_t len)
 
 		if ((wacom->shared->type == INTUOSHT ||
 		    wacom->shared->type == INTUOSHT2) &&
-		    wacom->shared->touch_input &&
 		    wacom->shared->touch_max) {
-			input_report_switch(wacom->shared->touch_input,
-					SW_MUTE_DEVICE, data[5] & 0x40);
-			input_sync(wacom->shared->touch_input);
+			wacom_report_touch_mute(wacom, data[5] & 0x40);
 		}
 
 		pid = get_unaligned_be16(&data[6]);
@@ -3420,11 +3427,8 @@ static int wacom_status_irq(struct wacom_wac *wacom_wac, size_t len)
 
 	if ((features->type == INTUOSHT ||
 	    features->type == INTUOSHT2) &&
-	    wacom_wac->shared->touch_input &&
 	    features->touch_max) {
-		input_report_switch(wacom_wac->shared->touch_input,
-				    SW_MUTE_DEVICE, data[8] & 0x40);
-		input_sync(wacom_wac->shared->touch_input);
+		wacom_report_touch_mute(wacom_wac, data[8] & 0x40);
 	}
 
 	if (data[9] & 0x02) { /* wireless module is attached */
@@ -3951,11 +3955,22 @@ int wacom_setup_pen_input_capabilities(struct input_dev *input_dev,
 int wacom_setup_touch_input_capabilities(struct input_dev *input_dev,
 					 struct wacom_wac *wacom_wac)
 {
+	struct wacom *wacom = container_of(wacom_wac, struct wacom, wacom_wac);
+	struct hid_device *hdev = wacom->hdev;
 	struct wacom_features *features = &wacom_wac->features;
 
 	if (!(features->device_type & WACOM_DEVICETYPE_TOUCH))
 		return -ENODEV;
 
+	if (features->type != TABLETPC &&
+	    features->type != TABLETPC2FG &&
+	    features->type != MTSCREEN &&
+	    features->type != MTTPC &&
+	    features->type != MTTPC_B) {
+		input_dev->evbit[0] |= BIT_MASK(EV_SW);
+		__set_bit(SW_MUTE_DEVICE, input_dev->swbit);
+	}
+
 	if (features->device_type & WACOM_DEVICETYPE_DIRECT)
 		__set_bit(INPUT_PROP_DIRECT, input_dev->propbit);
 	else
@@ -3992,22 +4007,17 @@ int wacom_setup_touch_input_capabilities(struct input_dev *input_dev,
 	switch (features->type) {
 	case INTUOSP2_BT:
 	case INTUOSP2S_BT:
-		input_dev->evbit[0] |= BIT_MASK(EV_SW);
-		__set_bit(SW_MUTE_DEVICE, input_dev->swbit);
-
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
@@ -4037,10 +4047,8 @@ int wacom_setup_touch_input_capabilities(struct input_dev *input_dev,
 		fallthrough;
 
 	case WACOM_27QHDT:
-		if (wacom_wac->shared->touch->product == 0x32C ||
-		    wacom_wac->shared->touch->product == 0xF6) {
-			input_dev->evbit[0] |= BIT_MASK(EV_SW);
-			__set_bit(SW_MUTE_DEVICE, input_dev->swbit);
+		if (hdev->product == 0x32C ||
+		    hdev->product == 0xF6) {
 			wacom_wac->has_mute_touch_switch = true;
 			wacom_wac->is_soft_touch_switch = true;
 		}
@@ -4059,8 +4067,6 @@ int wacom_setup_touch_input_capabilities(struct input_dev *input_dev,
 
 	case INTUOSHT:
 	case INTUOSHT2:
-		input_dev->evbit[0] |= BIT_MASK(EV_SW);
-		__set_bit(SW_MUTE_DEVICE, input_dev->swbit);
 		fallthrough;
 
 	case BAMBOO_PT:
diff --git a/drivers/hid/wacom_wac.h b/drivers/hid/wacom_wac.h
index 126bec6e5c0c..a8bbba4a6f37 100644
--- a/drivers/hid/wacom_wac.h
+++ b/drivers/hid/wacom_wac.h
@@ -285,7 +285,7 @@ struct wacom_shared {
 	/* for wireless device to access USB interfaces */
 	unsigned touch_max;
 	int type;
-	struct input_dev *touch_input;
+	struct input_dev __rcu *touch_input;
 	struct hid_device *pen;
 	struct hid_device *touch;
 	bool has_mute_touch_switch;
-- 
2.54.0.1099.g489fc7bff1-goog

