Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02EBA37F75E
	for <linux-input@vger.kernel.org>; Mon, 20 Apr 2026 05:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776662016; cv=none; b=UePQJFakQb+RaLuAALM322XbhD2YpfOdn8rMvBx3o34ycNq7FYA2jVoB+CTQnayV3kxD1FN7j8KulzuuBOGAdni0vkzUBo54M0/N65ojbwd6Q5aIpkyNsE8GMbvqv0JivbDyuY8RHQ3Tf7UKO9Coh/GTf0RYmTjgYy4x8V1V/8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776662016; c=relaxed/simple;
	bh=Itt2y7GTnHVJrFtAaPeXswkX8rW4RyB7vpTnRm0B4uU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qyUR+ky7eTsRah+Vj3rambmCYD2jOLPTLw1iaM9BIq5JPKC+uRek9yU2g8NLo/OK/JZEbaWrEfqAv27oyrgTlShyx3nk2F4uZVzqXt8hK5kGia6Cbt0gm6udCoOzfC7UugiH2xodAZzE9TuhjFgaHToaHxdPhyQXuw+ZYquKdeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=snu.ac.kr; spf=pass smtp.mailfrom=snu.ac.kr; dkim=pass (1024-bit key) header.d=snu.ac.kr header.i=@snu.ac.kr header.b=WEPV4znX; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=snu.ac.kr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=snu.ac.kr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=snu.ac.kr header.i=@snu.ac.kr header.b="WEPV4znX"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-35d99bae2ebso2471875a91.3
        for <linux-input@vger.kernel.org>; Sun, 19 Apr 2026 22:13:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=snu.ac.kr; s=google; t=1776662013; x=1777266813; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=panaAxBG+Oj8O67g22hba7g+kj4UgFC78OIsOhVGnTk=;
        b=WEPV4znXk5QBV4avjqTQ+t11JCv0KYVG8TWzjgKFwzJc7HiS+VYJ3KJDeyA03iSUbz
         bkKhucH/gH7dFD4ytiP1q36T3Om1jvW6J73PWaNtFiEOfwcNd7+cnGIwlKHPCkRt3Rti
         +2fqnSjxLJqSqE2XD3DCEq7XnrCpnpb1pttTA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776662013; x=1777266813;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=panaAxBG+Oj8O67g22hba7g+kj4UgFC78OIsOhVGnTk=;
        b=NMjMjtoMColZ/jaMumRWuCUiiKBWOiuScVttlOj/iGFgQcXqL3rII5aHx5l8PiNV4E
         wo7Fgslt217pX9xb7TN4JhOgJrvW6pxNI8s1HD/Mi8sUB25XJXBcug3nHWW7O4txiN4W
         vb1yg0QpM85JF+k3sV4WkZRqsTWP1DswQduDO+KZaC7qRJlkz/W3z7sWNpO8hwXxRQ9A
         hABX5bMYZ5WzvvotjlCQ0BWviUCBrpU/DjrDIsZm/NVvDO897K0ksLmMq19bN4BLWfo/
         5FLwb0p6tfZ6i5BXgZkn/rRkrpK2qwTYHREVzJ4BlzfNNXBifBJczLu5g44TVZQC4A1w
         vDSQ==
X-Forwarded-Encrypted: i=1; AFNElJ8wrBh41Vt/JUWqdCEAeigqBbilxmqbq25XNchUUDT5qcaDha9teWfRHLuaahBvWUDsjpRVpHCDzkm2aQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzqDm26yHNcsYXWN35N+4Kw/kCHl5FqT+bFCMiEUSTF3zNLQxW3
	gaZYFCZBrCSU53WM4rvL02Stv7WI1ccwnR1nSpQOd1hO/oaQyWMphPB2s/7ulkYPdec=
X-Gm-Gg: AeBDies1oiDYAT/7gZ2K3+w35M+10N/L/0fvoOIaz2PMvgImlsrdkc6UMkftkPV/omV
	InQbG+mgtYw+feWHX54Hto6bs8ldUpi/vfHrTUEe5XYDyE1KDyg+PaZyJj5MsPrUaBY0gsqqQPt
	jiMKrMxxp7qSzp0xvTsovUEQO5crLO671iV6TxgvauS+LB1KxwBY645H/d23bh5oEbC++1RbYwU
	EyfldOhHaC7cPnVgEUGFB+DbuREEQZwZlmJw9Eyz6v2I/tftNdYo0WlGWFC29pxdUBD4RzvjxSN
	eXoXEYAgSTKivfz5kkJYugtS5hccjMS/lcvmZKJOttBENe+8gqmAjgg7s5T1p16h8Xt2/PvOJUc
	3Aj4wb+wkQW+TH259yhItU7xj2pO7TkZq6bzpHEbkj2iFJz/ydxhbLpzyMQ+No6H7SoR+RMdLzz
	zUswOsTkryP2lxdzUp7gFf7X848lscAo2TOyqoc7m6k4Ep9fy06WuT+uYsHRtS96rKm2lQjg==
X-Received: by 2002:a17:90b:5106:b0:35d:93ff:2855 with SMTP id 98e67ed59e1d1-361403e159amr11563269a91.8.1776662013426;
        Sun, 19 Apr 2026 22:13:33 -0700 (PDT)
Received: from nunu.. (nunu.snu.ac.kr. [147.46.112.82])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3614186a52csm11032591a91.4.2026.04.19.22.13.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Apr 2026 22:13:33 -0700 (PDT)
From: Sangyun Kim <sangyun.kim@snu.ac.kr>
To: jikos@kernel.org,
	bentiss@kernel.org
Cc: qasdev00@gmail.com,
	gargaditya08@live.com,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 1/2] HID: appletb-kbd: fix UAF in inactivity-timer cleanup path
Date: Mon, 20 Apr 2026 14:13:17 +0900
Message-Id: <20260420051318.1411671-2-sangyun.kim@snu.ac.kr>
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

Commit 38224c472a03 ("HID: appletb-kbd: fix slab use-after-free bug in
appletb_kbd_probe") added timer_delete_sync(&kbd->inactivity_timer) to
both the probe close_hw error path and appletb_kbd_remove(), but the
way it was wired in left the inactivity timer reachable during driver
tear-down via two distinct windows.

Window A -- put_device() before timer_delete_sync():

	put_device(&kbd->backlight_dev->dev);
	timer_delete_sync(&kbd->inactivity_timer);

The inactivity_timer softirq reads kbd->backlight_dev and calls
backlight_device_set_brightness() -> mutex_lock(&ops_lock).  If a
concurrent hid_appletb_bl unbind drops the last devm reference
between these two calls, the backlight_device is freed and the
mutex_lock() touches freed memory.

Window B -- backlight cleanup before hid_hw_stop():

	if (kbd->backlight_dev) {
		timer_delete_sync(...);
		put_device(...);
	}
	hid_hw_close(hdev);
	hid_hw_stop(hdev);

Even after Window A is closed, hid_hw_close()/hid_hw_stop() still run
afterwards, so a late ".event" callback from the HID core (USB URB
completion on real Apple hardware) can arrive after
timer_delete_sync() drained the softirq but before put_device() drops
the reference.  That callback reaches reset_inactivity_timer(), which
calls mod_timer() and re-arms the timer.  The freshly re-armed timer
can then fire on the about-to-be-freed backlight_device.

Both windows produce the same KASAN slab-use-after-free:

  BUG: KASAN: slab-use-after-free in __mutex_lock+0x1aab/0x21c0
  Read of size 8 at addr ffff88803ee9a108 by task swapper/0/0
  Call Trace:
   <IRQ>
   __mutex_lock
   backlight_device_set_brightness
   appletb_inactivity_timer
   call_timer_fn
   run_timer_softirq
   handle_softirqs
  Allocated by task N:
   devm_backlight_device_register
   appletb_bl_probe
  Freed by task M:
   (concurrent hid_appletb_bl unbind path)

Close both windows at once by reworking the tear-down in
appletb_kbd_remove() and in the probe close_hw error path so that

 1) hid_hw_close()/hid_hw_stop() run before the backlight cleanup,
    guaranteeing no further .event callback can fire and re-arm the
    timer, and
 2) inside the "if (kbd->backlight_dev)" block, timer_delete_sync()
    runs before put_device(), so the softirq is drained before the
    final reference is dropped.

Fixes: 38224c472a03 ("HID: appletb-kbd: fix slab use-after-free bug in appletb_kbd_probe")
Cc: stable@vger.kernel.org
Signed-off-by: Sangyun Kim <sangyun.kim@snu.ac.kr>
---
 drivers/hid/hid-appletb-kbd.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/hid/hid-appletb-kbd.c b/drivers/hid/hid-appletb-kbd.c
index 0fdc0968b9ef..8feac9e3589b 100644
--- a/drivers/hid/hid-appletb-kbd.c
+++ b/drivers/hid/hid-appletb-kbd.c
@@ -440,13 +440,13 @@ static int appletb_kbd_probe(struct hid_device *hdev, const struct hid_device_id
 unregister_handler:
 	input_unregister_handler(&kbd->inp_handler);
 close_hw:
-	if (kbd->backlight_dev) {
-		put_device(&kbd->backlight_dev->dev);
-		timer_delete_sync(&kbd->inactivity_timer);
-	}
 	hid_hw_close(hdev);
 stop_hw:
 	hid_hw_stop(hdev);
+	if (kbd->backlight_dev) {
+		timer_delete_sync(&kbd->inactivity_timer);
+		put_device(&kbd->backlight_dev->dev);
+	}
 	return ret;
 }
 
@@ -457,13 +457,13 @@ static void appletb_kbd_remove(struct hid_device *hdev)
 	appletb_kbd_set_mode(kbd, APPLETB_KBD_MODE_OFF);
 
 	input_unregister_handler(&kbd->inp_handler);
+	hid_hw_close(hdev);
+	hid_hw_stop(hdev);
+
 	if (kbd->backlight_dev) {
-		put_device(&kbd->backlight_dev->dev);
 		timer_delete_sync(&kbd->inactivity_timer);
+		put_device(&kbd->backlight_dev->dev);
 	}
-
-	hid_hw_close(hdev);
-	hid_hw_stop(hdev);
 }
 
 static int appletb_kbd_suspend(struct hid_device *hdev, pm_message_t msg)
-- 
2.34.1

