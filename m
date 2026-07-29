Received: from endrift.com (endrift.com [173.255.198.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18B183161BA
	for <linux-input@vger.kernel.org>; Wed, 29 Jul 2026 01:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.255.198.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785290052; cv=none; b=DF0Q19sZC9nksMmN/8B6uZOR1dAGBtE6i9p1QtmSA1F5jamcDfxjBFRRucP6cg8Ov7CORi8OtGFE0c/5vMX2xcy2I+bgXe138HaSaAI3BZiywdEWaE+1QpLM/xvXNmKkvUkbTRh4f8Hcr27IRn03oJBktkimDgU72VwRRNXKPDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785290052; c=relaxed/simple;
	bh=3UBvNofh1y4vq+SM8kqEMcNTQ1V2WS3pC6PAUVmaK6o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=olhIn/dyOrH98pEKfNVYi859r84dPEP8hGD0rPH4jouOiRQQL97GIQ6GSddVyCAplXSVXsp+UF7d2ltjzqW/oxSMZC5YGBi4BWahiOawfJ9dq/DnHsxwD3hgbzjXW83OPFNb8l1+OqIwBSoeEIzGREZMB2b48IVtxEenWkLbOi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endrift.com; spf=pass smtp.mailfrom=endrift.com; dkim=pass (2048-bit key) header.d=endrift.com header.i=@endrift.com header.b=c/sElS/5; arc=none smtp.client-ip=173.255.198.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endrift.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=endrift.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=endrift.com header.i=@endrift.com header.b="c/sElS/5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=endrift.com; s=2020;
	t=1785290046; bh=3UBvNofh1y4vq+SM8kqEMcNTQ1V2WS3pC6PAUVmaK6o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=c/sElS/5HTs50pLI0vMSSlWJKwbF0JGVJeU9phptWt4Oc/JOyanlQCBw2Gh/qr6ls
	 Qmp7E3AJflhINF9CAqMfh4Kh9kxzIAtaZ2RHszAFMahbPy7k9llrg7Qm8d816MzZH5
	 O5+I/SImd9UlaJBypKnNQ2nATma+JiXhlwxDRh4alcOJ0GrCCRwl6OfdJ5a3tLd2AE
	 /6FoDLKaOfNXyIMZStAOfq6HYA8/MYaAkzOI8DE31wtcnbp8HoAxIZeP0HgExvygHR
	 +t4y/U1AQI5Pfxsxv+/yKknwwV39sA0Uo4zUBjcLnXB9nrURbymLkMZXOJ2gs/mGP7
	 5CLPJSVVveGSg==
Received: from microtis.vulpes.eutheria.net (71-212-73-87.tukw.qwest.net [71.212.73.87])
	by endrift.com (Postfix) with ESMTPSA id 6B1DFA141;
	Tue, 28 Jul 2026 18:54:06 -0700 (PDT)
From: Vicki Pfau <vi@endrift.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	linux-input@vger.kernel.org
Cc: Vicki Pfau <vi@endrift.com>,
	Yousef Alhouseen <alhouseenyousef@gmail.com>
Subject: [PATCH v4 07/11] HID: steam: Fully unregister controller when hidraw is opened
Date: Tue, 28 Jul 2026 18:52:29 -0700
Message-ID: <20260729015243.1170573-8-vi@endrift.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260729015243.1170573-1-vi@endrift.com>
References: <20260729015243.1170573-1-vi@endrift.com>
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
 drivers/hid/hid-steam.c | 60 +++++++++++++----------------------------
 1 file changed, 18 insertions(+), 42 deletions(-)

diff --git a/drivers/hid/hid-steam.c b/drivers/hid/hid-steam.c
index a200878db8ac..ff112aa1b0e9 100644
--- a/drivers/hid/hid-steam.c
+++ b/drivers/hid/hid-steam.c
@@ -348,7 +348,6 @@ struct steam_device {
 	u16 rumble_right;
 	unsigned int sensor_timestamp_us;
 	unsigned int sensor_update_rate_us;
-	struct work_struct unregister_work;
 };
 
 static int steam_recv_report(struct steam_device *steam,
@@ -817,6 +816,7 @@ static int steam_battery_register(struct steam_device *steam)
 			&steam->battery_desc, &battery_cfg);
 	if (IS_ERR(battery)) {
 		ret = PTR_ERR(battery);
+		devm_kfree(&steam->hdev->dev, steam->battery_desc.name);
 		hid_err(steam->hdev,
 				"%s:power_supply_register failed with error %d\n",
 				__func__, ret);
@@ -1076,6 +1076,7 @@ static void steam_battery_unregister(struct steam_device *steam)
 	RCU_INIT_POINTER(steam->battery, NULL);
 	synchronize_rcu();
 	power_supply_unregister(battery);
+	devm_kfree(&steam->hdev->dev, steam->battery_desc.name);
 }
 
 static int steam_register(struct steam_device *steam)
@@ -1141,38 +1142,41 @@ static int steam_register(struct steam_device *steam)
 
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
@@ -1206,31 +1210,6 @@ static void steam_mode_switch_cb(struct work_struct *work)
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
@@ -1276,7 +1255,7 @@ static int steam_client_ll_open(struct hid_device *hdev)
 	steam->client_opened++;
 	spin_unlock_irqrestore(&steam->lock, flags);
 
-	schedule_work(&steam->unregister_work);
+	schedule_work(&steam->work_connect);
 
 	return 0;
 }
@@ -1291,7 +1270,7 @@ static void steam_client_ll_close(struct hid_device *hdev)
 	steam->client_opened--;
 	spin_unlock_irqrestore(&steam->lock, flags);
 
-	schedule_work(&steam->unregister_work);
+	schedule_work(&steam->work_connect);
 }
 
 static int steam_client_ll_raw_request(struct hid_device *hdev,
@@ -1388,7 +1367,6 @@ static int steam_probe(struct hid_device *hdev,
 		steam->sensor_update_rate_us = 4000;
 	else
 		steam->sensor_update_rate_us = 9000;
-	INIT_WORK(&steam->unregister_work, steam_work_unregister_cb);
 
 	/*
 	 * With the real steam controller interface, do not connect hidraw.
@@ -1450,7 +1428,6 @@ static int steam_probe(struct hid_device *hdev,
 	cancel_delayed_work_sync(&steam->mode_switch);
 	cancel_work_sync(&steam->rumble_work);
 	cancel_delayed_work_sync(&steam->coalesce_rumble_work);
-	cancel_work_sync(&steam->unregister_work);
 
 	return ret;
 }
@@ -1469,7 +1446,6 @@ static void steam_remove(struct hid_device *hdev)
 	cancel_work_sync(&steam->work_connect);
 	cancel_work_sync(&steam->rumble_work);
 	cancel_delayed_work_sync(&steam->coalesce_rumble_work);
-	cancel_work_sync(&steam->unregister_work);
 	steam->client_hdev = NULL;
 	steam->client_opened = 0;
 	if (steam->quirks & STEAM_QUIRK_WIRELESS) {
-- 
2.54.0

