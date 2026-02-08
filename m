Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3338A1F239B
	for <linux-input@vger.kernel.org>; Sun,  8 Feb 2026 19:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770579924; cv=none; b=pVOxpxE4HXPiFfo4RNDzlUUoijiwjokotTGgNR7svRvPj5dH2Y67Y24QRAcHxaSCvrqnBHAMweYNBuuulhkkCApChnf94kuzc9ck0nX+Nz94pc257jU8RrxThvhBvl6u58J9LzvV5ggfG642MiNlc6qa3ufCEETYt0U6w4akGmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770579924; c=relaxed/simple;
	bh=i31OkZlpgnIJcWukDCt8W/+B9RFRlgF6XnWc2qK8l8g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CmKZ/JolKogwja3H2baFxxTSqga/55N3sLSlPZZpdqECJhzYw9xIWgTX5MCnKBwwMwbW8RU5NTac07WE+xfJXbCxX4xyiq4zbuCteDqsaghNk+HkgwtN+54KNNFPar1Rw3G6Dzvoq05t0BfekGtxdgWeFzFzLL6/9vHiUIfZfOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IQery9JJ; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IQery9JJ"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4806d23e9f1so44465875e9.2
        for <linux-input@vger.kernel.org>; Sun, 08 Feb 2026 11:45:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770579922; x=1771184722; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4savXoBoHaXpOQrpiUmrwRajjDB478cEODdHQS8ceO8=;
        b=IQery9JJadSIcMEUjj3fg2vMVWxrsLl/8fV4wQM3uvGm1gaxhaTJOKE4RIy68br9Sx
         TWUFN3yBUf+5QT3wIMbW5i7sYlSCB3k3Ca7OAw7sEpLlHgFAshzJnda2tUGuzvULbUfQ
         2KPXd6icV9MSlc2B6qzwtMSEQdGPXsMS8c/uGzS0Kb3/ncTGGP8IPjcepMljcNRY99tf
         9GjiMiLpjFhx6U5IxqVTT9VM5naS7gYDHB2XJ3fcHxLZgf7fx8cibmSaVX3J0CgPTObE
         im7dOhzOJHR4wmu79GB8OJlyxY2zU0nB8hJedRGFCklN9tAWW0J89me/dBKNwpN0vTZt
         z1qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770579922; x=1771184722;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4savXoBoHaXpOQrpiUmrwRajjDB478cEODdHQS8ceO8=;
        b=LqokjYVc+LnlrmIaa94fxJnCTc18o0ho0qHm2OUtb6RWKIT/hJJCZqLkyZ7XX9vk4i
         MorA4yWuVQP9dy/Fula4KGSJYEWkypsgijU+4yIITkuYTeVT/DqFqqGPrdk/a98YaE7a
         AHLttIDQUmvHWOL65+wK8fafmPCTooT+5VHIm6Kak1tkRWa12dcgZjoZRPWZXumkuSc+
         8Zm4cLnv2qwq/35vUAaBz40P4pvriktQwEi2jwoJlFbNFIYddGTzgrecSToa8FqHVPsj
         hU1KAV7yKU/iaRqKRwhsCWKGhIfUd/95YsNTte3lMa1jVqAlL9bsccn/k0oqZT1L0BkZ
         VY8g==
X-Forwarded-Encrypted: i=1; AJvYcCXPmme+Qbzk3cP4XJ0dcsl6oPorPrTNaAF0IFlio3aDxQOpE2K6svXW6xB7poYa/wXEAtbZ6AeVmCFR3Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YxT+ioetzBzWhqlOmtwT4NYLDB1O7KY0UmNqQ2u2TQL7Vp1U0+E
	5Aa7FauG5xHUckG4zI8X6hm8mcKO+owC+fHKeXef/5+dUWPnxePBgISy
X-Gm-Gg: AZuq6aJr6kONQTuwK6GQNpcILgtQy2lK0atcdrh6PgdDt1EAH/+LHix2n0Ei11gjkdA
	XfrQ5ZpEi9rSavhcL4Bon48lcAVfpO5mSOwig5VuqiTTfU9SmOzjedEPaqz5uNuurhvSR+naxV/
	PY1WHM0GksLEnSeoKFGXqZ9joLoV5roI3vwPGF67jC3Umfc/yJjw29rTcUk/mYGMyzZO/jHmro6
	PIcFcJ7pi3s4nKAd6utRxSmfTDc8hu7yDOzufIiKAyIY4Nvt3/s895x6SXsOuYUCx9lYRaCNSNN
	yTxuUWqLCLFPnORQamu+E3kjDU4Q3TFBK3i+CXwuuwYhZ+uJjq+f/KKRXEgHfuhE1A2yV7qXOa1
	8Zk+JzNkJ9Ud12eT9sxLe4fxzluEd21hkN6W8KSRj/exRnfdeNn3Ap1uVgObWYnI0z9ofXNinC6
	XSMsHZmrqZnMXWmHQSoUNFwgOMieJCpmHUSne4OLUb4ENeww==
X-Received: by 2002:a05:600c:8116:b0:480:3b26:82c3 with SMTP id 5b1f17b1804b1-4832021b549mr111365415e9.20.1770579922050;
        Sun, 08 Feb 2026 11:45:22 -0800 (PST)
Received: from osama.. ([197.46.145.207])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4832040e91fsm74211585e9.6.2026.02.08.11.45.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Feb 2026 11:45:21 -0800 (PST)
From: Osama Abdelkader <osama.abdelkader@gmail.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Osama Abdelkader <osama.abdelkader@gmail.com>,
	syzbot+1b327485934adf39955b@syzkaller.appspotmail.com
Subject: [PATCH] Input: evdev: fix data race in evdev_read() and evdev_poll()
Date: Sun,  8 Feb 2026 20:45:15 +0100
Message-ID: <20260208194516.172227-1-osama.abdelkader@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Protect all reads of client->packet_head with buffer_lock to fix a
KCSAN-reported data race. The race occurs between:

- evdev_pass_values() writing to packet_head (protected by buffer_lock)
- evdev_read() reading packet_head without lock protection
- evdev_poll() reading packet_head without lock protection

The fix ensures all accesses to packet_head are protected by buffer_lock,
matching the existing write-side protection pattern used in
evdev_pass_values() and evdev_fetch_next_event().

Changes:
- evdev_read(): Protect packet_head read in O_NONBLOCK check
- evdev_read(): Protect packet_head read in wait loop condition
- evdev_poll(): Protect packet_head read in poll check

KCSAN report:
BUG: KCSAN: data-race in evdev_pass_values / evdev_read

write to 0xffff888104842008 of 4 bytes by task 8439 on cpu 1:
 __pass_event drivers/input/evdev.c:239 [inline]
 evdev_pass_values+0x387/0x4e0 drivers/input/evdev.c:278
 evdev_events+0x8e/0xd0 drivers/input/evdev.c:306
 input_pass_values+0x123/0x390 drivers/input/input.c:128
 input_event_dispose+0x248/0x320 drivers/input/input.c:342
 input_handle_event+0x9e8/0xa20 drivers/input/input.c:370
 input_inject_event+0xbc/0x120 drivers/input/input.c:424
 evdev_write+0x224/0x2b0 drivers/input/evdev.c:528
 vfs_write+0x269/0x9f0 fs/read_write.c:684
 ksys_write+0xdc/0x1a0 fs/read_write.c:738
 __do_sys_write fs/read_write.c:749 [inline]
 __se_sys_write fs/read_write.c:746 [inline]
 __x64_sys_write+0x40/0x50 fs/read_write.c:746
 x64_sys_call+0x2847/0x3000 arch/x86/include/generated/asm/syscalls_64.h:2
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xc0/0x2a0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

read to 0xffff888104842008 of 4 bytes by task 2991 on cpu 0:
 evdev_read+0x157/0x5e0 drivers/input/evdev.c:572
 vfs_read+0x1ab/0x7f0 fs/read_write.c:570
 ksys_read+0xdc/0x1a0 fs/read_write.c:715
 __do_sys_read fs/read_write.c:724 [inline]
 __se_sys_read fs/read_write.c:722 [inline]
 __x64_sys_read+0x40/0x50 fs/read_write.c:722
 x64_sys_call+0x2889/0x3000 arch/x86/include/generated/asm/syscalls_64.h:1
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xc0/0x2a0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

value changed: 0x00000002 -> 0x00000004

Reported-by: syzbot+1b327485934adf39955b@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=1b327485934adf39955b
Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>
---
 drivers/input/evdev.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/drivers/input/evdev.c b/drivers/input/evdev.c
index 90ff6be85cf4..eebd59d190f5 100644
--- a/drivers/input/evdev.c
+++ b/drivers/input/evdev.c
@@ -569,9 +569,13 @@ static ssize_t evdev_read(struct file *file, char __user *buffer,
 		if (!evdev->exist || client->revoked)
 			return -ENODEV;
 
+		spin_lock_irq(&client->buffer_lock);
 		if (client->packet_head == client->tail &&
-		    (file->f_flags & O_NONBLOCK))
+		    (file->f_flags & O_NONBLOCK)) {
+			spin_unlock_irq(&client->buffer_lock);
 			return -EAGAIN;
+		}
+		spin_unlock_irq(&client->buffer_lock);
 
 		/*
 		 * count == 0 is special - no IO is done but we check
@@ -593,9 +597,12 @@ static ssize_t evdev_read(struct file *file, char __user *buffer,
 			break;
 
 		if (!(file->f_flags & O_NONBLOCK)) {
-			error = wait_event_interruptible(client->wait,
+			spin_lock_irq(&client->buffer_lock);
+			error = wait_event_interruptible_lock_irq(client->wait,
 					client->packet_head != client->tail ||
-					!evdev->exist || client->revoked);
+					!evdev->exist || client->revoked,
+					client->buffer_lock);
+			spin_unlock_irq(&client->buffer_lock);
 			if (error)
 				return error;
 		}
@@ -610,6 +617,7 @@ static __poll_t evdev_poll(struct file *file, poll_table *wait)
 	struct evdev_client *client = file->private_data;
 	struct evdev *evdev = client->evdev;
 	__poll_t mask;
+	bool have_data;
 
 	poll_wait(file, &client->wait, wait);
 
@@ -618,7 +626,11 @@ static __poll_t evdev_poll(struct file *file, poll_table *wait)
 	else
 		mask = EPOLLHUP | EPOLLERR;
 
-	if (client->packet_head != client->tail)
+	spin_lock_irq(&client->buffer_lock);
+	have_data = client->packet_head != client->tail;
+	spin_unlock_irq(&client->buffer_lock);
+
+	if (have_data)
 		mask |= EPOLLIN | EPOLLRDNORM;
 
 	return mask;
-- 
2.43.0

