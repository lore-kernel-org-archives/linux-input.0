Received: from endrift.com (endrift.com [173.255.198.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E550A3B8124
	for <linux-input@vger.kernel.org>; Thu,  2 Jul 2026 22:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.255.198.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783030985; cv=none; b=kyjvY9qJHIdeuhjzGNuC3lHycpCYIeCP4dV8YCK8OpIdwIdpu/g4eRWYpiXsuV2ngI6Dsvhsc8uF2OjKZvNvohtv2/HBPDf4n3DH7FiEgaf5ibV65ugP+9ULcA00t9Cj+ECRDohZrVrHC06DV1tVDIPp+oT5YZxyEkb4XaRl0uQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783030985; c=relaxed/simple;
	bh=xm1jYNGqCD7/xCQgCRD6UOoY2OC2ebRDPLW6CsIuuZM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r/6HgyZS3TzbUjz5TgJ0Xa1nPSUyxdheeVlTB2wO/eRhKgAcZff++f2XkyKvZU3WpFB1ySSnGZbrVgs0AzzyeXhAaFmPt9zBDsO/KDpS4A2pvIECL1ivyRO3kpq2xAijyc8Qzz3GcPK8SUusS5vIFB0S1mfOF741FRJJEBNK+DQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endrift.com; spf=pass smtp.mailfrom=endrift.com; dkim=pass (2048-bit key) header.d=endrift.com header.i=@endrift.com header.b=qhYHlpmj; arc=none smtp.client-ip=173.255.198.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endrift.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=endrift.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=endrift.com header.i=@endrift.com header.b="qhYHlpmj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=endrift.com; s=2020;
	t=1783030983; bh=xm1jYNGqCD7/xCQgCRD6UOoY2OC2ebRDPLW6CsIuuZM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qhYHlpmjrhIlSgemeFhn3rS6s9UMCSKV3hYCo9LSv0Dt1oqtNHxCIwI/SCxFveV1h
	 3vmrmDsW80SlIBiB1a6y3xqOnbIxLoat/v9+9QzsRNmns0GHC0VsxIGRsJpOx3yK3w
	 XmUd8vNop07ewAJKRlbxDjfefKVhQHbKZsK6o0szwCgHOnSTL/bNyUANuanK4FyBfB
	 VM9upu7hJVtHtBlOhcp/4YnUoP5LP0K0lKNCA0eEr2oStq3ylb62Frcw68iSxunKQf
	 sD0P38+WzKQXXRK/25x0LkoFtma9kvuNPhNP8PeOHqgJX4PE2VLaC1BVa61YWqZbXx
	 eeh3B1VuDRtgw==
Received: from microtis.vulpes.eutheria.net (71-212-73-87.tukw.qwest.net [71.212.73.87])
	by endrift.com (Postfix) with ESMTPSA id 3DDC7A0F7;
	Thu, 02 Jul 2026 15:23:03 -0700 (PDT)
From: Vicki Pfau <vi@endrift.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	linux-input@vger.kernel.org
Cc: Vicki Pfau <vi@endrift.com>,
	Yousef Alhouseen <alhouseenyousef@gmail.com>
Subject: [PATCH 06/10] HID: steam: Fully unregister controller when hidraw is opened
Date: Thu,  2 Jul 2026 15:21:39 -0700
Message-ID: <20260702222145.1863104-6-vi@endrift.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260702222145.1863104-1-vi@endrift.com>
References: <20260702222145.1863104-1-vi@endrift.com>
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
 drivers/hid/hid-steam.c | 58 ++++++++++++-----------------------------
 1 file changed, 16 insertions(+), 42 deletions(-)

diff --git a/drivers/hid/hid-steam.c b/drivers/hid/hid-steam.c
index 01b64194ec97..546916da31f9 100644
--- a/drivers/hid/hid-steam.c
+++ b/drivers/hid/hid-steam.c
@@ -348,7 +348,6 @@ struct steam_device {
 	u16 rumble_right;
 	unsigned int sensor_timestamp_us;
 	unsigned int sensor_update_rate_us;
-	struct work_struct unregister_work;
 };
 
 static int steam_recv_report(struct steam_device *steam,
@@ -1144,38 +1143,41 @@ static int steam_register(struct steam_device *steam)
 
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
@@ -1209,31 +1211,6 @@ static void steam_mode_switch_cb(struct work_struct *work)
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
@@ -1279,7 +1256,7 @@ static int steam_client_ll_open(struct hid_device *hdev)
 	steam->client_opened++;
 	spin_unlock_irqrestore(&steam->lock, flags);
 
-	schedule_work(&steam->unregister_work);
+	schedule_work(&steam->work_connect);
 
 	return 0;
 }
@@ -1294,7 +1271,7 @@ static void steam_client_ll_close(struct hid_device *hdev)
 	steam->client_opened--;
 	spin_unlock_irqrestore(&steam->lock, flags);
 
-	schedule_work(&steam->unregister_work);
+	schedule_work(&steam->work_connect);
 }
 
 static int steam_client_ll_raw_request(struct hid_device *hdev,
@@ -1391,7 +1368,6 @@ static int steam_probe(struct hid_device *hdev,
 		steam->sensor_update_rate_us = 4000;
 	else
 		steam->sensor_update_rate_us = 9000;
-	INIT_WORK(&steam->unregister_work, steam_work_unregister_cb);
 
 	/*
 	 * With the real steam controller interface, do not connect hidraw.
@@ -1453,7 +1429,6 @@ static int steam_probe(struct hid_device *hdev,
 	cancel_delayed_work_sync(&steam->mode_switch);
 	cancel_work_sync(&steam->rumble_work);
 	cancel_delayed_work_sync(&steam->coalesce_rumble_work);
-	cancel_work_sync(&steam->unregister_work);
 
 	return ret;
 }
@@ -1472,7 +1447,6 @@ static void steam_remove(struct hid_device *hdev)
 	cancel_work_sync(&steam->work_connect);
 	cancel_work_sync(&steam->rumble_work);
 	cancel_delayed_work_sync(&steam->coalesce_rumble_work);
-	cancel_work_sync(&steam->unregister_work);
 	steam->client_hdev = NULL;
 	steam->client_opened = 0;
 	if (steam->quirks & STEAM_QUIRK_WIRELESS) {
-- 
2.54.0

