Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C33437A48B
	for <linux-input@vger.kernel.org>; Mon, 20 Apr 2026 05:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776662018; cv=none; b=b/nnJw8HOEXeiU9Vvk6f8Jl3ywRNqkcl8sFzfGjcO0u8GJaUtCh6L5yO5Tw18ya5tGel8CQSxNNLv8eEmyt1UyfOECWANnUkBBfqljGEEP3tH+NuLqXwebY+Z/LsbO1aIaVNOzwvsOibzLYVtKnhRVvMDEyc0+Dl9It2EfOG4vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776662018; c=relaxed/simple;
	bh=01XNhHkfueCJ1FLR+EHojwXfn62aRxo9vj4McCxGw5k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=F8C3JDtVaKv2XqE+zGFZs4QoGqNXwuQGJAMhrA5kkdiGhjRy8poeNrAJ5FBqH5hwNKFMZuB3hqlq5kVKVvNnkE9+l2nlnYHkIXCCNmGwasB76adU3QAtZbEFjjryl3KI89ShdCW7DuT7cerHaOElRn/Ue2HQaPc4LQhvCaCsnj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=snu.ac.kr; spf=pass smtp.mailfrom=snu.ac.kr; dkim=pass (1024-bit key) header.d=snu.ac.kr header.i=@snu.ac.kr header.b=HuMfC8Sb; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=snu.ac.kr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=snu.ac.kr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=snu.ac.kr header.i=@snu.ac.kr header.b="HuMfC8Sb"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-3614826eca4so1951128a91.1
        for <linux-input@vger.kernel.org>; Sun, 19 Apr 2026 22:13:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=snu.ac.kr; s=google; t=1776662016; x=1777266816; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ihcvVaBfQ28dquD5a+undc5jBXoT8T5VO4GMetOrvw0=;
        b=HuMfC8Sb6MUTOKhVtSxg1rTxT1Na0uAILTOuiS0j6Trhjwa15yfIW24PGflLcc5PPH
         mVs0dz9ib6An92AkW6I/NwzHw2HnPddAFafV6xF5r62UL9atJ6nRznT1vYBnCgSpS/CQ
         W4PAl2jldLE+jEcGTDc6KihXrOIKf3iN9ITFs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776662016; x=1777266816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ihcvVaBfQ28dquD5a+undc5jBXoT8T5VO4GMetOrvw0=;
        b=ZoANuuryQYULIPbeM/M8w6zGD6TBwOkmaMLFjOHsZO4yMz9gYehx3LJzw6i+lJ16cO
         B+UyJdfeeHIji/Y/2PZaCP030mCK2qh34FgWOur+yy5PAPUT+jil2/dkAT73A6SV6FGe
         bPqRRm9qRZKcbEOtmRDwmKJcDhdWDp4T7QPTpiHN5N4PMqoF0cWSrAOdsoORON4P+7IG
         2N4NRxeafJ5WrFYFpYPj++mqU9UPr6OVLq7SPl4ThoO83Vs4Zb7t46emXbx9xYRwospF
         SRlsXuYKzn/g2VzKvpKnMjJG05oHYy+y3d3QiRi/B9jKag5ZobDhixKOlPecFyba2t86
         uuAw==
X-Forwarded-Encrypted: i=1; AFNElJ/eIEkf0P+vEXy5Xp0fI522KvsNtVrNiy/lSw8WTTYJIDwAU22TU7dpqBDUguu+T1mfjI5T+BYSDTDirA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxuBG/jjdD5M2vBBR3coQAdRuSrTy1pcvcAJlp2uwQLlSpTJ/17
	7xKFITD2GHJUXaIaABpZj8DeM6S1xeNqG/yIMIE74BIA0RFiBam9A411NeqGeNV2ats=
X-Gm-Gg: AeBDieu4UcHmfcgm3QPYZ0PLrFyGOsoBP8zL9+l8Ky+j8PULSyD4D5Po3TW6uAwdkT+
	ohwhlU8cm/OfkJXYdqi9eY1C3n5JNX80kNDbsw8bdDE9WCGj3QPoI0Dhj7fPYTm8nbjQEVXFPTt
	wkYj6MFLecF+ClqIGohu2u6ThZ4PDlmODPghnWg7VlIH/jXfXWHBsw8llImMrkzIH6fN6FFoGhK
	irXgStj3GXFaJfzdHnd5VyT5WOSOnAGIG+4jRlb+xWEVo4NzCKxMiPV5ObvPypWOGZ+gH2nMOqf
	PKxB4ziw7L/DwlEHn5tjGlphwiNlnFDKOz8A1L3Wy9lBckb1trTGwjeVK9OvuN/Hicmhd/YHqK3
	sBTfOI8bgxhoRc5FRwF+bAqVHo/uBCrypUDO//7F1kTSGv4Z/TRXHucRPZXgb30XcTSyOzPtD2c
	p7L+KHX/UgR+rgGr36QhlX+HKKejnUMfGww2DLPPuJj/aMFtmbgfYEHMB9LhkZhmqYgmaQqA==
X-Received: by 2002:a17:90b:5865:b0:35e:27ec:dea with SMTP id 98e67ed59e1d1-36140493410mr13257104a91.23.1776662016114;
        Sun, 19 Apr 2026 22:13:36 -0700 (PDT)
Received: from nunu.. (nunu.snu.ac.kr. [147.46.112.82])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3614186a52csm11032591a91.4.2026.04.19.22.13.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Apr 2026 22:13:35 -0700 (PDT)
From: Sangyun Kim <sangyun.kim@snu.ac.kr>
To: jikos@kernel.org,
	bentiss@kernel.org
Cc: qasdev00@gmail.com,
	gargaditya08@live.com,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 2/2] HID: appletb-kbd: run inactivity autodim from workqueues
Date: Mon, 20 Apr 2026 14:13:18 +0900
Message-Id: <20260420051318.1411671-3-sangyun.kim@snu.ac.kr>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260420051318.1411671-1-sangyun.kim@snu.ac.kr>
References: <20260420051318.1411671-1-sangyun.kim@snu.ac.kr>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The autodim code in hid-appletb-kbd takes backlight_device->ops_lock
via backlight_device_set_brightness() -> mutex_lock() from two
different atomic contexts:

 * appletb_inactivity_timer() is a struct timer_list callback, so it
   runs in softirq context.  Every expiry triggers

     BUG: sleeping function called from invalid context at kernel/locking/mutex.c:591
     Call Trace:
      <IRQ>
      __might_resched
      __mutex_lock
      backlight_device_set_brightness
      appletb_inactivity_timer
      call_timer_fn
      run_timer_softirq

 * reset_inactivity_timer() is called from appletb_kbd_hid_event() and
   appletb_kbd_inp_event().  On real USB hardware these run in
   softirq/IRQ context (URB completion and input-event dispatch).
   When the Touch Bar has already been dimmed or turned off, the
   reset path calls backlight_device_set_brightness() directly to
   restore brightness, producing the same warning.

Both call sites hit the same mutex_lock()-from-atomic bug.  Fix them
together by moving the blocking work onto the system workqueue:

 * Convert the inactivity timer from struct timer_list to
   struct delayed_work; the callback (appletb_inactivity_work) now
   runs in process context where mutex_lock() is legal.
 * Add a dedicated struct work_struct restore_brightness_work and have
   reset_inactivity_timer() schedule it instead of calling
   backlight_device_set_brightness() directly.

Cancel both works synchronously during driver tear-down alongside the
existing backlight reference drop.

The semantics are unchanged (same delays, same state transitions on
dim, turn-off and user activity); only the execution context of the
sleeping call changes.  The timer field and callback are renamed to
match their new type; reset_inactivity_timer() keeps its name because
it is invoked from input event paths that read naturally as "reset
the inactivity timer".

Fixes: 93a0fc489481 ("HID: hid-appletb-kbd: add support for automatic brightness control while using the touchbar")
Cc: stable@vger.kernel.org
Signed-off-by: Sangyun Kim <sangyun.kim@snu.ac.kr>
---
 drivers/hid/hid-appletb-kbd.c | 44 ++++++++++++++++++++++++-----------
 1 file changed, 30 insertions(+), 14 deletions(-)

diff --git a/drivers/hid/hid-appletb-kbd.c b/drivers/hid/hid-appletb-kbd.c
index 8feac9e3589b..462010a75899 100644
--- a/drivers/hid/hid-appletb-kbd.c
+++ b/drivers/hid/hid-appletb-kbd.c
@@ -17,7 +17,7 @@
 #include <linux/module.h>
 #include <linux/string.h>
 #include <linux/backlight.h>
-#include <linux/timer.h>
+#include <linux/workqueue.h>
 #include <linux/input/sparse-keymap.h>
 
 #include "hid-ids.h"
@@ -62,7 +62,8 @@ struct appletb_kbd {
 	struct input_handle kbd_handle;
 	struct input_handle tpd_handle;
 	struct backlight_device *backlight_dev;
-	struct timer_list inactivity_timer;
+	struct delayed_work inactivity_work;
+	struct work_struct restore_brightness_work;
 	bool has_dimmed;
 	bool has_turned_off;
 	u8 saved_mode;
@@ -164,16 +165,18 @@ static int appletb_tb_key_to_slot(unsigned int code)
 	}
 }
 
-static void appletb_inactivity_timer(struct timer_list *t)
+static void appletb_inactivity_work(struct work_struct *work)
 {
-	struct appletb_kbd *kbd = timer_container_of(kbd, t, inactivity_timer);
+	struct appletb_kbd *kbd = container_of(to_delayed_work(work),
+					       struct appletb_kbd,
+					       inactivity_work);
 
 	if (kbd->backlight_dev && appletb_tb_autodim) {
 		if (!kbd->has_dimmed) {
 			backlight_device_set_brightness(kbd->backlight_dev, 1);
 			kbd->has_dimmed = true;
-			mod_timer(&kbd->inactivity_timer,
-				jiffies + secs_to_jiffies(appletb_tb_idle_timeout));
+			mod_delayed_work(system_wq, &kbd->inactivity_work,
+					 secs_to_jiffies(appletb_tb_idle_timeout));
 		} else if (!kbd->has_turned_off) {
 			backlight_device_set_brightness(kbd->backlight_dev, 0);
 			kbd->has_turned_off = true;
@@ -181,16 +184,25 @@ static void appletb_inactivity_timer(struct timer_list *t)
 	}
 }
 
+static void appletb_restore_brightness_work(struct work_struct *work)
+{
+	struct appletb_kbd *kbd = container_of(work, struct appletb_kbd,
+					       restore_brightness_work);
+
+	if (kbd->backlight_dev)
+		backlight_device_set_brightness(kbd->backlight_dev, 2);
+}
+
 static void reset_inactivity_timer(struct appletb_kbd *kbd)
 {
 	if (kbd->backlight_dev && appletb_tb_autodim) {
 		if (kbd->has_dimmed || kbd->has_turned_off) {
-			backlight_device_set_brightness(kbd->backlight_dev, 2);
 			kbd->has_dimmed = false;
 			kbd->has_turned_off = false;
+			schedule_work(&kbd->restore_brightness_work);
 		}
-		mod_timer(&kbd->inactivity_timer,
-			jiffies + secs_to_jiffies(appletb_tb_dim_timeout));
+		mod_delayed_work(system_wq, &kbd->inactivity_work,
+				 secs_to_jiffies(appletb_tb_dim_timeout));
 	}
 }
 
@@ -408,9 +420,11 @@ static int appletb_kbd_probe(struct hid_device *hdev, const struct hid_device_id
 		dev_err_probe(dev, -ENODEV, "Failed to get backlight device\n");
 	} else {
 		backlight_device_set_brightness(kbd->backlight_dev, 2);
-		timer_setup(&kbd->inactivity_timer, appletb_inactivity_timer, 0);
-		mod_timer(&kbd->inactivity_timer,
-			jiffies + secs_to_jiffies(appletb_tb_dim_timeout));
+		INIT_DELAYED_WORK(&kbd->inactivity_work, appletb_inactivity_work);
+		INIT_WORK(&kbd->restore_brightness_work,
+			  appletb_restore_brightness_work);
+		mod_delayed_work(system_wq, &kbd->inactivity_work,
+				 secs_to_jiffies(appletb_tb_dim_timeout));
 	}
 
 	kbd->inp_handler.event = appletb_kbd_inp_event;
@@ -444,7 +458,8 @@ static int appletb_kbd_probe(struct hid_device *hdev, const struct hid_device_id
 stop_hw:
 	hid_hw_stop(hdev);
 	if (kbd->backlight_dev) {
-		timer_delete_sync(&kbd->inactivity_timer);
+		cancel_delayed_work_sync(&kbd->inactivity_work);
+		cancel_work_sync(&kbd->restore_brightness_work);
 		put_device(&kbd->backlight_dev->dev);
 	}
 	return ret;
@@ -461,7 +476,8 @@ static void appletb_kbd_remove(struct hid_device *hdev)
 	hid_hw_stop(hdev);
 
 	if (kbd->backlight_dev) {
-		timer_delete_sync(&kbd->inactivity_timer);
+		cancel_delayed_work_sync(&kbd->inactivity_work);
+		cancel_work_sync(&kbd->restore_brightness_work);
 		put_device(&kbd->backlight_dev->dev);
 	}
 }
-- 
2.34.1

