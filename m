Received: from endrift.com (endrift.com [173.255.198.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18A482DC331
	for <linux-input@vger.kernel.org>; Wed, 29 Jul 2026 01:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.255.198.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785290052; cv=none; b=V1hP+sQlk1W6Pb5MeoqwKafr0OcX73hiD8MWJMIRdOdtsXHNfrXmAb7eKDGWBHypQuh3ihctfFooqZECUCE2BcT7bvf1De5ckjwMvZnIOCGFkk039Ggr8x19L2fAj2uCtUKcRjz7VbcvPiJVTtslNI3BsMK+HefsoPXlCvDiV/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785290052; c=relaxed/simple;
	bh=v/aPisqvYN94eBU++HJiN5kaFTCX2u2ZUzZ73RTFD4M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Hwq0ZHlsGPaeotbFKjjjVGeaeZLH8FWLSCwvYG5XV31iFcjkYZJZdI96WG6HVe1h7iJlEI862PASUjlY/knuFNSZbWin838penxcrRojGE7JH1weYGZ2fG9+ySap93gNq2PmDfuKDybhy+TamSuKpNEgALCLyR77QQ46VX+xWbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endrift.com; spf=pass smtp.mailfrom=endrift.com; dkim=pass (2048-bit key) header.d=endrift.com header.i=@endrift.com header.b=M70fiQnZ; arc=none smtp.client-ip=173.255.198.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endrift.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=endrift.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=endrift.com header.i=@endrift.com header.b="M70fiQnZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=endrift.com; s=2020;
	t=1785290047; bh=v/aPisqvYN94eBU++HJiN5kaFTCX2u2ZUzZ73RTFD4M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=M70fiQnZkeR5DGQbTxsZx8I1VnxN7VDGiIpCAlg2paOcEvym+55g/JFP3SR2AaBcR
	 IdXSjkQYh2I92qdVEVTxgB2Jjp1NBKPzVDoCfflxqTS/jIaRqJ6rRmSuf4LxScQ6oz
	 OwRmdEYwXhsrkYXYknw+eRwg+IKlmNwELiZwdrjBroqqOfpkKifgpsIp4f7H1OPYKT
	 3q88JT0klfJiPHjcckmKZYWJTQhAUeKdkvYizboSYmTHikd8xR6B90znJDjQ0Fz9i9
	 VF2YPhJ7s4DctMdWbfhWpuamSt1Ltphxs45WT7Cve2NFzTGiulFmP1iKK3+NJ/FUKS
	 3pc15B/EdxLWg==
Received: from microtis.vulpes.eutheria.net (71-212-73-87.tukw.qwest.net [71.212.73.87])
	by endrift.com (Postfix) with ESMTPSA id CD827A148;
	Tue, 28 Jul 2026 18:54:06 -0700 (PDT)
From: Vicki Pfau <vi@endrift.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	linux-input@vger.kernel.org
Cc: Vicki Pfau <vi@endrift.com>,
	Yousef Alhouseen <alhouseenyousef@gmail.com>
Subject: [PATCH v4 08/11] HID: steam: Rearrange teardown sequence
Date: Tue, 28 Jul 2026 18:52:30 -0700
Message-ID: <20260729015243.1170573-9-vi@endrift.com>
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

This fixes a narrow window during the teardown sequence where callbacks
could still be scheduled during cleanup that would then have a dangling
pointer to the now-freed steam struct.

This also puts work canceling for rumble and mode switch in
steam_unregister, as that shouldn't persist while the client hdev is open.

Signed-off-by: Vicki Pfau <vi@endrift.com>
---
 drivers/hid/hid-steam.c | 67 ++++++++++++++++++++++-------------------
 1 file changed, 36 insertions(+), 31 deletions(-)

diff --git a/drivers/hid/hid-steam.c b/drivers/hid/hid-steam.c
index ff112aa1b0e9..5ab4396a241e 100644
--- a/drivers/hid/hid-steam.c
+++ b/drivers/hid/hid-steam.c
@@ -1150,6 +1150,9 @@ static void steam_unregister(struct steam_device *steam)
 	steam_battery_unregister(steam);
 	steam_sensors_unregister(steam);
 	steam_input_unregister(steam);
+	cancel_work_sync(&steam->rumble_work);
+	cancel_delayed_work_sync(&steam->mode_switch);
+	cancel_delayed_work_sync(&steam->coalesce_rumble_work);
 	mutex_lock(&steam_devices_lock);
 	list_del_init(&steam->list);
 	mutex_unlock(&steam_devices_lock);
@@ -1327,6 +1330,7 @@ static int steam_probe(struct hid_device *hdev,
 {
 	struct steam_device *steam;
 	int ret;
+	unsigned long flags;
 
 	ret = hid_parse(hdev);
 	if (ret) {
@@ -1352,6 +1356,14 @@ static int steam_probe(struct hid_device *hdev,
 	if (!steam)
 		return -ENOMEM;
 
+	/*
+	 * With the real steam controller interface, do not connect hidraw.
+	 * Instead, create the client_hid and connect that.
+	 */
+	ret = hid_hw_start(hdev, HID_CONNECT_DEFAULT & ~HID_CONNECT_HIDRAW);
+	if (ret)
+		return ret;
+
 	steam->hdev = hdev;
 	hid_set_drvdata(hdev, steam);
 	spin_lock_init(&steam->lock);
@@ -1368,22 +1380,6 @@ static int steam_probe(struct hid_device *hdev,
 	else
 		steam->sensor_update_rate_us = 9000;
 
-	/*
-	 * With the real steam controller interface, do not connect hidraw.
-	 * Instead, create the client_hid and connect that.
-	 */
-	ret = hid_hw_start(hdev, HID_CONNECT_DEFAULT & ~HID_CONNECT_HIDRAW);
-	if (ret)
-		goto err_cancel_work;
-
-	ret = hid_hw_open(hdev);
-	if (ret) {
-		hid_err(hdev,
-			"%s:hid_hw_open\n",
-			__func__);
-		goto err_hw_stop;
-	}
-
 	if (steam->quirks & STEAM_QUIRK_WIRELESS) {
 		hid_info(hdev, "Steam wireless receiver connected");
 		/* If using a wireless adaptor ask for connection status */
@@ -1397,14 +1393,22 @@ static int steam_probe(struct hid_device *hdev,
 			hid_err(hdev,
 				"%s:steam_register failed with error %d\n",
 				__func__, ret);
-			goto err_hw_close;
+			goto err_hw_stop;
 		}
 	}
 
+	ret = hid_hw_open(hdev);
+	if (ret) {
+		hid_err(hdev,
+			"%s:hid_hw_open\n",
+			__func__);
+		goto err_steam_unregister;
+	}
+
 	steam->client_hdev = steam_create_client_hid(hdev);
 	if (IS_ERR(steam->client_hdev)) {
 		ret = PTR_ERR(steam->client_hdev);
-		goto err_steam_unregister;
+		goto err_hw_close;
 	}
 	steam->client_hdev->driver_data = steam;
 
@@ -1416,18 +1420,20 @@ static int steam_probe(struct hid_device *hdev,
 
 err_destroy:
 	hid_destroy_device(steam->client_hdev);
-err_steam_unregister:
-	if (steam->connected)
-		steam_unregister(steam);
 err_hw_close:
 	hid_hw_close(hdev);
-err_hw_stop:
-	hid_hw_stop(hdev);
-err_cancel_work:
+err_steam_unregister:
+	spin_lock_irqsave(&steam->lock, flags);
+	steam->client_opened = 0;
+	spin_unlock_irqrestore(&steam->lock, flags);
 	cancel_work_sync(&steam->work_connect);
+	if (steam->connected)
+		steam_unregister(steam);
 	cancel_delayed_work_sync(&steam->mode_switch);
+err_hw_stop:
 	cancel_work_sync(&steam->rumble_work);
 	cancel_delayed_work_sync(&steam->coalesce_rumble_work);
+	hid_hw_stop(hdev);
 
 	return ret;
 }
@@ -1435,25 +1441,24 @@ static int steam_probe(struct hid_device *hdev,
 static void steam_remove(struct hid_device *hdev)
 {
 	struct steam_device *steam = hid_get_drvdata(hdev);
+	unsigned long flags;
 
 	if (!steam || hdev->group == HID_GROUP_STEAM) {
 		hid_hw_stop(hdev);
 		return;
 	}
 
+	hid_hw_close(hdev);
 	hid_destroy_device(steam->client_hdev);
-	cancel_delayed_work_sync(&steam->mode_switch);
-	cancel_work_sync(&steam->work_connect);
-	cancel_work_sync(&steam->rumble_work);
-	cancel_delayed_work_sync(&steam->coalesce_rumble_work);
-	steam->client_hdev = NULL;
+	spin_lock_irqsave(&steam->lock, flags);
 	steam->client_opened = 0;
+	spin_unlock_irqrestore(&steam->lock, flags);
+	cancel_work_sync(&steam->work_connect);
 	if (steam->quirks & STEAM_QUIRK_WIRELESS) {
 		hid_info(hdev, "Steam wireless receiver disconnected");
 	}
-	hid_hw_close(hdev);
-	hid_hw_stop(hdev);
 	steam_unregister(steam);
+	hid_hw_stop(hdev);
 }
 
 static void steam_do_connect_event(struct steam_device *steam, bool connected)
-- 
2.54.0

