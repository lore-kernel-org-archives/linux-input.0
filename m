Received: from endrift.com (endrift.com [173.255.198.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58D192D6E44
	for <linux-input@vger.kernel.org>; Thu, 25 Jun 2026 05:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.255.198.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782363666; cv=none; b=D8CoZuruuHJfbPawR4VZsK0FQ0PL6bwaztomgNikw1QVZ+zZIymWj50y8COnBwO2poIPpVCACWGGagwpvOoy3IeoaiTfkw0UEQ/kpbp3YQ4LAZjfA15V6fWzfL3fGyyLJPVVza4z5jpVJoOAQy1qIp9uyjiE5axXcBaBE16xQck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782363666; c=relaxed/simple;
	bh=vxfjPKfO5I+2uBy2Pv1PQqIkCvBqWDhyUoePnVl0fEs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QBnEFjEjDSZHCegRmMGiItbdx/H341o4mBOOHyMrezRtb8ALWYOvNGfnvF/AxijJncAPk9jk1KSn0JCmMRmXdU8Oa+6S2XY/arkVULS0uKdqa/iNe1/YEG4pdsU82W5yPEPJBizZSkBHWHkxRFK4Jj/8CMBFgA0RbsSOO2494/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endrift.com; spf=pass smtp.mailfrom=endrift.com; dkim=pass (2048-bit key) header.d=endrift.com header.i=@endrift.com header.b=R/kyp5I9; arc=none smtp.client-ip=173.255.198.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endrift.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=endrift.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=endrift.com header.i=@endrift.com header.b="R/kyp5I9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=endrift.com; s=2020;
	t=1782363659; bh=vxfjPKfO5I+2uBy2Pv1PQqIkCvBqWDhyUoePnVl0fEs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=R/kyp5I9N6daTjq9SjMLpJ7QoCHOLg00+IR//I+g1445pBpj2s7ChcUbGEHJJ0b0M
	 Zw6vGcuzGgSJSb4e9sCkLC9NkxIcxYcv22H820zEYQTQV5fzA7R+Nk/HFgGONs0cFL
	 K25j7REkAO5yXpHLkJdRld6unCDwGq9CGDWVL3ReVDS4jNUqchg8LTfztGj/a7u+IE
	 oUYhIVIyVP1Ay0g9OUO1Q2siQ43gBFZ+F1+7T0tBZu2lYdEZyrPateP/XA+hjG0c60
	 g18qzR+cwgAi9jW156abs0s3aQu28xK2wjbp3YddIJrWq1hQHPE+DZAJpy135E40py
	 QXy49sECri2pg==
Received: from microtis.vulpes.eutheria.net (71-212-73-87.tukw.qwest.net [71.212.73.87])
	by endrift.com (Postfix) with ESMTPSA id 4BEB1A079;
	Wed, 24 Jun 2026 22:00:59 -0700 (PDT)
From: Vicki Pfau <vi@endrift.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	linux-input@vger.kernel.org
Cc: Vicki Pfau <vi@endrift.com>,
	Silvan Jegen <s.jegen@gmail.com>
Subject: [PATCH v6 2/3] HID: nintendo: Add rumble support for Switch 2 controllers
Date: Wed, 24 Jun 2026 21:59:44 -0700
Message-ID: <20260625045948.2343168-3-vi@endrift.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260625045948.2343168-1-vi@endrift.com>
References: <20260625045948.2343168-1-vi@endrift.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This adds rumble support for both the "HD Rumble" linear resonant actuator
type as used in the Joy-Cons and Pro Controller, as well as the eccentric
rotating mass type used in the GameCube controller. Note that since there's
currently no API for exposing full control of LRAs with evdev, it only
simulates a basic rumble for now.

Signed-off-by: Vicki Pfau <vi@endrift.com>
---
 drivers/hid/Kconfig        |   8 +-
 drivers/hid/hid-nintendo.c | 194 ++++++++++++++++++++++++++++++++++++-
 2 files changed, 196 insertions(+), 6 deletions(-)

diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
index 19c77c323ec9..851eed76c236 100644
--- a/drivers/hid/Kconfig
+++ b/drivers/hid/Kconfig
@@ -859,10 +859,10 @@ config NINTENDO_FF
 	depends on HID_NINTENDO
 	select INPUT_FF_MEMLESS
 	help
-	Say Y here if you have a Nintendo Switch controller and want to enable
-	force feedback support for it. This works for both joy-cons, the pro
-	controller, and the NSO N64 controller. For the pro controller, both
-	rumble motors can be controlled individually.
+	Say Y here if you have a Nintendo Switch or Switch 2 controller and want
+	to enable force feedback support for it. This works for Joy-Cons, the Pro
+	Controllers, and the NSO N64 and GameCube controller. For the Pro
+	Controller, both rumble motors can be controlled individually.
 
 config HID_NTI
 	tristate "NTI keyboard adapters"
diff --git a/drivers/hid/hid-nintendo.c b/drivers/hid/hid-nintendo.c
index 6573fd31a232..ae360f4d15d1 100644
--- a/drivers/hid/hid-nintendo.c
+++ b/drivers/hid/hid-nintendo.c
@@ -2989,6 +2989,7 @@ enum switch2_init_step {
 	NS2_INIT_READ_USER_SECONDARY_CALIB,
 	NS2_INIT_SET_FEATURE_MASK,
 	NS2_INIT_ENABLE_FEATURES,
+	NS2_INIT_ENABLE_RUMBLE,
 	NS2_INIT_GRIP_BUTTONS,
 	NS2_INIT_REPORT_FORMAT,
 	NS2_INIT_SET_PLAYER_LEDS,
@@ -3020,6 +3021,18 @@ struct switch2_stick_calibration {
 	struct switch2_axis_calibration y;
 };
 
+struct switch2_hd_rumble {
+	uint16_t hi_freq : 10;
+	uint16_t hi_amp : 10;
+	uint16_t lo_freq : 10;
+	uint16_t lo_amp : 10;
+} __packed;
+
+struct switch2_erm_rumble {
+	uint16_t error;
+	uint16_t amplitude;
+};
+
 struct switch2_controller {
 	struct hid_device *hdev;
 	struct switch2_cfg_intf *cfg;
@@ -3042,8 +3055,45 @@ struct switch2_controller {
 
 	uint32_t player_id;
 	struct led_classdev leds[4];
+
+#if IS_ENABLED(CONFIG_NINTENDO_FF)
+	spinlock_t rumble_lock;
+	uint8_t rumble_seq;
+	union {
+		struct switch2_hd_rumble hd;
+		struct switch2_erm_rumble sd;
+	} rumble;
+	uint64_t last_rumble_work;
+	struct delayed_work rumble_work;
+	uint8_t rumble_buffer[64];
+#endif
+};
+
+enum gc_rumble {
+	GC_RUMBLE_OFF = 0,
+	GC_RUMBLE_ON = 1,
+	GC_RUMBLE_STOP = 2,
 };
 
+/*
+ * The highest rumble level for "HD Rumble" is strong enough to potentially damage the controller,
+ * and also leaves your hands feeling like melted jelly, so we set a semi-arbitrary scaling factor
+ * to artificially limit the maximum for safety and comfort. It is currently unknown if the Switch
+ * 2 itself does something similar, but it's quite likely.
+ *
+ * This value must be between 0 and 1024, otherwise the math below will overflow.
+ */
+#define RUMBLE_MAX 450u
+
+/*
+ * Semi-arbitrary values used to simulate the "rumble" sensation of an eccentric rotating
+ * mass type haptic motor on the Switch 2 controllers' linear resonant actuator type haptics.
+ *
+ * The units used are unknown, but the values must be between 0 and 1023.
+ */
+#define RUMBLE_HI_FREQ 0x187
+#define RUMBLE_LO_FREQ 0x112
+
 static DEFINE_MUTEX(switch2_controllers_lock);
 static LIST_HEAD(switch2_controllers);
 
@@ -3133,9 +3183,12 @@ static const uint8_t switch2_init_cmd_data[] = {
 };
 
 static const uint8_t switch2_one_data[] = { 0x01, 0x00, 0x00, 0x00 };
+#if IS_ENABLED(CONFIG_NINTENDO_FF)
+static const uint8_t switch2_zero_data[] = { 0x00, 0x00, 0x00, 0x00 };
+#endif
 
 static const uint8_t switch2_feature_mask[] = {
-	NS2_FEATURE_BUTTONS | NS2_FEATURE_ANALOG | NS2_FEATURE_IMU,
+	NS2_FEATURE_BUTTONS | NS2_FEATURE_ANALOG | NS2_FEATURE_IMU | NS2_FEATURE_RUMBLE,
 	0x00, 0x00, 0x00
 };
 
@@ -3153,6 +3206,107 @@ static inline bool switch2_ctlr_is_joycon(enum switch2_ctlr_type type)
 	return type == NS2_CTLR_TYPE_JCL || type == NS2_CTLR_TYPE_JCR;
 }
 
+#if IS_ENABLED(CONFIG_NINTENDO_FF)
+static void switch2_encode_rumble(struct switch2_hd_rumble *rumble, uint8_t buffer[5])
+{
+	buffer[0] = rumble->hi_freq;
+	buffer[1] = (rumble->hi_freq >> 8) | (rumble->hi_amp << 2);
+	buffer[2] = (rumble->hi_amp >> 6) | (rumble->lo_freq << 4);
+	buffer[3] = (rumble->lo_freq >> 4) | (rumble->lo_amp << 6);
+	buffer[4] = rumble->lo_amp >> 2;
+}
+
+static int switch2_play_effect(struct input_dev *dev, void *data, struct ff_effect *effect)
+{
+	struct switch2_controller *ns2 = input_get_drvdata(dev);
+
+	if (effect->type != FF_RUMBLE)
+		return 0;
+
+	guard(spinlock_irqsave)(&ns2->rumble_lock);
+	if (ns2->ctlr_type == NS2_CTLR_TYPE_GC) {
+		ns2->rumble.sd.amplitude = max(effect->u.rumble.strong_magnitude,
+			(uint16_t) (effect->u.rumble.weak_magnitude >> 1));
+	} else {
+		ns2->rumble.hd.hi_freq = RUMBLE_HI_FREQ;
+		ns2->rumble.hd.lo_freq = RUMBLE_LO_FREQ;
+		ns2->rumble.hd.hi_amp = effect->u.rumble.weak_magnitude * RUMBLE_MAX >> 16;
+		ns2->rumble.hd.lo_amp = effect->u.rumble.strong_magnitude * RUMBLE_MAX >> 16;
+	}
+
+	if (ns2->hdev)
+		schedule_delayed_work(&ns2->rumble_work, 0);
+
+	return 0;
+}
+
+static void switch2_rumble_work(struct work_struct *work)
+{
+	struct switch2_controller *ns2 = container_of(to_delayed_work(work),
+						      struct switch2_controller, rumble_work);
+	unsigned long flags;
+	bool active;
+	int ret = 0;
+
+	spin_lock_irqsave(&ns2->rumble_lock, flags);
+	ns2->rumble_buffer[0x1] = 0x50 | ns2->rumble_seq;
+	if (ns2->ctlr_type == NS2_CTLR_TYPE_GC) {
+		ns2->rumble_buffer[0] = 3;
+		if (ns2->rumble.sd.amplitude == 0) {
+			ns2->rumble_buffer[2] = GC_RUMBLE_STOP;
+			ns2->rumble.sd.error = 0;
+			active = false;
+		} else {
+			if (ns2->rumble.sd.error < ns2->rumble.sd.amplitude) {
+				ns2->rumble_buffer[2] = GC_RUMBLE_ON;
+				ns2->rumble.sd.error += U16_MAX - ns2->rumble.sd.amplitude;
+			} else {
+				ns2->rumble_buffer[2] = GC_RUMBLE_OFF;
+				ns2->rumble.sd.error -= ns2->rumble.sd.amplitude;
+			}
+			active = true;
+		}
+	} else {
+		ns2->rumble_buffer[0] = 1;
+		switch2_encode_rumble(&ns2->rumble.hd, &ns2->rumble_buffer[0x2]);
+		active = ns2->rumble.hd.hi_amp || ns2->rumble.hd.lo_amp;
+		if (ns2->ctlr_type == NS2_CTLR_TYPE_PRO) {
+			/*
+			 * The Pro Controller contains separate LRAs on each
+			 * side that can be controlled individually.
+			 */
+			ns2->rumble_buffer[0] = 2;
+			ns2->rumble_buffer[0x11] = 0x50 | ns2->rumble_seq;
+			switch2_encode_rumble(&ns2->rumble.hd, &ns2->rumble_buffer[0x12]);
+		}
+	}
+	ns2->rumble_seq = (ns2->rumble_seq + 1) & 0xF;
+
+	if (active) {
+		unsigned long interval = msecs_to_jiffies(2);
+		uint64_t current_jiffies = get_jiffies_64();
+
+		if (!ns2->last_rumble_work)
+			ns2->last_rumble_work = current_jiffies;
+		else
+			ns2->last_rumble_work += interval;
+		schedule_delayed_work(&ns2->rumble_work,
+			ns2->last_rumble_work + interval - current_jiffies);
+	} else {
+		ns2->last_rumble_work = 0;
+	}
+	spin_unlock_irqrestore(&ns2->rumble_lock, flags);
+
+	if (!ns2->hdev)
+		cancel_delayed_work(&ns2->rumble_work);
+	else
+		ret = hid_hw_output_report(ns2->hdev, ns2->rumble_buffer, 64);
+
+	if (ret < 0)
+		hid_warn_ratelimited(ns2->hdev, "Failed to send output report ret=%d\n", ret);
+}
+#endif
+
 static int switch2_set_leds(struct switch2_controller *ns2)
 {
 	int i;
@@ -3276,6 +3430,15 @@ static int switch2_init_input(struct switch2_controller *ns2)
 		return -EINVAL;
 	}
 
+#if IS_ENABLED(CONFIG_NINTENDO_FF)
+	input_set_capability(input, EV_FF, FF_RUMBLE);
+	ret = input_ff_create_memless(input, NULL, switch2_play_effect);
+	if (ret) {
+		input_free_device(input);
+		return ret;
+	}
+#endif
+
 	hid_info(ns2->hdev, "Firmware version %u.%u.%u (type %i)\n", ns2->version.major,
 		ns2->version.minor, ns2->version.patch, ns2->version.ctlr_type);
 	if (ns2->version.dsp_type >= 0)
@@ -3358,6 +3521,10 @@ static void switch2_controller_put(struct switch2_controller *ns2)
 	if (input)
 		input_unregister_device(input);
 
+#if IS_ENABLED(CONFIG_NINTENDO_FF)
+	cancel_delayed_work_sync(&ns2->rumble_work);
+#endif
+
 	if (do_free) {
 		list_del_init(&ns2->entry);
 		mutex_destroy(&ns2->lock);
@@ -3728,7 +3895,16 @@ static int switch2_init_controller(struct switch2_controller *ns2)
 		return ns2->cfg->send_command(NS2_CMD_FEATSEL, NS2_SUBCMD_FEATSEL_SET_MASK,
 			switch2_feature_mask, sizeof(switch2_feature_mask), ns2->cfg);
 	case NS2_INIT_ENABLE_FEATURES:
-		return switch2_features_enable(ns2, NS2_FEATURE_BUTTONS | NS2_FEATURE_ANALOG);
+		return switch2_features_enable(ns2, NS2_FEATURE_BUTTONS |
+			NS2_FEATURE_ANALOG | NS2_FEATURE_RUMBLE);
+	case NS2_INIT_ENABLE_RUMBLE:
+		/*
+		 * It is unclear what this packet is supposed to be for, but it
+		 * appears to be needed for rumble to work reliably. The reply
+		 * data indicates it might be a query of some sort, but we
+		 * ignore the reply so long as it doesn't return an error.
+		 */
+		return ns2->cfg->send_command(0x11, 1, NULL, 0, ns2->cfg);
 	case NS2_INIT_GRIP_BUTTONS:
 		if (!switch2_ctlr_is_joycon(ns2->ctlr_type)) {
 			switch2_init_step_done(ns2, ns2->init_step);
@@ -3840,6 +4016,10 @@ int switch2_receive_command(struct switch2_controller *ns2,
 			switch2_init_step_done(ns2, NS2_INIT_GET_FIRMWARE_INFO);
 		}
 		break;
+	case 0x11:
+		if (header->subcommand == 1)
+			switch2_init_step_done(ns2, NS2_INIT_ENABLE_RUMBLE);
+		break;
 	default:
 		break;
 	}
@@ -3945,6 +4125,10 @@ static int switch2_probe(struct hid_device *hdev, const struct hid_device_id *id
 
 	switch2_leds_create(ns2);
 
+#if IS_ENABLED(CONFIG_NINTENDO_FF)
+	spin_lock_init(&ns2->rumble_lock);
+	INIT_DELAYED_WORK(&ns2->rumble_work, switch2_rumble_work);
+#endif
 	hid_set_drvdata(hdev, ns2);
 
 	ret = hid_hw_open(hdev);
@@ -3965,6 +4149,9 @@ static int switch2_probe(struct hid_device *hdev, const struct hid_device_id *id
 err_cleanup:
 	hid_hw_close(hdev);
 	ida_free(&nintendo_player_id_allocator, ns2->player_id);
+#if IS_ENABLED(CONFIG_NINTENDO_FF)
+	cancel_delayed_work_sync(&ns2->rumble_work);
+#endif
 	ns2->hdev = NULL;
 	mutex_unlock(&ns2->lock);
 	switch2_controller_put(ns2);
@@ -3979,6 +4166,9 @@ static void switch2_remove(struct hid_device *hdev)
 	struct switch2_controller *ns2 = hid_get_drvdata(hdev);
 
 	hid_hw_close(hdev);
+#if IS_ENABLED(CONFIG_NINTENDO_FF)
+	cancel_delayed_work_sync(&ns2->rumble_work);
+#endif
 	mutex_lock(&ns2->lock);
 	WARN_ON(ns2->hdev != hdev);
 	ns2->hdev = NULL;
-- 
2.54.0

