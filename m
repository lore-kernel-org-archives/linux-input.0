Received: from endrift.com (endrift.com [173.255.198.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C3D8397E75
	for <linux-input@vger.kernel.org>; Fri,  7 Aug 2026 01:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.255.198.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786066519; cv=none; b=UkXFyLcP90Eq2vN3YLzq6MJ2pZ810I+TdfCtuMCw2lv6WZYnai/3g0ZWX7yvwqjUXKZ6HaEhz+MsHDUsQn0zYS/VbMD7A1dJXpzvxEuIVjBLuR6SHU37i0kQ606BU3S8jyl7WwOGVSNXbUFfFK0Z7dkSZZhI2pFuuDDQpdl6a5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786066519; c=relaxed/simple;
	bh=sHZcm/i4J4LPN6/5H/e1oC2d0vB8j6fLyrqt97v3RZA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ca7of8qkE8okKR+WezQeCIbbZ4w1ZSY5GcmDj1FUG/mxyDYcaCorJm0lHEH+Z3NLCrwLadMS3dx4f7j9vao6bLazXT3qPk+3uMjcOD4Sv9WkX4Zrt/69wNx3J2nZszXbAHW4NCNRc3qqQ+HywgtdohOafM+c7oDFNK1tFc6yogQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endrift.com; spf=pass smtp.mailfrom=endrift.com; dkim=pass (2048-bit key) header.d=endrift.com header.i=@endrift.com header.b=HtFqrWgC; arc=none smtp.client-ip=173.255.198.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endrift.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=endrift.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=endrift.com header.i=@endrift.com header.b="HtFqrWgC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=endrift.com; s=2020;
	t=1786066501; bh=sHZcm/i4J4LPN6/5H/e1oC2d0vB8j6fLyrqt97v3RZA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HtFqrWgC9U4/t1VblCcs+mReAio3MaCM7gL+RcTu46gTqK8hE5oKMacCVCx7AJTDQ
	 o1lHBuZR5sBTa7YoLp80IRQ3iWrcm+1AlQstC0N+pmGC5ZPmL2hgsBZ+9NW8bmtALc
	 +zCEN2vlqb0EAyOsC4YnsFgPVfp6Eb7/NN/Od/CMV1Bue8VdznUIa+/1X+OyrXJMw/
	 BS2YxMt/fwJfM33CKf+cnGr8l1xTCmigsN9Q8/PmxqF4bWUV4xCsJgh0ncqdYkxN2U
	 5b9ayce54rLgYUTDEwZYxrIqXJnTwMHEKk+tKrd0RlHSzuJLdL/1k0fH9jD8nnhHNE
	 3z5htvY5mi+4A==
Received: from microtis.vulpes.eutheria.net (71-212-73-87.tukw.qwest.net [71.212.73.87])
	by endrift.com (Postfix) with ESMTPSA id 946EA132034;
	Thu, 06 Aug 2026 18:35:01 -0700 (PDT)
From: Vicki Pfau <vi@endrift.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	linux-input@vger.kernel.org
Cc: Vicki Pfau <vi@endrift.com>
Subject: [PATCH v3 5/6] HID: steam: Clean up locking
Date: Thu,  6 Aug 2026 18:33:29 -0700
Message-ID: <20260807013334.2109386-6-vi@endrift.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260807013334.2109386-1-vi@endrift.com>
References: <20260807013334.2109386-1-vi@endrift.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This cleans up several issues with locking behavior, including RCU accesses
not being guarded behind a lock.

Signed-off-by: Vicki Pfau <vi@endrift.com>
---
 drivers/hid/hid-steam.c | 100 +++++++++++++++++++++-------------------
 1 file changed, 53 insertions(+), 47 deletions(-)

diff --git a/drivers/hid/hid-steam.c b/drivers/hid/hid-steam.c
index d95296b28f92..0e0ccf263416 100644
--- a/drivers/hid/hid-steam.c
+++ b/drivers/hid/hid-steam.c
@@ -403,6 +403,7 @@ struct steam_device {
 	spinlock_t lock;
 	struct hid_device *hdev, *client_hdev;
 	struct mutex report_mutex;
+	struct mutex registration_mutex;
 	unsigned long client_opened;
 	struct input_dev __rcu *input;
 	struct input_dev __rcu *sensors;
@@ -633,7 +634,6 @@ static int steam_exchange_report(struct steam_device *steam, u8 *cmd, int csize,
 	unsigned int retries = 5;
 	int ret;
 
-	guard(mutex)(&steam->report_mutex);
 	do {
 		ret = steam_send_report(steam, cmd, csize);
 		if (ret < 0)
@@ -787,7 +787,6 @@ static inline int steam_haptic_pulse(struct steam_device *steam, u8 pad,
 		report[8] = count >> 8;
 		report[9] = gain;
 
-		guard(mutex)(&steam->report_mutex);
 		ret = steam_send_report(steam, report, 10);
 	}
 
@@ -829,7 +828,6 @@ static inline int steam_haptic_rumble(struct steam_device *steam,
 		report[9] = left_gain;
 		report[10] = right_gain;
 
-		guard(mutex)(&steam->report_mutex);
 		ret = steam_send_report(steam, report, sizeof(report));
 	}
 	return ret;
@@ -840,8 +838,10 @@ static void steam_haptic_rumble_cb(struct work_struct *work)
 	struct steam_device *steam = container_of(work, struct steam_device,
 							rumble_work);
 
+	mutex_lock(&steam->report_mutex);
 	steam_haptic_rumble(steam, 0, steam->rumble_left,
 		steam->rumble_right, 2, 0);
+	mutex_unlock(&steam->report_mutex);
 }
 
 static void steam_coalesce_rumble_cb(struct work_struct *work)
@@ -850,8 +850,10 @@ static void steam_coalesce_rumble_cb(struct work_struct *work)
 							struct steam_device,
 							coalesce_rumble_work);
 
+	mutex_lock(&steam->report_mutex);
 	steam_haptic_rumble(steam, 0, steam->rumble_left,
 		steam->rumble_right, 2, 0);
+	mutex_unlock(&steam->report_mutex);
 
 	if (steam->rumble_left || steam->rumble_right)
 		schedule_delayed_work(&steam->coalesce_rumble_work, HZ / 20);
@@ -883,7 +885,6 @@ static void steam_set_lizard_mode(struct steam_device *steam, bool enable)
 	if (steam->gamepad_mode)
 		enable = false;
 
-	mutex_lock(&steam->report_mutex);
 	if (enable) {
 		/* enable esc, enter, cursors */
 		steam_send_report_byte(steam, ID_SET_DEFAULT_DIGITAL_MAPPINGS);
@@ -906,14 +907,13 @@ static void steam_set_lizard_mode(struct steam_device *steam, bool enable)
 				SETTING_RIGHT_TRACKPAD_MODE, TRACKPAD_NONE, /* disable mouse */
 				0);
 	}
-	mutex_unlock(&steam->report_mutex);
 }
 
 static int steam_input_open(struct input_dev *dev)
 {
 	struct steam_device *steam = input_get_drvdata(dev);
 	unsigned long flags;
-	bool set_lizard_mode;
+	bool client_opened;
 
 	/*
 	 * Disabling lizard mode automatically is only done on the Steam
@@ -922,9 +922,10 @@ static int steam_input_open(struct input_dev *dev)
 	 */
 	if (!(steam->quirks & (STEAM_QUIRK_DECK | STEAM_QUIRK_IBEX))) {
 		spin_lock_irqsave(&steam->lock, flags);
-		set_lizard_mode = !steam->client_opened && lizard_mode;
+		client_opened = steam->client_opened;
 		spin_unlock_irqrestore(&steam->lock, flags);
-		if (set_lizard_mode)
+		guard(mutex)(&steam->report_mutex);
+		if (!client_opened && lizard_mode)
 			steam_set_lizard_mode(steam, false);
 	}
 
@@ -935,13 +936,14 @@ static void steam_input_close(struct input_dev *dev)
 {
 	struct steam_device *steam = input_get_drvdata(dev);
 	unsigned long flags;
-	bool set_lizard_mode;
+	bool client_opened;
 
 	if (!(steam->quirks & (STEAM_QUIRK_DECK | STEAM_QUIRK_IBEX))) {
 		spin_lock_irqsave(&steam->lock, flags);
-		set_lizard_mode = !steam->client_opened && lizard_mode;
+		client_opened = steam->client_opened;
 		spin_unlock_irqrestore(&steam->lock, flags);
-		if (set_lizard_mode)
+		guard(mutex)(&steam->report_mutex);
+		if (!client_opened && lizard_mode)
 			steam_set_lizard_mode(steam, true);
 	}
 }
@@ -949,14 +951,11 @@ static void steam_input_close(struct input_dev *dev)
 static int steam_sensor_open(struct input_dev *dev)
 {
 	struct steam_device *steam = input_get_drvdata(dev);
-	unsigned long flags;
-	bool client_opened;
 
-	spin_lock_irqsave(&steam->lock, flags);
-	client_opened = steam->client_opened;
-	spin_unlock_irqrestore(&steam->lock, flags);
-	if (client_opened)
-		return 0;
+	scoped_guard(spinlock_irqsave, &steam->lock) {
+		if (steam->client_opened)
+			return 0;
+	}
 
 	guard(mutex)(&steam->report_mutex);
 	steam_write_settings(steam, SETTING_IMU_MODE,
@@ -969,14 +968,11 @@ static int steam_sensor_open(struct input_dev *dev)
 static void steam_sensor_close(struct input_dev *dev)
 {
 	struct steam_device *steam = input_get_drvdata(dev);
-	unsigned long flags;
-	bool client_opened;
 
-	spin_lock_irqsave(&steam->lock, flags);
-	client_opened = steam->client_opened;
-	spin_unlock_irqrestore(&steam->lock, flags);
-	if (client_opened)
-		return;
+	scoped_guard(spinlock_irqsave, &steam->lock) {
+		if (steam->client_opened)
+			return;
+	}
 
 	guard(mutex)(&steam->report_mutex);
 	steam_write_settings(steam, SETTING_IMU_MODE, 0, 0);
@@ -1380,13 +1376,16 @@ static int steam_register(struct steam_device *steam)
 {
 	int ret;
 
+	mutex_lock(&steam->registration_mutex);
 	/*
 	 * This function can be called several times in a row with the
 	 * wireless adaptor, without steam_unregister() between them, because
 	 * another client send a get_connection_status command, for example.
 	 */
-	if (steam->registered)
+	if (steam->registered) {
+		mutex_unlock(&steam->registration_mutex);
 		return 0;
+	}
 
 	/*
 	 * Unlikely, but getting the serial could fail, and it is not so
@@ -1419,6 +1418,7 @@ static int steam_register(struct steam_device *steam)
 		goto steam_register_sensors_fail;
 
 	steam->registered = true;
+	mutex_unlock(&steam->registration_mutex);
 	mutex_lock(&steam_devices_lock);
 	if (list_empty(&steam->list))
 		list_add(&steam->list, &steam_devices);
@@ -1429,6 +1429,7 @@ static int steam_register(struct steam_device *steam)
 	steam_input_unregister(steam);
 steam_register_input_fail:
 	steam_battery_unregister(steam);
+	mutex_unlock(&steam->registration_mutex);
 	return ret;
 }
 
@@ -1440,10 +1441,12 @@ static void steam_unregister(struct steam_device *steam)
 	hid_info(steam->hdev, "Steam %s '%s' disconnected",
 			steam->quirks & STEAM_QUIRK_DECK ? "Deck" : "Controller",
 			steam->serial_no);
+	mutex_lock(&steam->registration_mutex);
 	steam->registered = false;
 	steam_battery_unregister(steam);
 	steam_sensors_unregister(steam);
 	steam_input_unregister(steam);
+	mutex_unlock(&steam->registration_mutex);
 	cancel_work_sync(&steam->rumble_work);
 	cancel_delayed_work_sync(&steam->mode_switch);
 	cancel_delayed_work_sync(&steam->coalesce_rumble_work);
@@ -1484,23 +1487,26 @@ static void steam_mode_switch_cb(struct work_struct *work)
 							struct steam_device, mode_switch);
 	unsigned long flags;
 	bool client_opened;
+	bool gamepad_mode;
+
 	if (!lizard_mode)
 		return;
 
+	spin_lock_irqsave(&steam->lock, flags);
 	steam->gamepad_mode = !steam->gamepad_mode;
+	gamepad_mode = steam->gamepad_mode;
+	client_opened = steam->client_opened;
+	spin_unlock_irqrestore(&steam->lock, flags);
+
+	guard(mutex)(&steam->report_mutex);
 	hid_dbg(steam->hdev, "%s: switching gamepad mode to %i\n", __func__, steam->gamepad_mode);
-	if (steam->gamepad_mode)
+	if (gamepad_mode)
 		steam_set_lizard_mode(steam, false);
-	else {
-		spin_lock_irqsave(&steam->lock, flags);
-		client_opened = steam->client_opened;
-		spin_unlock_irqrestore(&steam->lock, flags);
-		if (!client_opened)
-			steam_set_lizard_mode(steam, lizard_mode);
-	}
+	else if (!client_opened)
+		steam_set_lizard_mode(steam, lizard_mode);
 
 	steam_haptic_pulse(steam, STEAM_PAD_RIGHT, 0x190, 0, 1, 0);
-	if (steam->gamepad_mode) {
+	if (gamepad_mode) {
 		steam_haptic_pulse(steam, STEAM_PAD_LEFT, 0x14D, 0x14D, 0x2D, 0);
 	} else {
 		steam_haptic_pulse(steam, STEAM_PAD_LEFT, 0x1F4, 0x1F4, 0x1E, 0);
@@ -1687,6 +1693,7 @@ static int steam_probe(struct hid_device *hdev,
 	hid_set_drvdata(hdev, steam);
 	spin_lock_init(&steam->lock);
 	mutex_init(&steam->report_mutex);
+	mutex_init(&steam->registration_mutex);
 	steam->quirks = id->driver_data;
 	INIT_WORK(&steam->work_connect, steam_work_connect_cb);
 	INIT_DELAYED_WORK(&steam->mode_switch, steam_mode_switch_cb);
@@ -1795,13 +1802,10 @@ static void steam_remove(struct hid_device *hdev)
 
 static void steam_do_connect_event(struct steam_device *steam, bool connected)
 {
-	unsigned long flags;
 	bool changed;
 
-	spin_lock_irqsave(&steam->lock, flags);
 	changed = steam->connected != connected;
 	steam->connected = connected;
-	spin_unlock_irqrestore(&steam->lock, flags);
 
 	if (changed && schedule_work(&steam->work_connect) == 0)
 		dbg_hid("%s: connected=%d event already queued\n",
@@ -2230,8 +2234,6 @@ static void steam_do_deck_sensors_event(struct steam_device *steam,
 static void steam_do_battery_event(struct steam_device *steam,
 		struct power_supply *battery, u8 *data)
 {
-	unsigned long flags;
-
 	s16 volts = steam_le16(data + 12);
 	u8 batt = data[14];
 
@@ -2239,10 +2241,9 @@ static void steam_do_battery_event(struct steam_device *steam,
 	rcu_read_lock();
 	battery = rcu_dereference(steam->battery);
 	if (likely(battery)) {
-		spin_lock_irqsave(&steam->lock, flags);
+		guard(spinlock_irqsave)(&steam->lock);
 		steam->battery_voltage = volts;
 		steam->battery_charge = batt;
-		spin_unlock_irqrestore(&steam->lock, flags);
 		power_supply_changed(battery);
 	}
 	rcu_read_unlock();
@@ -2427,15 +2428,13 @@ static void steam_do_ibex_battery_event(struct steam_device *steam,
 		struct power_supply *battery,
 		const struct steam_ibex_battery_status *data)
 {
-	unsigned long flags;
-
 	/* Creating the battery may have failed */
 	guard(rcu)();
 	battery = rcu_dereference(steam->battery);
 	if (!likely(battery))
 		return;
 
-	spin_lock_irqsave(&steam->lock, flags);
+	guard(spinlock_irqsave)(&steam->lock);
 	steam->battery_voltage = get_unaligned_le16(&data->battery_voltage);
 	steam->battery_current = get_unaligned_le16(&data->battery_current);
 	steam->battery_temp = get_unaligned_le16(&data->temperature);
@@ -2454,7 +2453,6 @@ static void steam_do_ibex_battery_event(struct steam_device *steam,
 		steam->battery_status = POWER_SUPPLY_STATUS_UNKNOWN;
 		break;
 	}
-	spin_unlock_irqrestore(&steam->lock, flags);
 	power_supply_changed(battery);
 }
 
@@ -2470,6 +2468,7 @@ static int steam_raw_event(struct hid_device *hdev,
 	if (!steam)
 		return 0;
 
+	guard(spinlock_irqsave)(&steam->lock);
 	if (steam->client_opened)
 		hid_input_report(steam->client_hdev, report->type, data, size, 0);
 
@@ -2633,6 +2632,8 @@ static int steam_param_set_lizard_mode(const char *val,
 {
 	struct steam_device *steam;
 	int ret;
+	bool client_opened;
+	unsigned long flags;
 
 	ret = param_set_bool(val, kp);
 	if (ret)
@@ -2640,8 +2641,13 @@ static int steam_param_set_lizard_mode(const char *val,
 
 	mutex_lock(&steam_devices_lock);
 	list_for_each_entry(steam, &steam_devices, list) {
-		if (!steam->client_opened)
+		spin_lock_irqsave(&steam->lock, flags);
+		client_opened = steam->client_opened;
+		spin_unlock_irqrestore(&steam->lock, flags);
+		if (!client_opened) {
+			guard(mutex)(&steam->report_mutex);
 			steam_set_lizard_mode(steam, lizard_mode);
+		}
 	}
 	mutex_unlock(&steam_devices_lock);
 	return 0;
-- 
2.54.0

