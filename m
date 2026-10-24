Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792815828;
	b=IpryNQFjGxK1719z+zObUoeTw4xnDw9zky5saIz5IbDJUGor2bzitUVxUYfToQxJWnLR
	 CEs9bQ3CGvEgkJagT4M3W7DIjDRWdEYqSCbRpsGUMYu1qTIadSf9W83YI15R0uvO/xBzF
	 al7UM8TkrY65cOfDv45vffM9EBla7uyGRthZblk+r95+w+c9yr4sIm/7GrcURyhQU0+sV
	 yr+DPtRrdjEnpgo9C3YNNUWOIdoE64gFCgZWS5wmIE7Bg1C6s73dgMj0jNt3brAZPRTK+
	 FHsaUbeHnGpHLPrKLS93veiG+QkyKOn2HyPK7cgGUgOf7hB8l9o8i8d6F3fFlYBDrnQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792815828;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer;
	bh=A7v3iQvYpOI1vlkhEubPLkV9x5gOZiQT5f5VIsmNMyk=;
	b=mjXT5Vk5TBxYcJub15KeGrOtIPlF+1+TbKELimh+vD3SeNl7pJlGpzRODEe17X9ouTVp
	 apYOKkZBDSJ2QBPRKkSCBEyRNiANYKrFsOzfN53CIxR8u4EPNkO266Th7d3iXPUahM3HS
	 eAkjRV3mRyD7Pr5uAWTTzR0HW+uGYjbn1mLHWl0XKTgk3EOPwZ0FEIfdtz8WAYu6nWE6d
	 YT+d3PbO5kLatFYsF56dDvzCix/kEjzdI3vXBas25nRGXUjH0tuxrayP9tGiXNOcW3BmC
	 QSOk1VmeMkgpiP9sxMiy6ACmoa1powfS9P1gJZRsxYBJ4Nz9FAkO67tLxmmU0HJ7NgQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=glD74pUq;
	arc=none smtp.remote-ip=209.85.167.177
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 427F1606A31D
	for <linux-input@vger.kernel.org>; Sat, 24 Oct 2026 04:23:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 427F1606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=glD74pUq
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-4af173320f9so904236b6e.2
        for <linux-input@vger.kernel.org>; Fri, 23 Oct 2026 21:23:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792815827; x=1793420627; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=A7v3iQvYpOI1vlkhEubPLkV9x5gOZiQT5f5VIsmNMyk=;
        b=glD74pUqbkxWRdZnLCx3z60ZiLGN9SkQ82qloBuEp8QYlM9I7Z4/ghs9839ux9Sim3
         h0x6oKvoaSA4mG3EEKuJforRNNCa/VCIJRfUg4fip1q/XJjedlIbwt9+O7/v3W6Hx2Fv
         Xj53HOLbRTTSBbLjHxHRAVakPg/OnQ4nojy3sR3QdukG2RLNbQgZE4Bg5vpB0GXc4Fz0
         Itjqsu8/z5wrMYZVe8Zw0IrKFrK1EBeBou0i5LOCh0K4OP+tRB8i4BNeqzvOZ8Xe9rNM
         7w/tXHYufggjje0ugsQLs4fklpm0wiU1/IRjuY1nPvsp9Dx7hYHvrGowt/vmoMwWl9W4
         mYFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792815827; x=1793420627;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=A7v3iQvYpOI1vlkhEubPLkV9x5gOZiQT5f5VIsmNMyk=;
        b=S4QU+Dijkp7ZCUTdzPwFMgo+kVk4DLf8bAOvAYNmab7JNmRyU5vJIjgPgfFKJGd/H2
         g148JxU3mvkFSxXUcdTKRbdA30ViTX3qcnxfSHv0HghgoaPaPqtzcT13207IcfeM7PUp
         NBsn5dwP5XP4jX+DqbtuWdrhbIBkMsJQNMwuNu4Y0JI/rb+cI8QQuGW84QduXB8fDIGh
         pCMWz3GnQt+y1Ip1hLI8f+sJqrrAcTIjqZUOzCTqzKO+7roqG3U1NcVneyDcD8GieNoI
         aik1oJ1fC5B9CObrvPLDhgALyn1fpt1c2OVxZ3A5kq3B9QlyyAy3mh+3jvWl2bBEDtwG
         4bgw==
X-Forwarded-Encrypted: i=1; AKwUvBxIqpzehof0lws0yusXRbNFEcETKnyZbW006QbFYNgC7F0J5VPb29axwZ/NgZyQ9fXjq5dN0LILAy1Fqg==@vger.kernel.org
X-Gm-Message-State: AFq9FYIrk7ABSz0VPLA6t3fIR+orq1L+XuoTSLvxZV5lJsVaZwQSO3/s
	y5mGLlF/00Rh+AVC7iVShmZsrwSaxpNt3I3yrilXgNMuuhNBKZr6IIDX
X-Gm-Gg: AYBFou3oIRQfLzlEyRFR2sXTgA9EIUhq4fVCnC9OveKKzG/MMbEs1cw8r8HVPdwrHNt
	VRe0r2Sr8PaZgkU7zlzpyypqtuemZSftl/aW/PQMySEde5f/13K6yhG1oD6zEUk3WlQYLzjLmYo
	5l6qxrR8glBec85HZrwf3OcOBKQNoup7zhIXi5+SkHC+z8WCDpP9PeY4+n6MuJhz57jnYNaS6bC
	758FR6PAZjyQat1HXuHxnpANe1z5lFGLed+m+1Rd9GrQx1efV+KosROlFo0wntZtReyEqvG2FXK
	vkRpka6WuUQxSp2NkI5BCArC12IiJiZiaTWC4UbTdbPcb/cDN0iBTjmAd8e0+D4YTH0rHBIcMk7
	lc0q4NGidgCizuhEsJCimIrhszPI+m7XtCCDsWE683WzgBDiDfrhzhARAq/Ywl2MUTZySFuehb/
	qmaIn4DD1Yia91X0Td/am+yHOXEUSRJ2r23Ua8mptgOG650qE7c4eMEKdXjtxjM+uQKakn6BEUA
	UUWUVXjw09DGWoZbgikqm0VNIm65E+6h8OJGjDjJINVd2sLkjmmMDrO0zU9OeqRojPXrmw2jv1r
	SaV8Y1zdX9gcXnoOAqlys/pfw34h4DNrTUXlbmltPGfn62uQqo4u93fXSoqt2c3TBkUOYJW5PYZ
	/IzZ8VrAG+yghGoyxuMlpywffGmn3GWGe9c7iWcP/nooauGZJk132eCFAsnB9cXBLfsUieSah2v
	IYExn0
X-Received: by 2002:a05:6808:e89:b0:539:a2c2:aba3 with SMTP id 5614622812f47-55c00366527mr677126b6e.52.1792815827190;
        Fri, 23 Oct 2026 21:23:47 -0700 (PDT)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-55c040806a7sm691649b6e.2.2026.10.23.21.23.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 21:23:46 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Fri, 23 Oct 2026 22:23:44 -0600
Subject: [PATCH] Input: serport - defer write wakeups to a worker
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
Message-Id: <20261023-submit-serport-write-wakeup-v1-v1-1-74e7311638a2@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWNSw7DIAxErxJ5XauQSln0KlUXEEzjfggykESKc
 vdCu3yjmTc7JBKmBNduB6GFE8+hgj51ME4mPAjZVYZe9YNW/QVTsR/OWGdxloyrcCZczYtKxEW
 jts5ppQZvvIEqiUKet9/B7f7nanjSmJu1NaxJhFZMGKcWcYgln/0s+OZQEhzHF6qWmPqkAAAA
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
from a line discipline's write-wakeup path. Keep the SERPORT_ACTIVE check
and callback under serport->lock to serialize with serio close. Cancel the
work before freeing serport in line-discipline close, where the TTY layer
has already excluded further line-discipline callbacks.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/input/serio/serport.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/drivers/input/serio/serport.c b/drivers/input/serio/serport.c
index cabe3876c168..24c0d0c0c9aa 100644
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
@@ -66,6 +68,16 @@ static void serport_serio_close(struct serio *serio)
 	clear_bit(SERPORT_ACTIVE, &serport->flags);
 }
 
+static void serport_write_wakeup(struct work_struct *work)
+{
+	struct serport *serport = container_of(work, struct serport, write_wakeup);
+
+	guard(spinlock_irqsave)(&serport->lock);
+
+	if (test_bit(SERPORT_ACTIVE, &serport->flags))
+		serio_drv_write_wakeup(serport->serio);
+}
+
 /*
  * serport_ldisc_open() is the routine that is called upon setting our line
  * discipline on a tty. It prepares the serio struct.
@@ -85,6 +97,7 @@ static int serport_ldisc_open(struct tty_struct *tty)
 	serport->tty = tty;
 	spin_lock_init(&serport->lock);
 	init_waitqueue_head(&serport->wait);
+	INIT_WORK(&serport->write_wakeup, serport_write_wakeup);
 
 	tty->disc_data = serport;
 	tty->receive_room = 256;
@@ -101,6 +114,7 @@ static void serport_ldisc_close(struct tty_struct *tty)
 {
 	struct serport *serport = tty->disc_data;
 
+	cancel_work_sync(&serport->write_wakeup);
 	kfree(serport);
 }
 
@@ -249,10 +263,8 @@ static void serport_ldisc_write_wakeup(struct tty_struct * tty)
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
base-commit: 2e6f2e5799f328ca0879dad14d7f3709c7f7496b
change-id: 20261023-submit-serport-write-wakeup-v1-1bdd1006fafa

Best regards,
--  
James Hilliard <james.hilliard1@gmail.com>

