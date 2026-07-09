Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC49D393DDD
	for <linux-input@vger.kernel.org>; Thu,  9 Jul 2026 03:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783567430; cv=none; b=Da9RQQOWZ9xJhugmWBt2dmwJma9V960uVdn4DXUVb02FxcW9Ltpp8tVPMe9Ehwhw4+ba5JTQ2KOi9Vpl8xkyrpRmNJl1XNdJKI2Kl9WeAfM7xG2M7aAZCTU0EcEqq3jMFzByMeTMISnbKnWf6fgEkX5c21PdHg5iFQldgFBI3Q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783567430; c=relaxed/simple;
	bh=zT7kTdHN4P3nf+TCkI8kd8HYSaJzCwr0xWStlQ6gZRA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I2/eMbsWZuZ1FBq+k0jD8bM673G8xZctFL45CTkPoPfhRWMSQCYz5C+0SFV8A2fUdbR7XZFdMK2Pkj/crk+tniG7zgH/Xy6TQH52FywBlZ+REirqMctIqrp6FOmSi6pT3vTYYoGSEYjBSs0jZK0evhoA34jk3jJ6OOpihCZjUDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A/pDSvzT; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A/pDSvzT"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-92e7632b193so79844285a.2
        for <linux-input@vger.kernel.org>; Wed, 08 Jul 2026 20:23:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783567428; x=1784172228; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bUrfuNP6dOqO85ElllUHoH5HU6wC2zxU1nHR887AKfc=;
        b=A/pDSvzT2ucs+rKA35DEoQ17afcvy5HSjTSuue6wpIIlnGG0hs+GydQ1FVFdSEDbhO
         0MpWedABlVPz8AWx440ywxkSbtn4eLAhVBcLVZKSFmTzEZ4mZCcZ/C23D70PRuvPLb1T
         Bje8P5zduY+zKsPkxMhE6n9TssEgmZIvcO5hExgRigXztbt5+lhOVkJMRyMOlSDzlmmx
         TxfdlSz/w9HrVJgHGrUParbNrHI6iaeDE3GVrDcxsC3uYrp6cIgFRh6u4Podqt492gX3
         opBwao2sF6AQEJTNT96ZICtgD+S3AdXHWIeqXuJK/CPjXAe6ics3kVMZvN0LQNsrefk4
         W5JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783567428; x=1784172228;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=bUrfuNP6dOqO85ElllUHoH5HU6wC2zxU1nHR887AKfc=;
        b=l0SK/PsiXY8zOJ1Lw3azZb91X9dZZ1hYB2yT/dQ0YAxTQPGIWKgDh99A6o4E7LFdDH
         sVluSyFJ8EpcqFsZMh9pSSsJIvvTP9HBkKBlO2a7sMk04kQ07hcgO4yU82N7wX+OJjWS
         xC3WrJLoF6M36a6LLVB3bcIAiuNA6eY7m3kueoa1F8uHEXrcTp205BcLDcAYGG3G1VOZ
         AuhFzT93yNR0TTLzFOEyTWA15gmuNSBLVT1RaBj9xrZpLki9gm6tFmPtIcN0agcQubfE
         TBHOqB3CpSuB1jqi0uyAsiRN7sxBYUE5XxcWoc1uIswsNo3WLOjiD6rBOt6b56RvfDtU
         AVLA==
X-Gm-Message-State: AOJu0Yyq3AUZ6uBOZYMajrCWeQN6F5XP1LajGwep8+CdYQZMYHaOYEG6
	lNMn7kt8VeEFo/Cj6TnTbYcZ+MD7pROU4YgWq/WAR8W6rnGwpPOMCNh3
X-Gm-Gg: AfdE7cnf//q8obnY0rFV3dDFra8yaysYb5cHsaXC00OnDVJBzsumUr+wnxYAzb3+Evw
	od0zOsd3zRLe0TFkAXoR5BdPIehk7Wset7W5oyhR+aicG8SL1UNWGymteP/jWHT5A979plSLZNU
	ELkyc8whZfl/vw0sj3s1cN7mZP1BntvqBUc7NF8z/bf8+SBc2Wx43oUYZRi0TbCjzz3QAMz/bpR
	BplnzeX9fLUQoSmkA6ojrP4o7bOrcEpyxs1h/SbFDrQYWFuK611THEDPt/ELXiCbumZdHj/Zr6g
	czvqEfUd9cKGaxljdlEMLOPWprxMbTv0s5aceVRx1emt3Uj49IPA+0wtjfUm4W61wkuy28E1h7P
	ybpmM9lNrS5P8HFVg3prctBhXLH6RtrBu+bDRhEpjPwPR78/2ycClUZ9skvD9qb3R1RMtJMHyHI
	Yo941g5CW64Mmf6LR0//fPImL2/wIxCrrwbliTyX19OR6RzPL/0fvJiztQFUfvNvkelkMekbq8k
	3ruJ0Sw
X-Received: by 2002:a05:620a:3195:b0:915:68dd:1eff with SMTP id af79cd13be357-92ecf68c95amr629644485a.50.1783567427867;
        Wed, 08 Jul 2026 20:23:47 -0700 (PDT)
Received: from achantapc.mynetworksettings.com ([2600:4040:122a:dd00:da6a:a6e4:2464:e6a1])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92e9c0f7de9sm1336872185a.26.2026.07.08.20.23.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 20:23:47 -0700 (PDT)
From: Sriman Achanta <srimanachanta@gmail.com>
X-Google-Original-From: Sriman Achanta <68172138+srimanachanta@users.noreply.github.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bastien Nocera <hadess@hadess.net>,
	Simon Wood <simon@mungewell.org>,
	Christian Mayer <git@mayer-bgk.de>,
	Sriman Achanta <srimanachanta@gmail.com>
Subject: [PATCH v6 8/9] HID: steelseries: Add async status interface support
Date: Wed,  8 Jul 2026 23:23:15 -0400
Message-ID: <20260709032316.1908460-9-68172138+srimanachanta@users.noreply.github.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260709032316.1908460-1-68172138+srimanachanta@users.noreply.github.com>
References: <20260709032316.1908460-1-68172138+srimanachanta@users.noreply.github.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sriman Achanta <srimanachanta@gmail.com>

Some headsets expose a second HID interface that sends battery and
connection updates on its own. Watching that interface lets the driver
stop polling the sync interface. Add a
steelseries_device_info::async_interface field and the code to handle
it:

  - The driver binds both the sync and async interfaces. The async
    interface shares the steelseries_device created by the sync
    interface. It finds the sibling with usb_ifnum_to_if(), and before
    trusting its intfdata it rejects non-HID siblings by descriptor
    class and holds the sibling's device lock across the lookup, so a
    crafted device cannot cause a type-confused read and a concurrent
    unbind cannot free the hid_device from under it. It then takes a
    reference and returns -EPROBE_DEFER until the sync interface has
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
 drivers/hid/hid-steelseries-arctis.c | 158 ++++++++++++++++++++++-----
 1 file changed, 131 insertions(+), 27 deletions(-)

diff --git a/drivers/hid/hid-steelseries-arctis.c b/drivers/hid/hid-steelseries-arctis.c
index e534aa44e70a..9960c0ec512b 100644
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
@@ -318,6 +320,53 @@ static int steelseries_battery_register(struct steelseries_device *sd)
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
+	struct steelseries_device *sd = NULL;
+
+	sibling_intf = usb_ifnum_to_if(usb_dev, interface_num);
+	if (!sibling_intf)
+		return NULL;
+
+	/*
+	 * usb_get_intfdata() only yields a hid_device when usbhid is bound;
+	 * gate on the descriptor class so a non-HID sibling (e.g. a crafted
+	 * device exposing storage or audio here) is never treated as one.
+	 */
+	if (sibling_intf->cur_altsetting->desc.bInterfaceClass != USB_INTERFACE_CLASS_HID)
+		return NULL;
+
+	/*
+	 * Take the sibling's device lock across the intfdata read and the
+	 * kref_get so a concurrent unbind cannot free the hid_device underneath
+	 * us; usbhid leaves intfdata dangling on disconnect, so dev.driver is
+	 * the reliable "still bound" test under this lock. Use device_trylock()
+	 * to stay off the lockdep chain of the interface being probed and let
+	 * the caller retry via -EPROBE_DEFER if the sibling is momentarily busy.
+	 */
+	if (!device_trylock(&sibling_intf->dev))
+		return NULL;
+	if (sibling_intf->dev.driver) {
+		sibling_hdev = usb_get_intfdata(sibling_intf);
+		if (sibling_hdev &&
+		    sibling_hdev->driver == &steelseries_arctis_driver) {
+			sd = hid_get_drvdata(sibling_hdev);
+			if (sd)
+				kref_get(&sd->refcnt);
+		}
+	}
+	device_unlock(&sibling_intf->dev);
+
+	return sd;
+}
+
 static int steelseries_arctis_probe(struct hid_device *hdev,
 				    const struct hid_device_id *id)
 {
@@ -339,43 +388,81 @@ static int steelseries_arctis_probe(struct hid_device *hdev,
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
@@ -428,10 +515,21 @@ static int steelseries_arctis_raw_event(struct hid_device *hdev,
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
@@ -444,6 +542,10 @@ static int steelseries_arctis_raw_event(struct hid_device *hdev,
 			old_connected ? "" : "not ",
 			sd->headset_connected ? "" : "not ");
 
+		if (sd->headset_connected && !old_connected &&
+		    sd->info->async_interface && is_async_interface)
+			schedule_delayed_work(&sd->status_work, 0);
+
 		if (sd->battery) {
 			steelseries_headset_set_wireless_status(sd->hdev,
 							       sd->headset_connected);
@@ -467,6 +569,8 @@ static int steelseries_arctis_raw_event(struct hid_device *hdev,
 			power_supply_changed(sd->battery);
 	}
 
+	spin_unlock_irqrestore(&sd->lock, flags);
+
 	return 0;
 }
 
-- 
2.55.0

