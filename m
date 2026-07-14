Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 382C136402A
	for <linux-input@vger.kernel.org>; Tue, 14 Jul 2026 10:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784023967; cv=none; b=TjOYXpND58XFD4LSTchU/PQTVRu6kDoeJFq25hxBMOJt7rjhjyulmaxc/zSqXRdAmumUv5m4ak1zun10fJZ11fI01+9QCen21avHLivbj+KH1YbyLTkoZOPImqaVgtZ0WcSF/uuIgzFisy8vMqwsGWMJqsr0UAddLOxAoB1ga4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784023967; c=relaxed/simple;
	bh=M3qI+r7hpBN01uwCIPljXnWSlB+ogpkoHJOtqNLrAHI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KygxwnfGuHFn5ER3yNnhbliGXFgxJFjfojbL77NCzRAbVX8P4/fzUtLrOmEvbrqnRtqoZ6uXHANQ/o5aE+k6QcHNR+ZT5zQS+oV5uSLdJSwMfzCdiM6Ty9bGlG+8VZOMnhlMmuqfJYHecvlZZiZ0yQl0AWwXFr1JH73modXAoKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Asd9JoAL; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Asd9JoAL"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-51c4436d02cso4292151cf.1
        for <linux-input@vger.kernel.org>; Tue, 14 Jul 2026 03:12:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784023965; x=1784628765; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qqn3xnPudw35budYpsjbVJww8rbA3LMj5DFGAAy5AaQ=;
        b=Asd9JoALSlBVK6uKuRm7eLe7nkh+GDPhgn5E04lMIpDhWcQP7qhbzKdxs3A+US1Osr
         SspFeZm8RuefzigBvzVse1VDlUiKtn0aviNzFOS+N9DeenAgoA7YDZhnu3Qu9vn8ZGCV
         3xcMseOUnnpugF0cYNOjTjR7TIv5Ty50MvcMcOIzkbsl+4TNQG1T3iq117zyhjDmPZ1P
         pxCMxAFA2O1EFG5l1vyxuFUeb0IOL0ZWEyUFP11LCy7iqV58g0I/JT5UuF5l0iJHonxz
         tb5CWmPtxqP+5m+3adR08rMmNRd5eA1ziuIZCS/iPqOxIpPJPMPE/HY23clG5zrLIKeS
         OcgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784023965; x=1784628765;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=qqn3xnPudw35budYpsjbVJww8rbA3LMj5DFGAAy5AaQ=;
        b=ElrGQkCMnXsT3dYh64LWhMA6o8aS24px5XGUx3S8AEDQHVCyayo+UmQYQHF7KNEEn+
         aCTTDUglgBCO4GX1hajF/N5I4r6B7CtMrz0/K9OGvB7oIOJSF1NwZF3AbEsmyyEdCvcI
         ZFdRe+3m3t+YlEYIbaYhFz7vuQjdTOs0ovoBzIPIzxjEdsq4spQJXcjBWjv3xTomjwvE
         LPz8NoKazjlxCaba821pjTg2ltddqkzsjYy1tqsjCZ8vIPKkPPjHxPGUSWERnQVmnEAU
         e5afGSESLfqwi9j0pwYxtS7ImGxFXUdA3VA4Kzt6/Osbm50vBjJh3TNQ2/nash4Wax0o
         RloA==
X-Forwarded-Encrypted: i=1; AHgh+RqgokFWB/PRuUod85jsPdjFvFwpDmz4aiBVsac3mRd98ISJLokSG0LmrpuY+qCnC6gLKa86Er32nhfpVA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyu0CNaDtWxzbNenqnQF7ylkKzpA8SyUK4FDicQh18z6OjOLbt4
	1rkwwiWQVUUYmwfi0f2WfYdDrneIBNwtPm+w/cSPHrzCKaaHe2Iv8u76
X-Gm-Gg: AfdE7cmkNalsQ4Fl/k/z5qauuwwfIvyKaoDxXIJ61iDRAVb+R/uaXJNCszziycKLNNx
	XhDboforXawJDxSL64mec5JjLftKnqZAnAK3ilblIip2kNzHVTE8x9DpoolEcXvwYHRD6u95E7C
	ttEYVgaxICYfkeefvIAQxI5vO8CmFoSr/f0TBlMLWvVY+NXGwRJQ+wIW5nTcL6Ut5b9cCE2rp8P
	VFh4OhwU7rpETpIhqQ1S9fwmDwn9AorqYa/pusNeMDdFAGBvZ2htBbFteAOO/kmevLJYlM02hE2
	lo1GdjiGehfZ2c7M4tlJ3Xlb54NH54yC7cbt3tyRcpAQ/eUIdmcNI1ljfxIdfZlv3Ne7XFvuwVv
	dgA7lkQOF891ykM93n+TJ8A9lm/3ob4aBsQ7P19zeqxdaGFZ6c3EOF2bO4rk56mc8XgEJsip2qf
	uP0pouF5N27kX6tabxzPkNF+MkxWh06XtSNZ/M6vI6rQgb
X-Received: by 2002:a05:620a:2951:b0:92e:c116:bef3 with SMTP id af79cd13be357-92ef2e69862mr1306029485a.80.1784023964879;
        Tue, 14 Jul 2026 03:12:44 -0700 (PDT)
Received: from FairplayBox ([2601:5cf:837e:d920::f9a2])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92ee5cfcb0dsm1463056185a.25.2026.07.14.03.12.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 03:12:44 -0700 (PDT)
From: Alec Hall <signshop.alec@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	linux-input@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Alec Hall <signshop.alec@gmail.com>
Subject: [PATCH 2/3] HID: magicmouse: report battery over Bluetooth
Date: Tue, 14 Jul 2026 06:12:34 -0400
Message-ID: <20260714101235.99447-3-signshop.alec@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260714101235.99447-1-signshop.alec@gmail.com>
References: <20260714101235.99447-1-signshop.alec@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

magicmouse_fetch_battery() only runs for USB Magic Mouse 2 / Magic
Trackpad 2. Over Bluetooth the kernel never queries the battery and the
power_supply reports 0%, even though the device answers a GET_REPORT for
battery input report 0x90. (A Magic Trackpad 2 appears to work while
charging only because it then pushes battery reports unsolicited; off
the charger the reading goes stale.)

As with hid-apple, the fetch cannot run from the battery timer over
Bluetooth: hid_hw_request() sleeps on the uhid transport, but
magicmouse_battery_timer_tick() runs in atomic softirq context. Move
the periodic fetch to a delayed work item, add magicmouse_has_battery()
and use it to arm the fetch for Magic Mouse 2 / Magic Trackpad 2
regardless of transport, and keep polling once full so the reading
stays current over Bluetooth.

Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Alec Hall <signshop.alec@gmail.com>
---
 drivers/hid/hid-magicmouse.c | 62 +++++++++++++++++++++---------------
 1 file changed, 36 insertions(+), 26 deletions(-)

diff --git a/drivers/hid/hid-magicmouse.c b/drivers/hid/hid-magicmouse.c
index 802a3479e24b..6d0e76314b10 100644
--- a/drivers/hid/hid-magicmouse.c
+++ b/drivers/hid/hid-magicmouse.c
@@ -123,7 +123,7 @@ MODULE_PARM_DESC(report_undeciphered, "Report undeciphered multi-touch state fie
  * @tracking_ids: Mapping of current touch input data to @touches.
  * @hdev: Pointer to the underlying HID device.
  * @work: Workqueue to handle initialization retry for quirky devices.
- * @battery_timer: Timer for obtaining battery level information.
+ * @battery_work: Delayed work for obtaining battery level information.
  */
 struct magicmouse_sc {
 	struct input_dev *input;
@@ -148,7 +148,7 @@ struct magicmouse_sc {
 
 	struct hid_device *hdev;
 	struct delayed_work work;
-	struct timer_list battery_timer;
+	struct delayed_work battery_work;
 };
 
 static int magicmouse_firm_touch(struct magicmouse_sc *msc)
@@ -828,6 +828,19 @@ static bool is_usb_magictrackpad2(__u32 vendor, __u32 product)
 	       product == USB_DEVICE_ID_APPLE_MAGICTRACKPAD2_USBC;
 }
 
+/*
+ * Magic Mouse 2 and Magic Trackpad 2 expose a battery over both USB and
+ * Bluetooth (the pre-2 Magic Mouse/Trackpad do not). Transport-agnostic:
+ * over Bluetooth the vendor is BT_VENDOR_ID_APPLE but the product id matches.
+ */
+static bool magicmouse_has_battery(struct hid_device *hdev)
+{
+	return hdev->product == USB_DEVICE_ID_APPLE_MAGICMOUSE2 ||
+	       hdev->product == USB_DEVICE_ID_APPLE_MAGICMOUSE2_USBC ||
+	       hdev->product == USB_DEVICE_ID_APPLE_MAGICTRACKPAD2 ||
+	       hdev->product == USB_DEVICE_ID_APPLE_MAGICTRACKPAD2_USBC;
+}
+
 static int magicmouse_fetch_battery(struct hid_device *hdev)
 {
 #ifdef CONFIG_HID_BATTERY_STRENGTH
@@ -836,9 +849,7 @@ static int magicmouse_fetch_battery(struct hid_device *hdev)
 	struct hid_battery *bat;
 
 	bat = hid_get_battery(hdev);
-	if (!bat ||
-	    (!is_usb_magicmouse2(hdev->vendor, hdev->product) &&
-	     !is_usb_magictrackpad2(hdev->vendor, hdev->product)))
+	if (!bat || !magicmouse_has_battery(hdev))
 		return -1;
 
 	report_enum = &hdev->report_enum[bat->report_type];
@@ -847,9 +858,6 @@ static int magicmouse_fetch_battery(struct hid_device *hdev)
 	if (!report || report->maxfield < 1)
 		return -1;
 
-	if (bat->capacity == bat->max)
-		return -1;
-
 	hid_hw_request(hdev, report, HID_REQ_GET_REPORT);
 	return 0;
 #else
@@ -857,15 +865,21 @@ static int magicmouse_fetch_battery(struct hid_device *hdev)
 #endif
 }
 
-static void magicmouse_battery_timer_tick(struct timer_list *t)
+static void magicmouse_battery_work(struct work_struct *work)
 {
-	struct magicmouse_sc *msc = timer_container_of(msc, t, battery_timer);
+	struct magicmouse_sc *msc = container_of(work, struct magicmouse_sc,
+						 battery_work.work);
 	struct hid_device *hdev = msc->hdev;
 
-	if (magicmouse_fetch_battery(hdev) == 0) {
-		mod_timer(&msc->battery_timer,
-			  jiffies + secs_to_jiffies(USB_BATTERY_TIMEOUT_SEC));
-	}
+	/*
+	 * Runs in process context (workqueue), so the battery GET_REPORT may
+	 * sleep. This is required for the uhid/Bluetooth transport, whose
+	 * raw_request blocks on userspace -- unlike a timer_list callback,
+	 * which runs in atomic softirq context and would deadlock.
+	 */
+	if (magicmouse_fetch_battery(hdev) == 0)
+		schedule_delayed_work(&msc->battery_work,
+				      secs_to_jiffies(USB_BATTERY_TIMEOUT_SEC));
 }
 
 static int magicmouse_probe(struct hid_device *hdev,
@@ -900,12 +914,10 @@ static int magicmouse_probe(struct hid_device *hdev,
 		return ret;
 	}
 
-	if (is_usb_magicmouse2(id->vendor, id->product) ||
-	    is_usb_magictrackpad2(id->vendor, id->product)) {
-		timer_setup(&msc->battery_timer, magicmouse_battery_timer_tick, 0);
-		mod_timer(&msc->battery_timer,
-			  jiffies + secs_to_jiffies(USB_BATTERY_TIMEOUT_SEC));
-		magicmouse_fetch_battery(hdev);
+	if (magicmouse_has_battery(hdev)) {
+		INIT_DELAYED_WORK(&msc->battery_work, magicmouse_battery_work);
+		/* Kick an initial fetch; the work re-arms itself each timeout. */
+		schedule_delayed_work(&msc->battery_work, 0);
 	}
 
 	if (is_usb_magicmouse2(id->vendor, id->product) ||
@@ -973,9 +985,8 @@ static int magicmouse_probe(struct hid_device *hdev,
 
 	return 0;
 err_stop_hw:
-	if (is_usb_magicmouse2(id->vendor, id->product) ||
-	    is_usb_magictrackpad2(id->vendor, id->product))
-		timer_delete_sync(&msc->battery_timer);
+	if (magicmouse_has_battery(hdev))
+		cancel_delayed_work_sync(&msc->battery_work);
 
 	hid_hw_stop(hdev);
 	return ret;
@@ -987,9 +998,8 @@ static void magicmouse_remove(struct hid_device *hdev)
 
 	if (msc) {
 		cancel_delayed_work_sync(&msc->work);
-		if (is_usb_magicmouse2(hdev->vendor, hdev->product) ||
-		    is_usb_magictrackpad2(hdev->vendor, hdev->product))
-			timer_delete_sync(&msc->battery_timer);
+		if (magicmouse_has_battery(hdev))
+			cancel_delayed_work_sync(&msc->battery_work);
 	}
 
 	hid_hw_stop(hdev);
-- 
2.55.0

