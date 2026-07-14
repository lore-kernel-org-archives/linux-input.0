Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65C14350285
	for <linux-input@vger.kernel.org>; Tue, 14 Jul 2026 10:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784023966; cv=none; b=GfIxr5Ecltbq7kA1Ypdyrv43VmfCFi/tGyiyfs0t4m18VEBBw+PNN7HcS5CHA1RUKF8ZHwytxPlMsfr5P4RzogqP7x+8CkKZr0m1zlVofPBgQpiIm7CzHNjMBbtmW9Yzpkl458opwVjEWUtexOWiG7C1sqThI9PRjfwfsRM2G1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784023966; c=relaxed/simple;
	bh=J0UlSkJ/Kgu/J9BJDifAWIGP6dDakAVWK8bjDCL9MFk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sw3Db4kUbhwV+5QwMBuGrwSb2ecmjnrjTYjBr83r8UzTysp6Mz3JyVdy7LILRnteU3EE5R5D7ya0X6raifnWgjMg0bchXU+KNXVCrpIuLOS4Kc4hQ0S3W+cYbl6RDEl3LWLykV1yh2ABFx1Pbh6AWli5Dd/jxsLiY4ZbKwYbBEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IcOe5LWU; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IcOe5LWU"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-92f0b5ed131so127796085a.3
        for <linux-input@vger.kernel.org>; Tue, 14 Jul 2026 03:12:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784023964; x=1784628764; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fboD69W58/lw8bBMlFoHEiwTIiYQTbtsU798kq+SBeI=;
        b=IcOe5LWUapRxVKKpJfudAmM/2Df97Ie6W8nmqdILq54R2RoMOLLXUPoUQLkBv1Vw8Q
         BZJ+IeC33ZW/E5Uksnsm5qo0ME7iSvtoNe++PZ7NZgk3HHzfEgvuM377mFa08Bn76S6i
         73jrdUTpU4pPcZPWrF8Hc6LaW+FbKkILOPVcumF+4VK51lyvK1NA0AeCdj2AI84ri7z9
         Fg6734Xe8fG3dOdFXQYORN1ZpL6tyIn9UiWe2tekrOUZLVKOqes9aV/4lnndkSYjNHVa
         cXYm/sgKeF7qkPk4xl24PMk8rbbXtZfXW3LFbvEz1/kwBFNniSg25/l0m0+p2q5XyQ0s
         RG4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784023964; x=1784628764;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=fboD69W58/lw8bBMlFoHEiwTIiYQTbtsU798kq+SBeI=;
        b=pZzTQttHGsq60ApvDHln7fSB/IRauC76b1PckeNDafxTKDE3SWoTbdh63lu019WOXV
         kwkuIOQqMFDgoLTNVOrLcIMa91kNgOHQrJcpMdDl4twfpsovDW56HgxecrikDJGXFdwo
         21maYPUzM1VydTeQzz5PjzdeIt8D5qbR7N7QqUTTsdCi2654KQZsH+4G1BPjx4EI6dVt
         m+jfnM2doDQl+7ItTLezLAkjvvTMN1Lb6ygyLg2r7iNxcUTJ64Guzl57vVDyfl+dGJTA
         7w/T7LyUYtxIKIPcXC9LFirfI8/oEq/Wsf0Bk/ct4rMnUMW1oceMmeRWZ4ob9Mn0QdL6
         7kYQ==
X-Forwarded-Encrypted: i=1; AHgh+RqrogWEsR1wMa1UKLuhq7Vm+jkkMOI54o1er18U6QQ4LDRbhoUJqpIUXw/gZWo2Ii+LTp6stZyEEjxS2Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YxkHtCVn5yrUDgI3eNeTkw+PpT8FSH3Oi8Owuv3+F2tUdr1gLIb
	8nb/ecv+9LGUHOvQH/IBnppP7t46ZOuG30n2j4WvB6jr3TDeHyB0PL0bcYZA7uJyg82pzw==
X-Gm-Gg: AfdE7cmsKjoN0Iv9ZrloQwr6p2zzalTuYNNmB2elhQEpf/MO3WoiGi9wtQh+vqu3UiK
	af8upfikbd3fDxeQVMVQVRPpQCNUXK74uJQC3yFPNro/JE+dmU/SqUlGEuKNWKfZL4iUe5QTe+W
	cV6l1aCKkXK5QWM8hSaEhgQ/BHxbANt09mY/d+zkw0koopDhvOepXHGVxyXXgvlx9t/ouezd5Rb
	3mMwsc9Lyejf0VKCLc1ikl9HKcRNimPSCeQaZFA1B1eKCnl5k7J2/V/V/ubEG2Zg65+ZFiWxCxI
	MeRTAEsCRwASUDpJNCE1FUfZqht1b8zfCKY0k72pVwWHC0V1PT1EvzFD+8fWip6KyIwm78kFcr1
	6gm65RkB2BDDV7v4vtsd0WOY92woFfkUbStndgAaq+3ZCXbdXs8u64zQKDrEBU+sqfXor6SUO05
	bUIoKndnaRp1B5fPxNo91WCClD+ZmD5M6E6+Nh5mKqUF6v
X-Received: by 2002:a05:620a:4056:b0:92e:cc01:a67e with SMTP id af79cd13be357-92ef2ccac2emr1323685285a.76.1784023964155;
        Tue, 14 Jul 2026 03:12:44 -0700 (PDT)
Received: from FairplayBox ([2601:5cf:837e:d920::f9a2])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92ee5cfcb0dsm1463056185a.25.2026.07.14.03.12.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 03:12:43 -0700 (PDT)
From: Alec Hall <signshop.alec@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	linux-input@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Alec Hall <signshop.alec@gmail.com>
Subject: [PATCH 1/3] HID: apple: report Magic Keyboard battery over Bluetooth
Date: Tue, 14 Jul 2026 06:12:33 -0400
Message-ID: <20260714101235.99447-2-signshop.alec@gmail.com>
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

The Magic Keyboard answers a GET_REPORT for battery input report 0x90
over Bluetooth exactly as it does over USB, but battery reporting was
only ever enabled for USB: the Bluetooth device-table entry lacks the
APPLE_RDESC_BATTERY quirk, so apple_fetch_battery() returns early and
the kernel's power_supply is stuck at 0%.

The USB-only restriction is not cosmetic. apple_fetch_battery() issues
its GET_REPORT through hid_hw_request(), and over Bluetooth that goes
through the uhid transport, whose raw_request sleeps waiting on user
space. The fetch was driven from a timer callback
(apple_battery_timer_tick), which runs in atomic softirq context where
sleeping is forbidden, so requesting the battery there deadlocks the
machine:

    run_timer_softirq
     __run_timer_base
      apple_battery_timer_tick
       __hid_request
        uhid_hid_raw_request   /* sleeps in atomic context */

Move the periodic battery fetch to a delayed work item, which runs in
process context and may sleep, and set APPLE_RDESC_BATTERY on the
Bluetooth Magic Keyboard 2021 entry. The descriptor fixup guarded by
the quirk only fires for the 83-byte USB report descriptor, so enabling
the quirk over Bluetooth does not disturb the (different) Bluetooth
descriptor. Also stop returning early once capacity reaches max: over
Bluetooth the device sends no unsolicited updates, so the driver must
keep polling to notice the level fall after a full charge.

Only the plain Magic Keyboard 2021 is enabled and tested here; the
fingerprint, numpad and 2024 Bluetooth variants likely need the same
change but were not available to test.

Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Alec Hall <signshop.alec@gmail.com>
---
 drivers/hid/hid-apple.c | 36 +++++++++++++++++++-----------------
 1 file changed, 19 insertions(+), 17 deletions(-)

diff --git a/drivers/hid/hid-apple.c b/drivers/hid/hid-apple.c
index bf7dd0fbf249..e46a59844a30 100644
--- a/drivers/hid/hid-apple.c
+++ b/drivers/hid/hid-apple.c
@@ -23,6 +23,7 @@
 #include <linux/module.h>
 #include <linux/slab.h>
 #include <linux/timer.h>
+#include <linux/workqueue.h>
 #include <linux/string.h>
 #include <linux/leds.h>
 #include <dt-bindings/leds/common.h>
@@ -116,7 +117,7 @@ struct apple_sc {
 	unsigned int fn_on;
 	unsigned int fn_found;
 	DECLARE_BITMAP(pressed_numlock, KEY_CNT);
-	struct timer_list battery_timer;
+	struct delayed_work battery_work;
 	struct apple_sc_backlight *backlight;
 };
 
@@ -635,9 +636,6 @@ static int apple_fetch_battery(struct hid_device *hdev)
 	if (!report || report->maxfield < 1)
 		return -1;
 
-	if (bat->capacity == bat->max)
-		return -1;
-
 	hid_hw_request(hdev, report, HID_REQ_GET_REPORT);
 	return 0;
 #else
@@ -645,15 +643,20 @@ static int apple_fetch_battery(struct hid_device *hdev)
 #endif
 }
 
-static void apple_battery_timer_tick(struct timer_list *t)
+static void apple_battery_work(struct work_struct *work)
 {
-	struct apple_sc *asc = timer_container_of(asc, t, battery_timer);
+	struct apple_sc *asc = container_of(work, struct apple_sc, battery_work.work);
 	struct hid_device *hdev = asc->hdev;
 
-	if (apple_fetch_battery(hdev) == 0) {
-		mod_timer(&asc->battery_timer,
-			  jiffies + secs_to_jiffies(APPLE_BATTERY_TIMEOUT_SEC));
-	}
+	/*
+	 * Runs in process context (workqueue), so the battery GET_REPORT is
+	 * allowed to sleep. This is required for the uhid/Bluetooth transport,
+	 * whose raw_request blocks waiting on userspace -- unlike a timer_list
+	 * callback, which runs in atomic softirq context and would deadlock.
+	 */
+	if (apple_fetch_battery(hdev) == 0)
+		schedule_delayed_work(&asc->battery_work,
+				      secs_to_jiffies(APPLE_BATTERY_TIMEOUT_SEC));
 }
 
 /*
@@ -968,10 +971,9 @@ static int apple_probe(struct hid_device *hdev,
 	}
 
 	if (quirks & APPLE_RDESC_BATTERY) {
-		timer_setup(&asc->battery_timer, apple_battery_timer_tick, 0);
-		mod_timer(&asc->battery_timer,
-			  jiffies + secs_to_jiffies(APPLE_BATTERY_TIMEOUT_SEC));
-		apple_fetch_battery(hdev);
+		INIT_DELAYED_WORK(&asc->battery_work, apple_battery_work);
+		/* Kick an initial fetch; the work re-arms itself every timeout. */
+		schedule_delayed_work(&asc->battery_work, 0);
 	}
 
 	if (quirks & APPLE_BACKLIGHT_CTL)
@@ -987,7 +989,7 @@ static int apple_probe(struct hid_device *hdev,
 
 out_err:
 	if (quirks & APPLE_RDESC_BATTERY)
-		timer_delete_sync(&asc->battery_timer);
+		cancel_delayed_work_sync(&asc->battery_work);
 
 	hid_hw_stop(hdev);
 	return ret;
@@ -998,7 +1000,7 @@ static void apple_remove(struct hid_device *hdev)
 	struct apple_sc *asc = hid_get_drvdata(hdev);
 
 	if (asc->quirks & APPLE_RDESC_BATTERY)
-		timer_delete_sync(&asc->battery_timer);
+		cancel_delayed_work_sync(&asc->battery_work);
 
 	hid_hw_stop(hdev);
 }
@@ -1201,7 +1203,7 @@ static const struct hid_device_id apple_devices[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_MAGIC_KEYBOARD_2021),
 		.driver_data = APPLE_HAS_FN | APPLE_ISO_TILDE_QUIRK | APPLE_RDESC_BATTERY },
 	{ HID_BLUETOOTH_DEVICE(BT_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_MAGIC_KEYBOARD_2021),
-		.driver_data = APPLE_HAS_FN | APPLE_ISO_TILDE_QUIRK },
+		.driver_data = APPLE_HAS_FN | APPLE_ISO_TILDE_QUIRK | APPLE_RDESC_BATTERY },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_MAGIC_KEYBOARD_FINGERPRINT_2021),
 		.driver_data = APPLE_HAS_FN | APPLE_ISO_TILDE_QUIRK | APPLE_RDESC_BATTERY },
 	{ HID_BLUETOOTH_DEVICE(BT_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_MAGIC_KEYBOARD_FINGERPRINT_2021),
-- 
2.55.0

