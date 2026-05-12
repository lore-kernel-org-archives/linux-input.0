Received: from endrift.com (endrift.com [173.255.198.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51031385D88
	for <linux-input@vger.kernel.org>; Tue, 12 May 2026 20:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.255.198.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778616090; cv=none; b=O5kL8oumKE31j4CPP2lKW+QSdp3PZ401z/srj55tCraMHYn4FMr+tn5JkhoiKPNNNkdFKdWNHmKfMaqwcndnhk+lznwu3TPenIRAGQPpiuiBsLN8uOhpB6s23rM6snpBTOJ2rB6hXFkt8OHSkEWUdjRjuU/0pW4xKwHs5ucnFV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778616090; c=relaxed/simple;
	bh=UJ64CPhAuY/eQkbXxSZ5Pvm6X5/nVwlsEhFe02tt0yI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fOylNuPtj+53gRAQ7CLu3a+azlU5+a6Ep76iiww/H0I3Uh+eZJpZbDgy0UprFq/pyTvM3/nU7/F1BkZtPBOGi8ZOV+FM+CKJBRJuCND/2aTe7XhvIlYBMNeSyruxYciMYmT4c857WpAfnMp2xt5ZYea8HqKV9nnhYCfCqZZreyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endrift.com; spf=pass smtp.mailfrom=endrift.com; dkim=pass (2048-bit key) header.d=endrift.com header.i=@endrift.com header.b=WyRv4t4I; arc=none smtp.client-ip=173.255.198.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endrift.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=endrift.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=endrift.com header.i=@endrift.com header.b="WyRv4t4I"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=endrift.com; s=2020;
	t=1778616088; bh=UJ64CPhAuY/eQkbXxSZ5Pvm6X5/nVwlsEhFe02tt0yI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WyRv4t4IgvHmofsTGNuNUmnKB1GE59pAoJzfIhw2PL1CLtcrbxbfupxxkkzbBJFU3
	 4gSFV2v6wpXa0BzganIlr9sW4NFLZPzozdh6JwLdt8KmkV2T5uvtHvQZP1WZgLd+gg
	 16iHP0fFWdr26KH2tBVyiYkiFDnLacJX0udegMKteClwAH4muLYqhsgUan3ktq9iN7
	 W5p7YZ8AgSSLZGWrf/Xy+sEJWUFUB27zt1hBnWFbxbtnPZxe5Rkv56Etq8PGmuh0o1
	 KdL4/FipXNSr8Hzl3oJuXOLYwxzYgMSVV9FIB6OwhTWtzUHGvi6Rsh44C3oiDqh3pm
	 Z7m7Ky1kIHCBg==
Received: from microtis.vulpes.eutheria.net (71-212-73-87.tukw.qwest.net [71.212.73.87])
	by endrift.com (Postfix) with ESMTPSA id 7347B132022;
	Tue, 12 May 2026 13:01:28 -0700 (PDT)
From: Vicki Pfau <vi@endrift.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	linux-input@vger.kernel.org
Cc: Vicki Pfau <vi@endrift.com>,
	Silvan Jegen <s.jegen@gmail.com>
Subject: [PATCH v5 2/3] HID: nintendo: Add rumble support for Switch 2 controllers
Date: Tue, 12 May 2026 13:00:48 -0700
Message-ID: <20260512200051.2534081-3-vi@endrift.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260512200051.2534081-1-vi@endrift.com>
References: <20260512200051.2534081-1-vi@endrift.com>
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

Reviewed-by: Silvan Jegen <s.jegen@gmail.com>
Tested-by: Silvan Jegen <s.jegen@gmail.com>
Signed-off-by: Vicki Pfau <vi@endrift.com>
---
 drivers/hid/Kconfig        |   8 +-
 drivers/hid/hid-nintendo.c | 179 ++++++++++++++++++++++++++++++++++++-
 2 files changed, 181 insertions(+), 6 deletions(-)

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
index 2193afcdefab..9801799a9075 100644
--- a/drivers/hid/hid-nintendo.c
+++ b/drivers/hid/hid-nintendo.c
@@ -2972,6 +2972,18 @@ struct switch2_stick_calibration {
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
@@ -2993,8 +3005,45 @@ struct switch2_controller {
 
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
+	unsigned long last_rumble_work;
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
 
@@ -3084,9 +3133,12 @@ static const uint8_t switch2_init_cmd_data[] = {
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
 
@@ -3103,6 +3155,107 @@ static inline bool switch2_ctlr_is_joycon(enum switch2_ctlr_type type)
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
+			effect->u.rumble.weak_magnitude >> 1);
+	} else {
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
+	unsigned long current_ms = jiffies_to_msecs(get_jiffies_64());
+	unsigned long flags;
+	bool active;
+	int ret;
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
+		unsigned long interval = msecs_to_jiffies(4);
+
+		if (!ns2->last_rumble_work)
+			ns2->last_rumble_work = current_ms;
+		else
+			ns2->last_rumble_work += interval;
+		schedule_delayed_work(&ns2->rumble_work,
+			ns2->last_rumble_work + interval - current_ms);
+	} else {
+		ns2->last_rumble_work = 0;
+	}
+	spin_unlock_irqrestore(&ns2->rumble_lock, flags);
+
+	if (!ns2->hdev) {
+		cancel_delayed_work(&ns2->rumble_work);
+		ret = -ENODEV;
+	} else {
+		ret = hid_hw_output_report(ns2->hdev, ns2->rumble_buffer, 64);
+	}
+
+	if (ret < 0)
+		hid_dbg(ns2->hdev, "Failed to send output report ret=%d\n", ret);
+}
+#endif
+
 static int switch2_set_leds(struct switch2_controller *ns2)
 {
 	int i;
@@ -3226,6 +3379,15 @@ static int switch2_init_input(struct switch2_controller *ns2)
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
@@ -3308,6 +3470,10 @@ static void switch2_controller_put(struct switch2_controller *ns2)
 	if (input)
 		input_unregister_device(input);
 
+#if IS_ENABLED(CONFIG_NINTENDO_FF)
+	cancel_delayed_work_sync(&ns2->rumble_work);
+#endif
+
 	if (do_free) {
 		list_del_init(&ns2->entry);
 		mutex_destroy(&ns2->lock);
@@ -3667,7 +3833,8 @@ static int switch2_init_controller(struct switch2_controller *ns2)
 		return ns2->cfg->send_command(NS2_CMD_FEATSEL, NS2_SUBCMD_FEATSEL_SET_MASK,
 			switch2_feature_mask, sizeof(switch2_feature_mask), ns2->cfg);
 	case NS2_INIT_ENABLE_FEATURES:
-		return switch2_features_enable(ns2, NS2_FEATURE_BUTTONS | NS2_FEATURE_ANALOG);
+		return switch2_features_enable(ns2, NS2_FEATURE_BUTTONS |
+			NS2_FEATURE_ANALOG | NS2_FEATURE_RUMBLE);
 	case NS2_INIT_GRIP_BUTTONS:
 		if (!switch2_ctlr_is_joycon(ns2->ctlr_type)) {
 			switch2_init_step_done(ns2, ns2->init_step);
@@ -3881,6 +4048,14 @@ static int switch2_probe(struct hid_device *hdev, const struct hid_device_id *id
 
 	switch2_leds_create(ns2);
 
+#if IS_ENABLED(CONFIG_NINTENDO_FF)
+	if (ns2->ctlr_type != NS2_CTLR_TYPE_GC) {
+		ns2->rumble.hd.hi_freq = RUMBLE_HI_FREQ;
+		ns2->rumble.hd.lo_freq = RUMBLE_LO_FREQ;
+	}
+	spin_lock_init(&ns2->rumble_lock);
+	INIT_DELAYED_WORK(&ns2->rumble_work, switch2_rumble_work);
+#endif
 	hid_set_drvdata(hdev, ns2);
 
 	if (ns2->cfg)
-- 
2.54.0

