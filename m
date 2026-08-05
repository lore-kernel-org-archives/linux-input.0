Received: from endrift.com (endrift.com [173.255.198.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBCEE3A9002
	for <linux-input@vger.kernel.org>; Wed,  5 Aug 2026 01:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.255.198.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785894792; cv=none; b=skWkiaP6GNh8/RKLQuLjcTP8DzbPxuFVIw6nRmiFpVFKrb8ViX0NbEUO3y/fTZfML8bKG4dL6dssgnZafGh97Llsj1yTVEzLVcetBGa9U9JVvpAfT4YeJKyA779TkwldFFBkOoxEh5pSq3yyz0uQyxJ3eEEI6j15GeV4oBZAR5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785894792; c=relaxed/simple;
	bh=a9jjtStYui30mWuWioVigdbODKUn2GrDFhH6q99xfYQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qWkbSfrN8Wrjvm+TSpW02NTIsUvkqBpESiDyJ9VNSraw7zqvePoDmAY0qBPsxS6hzgH76EFyj/j7Big+R4SAliFcK3j+hxWiLlu6zb6vB/GUgdNu6G4efhWTgcEipz4qPqxzF8Q5JLi86tSeAegXrimvx6m7JuIO09B4ABZbOtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endrift.com; spf=pass smtp.mailfrom=endrift.com; dkim=pass (2048-bit key) header.d=endrift.com header.i=@endrift.com header.b=Dcw9wHTB; arc=none smtp.client-ip=173.255.198.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endrift.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=endrift.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=endrift.com header.i=@endrift.com header.b="Dcw9wHTB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=endrift.com; s=2020;
	t=1785894770; bh=a9jjtStYui30mWuWioVigdbODKUn2GrDFhH6q99xfYQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Dcw9wHTBpSjMmYDg4y21I3ASW4q5xcuCRQRX7k9oHBdxY0MhAf9IM6tOd2StJxSop
	 +Etr4nW+hYne77sr+/iUUaWU6qtKmrGhuc4+o0ESVPCb50tIeCMnfWt5WPekosl0AD
	 Vo+3mfgAmpnZq20Osgn1XYztrsbRSFHVvcyg0Vo22ehBzQ1sHpLNzwwuUBIbtZ59yj
	 IqIZ3SyR9M3jdJXcJwd4LPPGLkQ0d3OfHnUASAIA9AGagODNlUhXQYgZRM/SAe+bYZ
	 vB/WzjCUe7p32UkFNhs7OHuVrPJJdHgudT4qkCsV/7rqKsk3tGGsE96/9Q0XPqkXLj
	 b2QuYQ/Y6xcSw==
Received: from microtis.vulpes.eutheria.net (71-212-73-87.tukw.qwest.net [71.212.73.87])
	by endrift.com (Postfix) with ESMTPSA id B9DB4A276;
	Tue, 04 Aug 2026 18:52:49 -0700 (PDT)
From: Vicki Pfau <vi@endrift.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	linux-input@vger.kernel.org
Cc: Vicki Pfau <vi@endrift.com>
Subject: [PATCH 4/5] HID: steam: Clean up locking
Date: Tue,  4 Aug 2026 18:51:05 -0700
Message-ID: <20260805015116.3884465-5-vi@endrift.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260805015116.3884465-1-vi@endrift.com>
References: <20260805015116.3884465-1-vi@endrift.com>
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
 drivers/hid/hid-steam.c | 86 ++++++++++++++++++++---------------------
 1 file changed, 43 insertions(+), 43 deletions(-)

diff --git a/drivers/hid/hid-steam.c b/drivers/hid/hid-steam.c
index 2d60b79441b6..87af4bee9f5f 100644
--- a/drivers/hid/hid-steam.c
+++ b/drivers/hid/hid-steam.c
@@ -632,7 +632,6 @@ static int steam_exchange_report(struct steam_device *steam, u8 *cmd, int csize,
 	unsigned int retries = 5;
 	int ret;
 
-	guard(mutex)(&steam->report_mutex);
 	do {
 		ret = steam_send_report(steam, cmd, csize);
 		if (ret < 0)
@@ -728,7 +727,6 @@ static int steam_get_conn_status(struct steam_device *steam)
 	else
 		report_id = 0;
 
-	guard(mutex)(&steam->report_mutex);
 	ret = steam_send_report_id(steam, cmd, sizeof(cmd), report_id);
 	if (ret < 0)
 		return ret;
@@ -786,7 +784,6 @@ static inline int steam_haptic_pulse(struct steam_device *steam, u8 pad,
 		report[8] = count >> 8;
 		report[9] = gain;
 
-		guard(mutex)(&steam->report_mutex);
 		ret = steam_send_report(steam, report, 10);
 	}
 
@@ -828,7 +825,6 @@ static inline int steam_haptic_rumble(struct steam_device *steam,
 		report[9] = left_gain;
 		report[10] = right_gain;
 
-		guard(mutex)(&steam->report_mutex);
 		ret = steam_send_report(steam, report, sizeof(report));
 	}
 	return ret;
@@ -839,8 +835,10 @@ static void steam_haptic_rumble_cb(struct work_struct *work)
 	struct steam_device *steam = container_of(work, struct steam_device,
 							rumble_work);
 
+	mutex_lock(&steam->report_mutex);
 	steam_haptic_rumble(steam, 0, steam->rumble_left,
 		steam->rumble_right, 2, 0);
+	mutex_unlock(&steam->report_mutex);
 }
 
 static void steam_coalesce_rumble_cb(struct work_struct *work)
@@ -849,8 +847,10 @@ static void steam_coalesce_rumble_cb(struct work_struct *work)
 							struct steam_device,
 							coalesce_rumble_work);
 
+	mutex_lock(&steam->report_mutex);
 	steam_haptic_rumble(steam, 0, steam->rumble_left,
 		steam->rumble_right, 2, 0);
+	mutex_unlock(&steam->report_mutex);
 
 	if (steam->rumble_left || steam->rumble_right)
 		schedule_delayed_work(&steam->coalesce_rumble_work, HZ / 20);
@@ -882,7 +882,6 @@ static void steam_set_lizard_mode(struct steam_device *steam, bool enable)
 	if (steam->gamepad_mode)
 		enable = false;
 
-	mutex_lock(&steam->report_mutex);
 	if (enable) {
 		/* enable esc, enter, cursors */
 		steam_send_report_byte(steam, ID_SET_DEFAULT_DIGITAL_MAPPINGS);
@@ -905,14 +904,13 @@ static void steam_set_lizard_mode(struct steam_device *steam, bool enable)
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
@@ -921,9 +919,10 @@ static int steam_input_open(struct input_dev *dev)
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
 
@@ -934,13 +933,14 @@ static void steam_input_close(struct input_dev *dev)
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
@@ -948,14 +948,11 @@ static void steam_input_close(struct input_dev *dev)
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
@@ -968,14 +965,11 @@ static int steam_sensor_open(struct input_dev *dev)
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
@@ -1460,6 +1454,7 @@ static void steam_work_connect_cb(struct work_struct *work)
 	bool opened;
 	int ret;
 
+	guard(mutex)(&steam->report_mutex);
 	spin_lock_irqsave(&steam->lock, flags);
 	opened = steam->client_opened;
 	connected = steam->connected;
@@ -1482,23 +1477,28 @@ static void steam_mode_switch_cb(struct work_struct *work)
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
 	else {
-		spin_lock_irqsave(&steam->lock, flags);
-		client_opened = steam->client_opened;
-		spin_unlock_irqrestore(&steam->lock, flags);
 		if (!client_opened)
 			steam_set_lizard_mode(steam, lizard_mode);
 	}
 
 	steam_haptic_pulse(steam, STEAM_PAD_RIGHT, 0x190, 0, 1, 0);
-	if (steam->gamepad_mode) {
+	if (gamepad_mode) {
 		steam_haptic_pulse(steam, STEAM_PAD_LEFT, 0x14D, 0x14D, 0x2D, 0);
 	} else {
 		steam_haptic_pulse(steam, STEAM_PAD_LEFT, 0x1F4, 0x1F4, 0x1E, 0);
@@ -1728,7 +1728,9 @@ static int steam_probe(struct hid_device *hdev,
 			steam->connected = true;
 	}
 	if (steam->connected) {
+		mutex_lock(&steam->report_mutex);
 		ret = steam_register(steam);
+		mutex_unlock(&steam->report_mutex);
 		if (ret) {
 			hid_err(hdev,
 				"%s:steam_register failed with error %d\n",
@@ -1787,19 +1789,17 @@ static void steam_remove(struct hid_device *hdev)
 	if (steam->quirks & STEAM_QUIRK_WIRELESS) {
 		hid_info(hdev, "Steam wireless receiver disconnected");
 	}
+	guard(mutex)(&steam->report_mutex);
 	steam_unregister(steam);
 	hid_hw_stop(hdev);
 }
 
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
@@ -2228,8 +2228,6 @@ static void steam_do_deck_sensors_event(struct steam_device *steam,
 static void steam_do_battery_event(struct steam_device *steam,
 		struct power_supply *battery, u8 *data)
 {
-	unsigned long flags;
-
 	s16 volts = steam_le16(data + 12);
 	u8 batt = data[14];
 
@@ -2237,10 +2235,8 @@ static void steam_do_battery_event(struct steam_device *steam,
 	rcu_read_lock();
 	battery = rcu_dereference(steam->battery);
 	if (likely(battery)) {
-		spin_lock_irqsave(&steam->lock, flags);
 		steam->battery_voltage = volts;
 		steam->battery_charge = batt;
-		spin_unlock_irqrestore(&steam->lock, flags);
 		power_supply_changed(battery);
 	}
 	rcu_read_unlock();
@@ -2425,15 +2421,12 @@ static void steam_do_ibex_battery_event(struct steam_device *steam,
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
 	steam->battery_voltage = get_unaligned_le16(&data->battery_voltage);
 	steam->battery_current = get_unaligned_le16(&data->battery_current);
 	steam->battery_temp = get_unaligned_le16(&data->temperature);
@@ -2452,7 +2445,6 @@ static void steam_do_ibex_battery_event(struct steam_device *steam,
 		steam->battery_status = POWER_SUPPLY_STATUS_UNKNOWN;
 		break;
 	}
-	spin_unlock_irqrestore(&steam->lock, flags);
 	power_supply_changed(battery);
 }
 
@@ -2468,6 +2460,7 @@ static int steam_raw_event(struct hid_device *hdev,
 	if (!steam)
 		return 0;
 
+	guard(spinlock_irqsave)(&steam->lock);
 	if (steam->client_opened)
 		hid_input_report(steam->client_hdev, report->type, data, size, 0);
 
@@ -2631,6 +2624,8 @@ static int steam_param_set_lizard_mode(const char *val,
 {
 	struct steam_device *steam;
 	int ret;
+	bool client_opened;
+	unsigned long flags;
 
 	ret = param_set_bool(val, kp);
 	if (ret)
@@ -2638,8 +2633,13 @@ static int steam_param_set_lizard_mode(const char *val,
 
 	mutex_lock(&steam_devices_lock);
 	list_for_each_entry(steam, &steam_devices, list) {
-		if (!steam->client_opened)
+		spin_lock_irqsave(&steam->lock, flags);
+		client_opened = steam->client_opened;
+		spin_unlock_irqrestore(&steam->lock, flags);
+		if (client_opened) {
+			guard(mutex)(&steam->report_mutex);
 			steam_set_lizard_mode(steam, lizard_mode);
+		}
 	}
 	mutex_unlock(&steam_devices_lock);
 	return 0;
-- 
2.54.0

