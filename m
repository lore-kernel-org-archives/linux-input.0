Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCCB138E5DC
	for <linux-input@vger.kernel.org>; Tue, 23 Jun 2026 17:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782235402; cv=none; b=nePx79hcRZD5EJYSAwBtUWTXgsdk/0/xZJhMkt0e8jBW13+oD8S+bKxTQAJpqlkNQ8qHTnN+AD4+qDy9VQDynNIVc4dZLOc3m15VmsBp1qFPvCBsBVpKXd9V+WUW294RXVzVMo6bq5FpO6z9i0GzJY4nB4nKrJF8/Ry9xyn1VNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782235402; c=relaxed/simple;
	bh=5sQlbeFI8cyApWCjx8nktmxTD0MRAZjD7L3pz3SRJR4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lF0BCeO9jcD2NUjt0MoMKBBP40UBZHMt8yBs0kmIjOHCnmmCw+tXhXjxcd+/YPWL4LjduEzDSsM639QbPMcDJq1k1PD5uI5573KK0Kr2aysCq0tJej/Lx7CkTMrGSQmJ9HBl9WmuXd2MhgMpoHR4cjblS1430PJt0BQtCEaiUBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WtWTsmEj; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WtWTsmEj"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-51a1fe8f578so109591cf.2
        for <linux-input@vger.kernel.org>; Tue, 23 Jun 2026 10:23:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782235400; x=1782840200; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CC9uw0U9l70gRh7X4E8leOAl28Flmwa2bdYh8pY671Y=;
        b=WtWTsmEj1M9pueJ+L3V+sVft2LulqOzqyO2ZM1mvZ1f71N3dk1FcBwmEOF7MZZPp7D
         1Hbh4VUmIogOU4cObNjvO4kfYjCQYmBB9Sg/c9wfvD3bl/+uBWNuVESor4ORJSd0fhAF
         XbFCrsikfT83eDA30qeWr7HsMWZuVMJBS9rAIlbxbnWd/HtFJcj8hEVdnehrkVNkY2rk
         /ATtO6tGNwtE2zRpjH6/18IwrJVyYxypiS5B2refM7ZJZ32aYitsz5pCt8ggjU2ENTUv
         RgZGSEG3BXj9JjVkShuaBmNb4ZWVVO7gIG7cZu9O48Dbd7aar2jh1Q5uQXwi+b13KpAT
         KQ1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782235400; x=1782840200;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CC9uw0U9l70gRh7X4E8leOAl28Flmwa2bdYh8pY671Y=;
        b=DB0cZUEYcyS3fpMnmV+tBpiIxVSvaEdzEENV6tfYANf+/9cQ6ahwpkexdwBaWB3Xeu
         aMegNbvSzRVkWYGXdBnzGFtOBHN0t9eW5BHYjBz0jccMPKCAGFDc97wqRTOKu8Zoo3E9
         pG+W/3DJuwWKWb/M718YI2mca7D/ZCtj0yiTZX5CKrrPB/THO2dXBF32xAn0iCwApvn9
         sjRWEyqetOkpRR5LwvTghlUUybQtpFq3L2u0/362ZBSeCUJpZOS8860HStF3eWR0vsbj
         h8nTrcbDFrXDsy6UZi8ktgdy58U/3U73rB9Y7qtpi/YkJY/ImMjaUmvnyAHgjtmJCPAo
         cXDw==
X-Gm-Message-State: AOJu0YypmFEBQyp9Xgpwq4NUaCfW7xMRTp2upgNhcJ3vlT64cs1Rw4H6
	z2D69dre/Mok6c2YF0A+8pkCBB63EtnKW/gsaDX0yFAwMnnsx5i27f/e
X-Gm-Gg: AfdE7ckOcQXvddeeCJ3SpkSxyS7bN6xDgi+Qyz322rB5RkfQZ5I0Jlk6g863VBEDANF
	EkTYYmcFoNnnCz6lftZ7yhgCvIKxMbdur68KuHCNLS7+8gJxMBoXySk0NHLm1AXAxKdIBRzsjNR
	2GbH11WWtKfA2phXUCV9f8DTIVqvlarrkVcUr/MTSkWqfRL3erHedJgdNIzDJWNcQLrROUfctUF
	jt1sl6bRdj8oJlZjXBlTCcNR8k2eU327Apk4pQebHqXZn0s8VxfE7GB7HZuSzRPCSSyenuFj38H
	qYTlERMuAvlOpTAIjxfTd50jX4pi2fYQqi9iEtuE7XEI0ajHV6x3p2fiCvZX+zA/5zZPcZf3IeG
	Nm8uJaEG/lYc8nL84f/ZD5KLKWxkgAJccfQkcyHCM/2Yve0Gj7YipS1YrFVJF4gN/t1bon1kig/
	mZSZaq7TFcRvUyMl8CRdf5jxzB0vuZfEsLiCchaObbsyGmaVcUyJpxqb+utx4=
X-Received: by 2002:ac8:5c8f:0:b0:50d:82db:773e with SMTP id d75a77b69052e-51a54890e6amr55359511cf.47.1782235399835;
        Tue, 23 Jun 2026 10:23:19 -0700 (PDT)
Received: from achantapc.mynetworksettings.com ([2600:4040:124c:e000:ff10:313f:67f6:deeb])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51a515c72c1sm29390531cf.10.2026.06.23.10.23.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2026 10:23:19 -0700 (PDT)
From: Sriman Achanta <srimanachanta@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Simon Wood <simon@mungewell.org>,
	Christian Mayer <git@mayer-bgk.de>,
	Bastien Nocera <hadess@hadess.net>,
	Sriman Achanta <srimanachanta@gmail.com>
Subject: [PATCH v4 09/10] HID: steelseries: Add async status interface support
Date: Tue, 23 Jun 2026 13:23:09 -0400
Message-ID: <20260623172310.272708-10-srimanachanta@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260623172310.272708-1-srimanachanta@gmail.com>
References: <20260623172310.272708-1-srimanachanta@gmail.com>
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
 drivers/hid/hid-steelseries-arctis.c | 121 +++++++++++++++++++++------
 1 file changed, 97 insertions(+), 24 deletions(-)

diff --git a/drivers/hid/hid-steelseries-arctis.c b/drivers/hid/hid-steelseries-arctis.c
index 734cf1eb8789..2208d0e4cd2a 100644
--- a/drivers/hid/hid-steelseries-arctis.c
+++ b/drivers/hid/hid-steelseries-arctis.c
@@ -26,6 +26,7 @@ struct steelseries_device_info {
 	unsigned long capabilities;
 
 	u8 sync_interface;
+	u8 async_interface;
 
 	int (*request_status)(struct hid_device *hdev);
 	void (*parse_status)(struct steelseries_device *sd, u8 *data, int size);
@@ -272,7 +273,8 @@ static void steelseries_status_timer_work_handler(struct work_struct *work)
 	sd->info->request_status(sd->hdev);
 
 	spin_lock_irqsave(&sd->lock, flags);
-	if (!sd->removed)
+	/* Async devices push status events themselves; only poll once. */
+	if (!sd->removed && !sd->info->async_interface)
 		schedule_delayed_work(&sd->status_work,
 				msecs_to_jiffies(STEELSERIES_HEADSET_STATUS_TIMEOUT_MS));
 	spin_unlock_irqrestore(&sd->lock, flags);
@@ -316,6 +318,23 @@ static int steelseries_battery_register(struct steelseries_device *sd)
 	return 0;
 }
 
+static struct hid_device *steelseries_get_sibling_hdev(struct hid_device *hdev,
+						       int interface_num)
+{
+	struct usb_interface *intf = to_usb_interface(hdev->dev.parent);
+	struct usb_device *usb_dev = interface_to_usbdev(intf);
+	struct usb_interface *sibling_intf;
+	struct hid_device *sibling_hdev;
+
+	sibling_intf = usb_ifnum_to_if(usb_dev, interface_num);
+	if (!sibling_intf)
+		return NULL;
+
+	sibling_hdev = usb_get_intfdata(sibling_intf);
+
+	return sibling_hdev;
+}
+
 static int steelseries_arctis_probe(struct hid_device *hdev,
 				    const struct hid_device_id *id)
 {
@@ -337,39 +356,76 @@ static int steelseries_arctis_probe(struct hid_device *hdev,
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
+	if (interface_num == info->sync_interface) {
+		sd = kzalloc_obj(*sd, GFP_KERNEL);
+		if (!sd)
+			return -ENOMEM;
 
-	kref_init(&sd->refcnt);
-	sd->hdev = hdev;
-	sd->info = info;
-	spin_lock_init(&sd->lock);
+		kref_init(&sd->refcnt);
+		sd->hdev = hdev;
+		sd->info = info;
+		spin_lock_init(&sd->lock);
 
-	hid_set_drvdata(hdev, sd);
+		hid_set_drvdata(hdev, sd);
 
-	ret = hid_hw_start(hdev, HID_CONNECT_DEFAULT);
-	if (ret)
-		goto err_put;
+		ret = hid_hw_start(hdev, HID_CONNECT_DEFAULT);
+		if (ret)
+			goto err_put;
 
-	ret = hid_hw_open(hdev);
-	if (ret)
-		goto err_stop;
+		ret = hid_hw_open(hdev);
+		if (ret)
+			goto err_stop;
+
+		if (info->capabilities & SS_CAP_BATTERY) {
+			ret = steelseries_battery_register(sd);
+			if (ret < 0)
+				hid_warn(hdev, "Failed to register battery: %d\n", ret);
+		}
 
-	if (info->capabilities & SS_CAP_BATTERY) {
-		ret = steelseries_battery_register(sd);
-		if (ret < 0)
-			hid_warn(hdev, "Failed to register battery: %d\n", ret);
+		INIT_DELAYED_WORK(&sd->status_work, steelseries_status_timer_work_handler);
+		schedule_delayed_work(&sd->status_work, msecs_to_jiffies(100));
+
+		return 0;
 	}
 
-	INIT_DELAYED_WORK(&sd->status_work, steelseries_status_timer_work_handler);
-	schedule_delayed_work(&sd->status_work, msecs_to_jiffies(100));
+	/*
+	 * The async interface shares the steelseries_device created by the
+	 * sync interface. Defer until the sync interface has probed and
+	 * published its drvdata.
+	 */
+	if (info->async_interface && interface_num == info->async_interface) {
+		struct hid_device *master_hdev;
 
-	return 0;
+		master_hdev = steelseries_get_sibling_hdev(hdev, info->sync_interface);
+
+		if (!master_hdev || !hid_get_drvdata(master_hdev))
+			return -EPROBE_DEFER;
+
+		sd = hid_get_drvdata(master_hdev);
+		kref_get(&sd->refcnt);
+		hid_set_drvdata(hdev, sd);
+
+		ret = hid_hw_start(hdev, HID_CONNECT_DEFAULT);
+		if (ret) {
+			kref_put(&sd->refcnt, steelseries_device_release);
+			return ret;
+		}
+
+		ret = hid_hw_open(hdev);
+		if (ret) {
+			hid_hw_stop(hdev);
+			kref_put(&sd->refcnt, steelseries_device_release);
+			return ret;
+		}
+		return 0;
+	}
+
+	return -ENODEV;
 
 err_stop:
 	hid_hw_stop(hdev);
@@ -426,10 +482,21 @@ static int steelseries_arctis_raw_event(struct hid_device *hdev,
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
@@ -442,6 +509,10 @@ static int steelseries_arctis_raw_event(struct hid_device *hdev,
 			old_connected ? "" : "not ",
 			sd->headset_connected ? "" : "not ");
 
+		if (sd->headset_connected && !old_connected &&
+		    sd->info->async_interface && is_async_interface)
+			schedule_delayed_work(&sd->status_work, 0);
+
 		if (sd->battery) {
 			steelseries_headset_set_wireless_status(sd->hdev,
 							       sd->headset_connected);
@@ -465,6 +536,8 @@ static int steelseries_arctis_raw_event(struct hid_device *hdev,
 			power_supply_changed(sd->battery);
 	}
 
+	spin_unlock_irqrestore(&sd->lock, flags);
+
 	return 0;
 }
 
-- 
2.54.0

