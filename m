Received: from endrift.com (endrift.com [173.255.198.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F24C939A057
	for <linux-input@vger.kernel.org>; Thu, 30 Jul 2026 04:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.255.198.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785384876; cv=none; b=PxZix4NNOWf2+d6ZdKFUhfhhiD/0hsElbUF+38jTBZGMypPI5yHVWXBY0k2Xx+gDQf4BvdCmHv7sPuQUmL/qf7ywcgPrGAiBcGvOCk9KcKZzYhlvIEsHixLYN/NVfBgllaN+Fw4+kSHdkgSx6Fe35aWLRaPPqBsJ0RxXjKxf2jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785384876; c=relaxed/simple;
	bh=KgqA3WtyXYCC0mRAD1fpGOPNUJ4/ifkOxtO9K1FMfVA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aWC6BBrAcr9zCotlwFGlxYCc8xSTTTcMBRsc7tr5maALsujYudl/3+z0t7ztlBdSacBJbLuM1r4gvnCiSGt2MU17wuUC14BWAWn6r+YpyVoj5L5rABo7xPS5TmygeARZB9jKMz6RQkPzQqkprK1RKZWKNY+JxSChSjm4n/nu8bY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endrift.com; spf=pass smtp.mailfrom=endrift.com; dkim=pass (2048-bit key) header.d=endrift.com header.i=@endrift.com header.b=J3FReObi; arc=none smtp.client-ip=173.255.198.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endrift.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=endrift.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=endrift.com header.i=@endrift.com header.b="J3FReObi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=endrift.com; s=2020;
	t=1785384868; bh=KgqA3WtyXYCC0mRAD1fpGOPNUJ4/ifkOxtO9K1FMfVA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=J3FReObiEES8kK0tF1OtCZmCMPnxGOvxCfGXvhohXIHn0OQ4gdwTrG72rhte2V6fZ
	 JBNcwibhe7yv/CzHD+gh7hnFevn/MhxpcfGV6LCZcddy5or/9w7UHXBF90A2QgTSAv
	 kFfwDf/N6ow2s62jCrxV9Ckjx4NpsdlefY1ZL4Wje+l5rzhVt6iZlZLT16Q73Ud9XZ
	 lEBT7TQeF9Dqwy/ZRt7AG4FM57UIMuIF4If/W9UyrIs0B6k88K45djLgNYKK9g2Ixb
	 4/xsROzMe8VaRr2X7n7g+kJ5ZsxzcnvbLEmfafBpbypTT4IqRDZ5E+YKXEwZd1tns/
	 N/0kWuEgFo5DQ==
Received: from microtis.vulpes.eutheria.net (71-212-73-87.tukw.qwest.net [71.212.73.87])
	by endrift.com (Postfix) with ESMTPSA id F2425132035;
	Wed, 29 Jul 2026 21:14:27 -0700 (PDT)
From: Vicki Pfau <vi@endrift.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	linux-input@vger.kernel.org
Cc: Vicki Pfau <vi@endrift.com>,
	Yousef Alhouseen <alhouseenyousef@gmail.com>
Subject: [PATCH v5 06/11] HID: steam: Fully unregister controller when hidraw is opened
Date: Wed, 29 Jul 2026 21:12:29 -0700
Message-ID: <20260730041251.1659029-7-vi@endrift.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260730041251.1659029-1-vi@endrift.com>
References: <20260730041251.1659029-1-vi@endrift.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To avoid conflicts between anything touching the hidraw and the driver we
had previously detached the evdev nodes when the hidraw is opened. However,
this isn't sufficient to avoid FEATURE reports from conflicting, so we
change to fully unregistering the controller internally, leaving only the
hidraw active until it's closed.

This also unifies the unregister and connect callbacks, as now the logic
between these two callbacks is identical.

Signed-off-by: Vicki Pfau <vi@endrift.com>
---
 drivers/hid/hid-steam.c | 73 +++++++++++++++--------------------------
 1 file changed, 27 insertions(+), 46 deletions(-)

diff --git a/drivers/hid/hid-steam.c b/drivers/hid/hid-steam.c
index 87b3817a2f69..12203d61922f 100644
--- a/drivers/hid/hid-steam.c
+++ b/drivers/hid/hid-steam.c
@@ -348,7 +348,6 @@ struct steam_device {
 	u16 rumble_right;
 	unsigned int sensor_timestamp_us;
 	unsigned int sensor_update_rate_us;
-	struct work_struct unregister_work;
 };
 
 static int steam_recv_report(struct steam_device *steam,
@@ -818,6 +817,7 @@ static int steam_battery_register(struct steam_device *steam)
 			&steam->battery_desc, &battery_cfg);
 	if (IS_ERR(battery)) {
 		ret = PTR_ERR(battery);
+		devm_kfree(&steam->hdev->dev, steam->battery_desc.name);
 		hid_err(steam->hdev,
 				"%s:power_supply_register failed with error %d\n",
 				__func__, ret);
@@ -1077,6 +1077,7 @@ static void steam_battery_unregister(struct steam_device *steam)
 	RCU_INIT_POINTER(steam->battery, NULL);
 	synchronize_rcu();
 	power_supply_unregister(battery);
+	devm_kfree(&steam->hdev->dev, steam->battery_desc.name);
 }
 
 static int steam_register(struct steam_device *steam)
@@ -1084,6 +1085,7 @@ static int steam_register(struct steam_device *steam)
 	int ret;
 	unsigned long client_opened;
 	unsigned long flags;
+	bool do_add;
 
 	/*
 	 * This function can be called several times in a row with the
@@ -1113,10 +1115,7 @@ static int steam_register(struct steam_device *steam)
 		if (steam->quirks & STEAM_QUIRK_WIRELESS)
 			steam_battery_register(steam);
 
-		mutex_lock(&steam_devices_lock);
-		if (list_empty(&steam->list))
-			list_add(&steam->list, &steam_devices);
-		mutex_unlock(&steam_devices_lock);
+		do_add = true;
 	}
 
 	spin_lock_irqsave(&steam->lock, flags);
@@ -1132,6 +1131,13 @@ static int steam_register(struct steam_device *steam)
 		if (ret != 0)
 			goto steam_register_sensors_fail;
 	}
+
+	if (do_add) {
+		mutex_lock(&steam_devices_lock);
+		if (list_empty(&steam->list))
+			list_add(&steam->list, &steam_devices);
+		mutex_unlock(&steam_devices_lock);
+	}
 	return 0;
 
 steam_register_sensors_fail:
@@ -1142,38 +1148,41 @@ static int steam_register(struct steam_device *steam)
 
 static void steam_unregister(struct steam_device *steam)
 {
+	if (!steam->serial_no[0])
+		return;
+
+	hid_info(steam->hdev, "Steam Controller '%s' disconnected",
+			steam->serial_no);
 	steam_battery_unregister(steam);
 	steam_sensors_unregister(steam);
 	steam_input_unregister(steam);
-	if (steam->serial_no[0]) {
-		hid_info(steam->hdev, "Steam Controller '%s' disconnected",
-				steam->serial_no);
-		mutex_lock(&steam_devices_lock);
-		list_del_init(&steam->list);
-		mutex_unlock(&steam_devices_lock);
-		steam->serial_no[0] = 0;
-	}
+	mutex_lock(&steam_devices_lock);
+	list_del_init(&steam->list);
+	mutex_unlock(&steam_devices_lock);
+	steam->serial_no[0] = 0;
 }
 
 static void steam_work_connect_cb(struct work_struct *work)
 {
 	struct steam_device *steam = container_of(work, struct steam_device,
 							work_connect);
+
 	unsigned long flags;
 	bool connected;
+	bool opened;
 	int ret;
 
 	spin_lock_irqsave(&steam->lock, flags);
+	opened = steam->client_opened;
 	connected = steam->connected;
 	spin_unlock_irqrestore(&steam->lock, flags);
 
-	if (connected) {
+	if (connected && !opened) {
 		ret = steam_register(steam);
-		if (ret) {
+		if (ret)
 			hid_err(steam->hdev,
 				"%s:steam_register failed with error %d\n",
 				__func__, ret);
-		}
 	} else {
 		steam_unregister(steam);
 	}
@@ -1207,31 +1216,6 @@ static void steam_mode_switch_cb(struct work_struct *work)
 	}
 }
 
-static void steam_work_unregister_cb(struct work_struct *work)
-{
-	struct steam_device *steam = container_of(work, struct steam_device,
-							unregister_work);
-	unsigned long flags;
-	bool connected;
-	bool opened;
-
-	spin_lock_irqsave(&steam->lock, flags);
-	opened = steam->client_opened;
-	connected = steam->connected;
-	spin_unlock_irqrestore(&steam->lock, flags);
-
-	if (connected) {
-		if (opened) {
-			steam_sensors_unregister(steam);
-			steam_input_unregister(steam);
-		} else {
-			steam_set_lizard_mode(steam, lizard_mode);
-			steam_input_register(steam);
-			steam_sensors_register(steam);
-		}
-	}
-}
-
 static bool steam_is_valve_interface(struct hid_device *hdev)
 {
 	struct hid_report_enum *rep_enum;
@@ -1277,7 +1261,7 @@ static int steam_client_ll_open(struct hid_device *hdev)
 	steam->client_opened++;
 	spin_unlock_irqrestore(&steam->lock, flags);
 
-	schedule_work(&steam->unregister_work);
+	schedule_work(&steam->work_connect);
 
 	return 0;
 }
@@ -1292,7 +1276,7 @@ static void steam_client_ll_close(struct hid_device *hdev)
 	steam->client_opened--;
 	spin_unlock_irqrestore(&steam->lock, flags);
 
-	schedule_work(&steam->unregister_work);
+	schedule_work(&steam->work_connect);
 }
 
 static int steam_client_ll_raw_request(struct hid_device *hdev,
@@ -1389,7 +1373,6 @@ static int steam_probe(struct hid_device *hdev,
 		steam->sensor_update_rate_us = 4000;
 	else
 		steam->sensor_update_rate_us = 9000;
-	INIT_WORK(&steam->unregister_work, steam_work_unregister_cb);
 
 	/*
 	 * With the real steam controller interface, do not connect hidraw.
@@ -1451,7 +1434,6 @@ static int steam_probe(struct hid_device *hdev,
 	cancel_delayed_work_sync(&steam->mode_switch);
 	cancel_work_sync(&steam->rumble_work);
 	cancel_delayed_work_sync(&steam->coalesce_rumble_work);
-	cancel_work_sync(&steam->unregister_work);
 
 	return ret;
 }
@@ -1470,7 +1452,6 @@ static void steam_remove(struct hid_device *hdev)
 	cancel_work_sync(&steam->work_connect);
 	cancel_work_sync(&steam->rumble_work);
 	cancel_delayed_work_sync(&steam->coalesce_rumble_work);
-	cancel_work_sync(&steam->unregister_work);
 	steam->client_hdev = NULL;
 	steam->client_opened = 0;
 	if (steam->quirks & STEAM_QUIRK_WIRELESS) {
-- 
2.54.0

