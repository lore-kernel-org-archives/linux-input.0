Received: from endrift.com (endrift.com [173.255.198.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9258B349CD1
	for <linux-input@vger.kernel.org>; Tue,  7 Jul 2026 23:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.255.198.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783467235; cv=none; b=Kp1PujkD7CSSjchUY2PkDgeho1n+4DU9PTh4zoyE8oevP4/oiIkCGbN54xFN+Am63Zwng24xXj2akQO3fl/UX1Ob/5TyfnHHBOmVJCYBFyV4xhcN4UdJ3PajhWZnyrcKRBGyXQN6tzETJf984MT7KQPoPO3nFheRRm6Aq9knugA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783467235; c=relaxed/simple;
	bh=PEaSf3ZfCrRYTg+Y/gqeC+2BJc3mkdpcnGU9Av1GZnU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kqXgt2UoDua+EZ6pCGO9zYCuGrKvD69zduMSxJyNueipMRrWuObiICVFGeOfrukzLeH3ti+gkmEfb8A2AXOD9imJyJzgiUE8hhF70gA5UD9iD+Gs6y4fSd18cCkZTx5p7eMb4AX/7bnJs4d3TUMHF0ddEEr+PjMqul2lfq8pL3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endrift.com; spf=pass smtp.mailfrom=endrift.com; dkim=pass (2048-bit key) header.d=endrift.com header.i=@endrift.com header.b=SRHkwXT4; arc=none smtp.client-ip=173.255.198.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endrift.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=endrift.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=endrift.com header.i=@endrift.com header.b="SRHkwXT4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=endrift.com; s=2020;
	t=1783467233; bh=PEaSf3ZfCrRYTg+Y/gqeC+2BJc3mkdpcnGU9Av1GZnU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SRHkwXT4Z2hvyYAbmjTf6z9Cb3Da7joikRYlqFWe1mU+jB8WF/3cG2aEUmYi312YW
	 xUD/ZmOToGQ8Srp+L4vUBCWrxCTvKlp/4h1EujJV9zl/9u4nSBE1IRFa+bWZOFc7YD
	 EXxDrYELFctTF2sxbxZbh7I762vlkPVwx4IXgZ0N8X3PVFWFrin+y2VRTMelfeSxxA
	 /dvFSQJl79yq2hSNJvGlyD+GdMvI93ODT8qymqsOxufgQw8xnAaOrjCd6osh+39m3O
	 m4yb3AxTYs0yHYAtsV9Jn20boE1J4r/vW6u9nl9jTrXn9R1jGv7pj1wzWVLDJk9vdC
	 oQ65ceBY8N76w==
Received: from microtis.vulpes.eutheria.net (71-212-73-87.tukw.qwest.net [71.212.73.87])
	by endrift.com (Postfix) with ESMTPSA id C6F41A140;
	Tue, 07 Jul 2026 16:33:52 -0700 (PDT)
From: Vicki Pfau <vi@endrift.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	linux-input@vger.kernel.org
Cc: Vicki Pfau <vi@endrift.com>,
	Yousef Alhouseen <alhouseenyousef@gmail.com>
Subject: [PATCH v2 06/10] HID: steam: Fully unregister controller when hidraw is opened
Date: Tue,  7 Jul 2026 16:32:26 -0700
Message-ID: <20260707233241.2644971-7-vi@endrift.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260707233241.2644971-1-vi@endrift.com>
References: <20260707233241.2644971-1-vi@endrift.com>
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
 drivers/hid/hid-steam.c | 59 ++++++++++++-----------------------------
 1 file changed, 17 insertions(+), 42 deletions(-)

diff --git a/drivers/hid/hid-steam.c b/drivers/hid/hid-steam.c
index 553748813901..3f1dbdcad23c 100644
--- a/drivers/hid/hid-steam.c
+++ b/drivers/hid/hid-steam.c
@@ -348,7 +348,6 @@ struct steam_device {
 	u16 rumble_right;
 	unsigned int sensor_timestamp_us;
 	unsigned int sensor_update_rate_us;
-	struct work_struct unregister_work;
 };
 
 static int steam_recv_report(struct steam_device *steam,
@@ -1077,6 +1076,7 @@ static void steam_battery_unregister(struct steam_device *steam)
 	RCU_INIT_POINTER(steam->battery, NULL);
 	synchronize_rcu();
 	power_supply_unregister(battery);
+	devm_kfree(&steam->hdev->dev, steam->battery_desc.name);
 }
 
 static int steam_register(struct steam_device *steam)
@@ -1142,38 +1142,41 @@ static int steam_register(struct steam_device *steam)
 
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
@@ -1207,31 +1210,6 @@ static void steam_mode_switch_cb(struct work_struct *work)
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
@@ -1277,7 +1255,7 @@ static int steam_client_ll_open(struct hid_device *hdev)
 	steam->client_opened++;
 	spin_unlock_irqrestore(&steam->lock, flags);
 
-	schedule_work(&steam->unregister_work);
+	schedule_work(&steam->work_connect);
 
 	return 0;
 }
@@ -1292,7 +1270,7 @@ static void steam_client_ll_close(struct hid_device *hdev)
 	steam->client_opened--;
 	spin_unlock_irqrestore(&steam->lock, flags);
 
-	schedule_work(&steam->unregister_work);
+	schedule_work(&steam->work_connect);
 }
 
 static int steam_client_ll_raw_request(struct hid_device *hdev,
@@ -1389,7 +1367,6 @@ static int steam_probe(struct hid_device *hdev,
 		steam->sensor_update_rate_us = 4000;
 	else
 		steam->sensor_update_rate_us = 9000;
-	INIT_WORK(&steam->unregister_work, steam_work_unregister_cb);
 
 	/*
 	 * With the real steam controller interface, do not connect hidraw.
@@ -1451,7 +1428,6 @@ static int steam_probe(struct hid_device *hdev,
 	cancel_delayed_work_sync(&steam->mode_switch);
 	cancel_work_sync(&steam->rumble_work);
 	cancel_delayed_work_sync(&steam->coalesce_rumble_work);
-	cancel_work_sync(&steam->unregister_work);
 
 	return ret;
 }
@@ -1470,7 +1446,6 @@ static void steam_remove(struct hid_device *hdev)
 	cancel_work_sync(&steam->work_connect);
 	cancel_work_sync(&steam->rumble_work);
 	cancel_delayed_work_sync(&steam->coalesce_rumble_work);
-	cancel_work_sync(&steam->unregister_work);
 	steam->client_hdev = NULL;
 	steam->client_opened = 0;
 	if (steam->quirks & STEAM_QUIRK_WIRELESS) {
-- 
2.54.0

