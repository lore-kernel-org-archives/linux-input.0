Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CE08435EFE
	for <linux-input@vger.kernel.org>; Mon,  3 Aug 2026 19:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785784566; cv=none; b=IqsjsSXmui9L0e4s7dMnVTkwSVuvSgnxsy2zGSCwbnT+H4Cr7NcLeHXQXbScRFRWkBstgadjKaj9VSjEETlgSfaMSRtqqa67lbcLbRngUfJlREXdQqjbzLS/V9UtqAM1Ks6VDjE3EpbK1j4LTDr7c8CP7743OQdM85BN1onjd5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785784566; c=relaxed/simple;
	bh=rgiOAxrws7HtpWLSKi4FZUyJEZqLol8aZnFJ5cEkP1Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t1pGEcDsYZhUjv/a7JfhDuBoV9J6ge8fr/NVrbbAOymtmkXjdsGHbDajfKBI+jrMIG4lY71lQ5CR8cjaigzB5c22+ciGxLTGnWcQRXqM+Pbw5mfLZfRFATa08Of8GRXmxLEStuB/ZUqcjmumqXaP/kZ2KlVxUBE4Pmh0RGTu+fY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NImpVHgM; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NImpVHgM"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-526f963372aso22301161cf.1
        for <linux-input@vger.kernel.org>; Mon, 03 Aug 2026 12:16:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785784562; x=1786389362; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=geHMteasP6UB71yeWgSjp/T6tZ4uWNyLwhqzRYexiv0=;
        b=NImpVHgMJDPfCn7cTyLmi4Hy6lrosZkm+ripuPY+l6nwVjEfZT+60iLEMYX7asvVh0
         vr2SCRmLtJo7mkr21WwRX+YW2POwz4q9n8LvncvRfU2pdyxjwCJk5Rh96P7Okdns3Ay4
         fnh9LzkHwRACPT31emJMq3EclblNdq6pZ5PhE72TC9z1VGzwZHim/8a/Wk4NrvxoTtYm
         l3G7a4s4MNkX7cTWhG6TO8qKcp6d0yZS6Jo+qOunRi/fJwcV/1x1R36VTT7MCEGYF8NK
         5Og4hSnYfLlKcjjRau2fjHoGjxl/EojZB4awrA8Gx2kmO2223i4EVO/xP+qZvqqY44/r
         KaxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785784562; x=1786389362;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=geHMteasP6UB71yeWgSjp/T6tZ4uWNyLwhqzRYexiv0=;
        b=OkwZAqxdTHNNNBHozLimzdY8te81lLxv88OEC1k0wd3PYdKDFH21GYg5KTJTpjvj5C
         1WRfl05Mrh3unHKFsU/a3fDjjYFnAk/tRLE8T9aX5hSGiKAMZ+Mlga92x8Z0dciSudOQ
         ckpWoM8qjR6/Hbj9F4MJXG1AQdhTbPthUSpvFKFQZzBxdfH15AiaYd26M6PE6k0Bk/ZN
         XBIYx1OMUwYaeJiCKbNWMkz2e4KifdVrhcd5iVBjxCQ8SrTJesmAc277n6TWERp1tN14
         8TqV0O1t4Q/sFdnBAkax/pU81IUewxdpFWq9Lr0YjF4lRTZDJiLxFS4bf5e5JSYWqncS
         0mfg==
X-Gm-Message-State: AOJu0YzEWuaQa2kZqbm4VEBFZQFUPMBEmr6Sj8kC0KAtVO7QIu9Az6gt
	9G5105fGJaPfrK5ogauKWoDHZeWBpIFmut+hXwGXS+LBHJxBwTjEzk7t
X-Gm-Gg: AR+sD11zPGsOI5c7IP7HbkxANOQ4zaVCdkQs9aXM5DdJjFeJxIz9RbqOvqVAqqK66Gk
	fhBQ6Zy0YrZ50aBsALKSAzdw5mFZmury8kb6eKFPRz15R/OX4MvgDHJAVyRnHoQn0iC3S84ucG8
	bqRFYCo1252kFNg/9deyN5qXYyke+kLK+viMYIe1HzMwBY9LF5BgYr3sf1vPpqF/RqO0daaw5Ff
	CrTeZJ2yWrdo41AbQmRaB5XKAXnhcybcz/jWHn11T458cCiPjj/uGZhNbcgE9uhySi6/U1JWqlN
	GN2ZwH9ZkNd1x4qh0ofW6w95UqmAqGbSBOp4/k5wjWyYUby8yMEmN5PXUjNT3XrTKGI1BztPobN
	ifpSZcY+wuLmTNDPqf51oow88ZEW+6v2xQGfgkeMG82FSjy3OBG3FU5I6mS4Obk91cCG6Ed8kCZ
	klCTlSbKOSOiOFDg+xUUyArKPMlPTCQukq18MjzEvH6EkcelzCe/KHVm5gr/xXFYN3SJFq4wjlc
	ZqV384C/wvcaDdRRyc=
X-Received: by 2002:a05:622a:1e0e:b0:51c:1bb9:137f with SMTP id d75a77b69052e-52b56776470mr219645181cf.24.1785784561685;
        Mon, 03 Aug 2026 12:16:01 -0700 (PDT)
Received: from achantapc.tail227c81.ts.net ([2600:4040:122e:7d00:f04d:e0df:fe04:e789])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-52b4e64df9bsm67803541cf.0.2026.08.03.12.16.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 12:16:01 -0700 (PDT)
From: Sriman Achanta <srimanachanta@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bastien Nocera <hadess@hadess.net>,
	Simon Wood <simon@mungewell.org>,
	Christian Mayer <git@mayer-bgk.de>,
	Sriman Achanta <srimanachanta@gmail.com>
Subject: [PATCH v7 7/8] HID: steelseries: Add async status interface support
Date: Mon,  3 Aug 2026 15:15:52 -0400
Message-ID: <20260803191553.66368-8-srimanachanta@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260803191553.66368-1-srimanachanta@gmail.com>
References: <20260803191553.66368-1-srimanachanta@gmail.com>
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

