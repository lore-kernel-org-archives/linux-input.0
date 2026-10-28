Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793171666;
	b=ISvOce0KN5qjB0P6QDxJxvaPhB33RwHHxC0Xgz36m/nN/udaQ0nsXoUisiSL9qKPHtVW
	 Vf+LSfuG/NfMWRJKMJ/AehpN7/rxxJtafvMl9ySogToBX1sRMEoKe4r5TkQo4aujuej1i
	 ILAsVm3geAo1m6Jqy7QeGCiSzNtgiCmqFmxRPVsdlEjH3jb03VxPSVdmq3ZkO+HfDxQfJ
	 xhM0FoV515T1RcLUIzz+YdGWnhDZVEGTZj6bsboMrrsl0rPYjyyu6GLX3xBGT0I3SWN7d
	 hQidQJJtv+lq0A4wEbweOMhyD4Y/WtsF81RCa1qgn1H5bz4SMWSWdD9z2fxdlqyrsLQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793171666;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer;
	bh=vAqK6/o3m7kulnS3Xo/WbNmGpSEBQ1pj1A+/29p6vTw=;
	b=J0f9LdLk8cNUHPKT6a016MwUgIg1hM2Mqquux43XN2uGVIURPtJXPIa9k+MVmQjmaPtz
	 t1vVqPR2D570tV3UPnWaWRiro1FkGU+DPTLjl95KooOPRudXXQf8vqU6Ef46zIOQDuixF
	 NFtHiyOtHCqQ/BTvp6hVjbEZl1imZ0m1mkgb1gbntSWcgQUTAw1aqCTBaWQX6gIfdUobJ
	 gZb5Q3Rpe808ydNHxjaj8cZfSL7wHbZaqo8Fhb6PGUpW9x/N7BQYV13Oqc7BqcfF2U0Ye
	 HQdYqJRfjQxKbvpfDYLEvWRXOmGiVin5tkGNA+0huHJRHtbEpk4W5jUoPqh+iM/MFiw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ehrwSBl4;
	arc=none smtp.remote-ip=209.85.161.48
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E087606A330
	for <linux-input@vger.kernel.org>; Wed, 28 Oct 2026 07:14:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6E087606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ehrwSBl4
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-705cb6cedd5so1088254eaf.1
        for <linux-input@vger.kernel.org>; Wed, 28 Oct 2026 00:14:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793171665; x=1793776465; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=vAqK6/o3m7kulnS3Xo/WbNmGpSEBQ1pj1A+/29p6vTw=;
        b=ehrwSBl4TtsiLOdL3GtdzjF+qUtnhJYe8oKyoThGpy08uOT+1Y/iId4kc/qFP3aaq5
         yhBZ/lsXEz9sbYMWm2j45wY9tI1i4xIYAXI8psgmr7YErnVvZMc24XEHF3ouSOK7DkrA
         fAmelVVzi44n7CoV9nJVWGsCY7pmanIRu4QDBRPwnvPNr4K8IPRHr7wuLRKdiIhx8lfn
         KxCfKQAPrdPcVjDotN2L/agom0xDMOPsHctdqsl3d6k97pEqoivNafX1ggO0WQ0Bj1n1
         f5OVKzY4E0Y4fHK5tF6LMnNFLrmqeroIicGyMPdXm0HnM+zm9jP5dD8JMclr+2UqDrQb
         Dw4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793171665; x=1793776465;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=vAqK6/o3m7kulnS3Xo/WbNmGpSEBQ1pj1A+/29p6vTw=;
        b=2wON0qfN9lJU7ycsYe8RgvMzD5c1lmgzezDLPXl97XrnKyenoGmEHz8gqQ5eLl/Mc9
         SpSGfXv9QL5Q5FJcZfQ4/ledJm+8wptsHD6ST9B3w9zV86MdI3O9fYwPKn3gKleqUlxV
         ahentcNCVH96TXNgvEsqaDNLZ24wqyF+y+R8v1F5Irfp147LYxyKYf35D+qap/QfI4ga
         m8Pymd2i9jjnF5QYIPzyh5XS7qTQXp5Onouan3cT5OV0BzcYonK8vXYhNMh4SdlUIfZB
         OjE1brQYo5zJbhzPfc+KpWmp4JKgDUljmFEafTmjXU+EGKHKJwsPgAh37xiBr+FZkpEr
         SVwA==
X-Forwarded-Encrypted: i=1; AKwUvBw2NiGU/LFEQw3CsHUukbqKtCKVj7MuOeheKPhV50/iLXZwp1kt73en4OsF2v9s0RcjtZjDJiG8TzucMA==@vger.kernel.org
X-Gm-Message-State: AFq9FYLpvHui8ilwjoqiv+MUB358cZr0h7h7A7/4lBpbHoFyqgDeGusd
	jPcGwD11L7tlFPz7HY/OWqgbFC1ebAAvOwjFEnMnM/e7ENY++H/bswOE
X-Gm-Gg: AYBFou2mZMg3ZjBtKoGaskfNXKZESjIme4rbpwPpTPiearmS20qK9CQgFyDOOkiawX6
	OoP/OxMBu/2WbtI36M8P2y7IEBrPn7OZr0EziacGEbnvY3l7IAkkrL9B3a7eJDq5KboCDKUQAVP
	eeuqjWphojQNZr5uHWfRAjwlFiHNjZo1WrRuUktIZew64y9ca9lH28GTxS1Qv7Vdj9k/+/B3d+/
	JcT0unfgve7pilbUwmFdfacrOktIjy6J+rGHd1XKIHsSUFqOzMHJXtRmP9rLTwYD0z/ex5kX7sl
	3mCarNbNb34nJuk3cwIyavPEhT0qCSsPwPosbmuWLk9wG9GUEtrz6xY31KgH+XRnjEpmwwEVGOt
	l1IvQvXZj97FD+1F+Je60vIxi5/a2pnB58s7DO/OFOMWzJ0viPj1ycyqnOnmBo8xmO1xRrGKi1y
	lbuZtCGYdmi/NIqhsIkFxjcV/N+hEt+s/Sh3BlMVJWX6INTRdr9OcKN11siqnamkNkvELx4+iJU
	WTkUVvcXUne6Rt8oiu+RU620Xo/fR+nD95DcF/eD4P2qO43AvDjsZ/1Aj1tev2uO0eyfdkNyWwH
	Rs/B40DrfxmjSZ603r/tpAUQZfX7Gc4mbd6tldE7g4LEyAIxYdniBkcLSotVoZ8qQmN+4n4HjVH
	EcMRZuTUF7MgU4Op/13wZBsvJNPA3Fo/Vk5BPzRMHLp7wSNCUNNr+UdJqYwMAJyhOJ9iWmA7B24
	n2Mj1HaYXVd88DvL52WW0bE1w/aIURXXmG+6AjwtJHcSxwIlrUJEt6
X-Received: by 2002:a05:6820:200d:b0:704:2628:b1ba with SMTP id 006d021491bc7-7126b0508a6mr2396619eaf.23.1793171665381;
        Wed, 28 Oct 2026 00:14:25 -0700 (PDT)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-85b20216574sm924598a34.20.2026.10.28.00.14.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 00:14:24 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Wed, 28 Oct 2026 01:14:19 -0600
Subject: [PATCH v2] Input: serport - defer write wakeups to a worker
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261028-submit-serport-write-wakeup-v1-v2-1-c05d96259985@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/42OTQ6CMBCFr0K6dpQWA8aV9zAsShlgVFrSH9AQ7
 m6LF3D5Ju99863MoSV07JqtzOJMjoyOQRwypgapewRqY2YiFyXPRQEuNCN5iLPJWA+LJY+wyCe
 GCWYOvGlbnudlJzvJImSy2NF7f3CvfzkSHqh8oqZGIx1CY6VWQzqRnoI/dcbCi3RwqTGQ88Z+d
 seZJ9LfOskIqjNWBedlcZHi1o+SXkdlRlZv2/YFqQSa4gABAAA=
X-Change-ID: 20261023-submit-serport-write-wakeup-v1-1bdd1006fafa
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org, 
 linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
 James Hilliard <james.hilliard1@gmail.com>
X-Mailer: b4 0.15.2

UART drivers can invoke the line discipline's write_wakeup() callback with
their port lock held. serport forwards the notification directly to the
serio driver. I-Force's callback can transmit a queued packet through
serio_write(), which calls back into uart_write() and tries to acquire the
same port lock. A notification after I-Force queues a packet but before it
sets IFORCE_XMIT_RUNNING can therefore deadlock.

Defer the serio notification to a work item, as required for transmitting
from a line discipline's write-wakeup path. Initialize the work disabled
and enable it, along with TTY_DO_WRITE_WAKEUP, only when a serio driver
with a write_wakeup() callback opens the port.

Clear TTY_DO_WRITE_WAKEUP and disable and drain the work when that driver
closes the port, before the serio driver and port can be torn down. This
allows the worker to call the driver without holding serport->lock,
breaking the lock ordering cycle with input event callbacks that write
to the UART.

Also clear TTY_DO_WRITE_WAKEUP and disable and drain the work on hangup,
before waking the reader to unregister the serio port. The additional
disable keeps the work disabled even if a driver opens the port while
hangup is in progress.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
Changes in v2:
- Follow Dmitry's lifecycle suggestion: initialize the work disabled and
  enable notifications only for a serio driver with a write_wakeup callback.
- Disable and drain the work in serio close before the driver is detached,
  allowing the worker to call the driver without holding serport->lock.
- Disable and drain the work in hangup before waking the reader, keeping
  it disabled even if a driver probe races with hangup.
- Link to v1: https://patch.msgid.link/20261023-submit-serport-write-wakeup-v1-v1-1-74e7311638a2@gmail.com
---
 drivers/input/serio/serport.c | 36 +++++++++++++++++++++++++++++-------
 1 file changed, 29 insertions(+), 7 deletions(-)

diff --git a/drivers/input/serio/serport.c b/drivers/input/serio/serport.c
index cabe3876c168..e522aa7f0fc2 100644
--- a/drivers/input/serio/serport.c
+++ b/drivers/input/serio/serport.c
@@ -18,6 +18,7 @@
 #include <linux/serio.h>
 #include <linux/tty.h>
 #include <linux/compat.h>
+#include <linux/workqueue.h>
 
 MODULE_AUTHOR("Vojtech Pavlik <vojtech@ucw.cz>");
 MODULE_DESCRIPTION("Input device TTY line discipline");
@@ -33,6 +34,7 @@ struct serport {
 	wait_queue_head_t wait;
 	struct serio *serio;
 	struct serio_device_id id;
+	struct work_struct write_wakeup;
 	spinlock_t lock;
 	unsigned long flags;
 };
@@ -54,6 +56,11 @@ static int serport_serio_open(struct serio *serio)
 	guard(spinlock_irqsave)(&serport->lock);
 	set_bit(SERPORT_ACTIVE, &serport->flags);
 
+	if (serio->drv->write_wakeup) {
+		enable_work(&serport->write_wakeup);
+		set_bit(TTY_DO_WRITE_WAKEUP, &serport->tty->flags);
+	}
+
 	return 0;
 }
 
@@ -62,8 +69,20 @@ static void serport_serio_close(struct serio *serio)
 {
 	struct serport *serport = serio->port_data;
 
-	guard(spinlock_irqsave)(&serport->lock);
-	clear_bit(SERPORT_ACTIVE, &serport->flags);
+	scoped_guard(spinlock_irqsave, &serport->lock)
+		clear_bit(SERPORT_ACTIVE, &serport->flags);
+
+	if (serio->drv->write_wakeup) {
+		clear_bit(TTY_DO_WRITE_WAKEUP, &serport->tty->flags);
+		disable_work_sync(&serport->write_wakeup);
+	}
+}
+
+static void serport_write_wakeup(struct work_struct *work)
+{
+	struct serport *serport = container_of(work, struct serport, write_wakeup);
+
+	serio_drv_write_wakeup(serport->serio);
 }
 
 /*
@@ -85,10 +104,11 @@ static int serport_ldisc_open(struct tty_struct *tty)
 	serport->tty = tty;
 	spin_lock_init(&serport->lock);
 	init_waitqueue_head(&serport->wait);
+	INIT_WORK(&serport->write_wakeup, serport_write_wakeup);
+	disable_work(&serport->write_wakeup);
 
 	tty->disc_data = serport;
 	tty->receive_room = 256;
-	set_bit(TTY_DO_WRITE_WAKEUP, &tty->flags);
 
 	return 0;
 }
@@ -239,6 +259,10 @@ static void serport_ldisc_hangup(struct tty_struct *tty)
 {
 	struct serport *serport = tty->disc_data;
 
+	clear_bit(TTY_DO_WRITE_WAKEUP, &tty->flags);
+	/* Keep work disabled even if a driver opens the port during hangup. */
+	disable_work_sync(&serport->write_wakeup);
+
 	scoped_guard(spinlock_irqsave, &serport->lock)
 		set_bit(SERPORT_DEAD, &serport->flags);
 
@@ -249,10 +273,8 @@ static void serport_ldisc_write_wakeup(struct tty_struct * tty)
 {
 	struct serport *serport = tty->disc_data;
 
-	guard(spinlock_irqsave)(&serport->lock);
-
-	if (test_bit(SERPORT_ACTIVE, &serport->flags))
-		serio_drv_write_wakeup(serport->serio);
+	/* A serio driver may write to the TTY, so defer the callback. */
+	schedule_work(&serport->write_wakeup);
 }
 
 /*

---
base-commit: f57202d55333f750a18e21c3b3f35f48ef14a61e
change-id: 20261023-submit-serport-write-wakeup-v1-1bdd1006fafa

Best regards,
--  
James Hilliard <james.hilliard1@gmail.com>

