Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 922573E0251
	for <linux-input@vger.kernel.org>; Tue, 30 Jun 2026 17:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782840588; cv=none; b=cycmJOkipyOphadhrRkF4b+kxM85+bf6Qtma3ZvVBYBN2D8DXcDNy87qhbBnhw8HGBWtRjCKS/uWiH1OwKA/W4OUhXWtbTgL6mvO4OkQcqvQEv8NKd07YtJnerm9h/+BC0Rs6XIxJnfdJX4FySvystfc/HEeLjjazZryJNg94vY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782840588; c=relaxed/simple;
	bh=mKSuNJavbO3Evf1ogweLPnqXUKfOxfMIoZyGEsyGv7s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u9qAXtoytCBaNq21G2D56nZBvoduj1jH2IoZM8pCNgQvkPOeroTmfptlPXBUAZ4MqX13tlpYGZhr/20Bf/bTH/DXN3XFjX3AvXG1Nlm7aRZ4ToL0CrZ4mOQCPjq+vRZLkYwVxLYElaNRFkY8jVJRNbiEJa7C4LqjOzIxCkYYZrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cB4Mcd8/; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cB4Mcd8/"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-915ab38ac14so589020785a.0
        for <linux-input@vger.kernel.org>; Tue, 30 Jun 2026 10:29:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782840586; x=1783445386; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x8OH6duiJjGogXFXnElM71wCDu9pQp62uFHUJbqPoaU=;
        b=cB4Mcd8/Z4POqwKQtmBdikITEZFTxPs9CL9kzOuGgU8PQWzppNOV0+UGw7seUVYhRk
         ZJtamwf4lfu2r9a91h0cw/CFyAB2m+uL/Y741yp+eAhe3CqhZSwqRzjaeuA0D1eQ6IXX
         oPy0mmz8MQQQMEgSGIpJNuOpWyBu3qnvgY7JYQ6z5+lUPA89zd6UM/NaoKUS9Fec6RtE
         PXH9GiL/4mTXb3oc/L6H2e8OcHUfL1l5uDfHw6KaaFV2GEhxp1Rht0jMj4HxGYJOUPWc
         rkfqhPSs1HKMz3eLkpe/PCPQZl1HoSRE0ZcBmV2ubzHS+IH7IDDFrBLmPD5B/Swq03Kd
         ZlUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782840586; x=1783445386;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=x8OH6duiJjGogXFXnElM71wCDu9pQp62uFHUJbqPoaU=;
        b=cwa7uNIyr4J8ypENULlvX0+47BJzs05AcVlOxUuVAnWzkybEEDPxoLr2QDWBzPC4ob
         TKv3UFVtzvbAP/bXVn4GeqDC69amlI25/JkXrG0asT8mGp0cpoM9PZm3k3/3QoPQuUWa
         FY2sFcN4ygskk3byJOp9gbUtVp3ZXINu4Ia6vEod7cqnp3VheKeGNDOM7QgQQrKi2MhM
         xB+2vCV3GMpqz+jKFpnyB+SDc7L3lb0fLS9RLMhT6ck6fAKiQXZy27fExiXn8cPzLSrt
         VTGdToSvYB1KkJWw8MU92CJnv0nmalWpR5KJihUGSDrtyJmd18DGKTXKt9sn1AQ19Svh
         WFtQ==
X-Gm-Message-State: AOJu0YxvkY3olWczm0gKBInYAe7LSs7KObsi5zIaKVnHFEgBBr6YLPuX
	AzjiUhH12V+xWl9jTgkb+jS36Y61X5SQ9AyeX+lv7/YbG78cfKQX+51T
X-Gm-Gg: AfdE7cnqrQ+q7ZNIsX1FdIvqFtAFsrKo54gXlLH/jFtbA3x3i4s8Z6KkbV0OwGTiJCt
	AyLOwsLZ4ECyaNFy/UMAu0S51BUOF7b+V9pFDJCzbW9K089xwrB8vBPAIoaduQo/nTsGFqSPKc2
	jw6oXbCLJSm61GR0AQsxrahsiJzAQl3PMiBaGtCMXULlAD8GHG7BKywC5yVuIRBsoLyivrtC3Kh
	YdTt5qo2uDzzZmO1Pj+7wzo1O/UwM+kp+9Xt8cbGuJPiXHKaNqULI8bF0oz0QoTrjvKvi+q0vkk
	FBw9WYSVF/OBh3CYZaLef4oOEAhsph4IEXe20FDd5/8CsIrSW2xhKOf6LZ+ycK49RP4eq9d4oqh
	njnSbgD+k6+zo672Tc5K65ZAAtqsowmZp2PM/qmyIiL+1NgJtVmlxzCspMcu2opulo0zT+jNzSf
	XUiFZOOH9biAdU3R2YQZQyecD9RSwRbGBAaeRhH509YfHo0IgI
X-Received: by 2002:a05:620a:1793:b0:92b:6805:9184 with SMTP id af79cd13be357-92e6d8fcba3mr274283985a.60.1782840585572;
        Tue, 30 Jun 2026 10:29:45 -0700 (PDT)
Received: from achantapc.mynetworksettings.com ([2600:4040:122a:dd00:da6a:a6e4:2464:e6a1])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8f1a69c32cdsm29822906d6.31.2026.06.30.10.29.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 10:29:45 -0700 (PDT)
From: Sriman Achanta <srimanachanta@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bastien Nocera <hadess@hadess.net>,
	Simon Wood <simon@mungewell.org>,
	Christian Mayer <git@mayer-bgk.de>,
	Sriman Achanta <srimanachanta@gmail.com>
Subject: [PATCH v5 8/9] HID: steelseries: Add async status interface support
Date: Tue, 30 Jun 2026 13:29:29 -0400
Message-ID: <c993054229da167e96332fc142d372091e8c7406.1782840133.git.srimanachanta@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1782840133.git.srimanachanta@gmail.com>
References: <cover.1782840133.git.srimanachanta@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some headsets expose a second HID interface that sends battery and
connection updates on its own. Watching that interface lets the driver
stop polling the sync interface. Add a
steelseries_device_info::async_interface field and the code to handle
it:

  - The driver binds both the sync and async interfaces. The async
    interface shares the steelseries_device created by the sync
    interface. It finds the sibling with usb_ifnum_to_if(), takes a
    reference, and returns -EPROBE_DEFER until the sync interface has
    probed. If the sync interface never binds, the async interface
    defers forever, which is fine here.
  - raw_event() now holds sd->lock and re-checks sd->removed so events
    on either interface are serialised against removal.
  - status_work runs once for async devices instead of rearming. A
    single status request is sent when the headset connects to get the
    initial battery level.

No device sets async_interface yet. This is the infrastructure for the
next commit.

Signed-off-by: Sriman Achanta <srimanachanta@gmail.com>
---
 drivers/hid/hid-steelseries-arctis.c | 137 +++++++++++++++++++++------
 1 file changed, 110 insertions(+), 27 deletions(-)

diff --git a/drivers/hid/hid-steelseries-arctis.c b/drivers/hid/hid-steelseries-arctis.c
index 6c745058f70e..689435c60ecb 100644
--- a/drivers/hid/hid-steelseries-arctis.c
+++ b/drivers/hid/hid-steelseries-arctis.c
@@ -26,6 +26,7 @@ struct steelseries_device_info {
 	unsigned long capabilities;
 
 	u8 sync_interface;
+	u8 async_interface;
 
 	int (*request_status)(struct hid_device *hdev);
 	void (*parse_status)(struct steelseries_device *sd, u8 *data, int size);
@@ -271,7 +272,8 @@ static void steelseries_status_timer_work_handler(struct work_struct *work)
 	sd->info->request_status(sd->hdev);
 
 	spin_lock_irqsave(&sd->lock, flags);
-	if (!sd->removed)
+	/* Async devices push status events themselves; only poll once. */
+	if (!sd->removed && !sd->info->async_interface)
 		schedule_delayed_work(&sd->status_work,
 				msecs_to_jiffies(STEELSERIES_HEADSET_STATUS_TIMEOUT_MS));
 	spin_unlock_irqrestore(&sd->lock, flags);
@@ -318,6 +320,32 @@ static int steelseries_battery_register(struct steelseries_device *sd)
 	return 0;
 }
 
+static struct hid_driver steelseries_arctis_driver;
+
+static struct steelseries_device *
+steelseries_get_sibling_sd(struct hid_device *hdev, int interface_num)
+{
+	struct usb_interface *intf = to_usb_interface(hdev->dev.parent);
+	struct usb_device *usb_dev = interface_to_usbdev(intf);
+	struct usb_interface *sibling_intf;
+	struct hid_device *sibling_hdev;
+	struct steelseries_device *sd;
+
+	sibling_intf = usb_ifnum_to_if(usb_dev, interface_num);
+	if (!sibling_intf)
+		return NULL;
+
+	sibling_hdev = usb_get_intfdata(sibling_intf);
+	if (!sibling_hdev || sibling_hdev->driver != &steelseries_arctis_driver)
+		return NULL;
+
+	sd = hid_get_drvdata(sibling_hdev);
+	if (sd)
+		kref_get(&sd->refcnt);
+
+	return sd;
+}
+
 static int steelseries_arctis_probe(struct hid_device *hdev,
 				    const struct hid_device_id *id)
 {
@@ -339,43 +367,81 @@ static int steelseries_arctis_probe(struct hid_device *hdev,
 	if (ret)
 		return ret;
 
-	/* Let hid-generic handle non-sync interfaces */
-	if (interface_num != info->sync_interface)
+	/* Let hid-generic handle non-vendor or unknown interfaces */
+	if (interface_num != info->sync_interface &&
+	    (!info->async_interface || interface_num != info->async_interface))
 		return hid_hw_start(hdev, HID_CONNECT_DEFAULT);
 
-	sd = kzalloc_obj(*sd, GFP_KERNEL);
-	if (!sd)
-		return -ENOMEM;
-
-	kref_init(&sd->refcnt);
-	sd->hdev = hdev;
-	sd->info = info;
-	spin_lock_init(&sd->lock);
+	if (interface_num == info->sync_interface) {
+		sd = kzalloc_obj(*sd, GFP_KERNEL);
+		if (!sd)
+			return -ENOMEM;
+
+		kref_init(&sd->refcnt);
+		sd->hdev = hdev;
+		sd->info = info;
+		spin_lock_init(&sd->lock);
+		INIT_DELAYED_WORK(&sd->status_work, steelseries_status_timer_work_handler);
+
+		ret = hid_hw_start(hdev, HID_CONNECT_DEFAULT);
+		if (ret)
+			goto err_free;
+
+		ret = hid_hw_open(hdev);
+		if (ret)
+			goto err_stop;
+
+		if (info->capabilities & SS_CAP_BATTERY) {
+			ret = steelseries_battery_register(sd);
+			if (ret < 0)
+				hid_warn(hdev, "Failed to register battery: %d\n", ret);
+		}
 
-	hid_set_drvdata(hdev, sd);
+		/*
+		 * Publish drvdata only once fully initialised: the async sibling
+		 * attaches by reading it, so it must never observe a half-built or
+		 * failed instance. A failed probe never gets here, so the error
+		 * path below has nothing to unpublish.
+		 */
+		hid_set_drvdata(hdev, sd);
+		schedule_delayed_work(&sd->status_work, msecs_to_jiffies(100));
 
-	ret = hid_hw_start(hdev, HID_CONNECT_DEFAULT);
-	if (ret)
-		goto err_put;
+		return 0;
+	}
 
-	ret = hid_hw_open(hdev);
-	if (ret)
-		goto err_stop;
+	/*
+	 * The async interface shares the steelseries_device created by the
+	 * sync interface. Defer until the sync interface has probed and
+	 * published its drvdata.
+	 */
+	if (info->async_interface && interface_num == info->async_interface) {
+		sd = steelseries_get_sibling_sd(hdev, info->sync_interface);
+		if (!sd)
+			return -EPROBE_DEFER;
+
+		hid_set_drvdata(hdev, sd);
+
+		ret = hid_hw_start(hdev, HID_CONNECT_DEFAULT);
+		if (ret) {
+			kref_put(&sd->refcnt, steelseries_device_release);
+			return ret;
+		}
 
-	if (info->capabilities & SS_CAP_BATTERY) {
-		ret = steelseries_battery_register(sd);
-		if (ret < 0)
-			hid_warn(hdev, "Failed to register battery: %d\n", ret);
+		ret = hid_hw_open(hdev);
+		if (ret) {
+			hid_hw_stop(hdev);
+			kref_put(&sd->refcnt, steelseries_device_release);
+			return ret;
+		}
+		return 0;
 	}
 
-	INIT_DELAYED_WORK(&sd->status_work, steelseries_status_timer_work_handler);
-	schedule_delayed_work(&sd->status_work, msecs_to_jiffies(100));
-
-	return 0;
+	return -ENODEV;
 
 err_stop:
 	hid_hw_stop(hdev);
-err_put:
+err_free:
+	/* drvdata is unpublished until full success, so no sibling can hold sd. */
 	kref_put(&sd->refcnt, steelseries_device_release);
 	return ret;
 }
@@ -428,10 +494,21 @@ static int steelseries_arctis_raw_event(struct hid_device *hdev,
 	u8 old_capacity;
 	bool old_connected;
 	bool old_charging;
+	bool is_async_interface;
+	unsigned long flags;
 
 	if (!sd)
 		return 0;
 
+	is_async_interface = (hdev != sd->hdev);
+
+	spin_lock_irqsave(&sd->lock, flags);
+
+	if (sd->removed) {
+		spin_unlock_irqrestore(&sd->lock, flags);
+		return 0;
+	}
+
 	old_capacity = sd->battery_capacity;
 	old_connected = sd->headset_connected;
 	old_charging = sd->battery_charging;
@@ -444,6 +521,10 @@ static int steelseries_arctis_raw_event(struct hid_device *hdev,
 			old_connected ? "" : "not ",
 			sd->headset_connected ? "" : "not ");
 
+		if (sd->headset_connected && !old_connected &&
+		    sd->info->async_interface && is_async_interface)
+			schedule_delayed_work(&sd->status_work, 0);
+
 		if (sd->battery) {
 			steelseries_headset_set_wireless_status(sd->hdev,
 							       sd->headset_connected);
@@ -467,6 +548,8 @@ static int steelseries_arctis_raw_event(struct hid_device *hdev,
 			power_supply_changed(sd->battery);
 	}
 
+	spin_unlock_irqrestore(&sd->lock, flags);
+
 	return 0;
 }
 
-- 
2.54.0

