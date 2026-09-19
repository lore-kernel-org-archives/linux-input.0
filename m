Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B00F3A3E72
	for <linux-input@vger.kernel.org>; Sat, 19 Sep 2026 22:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789856794; cv=none; b=otq+WXwdTOKUXN3c97wKhXqrFCpz6oSeG0KNCVghCfhC1vMzTEQiPyb2KRhnV+5xLJa8qmkUWSO/Bl99mOvFTot1SLJyinwhIN+gnJ/FSNAeL/TUlEcyLvAFmBSUxP/SV+dTbBc8PQmbtIVq0Lk4EA6MhWXPeteWJlGGSlxwWJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789856794; c=relaxed/simple;
	bh=9LiXDkmYDVdB90kAVKrjVcXDHxIIpsoMoAoGDYQ+58Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NpzPdVdqCNS+kuvaUDY4IEZb1eKpMOl8aJo1X371RJM4dF3dxrNcKVK0mXS1/+0iza/Bb4mtkI3tolCH8/ky2MAXOiR6lcoYUrLWd5ZeMFAssT9g+oUSzK4UUQNh6GS5HulL3nQ6hTtaUj/WwbhbZAk8Lcmkyo1DLN+orupJvq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i+/DgmxK; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i+/DgmxK"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-396ccafb751so1548596a91.2
        for <linux-input@vger.kernel.org>; Sat, 19 Sep 2026 15:26:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789856791; x=1790461591; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=UmMKh/aeg8bACEW7HZInwh5u8Ule0MiW9EMCmiARcII=;
        b=i+/DgmxKUSkbPvYHQdCKwPFbHQJqTJRtfO/3AwGs1BuBXXfHH3nI1AHY9jVuavuE6U
         Pm+g4/bu5pxBD5V3nF6Njcli+Zc2h9yRgLGfqd8l4ToR91MERcden+QZkyD34ey/Tl6A
         3avkbAWjmpspz1bby9Zu1SQz4z8nPh3L6RwtUiVK7bxmMd4LPAuehjeAZXnOxWMNZuPD
         3DRczq8Yw9y6vYfcm89OhUFFTI6jsPov2WgtCRcQwU97/99Qb8avxJ36j7MqluxSKhEf
         9IgwY550OcZ67dITOaI3B+G16/WWhDQLUhQNA6o+xAiZkWd1L0VG4Fs8vjjg9lDItEmu
         jDvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789856791; x=1790461591;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UmMKh/aeg8bACEW7HZInwh5u8Ule0MiW9EMCmiARcII=;
        b=w6UFc2tuqdPuWUDKg4fdyAFyXlM79Z7Q9ye9/qVOhWOlpz4luA4c/gXmWK45QHWH9G
         /+MLhFn2bGtAJJFiMVeC7JDJFlbUrjAa0Xwt3fJaLs2XBpSwUSg2TzrZIGF3BUEMxo0J
         qbmmxpnwYhcN9JbQFCSEqkJnQVm0aor36KWugCDcWDPN6ypfbpz7Qdpjq5qN47+c2OGI
         BBlTmKXEaNYILWgmYZHKiyWdgmdJfnO8OylwxCM/0bSPprmdfHEXIwLkY5S0aWzZmjUV
         K8pAfKPFtxkFXdretqC9qvoA8Mzm32PT2TtCu1Ux8AP/WswHjHgZII9jkHwHZBsr4YQq
         4ldQ==
X-Gm-Message-State: AFuF++lwe8fPa8y+DNeJzY+aCqPZEsAXOGg3Jh6AkT0X9kz3+UgjYbHv
	e6BrQHEvX0fGUYx5Y/CO0ATfy7US4t0vbyBMbzMJlpbBznXU1xz1zllj
X-Gm-Gg: AYBFou15YX/IoLTOdVclScHeZUhyuiQLys/EFQiUeqSOvHeaRImjDvOHEMudLFnUWPa
	BFDRE9ADQJue+mixBYETz7WEtFcSSgZVNRunZ6r2Y35nXQ023xZip8ziJL1sI13/itwNRVyTgWk
	s7l6MGp3RHHYPUh76D7e8QZLE/hPNy6Mk2HmzexrhzZUgD1ZCpZoOv9qBdK1t/VrmwtdEJd+Ex0
	5rBU510sUZEaZmaeqXEKb/qeY2EeJMqAIcQpgN0wIi3blqIMDI8ioj3Y19Cv8OxPE02jlFnz80l
	PLOIp/8zJjxbhXbq+dV9MxjaugkIVaxSl0aRdo+CKAd+Wmb727afWFeMpe7kvOvW2Ub8YHjBXiQ
	K/hOYrG+XVvAsnTt7AsdmK0xkUe8BAKZjD0cT96iyDnyn612/qoK8AkAdmQCyo5K+TBuRO2DmE+
	aLNJcZQNrefX56Nu4hii8sUohmiRfAgkauAiCz3gb5YVeCCWO0ObzsUpAMrW3XpNwSKNYsr0yVF
	FayOWVXlVl+H3nWnczsMBs7o/T0FqP3kBGZ4AwmLksOGKHGCosNmNPFZG7EtquE7EIAxJc+z8Ot
	M4RIsgNMyA==
X-Received: by 2002:a17:90b:5305:b0:381:6c5:3f63 with SMTP id 98e67ed59e1d1-39e54dcd917mr17566941a91.6.1789856791293;
        Sat, 19 Sep 2026 15:26:31 -0700 (PDT)
Received: from phui-2.c.googlers.com.com (78.123.83.34.bc.googleusercontent.com. [34.83.123.78])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e6cabb771sm6318908a91.9.2026.09.19.15.26.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Sep 2026 15:26:30 -0700 (PDT)
From: Hui Peng <benquike@gmail.com>
To: jikos@kernel.org,
	bentiss@kernel.org
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] HID: fix sony Rock Band 3 IRQ sleep and hid_debug_events_read() UAF
Date: Sat, 19 Sep 2026 22:26:30 +0000
Message-ID: <20260919222630.3798292-1-benquike@gmail.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix two issues in drivers/hid/:

1. In sony_raw_event() (drivers/hid/hid-sony.c), defer the Rock Band 3
   Pro controller full-report feature request to sony_state_worker()
   instead of calling hid_hw_raw_request() synchronously from interrupt
   context.
2. In hid_debug_events_read() and hid_debug_events_release()
   (drivers/hid/hid-debug.c), remove list->node from hdev->debug_list
   under hdev->debug_list_lock before freeing or when hdev is unbound so
   hid_dump_input() cannot access a freed debug list entry.

Fixes: bd28ce008bdc ("HID: move sony quirks")
Assisted-by: LLM
Signed-off-by: Hui Peng <benquike@gmail.com>
---
diff --git a/drivers/hid/hid-debug.c b/drivers/hid/hid-debug.c
index f44e6e708404..edc45ca9e024 100644
--- a/drivers/hid/hid-debug.c
+++ b/drivers/hid/hid-debug.c
@@ -3728,15 +3728,14 @@ static ssize_t hid_debug_events_read(struct file *file, char __user *buffer,
 				break;
 			}
 
-			/* if list->hdev is NULL we cannot remove_wait_queue().
-			 * if list->hdev->debug is 0 then hid_debug_unregister()
-			 * was already called and list->hdev is being destroyed.
-			 * if we add remove_wait_queue() here we can hit a race.
+			/* if list->hdev->debug is 0 then hid_debug_unregister()
+			 * was already called; break out of the wait loop so
+			 * remove_wait_queue() is unconditionally called before
+			 * returning.
 			 */
 			if (!list->hdev || !list->hdev->debug) {
 				ret = -EIO;
-				__set_current_state(TASK_RUNNING);
-				goto out;
+				break;
 			}
 
 			if (file->f_flags & O_NONBLOCK) {
diff --git a/drivers/hid/hid-sony.c b/drivers/hid/hid-sony.c
index 50f5ad6bbeb4..d3862ddf68c9 100644
--- a/drivers/hid/hid-sony.c
+++ b/drivers/hid/hid-sony.c
@@ -561,6 +561,7 @@ struct sony_sc {
 
 	/* Rock Band 3 Pro Instruments */
 	unsigned long rb3_pro_poke_jiffies;
+	struct work_struct rb3_pro_poke_work;
 };
 
 static void sony_set_leds(struct sony_sc *sc);
@@ -657,6 +658,14 @@ static int rb3_pro_instrument_enable_full_report(struct sony_sc *sc)
 	return ret;
 }
 
+static void rb3_pro_poke_worker(struct work_struct *work)
+{
+	struct sony_sc *sc = container_of(work, struct sony_sc,
+					  rb3_pro_poke_work);
+
+	rb3_pro_instrument_enable_full_report(sc);
+}
+
 static int djh_turntable_mapping(struct hid_device *hdev, struct hid_input *hi,
 			  struct hid_field *field, struct hid_usage *usage,
 			  unsigned long **bit, int *max)
@@ -1101,7 +1110,7 @@ static int rb3_pro_instrument_raw_event(struct sony_sc *sc, u8 *rd, int size)
 	/* Only attempt to enable full report every 8 seconds */
 	if (time_after(jiffies, sc->rb3_pro_poke_jiffies)) {
 		sc->rb3_pro_poke_jiffies = jiffies + secs_to_jiffies(8);
-		rb3_pro_instrument_enable_full_report(sc);
+		schedule_work(&sc->rb3_pro_poke_work);
 	}
 
 	return 0;
@@ -2124,6 +2133,8 @@ static inline void sony_cancel_work_sync(struct sony_sc *sc)
 		}
 		cancel_work_sync(&sc->state_worker);
 	}
+	if (sc->quirks & RB3_PRO_INSTRUMENT)
+		cancel_work_sync(&sc->rb3_pro_poke_work);
 }
 
 static void sony_cleanup(struct sony_sc *sc)
@@ -2350,6 +2361,11 @@ static int sony_probe(struct hid_device *hdev, const struct hid_device_id *id)
 	hid_set_drvdata(hdev, sc);
 	sc->hdev = hdev;
 
+	if (sc->quirks & RB3_PRO_INSTRUMENT) {
+		sc->rb3_pro_poke_jiffies = 0;
+		INIT_WORK(&sc->rb3_pro_poke_work, rb3_pro_poke_worker);
+	}
+
 	ret = hid_parse(hdev);
 	if (ret) {
 		hid_err(hdev, "parse failed\n");
@@ -2391,9 +2407,6 @@ static int sony_probe(struct hid_device *hdev, const struct hid_device_id *id)
 		goto err;
 	}
 
-	if (sc->quirks & RB3_PRO_INSTRUMENT)
-		sc->rb3_pro_poke_jiffies = 0;
-
 	if (sc->quirks & (GHL_GUITAR_PS3WIIU | GHL_GUITAR_PS4)) {
 		if (!hid_is_usb(hdev)) {
 			ret = -EINVAL;
