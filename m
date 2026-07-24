Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED0414334A8
	for <linux-input@vger.kernel.org>; Fri, 24 Jul 2026 13:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784900564; cv=none; b=iifHBL7W4WfaumW3XPUD2MqAGznyU4LmjrNylJCYVszHP/TLyCb0bOw1bg7JofGhhj37zQ3viCcvt3D5QbT1Bcl7hkefflTlgNDTY1BepZVPg+VRLJdRYDpEJsvqy2b59bQK59G6qF+Zyiz5m28uYo84hRIzhz5RKOq1haVrD7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784900564; c=relaxed/simple;
	bh=wK7rofZviAO20txKtGb4Dl7RinRiYi+fH3brrT92tBo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IH7CNpCRYYsgdcwj6RxZuCh1W7fZPGCI1mna4DHETSxXbrXmxdzE4ILomT2AM7cIT4Pa/kycWdW1LiYLdzw4j2HOa0fBH4HpBT6vUTa2fRzSWKPxxjIfZN0OUPNCKA9yo8Ap7WWPwzRhghkj1+uwUBHPoyeyn+DVtcLt0ZEwccc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0sec.ai; spf=pass smtp.mailfrom=0sec.ai; dkim=temperror (0-bit key) header.d=0sec.ai header.i=@0sec.ai header.b=QUG9GpB0; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0sec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0sec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=0sec.ai header.i=@0sec.ai header.b="QUG9GpB0"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4921eed3fa2so3690475e9.0
        for <linux-input@vger.kernel.org>; Fri, 24 Jul 2026 06:42:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0sec.ai; s=google; t=1784900559; x=1785505359; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=U5v7064ffZlt2HlV90ACb40wb7LJr9dz3ciVnHFVCP8=;
        b=QUG9GpB0M0Lro31NhtSGtqfubtfJUoi8nKpz+jwgCVKzDKJMSYbhoaF6SXE4ADPudG
         EPwsrHK6vF1olb9fwk3ysrhjQH+VklFZ4UhyN8GGGX+AmHuEYYaB12+HVviZb4hA6Y+h
         yinDqXeFfc803R4kwQQCkfLfI5d9nXt/p5RsIQlMRn8per7OxfgrvqVqVKTmFWqG4thY
         v1Hna8XItivOB2IneZtACDH9SDHd1RS2dsM3Iu9jaB2c9U1EsBjih9k/iAGJNgJuaSjt
         qD/F6olRrG7jFyXhiJIsgmQ/6bTMfkrZm79oadMRQCoq86Ejd/svHfbjI32l4ZmlSMsK
         njig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784900559; x=1785505359;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=U5v7064ffZlt2HlV90ACb40wb7LJr9dz3ciVnHFVCP8=;
        b=VGDbdJaW3oJSx+7vh9NBbdK3Gi3fQD996D6F/FNpzRj0zczWxGeTjs8o0ONBqqpE67
         +ySnVZ7Xwe8BDURgkzNTm5sdlRm7bZZrVYtQFOdWI+Ey1w2So37cwsTCscZ/SMOLpdMD
         p9V3JslAlF19S4BCbdvuoF5UZnajIT+7ebU81qBTJxYiTQoix+zGdpbwtYlRguR9Fd33
         M51rS8zTf6a1TV4iXErj4QPVAN7pG9bYj3XEI+Jqk8fXA1b+JnTaPFgnqPFmRUwcKTwo
         chWj+nR/NUJdBSpvmm57hiWrSBojV0XtbBT5PCTQ6gJ3zkMXVADottxGg3PRa7FiuLLh
         H2kA==
X-Forwarded-Encrypted: i=1; AHgh+RoAmRJvUVOCzjhxN12rfzOXX/lpCgDTniGlDlVSEWh4GIkaj+65I6RyAwwbLy5kVvkxwHN8psHYFtbhCA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzqczVMFKzTJpb26zEKpOsjo/h7DaCcLxpmYdcIlfQIoNDdAk2X
	ex9ZT7qgZMOjonKQIvcE812J+bcfrEvQifKKii0IMDpQk9QQjz3nKstH7OwmN7vt5r+r
X-Gm-Gg: AR+sD10JTDdSDLB2bXQasjaOb7E8w8ySj7dJfpkf2Wh2i4UFOMWwEJQQIELOW9MZst1
	zpgDV5vK7iB3ZP0+fBxfW8H/IRw1FJ9QgfsWXrNAfHHyNO07r999NjCLlgGA7dYUnN12BOlDH6c
	TRME4DmsX6BIpEkPQe/p72HlkMcJ0NmxVPv//UGtLS5Sutqdrnx+LkUEmlJhrTov2golS2JYc6V
	uZn4tx3q+NlHnXOWqlaeQjC/yDZBhmmVeSx3pyQuGQ9Ziuu0Zeau2WDm63soFDu3Yrs6Inz41LH
	TC6cnYYjdccqn4EmsH5kOQgr6a8VEHf4nsMOn3bIRan4sxmcA2AkqyzuvWIxaQu0NyROlzQB2S4
	lgVQN+0/vB+NbfAe4jyaZ06HCFu3Ih2fUd/fLzH291UbH+7YAn0QBwmiwsgDEOzllY+burdCa/h
	pafhp5bYqLq5WtQFrWXV8Y1beN6UAKjoLW9rPqlWbFI+YEhH8TAAbMTGHJvxe4TBrXwpKIp5qJu
	PeE2Nbo3LezofzBV+1uzpikUA==
X-Received: by 2002:a05:600c:190a:b0:495:6e68:5df2 with SMTP id 5b1f17b1804b1-49573c9995bmr93163115e9.12.1784900558738;
        Fri, 24 Jul 2026 06:42:38 -0700 (PDT)
Received: from PeakBook-Mini.tail8e484.ts.net ([178.197.219.241])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4957f9ae5c3sm40634335e9.3.2026.07.24.06.42.37
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 24 Jul 2026 06:42:38 -0700 (PDT)
From: Doruk Tan Ozturk <doruk@0sec.ai>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: Pascal Giard <pascal.giard@etsmtl.ca>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] HID: sony: fix UAF of ghl_poke_timer / ghl_urb at driver unbind
Date: Fri, 24 Jul 2026 15:42:36 +0200
Message-ID: <20260724134236.34304-1-doruk@0sec.ai>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For GHL (Guitar Hero Live) dongles, sony_probe() arms a periodic timer:
ghl_magic_poke() (the timer callback) submits sc->ghl_urb, and the URB
completion ghl_magic_poke_cb() re-arms the timer with mod_timer().

sony_remove() drained the timer with timer_delete_sync() and then freed
the URB with usb_free_urb():

	timer_delete_sync(&sc->ghl_poke_timer);
	usb_free_urb(sc->ghl_urb);

timer_delete_sync() does not block re-arming, and while the URB is in
flight the timer is not pending, so the sync delete is a no-op. A URB
completion that runs after the delete re-arms the timer, and usb_free_urb()
only drops a reference -- it does not kill an in-flight URB. sc is
allocated with devm_kzalloc() and freed once sony_remove() returns, so the
re-armed ghl_poke_timer (embedded in sc) then fires on freed memory, a
use-after-free from timer softirq. This is a disconnect/rmmod race.

Kill the URB first so no completion can re-arm the timer (further
usb_submit_urb() from the callback then fails), then timer_shutdown_sync()
to drain any last callback and permanently block re-arming, before freeing
the URB. The probe error path is unaffected: it is only reached before the
timer is armed.

Reproduced under KASAN on next-20260710 via dummy_hcd + raw-gadget
emulation of the GHL PS4 dongle (VID 0x1430 / PID 0x07bb): hid-sony binds
and arms the poke timer, the poke URB is held in flight, the driver is
unbound (freeing sc), then the URB is released. The completion re-arms the
timer on the freed sc, and the re-armed timer fires ~8 s later:

  BUG: KASAN: slab-use-after-free in ghl_magic_poke+0x98/0xb0
  Read of size 8 at addr ffff88810b02fd50 by task swapper/0/0
   ghl_magic_poke+0x98/0xb0
   call_timer_fn+0x35/0x2b0
   __run_timers+0x69c/0x9a0
   run_timer_softirq+0x173/0x2a0
  Allocated by task 169:  sony_probe
  Freed by task 338:      devres_release_group <- hid_device_remove (sony_remove)

Found by 0sec (https://0sec.ai) using automated source analysis.

Fixes: cc894ac55360 ("HID: sony: support for ghlive ps3/wii u dongles")
Cc: stable@vger.kernel.org
Assisted-by: 0sec:multi-model
Signed-off-by: Doruk Tan Ozturk <doruk@0sec.ai>
---
 drivers/hid/hid-sony.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/hid-sony.c b/drivers/hid/hid-sony.c
index 253fff4066eb..5f9670f3910a 100644
--- a/drivers/hid/hid-sony.c
+++ b/drivers/hid/hid-sony.c
@@ -2431,7 +2431,19 @@ static void sony_remove(struct hid_device *hdev)
 	struct sony_sc *sc = hid_get_drvdata(hdev);
 
 	if (sc->quirks & (GHL_GUITAR_PS3WIIU | GHL_GUITAR_PS4)) {
-		timer_delete_sync(&sc->ghl_poke_timer);
+		/*
+		 * ghl_magic_poke() resubmits sc->ghl_urb from the poke timer
+		 * and its completion ghl_magic_poke_cb() re-arms the timer, so
+		 * an in-flight URB can re-arm the timer after a plain
+		 * timer_delete_sync() (a no-op while the URB is in flight and
+		 * the timer is not pending).  sc is devm-allocated and freed
+		 * once sony_remove() returns, so the re-armed timer would fire
+		 * on freed memory.  Kill the URB first so no completion can
+		 * re-arm the timer, then timer_shutdown_sync() to drain it and
+		 * permanently block further re-arming.
+		 */
+		usb_kill_urb(sc->ghl_urb);
+		timer_shutdown_sync(&sc->ghl_poke_timer);
 		usb_free_urb(sc->ghl_urb);
 	}
 
-- 
2.43.0

