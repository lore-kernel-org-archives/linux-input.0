Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA55232572F
	for <linux-input@vger.kernel.org>; Sun, 30 Aug 2026 20:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788123183; cv=none; b=TEjCj692/0cADc2OXh3hF86boGgqVxvLV1Mt9uGCjFiEngtafAUV2celQzhx3gdiVIYwZT798RmcZYA0mZxKKPayOK1zQDHY0PfO1JC0scFqh+H4oi8ctM+OCb4GL1uhdW2566CqlA8ss5jI+eAFKnoDEXp+ryvtUbmYuPYYnlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788123183; c=relaxed/simple;
	bh=GXnE++8ycCQ3Geyc1VEaJivw863kljbsemhtvc2XkW0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hMLDB+q2uaiJQXY7+5jsM43HHxaOXiffzq4JFMEFGegwtrMLrLGXz5Gz5aAIsjsQmcvUdA8VQOQ0u6mMp+Mh5+9BKRwfyunO85nTZYDUF1/AnHs7odH8KL5aw/g5vAuSqEMv2MOyt1m4JpmUzh3QFNGSQywwhn6Btn6qITeVsPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LMIlAmQv; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LMIlAmQv"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-38fdeaed181so4263006a91.1
        for <linux-input@vger.kernel.org>; Sun, 30 Aug 2026 13:52:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788123176; x=1788727976; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6Dq60Pyzo1OLSy7MU+OaidMLABdeC4LX97otWKe9Wa0=;
        b=LMIlAmQvTa8F1O3iDv4z56PI9Z8qth5rgwpOm6Het98hLwadf5fDHBEqJ5dgss9zLz
         3OU7PZ7alooHd3aI5tx5ju1cNQkBKB1w8No5eV1K51x1egwwxWxkTfpeRGY8wEyZ/H9C
         V9iO9Xpn3U+J7Mh5TfSt5JjS6G99sdmUwjvkmSPVhz2sNzKZ6ECyKJO6lkLiyzCQ744t
         V+xuuIj734Jt91jZiTDb1b2TJo1TppDPuo6JpLRKUTnXzPO1kuG8/4+Gc5lvAv+olpMV
         WNCsqd5IgTq03vuSoGv1QgDxR+6AlkNTOOOHAs0eo3D6c8eTfZMqgyQXMg4ZNpTLL0WD
         EEhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788123176; x=1788727976;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6Dq60Pyzo1OLSy7MU+OaidMLABdeC4LX97otWKe9Wa0=;
        b=rJ38xT91CIUMtc7xmBPfz1Lt0b2cjojOoKGHLybeSmGsTu45ywCBjQFHmbDXQaWOWV
         pvK/g49zW37cKVUzT1rq2xKmRVhE6cM0cooYPFsmews3lMnIxq8/i2ijLfs1dlEdJXba
         z2LQNxZFqPvusRPnea86Ilh0xgIrfO5wIhd2FkbRXijyvAfJ/OSu+Al+d/Dh6BiPIOqT
         AON8gZ6P8m709Kwm06KsgUKadGpopEnmlUT+c3N4G70X/W0W9V6kNZL30XF3lBhjoRZ+
         sp16bquiyEM77CLfzLXSBfSfZ81TeH/rQT3XPeaT/QVadnox5KLk6XVhdscSVrH/y3Nn
         iVXQ==
X-Forwarded-Encrypted: i=1; AKwUvBxCIXe+vX9G6dPXKxN1kunxP+RLqOofHPPRxSbmXl710DDo0iL642lZTCY8ZNcvObdhlb20DqT66+GvSA==@vger.kernel.org
X-Gm-Message-State: AFuF++mCk6fQP7H8OmwlbM+iolnUicfYNk2oN2yMUItB7+yOI2kdcAGQ
	4EVjH78uFFgv0sTKUxKfBKY2IoWeVMg/4XQ3XcB/IGa1bQZv9UlqKZhd
X-Gm-Gg: AYBFou2u7R+JlHCrLS5RYUS1hhUg3N+W0aJ+KhdjZV+FQByS6chcAYDY4yQ1EiK+6fH
	ktre9t6T+WZJdklu7URaYX8Hmub578tQFckb+M8uuIa+liBiedkckzlG9tUbUuNr0nF1w+RppcL
	j4Dh64xpWmyWO6mYg0AcWdMm4Kb7TDo8vrSdVKqugFog/Luk6Y30VFkP0GAwEQnM/GC4oHSYoOk
	CTmyq71PWNpbYDw18a6wkSz9bbqwGsdKM1h9kyWozD/K3ssKBOEIyCW8wWsuxowNNOnXVoIN+eO
	fg1KmBbOWZD9+JV2LE5xRBKGD71S3TKghYQQeJpw64B+/78V2HaVSoV2hXwWwTRTblescx2UiE7
	8lL7jXcZz17l2vK2Ksy/dz1Os9wjx+xAaMOoyWbQSpLJiSbzmlYl2FWAdP2cGWBUCRxaLqa4xmF
	AQSqYCRzhfKemZozf7ei8hwClLo4taoIa5r8Qe6YnCM0q7Lbz4+qceivfJVL+VqX9KQ//+58rmm
	XUxDsu7ieJgZgbIakV6Q/CxVf2i5iJgtd8Z1R0RqEEeYJ/f/nY=
X-Received: by 2002:a17:90b:3812:b0:398:b71e:60c1 with SMTP id 98e67ed59e1d1-398b71e6250mr11845600a91.12.1788123176445;
        Sun, 30 Aug 2026 13:52:56 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:c021:485f:75be:3c7])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3286f9e3cf8sm26849437eec.24.2026.08.30.13.52.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Aug 2026 13:52:54 -0700 (PDT)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date: Sun, 30 Aug 2026 13:52:47 -0700
Subject: [PATCH 2/7] Input: gscps2 - use RCU for ps2port_list and manage it
 in open/close
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260830-gscps2-v1-2-c733d4cae7f9@gmail.com>
References: <20260830-gscps2-v1-0-c733d4cae7f9@gmail.com>
In-Reply-To: <20260830-gscps2-v1-0-c733d4cae7f9@gmail.com>
To: "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, 
 Helge Deller <deller@gmx.de>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, 
 linux-parisc@vger.kernel.org, sashiko-bot@kernel.org
X-Mailer: b4 0.16-dev-b242f

Managing ps2port_list in gscps2_probe() and gscps2_remove() had two
issues:

- in gscps2_remove(), serio_unregister_port() frees the serio port, but
  because the port remained in ps2port_list until later in remove, a
  shared interrupt firing on another CPU could traverse ps2port_list and
  dereference the freed serio port

- ps2port_list additions and deletions in probe/remove raced locklessly
  against list traversals in gscps2_interrupt().

Convert ps2port_list traversal in gscps2_interrupt() to use RCU, and
move list management to gscps2_open() and gscps2_close(). When
serio_unregister_port() runs during device removal, serio_close() is
invoked, cleanly taking the port out of ps2port_list before the serio
structure is destroyed, while maintaining active hardware communication
during child driver disconnect.

Reported-by: sashiko-bot@kernel.org
Assisted-by: LLM
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/serio/gscps2.c | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/drivers/input/serio/gscps2.c b/drivers/input/serio/gscps2.c
index b82c56ba8ff7..5b6e311f8a02 100644
--- a/drivers/input/serio/gscps2.c
+++ b/drivers/input/serio/gscps2.c
@@ -26,6 +26,7 @@
 #include <linux/io.h>
 #include <linux/ioport.h>
 #include <linux/property.h>
+#include <linux/rcupdate.h>
 #include <linux/serio.h>
 
 #include <asm/irq.h>
@@ -195,6 +196,7 @@ struct gscps2port {
 	int id;
 };
 
+static DEFINE_SPINLOCK(ps2port_list_lock);
 static LIST_HEAD(ps2port_list);
 
 /*
@@ -292,14 +294,16 @@ static irqreturn_t gscps2_interrupt(int irq, void *dev)
 {
 	struct gscps2port *ps2port;
 
-	list_for_each_entry(ps2port, &ps2port_list, node) {
+	guard(rcu)();
+
+	list_for_each_entry_rcu(ps2port, &ps2port_list, node) {
 		guard(spinlock_irqsave)(&ps2port->lock);
 
 		gscps2_read_data(ps2port);
-	} /* list_for_each_entry */
+	}
 
 	/* all data was read from the ports - now report the data to upper layer */
-	list_for_each_entry(ps2port, &ps2port_list, node) {
+	list_for_each_entry_rcu(ps2port, &ps2port_list, node) {
 		if (gscps2_report_data(ps2port)) {
 			/* More data ready - break early to restart interrupt */
 			break;
@@ -397,6 +401,9 @@ static int gscps2_open(struct serio *port)
 
 	gscps2_reset(ps2port);
 
+	scoped_guard(spinlock_irqsave, &ps2port_list_lock)
+		list_add_tail_rcu(&ps2port->node, &ps2port_list);
+
 	/* enable it */
 	gscps2_enable(ps2port, true);
 
@@ -413,6 +420,11 @@ static void gscps2_close(struct serio *port)
 	struct gscps2port *ps2port = port->port_data;
 
 	gscps2_enable(ps2port, false);
+
+	scoped_guard(spinlock_irqsave, &ps2port_list_lock)
+		list_del_rcu(&ps2port->node);
+
+	synchronize_rcu();
 }
 
 /**
@@ -446,6 +458,7 @@ static int __init gscps2_probe(struct parisc_device *dev)
 
 	ps2port->port = serio;
 	ps2port->padev = dev;
+	INIT_LIST_HEAD(&ps2port->node);
 	ps2port->addr = ioremap(hpa, GSC_STATUS + 4);
 	if (!ps2port->addr) {
 		ret = -ENOMEM;
@@ -501,8 +514,6 @@ static int __init gscps2_probe(struct parisc_device *dev)
 
 	serio_register_port(ps2port->port);
 
-	list_add_tail(&ps2port->node, &ps2port_list);
-
 	return 0;
 
 fail:
@@ -539,12 +550,10 @@ static void __exit gscps2_remove(struct parisc_device *dev)
 	serio_unregister_port(ps2port->port);
 	free_irq(dev->irq, ps2port);
 	gscps2_flush(ps2port);
-	list_del(&ps2port->node);
 	iounmap(ps2port->addr);
 #if 0
 	release_mem_region(dev->hpa, GSC_STATUS + 4);
 #endif
-	dev_set_drvdata(&dev->dev, NULL);
 	kfree(ps2port);
 }
 

-- 
2.55.0.897.gb25b4bd76c-goog

