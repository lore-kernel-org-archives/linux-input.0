Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8C8136C9D0
	for <linux-input@vger.kernel.org>; Tue, 12 May 2026 19:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778614950; cv=none; b=bZtBshlxTzmY/WkSI5zyw6TbbIj8gUki8M5C65GLCB2GLMNxoePiPJcjiAz34ncruKcJzptIF030CCMBkzsD3JDcNz+pacWuqA5TWAdJw7O5Da1uKVml9Ui10nCyv60Cng7b0/XSJqZocElo8OnRQ9MsnVxLuwB9UKFZZQynPyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778614950; c=relaxed/simple;
	bh=2yDjn/mPjYhoF47aYYve4JaLOl4qQZFKvb74hkBb4dU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JbHdu/EbVjF2wdf5wVusYQdx2R58alJ4degPeRe56dxx+uJyWTWI9KjkSMz3OH5SVzK9mt6Hiw+WmgaQsYRZiciy/cTj+h7o5bSwVrm1CLqHi30GKY72zUn5GFoit333uo6nT/a9m7VsPagU4KXN1qy6SGSOHo5MMQzUaUQzlM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=URtDK6vt; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="URtDK6vt"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-488ad135063so48302275e9.0
        for <linux-input@vger.kernel.org>; Tue, 12 May 2026 12:42:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778614947; x=1779219747; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BssEr2hsUTBZdPDbGY3lvasib/t48VWuCs3XjnpwqR4=;
        b=URtDK6vtu+zKwq52fHeGv6ivrhmjExasItIPWCqlsY+LdCi51Q6MviRtpug8BY51c/
         jiBcQB0HBFdaVrJjfq62PQUwyMo8aBEDNVehy2ypkYbdf9mXNC3PGy+Z3IY0FE/1P/et
         mSsC/zUMBTNnLbcsNJerqAFKKFUwgcY90jSNGoX09vYQN2MgNOQvHypgCGAftqDwZMHi
         HrheWTZeg89BlC2cTFxMe7OVEhNJVDlgjiXGW+jzHatqCkHkrtR7XzmU0w9iLcl2dNsL
         0yIenQI36xboSLjj0p3h4sU6Lb21bFoOVjYXOCqO8jj4ig/4Ax155xKpKjj+GszkYOST
         Q7qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778614947; x=1779219747;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BssEr2hsUTBZdPDbGY3lvasib/t48VWuCs3XjnpwqR4=;
        b=fgBGbXkNe83dvC1dgBkeSoSjL6wnQK3EsKi6GIYZe43tFBSA+XWWvj8B+mtFFwd/OV
         yX+Z9hLw7UrXhJ/3hovRYQgHDeHtiulqAo2nIpvI6m8ZpJ9YDzSyWr4W3CDn30hmCRGf
         Qf4dvVPGKqZ3PNJVzLExSJitt/tJgNEZd0d2neG+lZTrW5kZrZSUMVj19IYLUUEfhrYh
         uRjiv8KbiHdhxd9KxMiidZHWA1I30gn3V3hA42GbCZdBVX8Ucoo58iiMYKDHWYpZJTBw
         9k9mpiQudaD+lTkRsWFXxiaIDPS+7kZu5aMWJIwZ6KFz4mOHe8gsxSf4w0em3NKbWCeX
         2qQA==
X-Gm-Message-State: AOJu0Yyck2ypbmYVC9y7xq5VreQLebtwYN59JmFYjnQnFFEB+FNV5CO2
	caJJLoo/NCPRk3B2AMg0l7CLqJpEAfGreSR6hYOAvDbfvkr/ZLBI8uVynmdtYL3F
X-Gm-Gg: Acq92OG/BrGqzyP+u9dGOcIxGxeMKwB0c5yNo8VGF98ph5iAHH7+hxsxCgVnsDfWqjT
	B0PLTA04owNxEQIt+2owUKEOWfe8U1bGp1hmgSkKM1l74MqbxFDqtmdDwUsnNQjwJrB0zaWaBMw
	uZ6OpWun2g6IdIog2y8lMQpLWv5yarfBK2Mc5OGFnNgKME/NN/gztro+/QGb8ClmgivugjO2W+P
	71qlLfqmvPGIcomgibZs0uMVvSTsepfPKB/svthmJ7FTk4T4FZJWkJA1hsPuybuSs012uFkCEYS
	UsPhNYcbE9Dryi0LDfd3F+Zpuv4kjuEGdm+ywXFCkK8SRhl4FoP1Qa/jBQYam0MkK3h4ufAGZ4b
	13rxCU+NqE/b3wnYObyG9PZ3XgLyEi0QxhUwYe3Pj1sRHZdsYZTIOAkaFRsxj/8jNLEekqUN/h5
	nis2zMPwV9rDsrk+aHb1Gb5NScLuVo
X-Received: by 2002:a05:600c:a4b:b0:48e:7f1c:8776 with SMTP id 5b1f17b1804b1-48fc9a516e3mr3923975e9.25.1778614946925;
        Tue, 12 May 2026 12:42:26 -0700 (PDT)
Received: from laptop ([2a07:7e81:6fe7:0:52c8:3131:c313:3115])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fc8d625basm15726755e9.9.2026.05.12.12.42.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 12:42:26 -0700 (PDT)
From: Dmitri Ollari <dimoolla200@gmail.com>
X-Google-Original-From: Dmitri Ollari <dmitri.ollari@protonmail.com>
To: linux-input@vger.kernel.org
Cc: jikos@kernel.org,
	Dmitri Ollari <dmitri.ollari@protonmail.com>
Subject: [PATCH v2] HID: magicmouse: fix battery reporting for 2024 Magic Trackpad USB-C
Date: Tue, 12 May 2026 21:36:56 +0200
Message-ID: <20260512194150.227920-1-dmitri.ollari@protonmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260411163806.35759-1-dmitri.ollari@protonmail.com>
References: <20260411163806.35759-1-dmitri.ollari@protonmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The 2024 Magic Trackpad USB-C (PID 0x0324) does not report battery
strength via HID descriptor fields over Bluetooth. Instead it requires
an explicit HID_REQ_GET_REPORT request to retrieve the battery level.

Replace the battery_timer (timer_list) with battery_work (delayed_work)
so that HID_REQ_GET_REPORT can be issued from a sleepable context.
Timers run in atomic context and cannot block, which caused deadlocks
on the Bluetooth transport path.

Extend the fetch guard and probe scheduling block to include the 2024
Magic Trackpad USB-C when connected over Bluetooth.

Schedule battery_work immediately at probe (delay=0) instead of
issuing a direct magicmouse_fetch_battery() call. The direct call
bypassed the cold-start correction logic and could publish a stale
value before the work handler had a chance to validate it.

Add a cold-start double-poll: the device may return a stale battery
value (e.g. 4%) on the very first GET_REPORT after power-on. On the
first successful poll battery_validated is set and a second poll is
scheduled 3 seconds later to obtain the real value. Subsequent polls
use the normal 60-second interval.

Remove the early-return guard that skipped polling when
battery_capacity equalled battery_max. This prevented the second
corrective poll from firing when the first stale response happened
to equal 100.

Signed-off-by: Dmitri Ollari <dmitri.ollari@protonmail.com>
---
v2:
  - Rebased onto v7.1-rc3
  - Fixed email line-wrapping and whitespace damage
  - Removed PGP signing

 drivers/hid/hid-magicmouse.c | 57 ++++++++++++++++++++++--------------
 1 file changed, 35 insertions(+), 22 deletions(-)

diff --git a/drivers/hid/hid-magicmouse.c b/drivers/hid/hid-magicmouse.c
index e70bd3dc07ab..1d7c84ecadbb 100644
--- a/drivers/hid/hid-magicmouse.c
+++ b/drivers/hid/hid-magicmouse.c
@@ -123,7 +123,10 @@ MODULE_PARM_DESC(report_undeciphered, "Report undeciphered multi-touch state fie
  * @tracking_ids: Mapping of current touch input data to @touches.
  * @hdev: Pointer to the underlying HID device.
  * @work: Workqueue to handle initialization retry for quirky devices.
- * @battery_timer: Timer for obtaining battery level information.
+ * @battery_work: Delayed work for periodic battery level polling.
+ * @battery_validated: Set after the first successful poll; gates the
+ *	second poll that corrects the stale value the device may report
+ *	on cold start.
  */
 struct magicmouse_sc {
 	struct input_dev *input;
@@ -148,7 +151,8 @@ struct magicmouse_sc {
 
 	struct hid_device *hdev;
 	struct delayed_work work;
-	struct timer_list battery_timer;
+	struct delayed_work battery_work;
+	bool battery_validated;
 };
 
 static int magicmouse_firm_touch(struct magicmouse_sc *msc)
@@ -822,7 +826,8 @@ static int magicmouse_fetch_battery(struct hid_device *hdev)
 	bat = hid_get_battery(hdev);
 	if (!bat ||
 	    (!is_usb_magicmouse2(hdev->vendor, hdev->product) &&
-	     !is_usb_magictrackpad2(hdev->vendor, hdev->product)))
+	     !is_usb_magictrackpad2(hdev->vendor, hdev->product) &&
+	     hdev->product != USB_DEVICE_ID_APPLE_MAGICTRACKPAD2_USBC))
 		return -1;
 
 	report_enum = &hdev->report_enum[bat->report_type];
@@ -831,9 +836,6 @@ static int magicmouse_fetch_battery(struct hid_device *hdev)
 	if (!report || report->maxfield < 1)
 		return -1;
 
-	if (bat->capacity == bat->max)
-		return -1;
-
 	hid_hw_request(hdev, report, HID_REQ_GET_REPORT);
 	return 0;
 #else
@@ -841,14 +843,25 @@ static int magicmouse_fetch_battery(struct hid_device *hdev)
 #endif
 }
 
-static void magicmouse_battery_timer_tick(struct timer_list *t)
+static void magicmouse_battery_work(struct work_struct *work)
 {
-	struct magicmouse_sc *msc = timer_container_of(msc, t, battery_timer);
+	struct magicmouse_sc *msc = container_of(work, struct magicmouse_sc, battery_work.work);
 	struct hid_device *hdev = msc->hdev;
 
 	if (magicmouse_fetch_battery(hdev) == 0) {
-		mod_timer(&msc->battery_timer,
-			  jiffies + secs_to_jiffies(USB_BATTERY_TIMEOUT_SEC));
+		if (!msc->battery_validated) {
+			/*
+			 * The device may return a stale value (e.g. 4%) on the
+			 * first GET_REPORT after cold start. Schedule a second
+			 * poll shortly after to get the real value, then settle
+			 * into the normal 60s interval.
+			 */
+			msc->battery_validated = true;
+			schedule_delayed_work(&msc->battery_work, secs_to_jiffies(3));
+		} else {
+			schedule_delayed_work(&msc->battery_work,
+					      secs_to_jiffies(USB_BATTERY_TIMEOUT_SEC));
+		}
 	}
 }
 
@@ -868,6 +881,7 @@ static int magicmouse_probe(struct hid_device *hdev,
 	msc->scroll_accel = SCROLL_ACCEL_DEFAULT;
 	msc->hdev = hdev;
 	INIT_DEFERRABLE_WORK(&msc->work, magicmouse_enable_mt_work);
+	INIT_DELAYED_WORK(&msc->battery_work, magicmouse_battery_work);
 
 	msc->quirks = id->driver_data;
 	hid_set_drvdata(hdev, msc);
@@ -885,11 +899,15 @@ static int magicmouse_probe(struct hid_device *hdev,
 	}
 
 	if (is_usb_magicmouse2(id->vendor, id->product) ||
-	    is_usb_magictrackpad2(id->vendor, id->product)) {
-		timer_setup(&msc->battery_timer, magicmouse_battery_timer_tick, 0);
-		mod_timer(&msc->battery_timer,
-			  jiffies + secs_to_jiffies(USB_BATTERY_TIMEOUT_SEC));
-		magicmouse_fetch_battery(hdev);
+	    is_usb_magictrackpad2(id->vendor, id->product) ||
+	    id->product == USB_DEVICE_ID_APPLE_MAGICTRACKPAD2_USBC) {
+		/*
+		 * Schedule immediately so battery_work runs ASAP, sets
+		 * battery_validated, then reschedules every 60s. Avoids
+		 * direct fetch which bypasses battery_validated and would
+		 * publish a stale startup value.
+		 */
+		schedule_delayed_work(&msc->battery_work, 0);
 	}
 
 	if (is_usb_magicmouse2(id->vendor, id->product) ||
@@ -957,10 +975,7 @@ static int magicmouse_probe(struct hid_device *hdev,
 
 	return 0;
 err_stop_hw:
-	if (is_usb_magicmouse2(id->vendor, id->product) ||
-	    is_usb_magictrackpad2(id->vendor, id->product))
-		timer_delete_sync(&msc->battery_timer);
-
+	cancel_delayed_work_sync(&msc->battery_work);
 	hid_hw_stop(hdev);
 	return ret;
 }
@@ -971,9 +986,7 @@ static void magicmouse_remove(struct hid_device *hdev)
 
 	if (msc) {
 		cancel_delayed_work_sync(&msc->work);
-		if (is_usb_magicmouse2(hdev->vendor, hdev->product) ||
-		    is_usb_magictrackpad2(hdev->vendor, hdev->product))
-			timer_delete_sync(&msc->battery_timer);
+		cancel_delayed_work_sync(&msc->battery_work);
 	}
 
 	hid_hw_stop(hdev);
-- 
2.54.0

