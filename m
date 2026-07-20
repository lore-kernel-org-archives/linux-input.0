Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4EC33955F9
	for <linux-input@vger.kernel.org>; Mon, 20 Jul 2026 10:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784542494; cv=none; b=B5hk1rih5KExEh/TcF5ch8dyuqyUGoQlJBqngWmpAiQz5XhPhu7aeQiY53IqWKTZXYnqpK9stg1ukxb3/LhFqakI1JZmoXSZPqZtI97bK8c+ZMdyHfQv5suNYc0Yzd0UPg44R2bbVgqtCVGH/k5TKr0e8kjZ/OFoRCO2Hkno/PQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784542494; c=relaxed/simple;
	bh=4olgis/+UK7LivGkbVIiRcuHyl1sNyQgXPWAGbpQwxE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PcQtOrvoLUUU20xNjAVR22KCzWUQeYIGyNXm6F0ZSVtwCxHY5cr5dXQ3CyfOugchcah9mUYCPXrcD0AGCrD7XCfCRWMQFV9gT/a+cYqOETI0tt+4sxeMnIh5bsRgZxUJOucFaKEeHf7fhzSVOLi6ZIj5yyTKSnVZ7jctVPw5DvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-848595b338cso11293459b3a.0
        for <linux-input@vger.kernel.org>; Mon, 20 Jul 2026 03:14:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784542483; x=1785147283;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=qUJCDmAKuwvWzvfCdV4S2qqsvo7USEen3xkhjOW/vGU=;
        b=I73zWluu/cGqH/IqjJO3FTH5rQ+Cq+1t2FCyLEiAcokeqb8z3i5t0DAhs1vWpyBimt
         Q+Or5UVwIYqmOJFq28XxTabgPOSrc6rSCFoDaKVuna3LqGg9Oi/nA29M4kbBYvAkyrVC
         SHmY158OjuqMztNT1VRf7YAwLoU+kzoAcCecK2nQJjMdjZPIEJiAaaa9bTcXBToVllP5
         eBF/vvrpB0LpTGVwmUlj4iS5BDvcNxLX7KF5EmJm3TPgN3dMaz91Qa2v3FmBLpxwC66m
         lqyhNEzu2eQfvVELK1TkBuHoiaOvIezmEFF5a5tXA9CC3um1bTY9g2Oc2TvW/5ZQpDBY
         HfHA==
X-Forwarded-Encrypted: i=1; AHgh+Rr1a1xLfelAJM0PKkwnLDyJSeVCDcwaLIfkvAvGOaceDslJ8fJ/7bIYeQvb0FtEbS0YiCHbllhP1vm1NA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyvNy1OaGZn6yXQpl9Ib61YJ9Pqlr3trdWnKCUf0mmoGFZ9XMK3
	yAxGrQPRYGKGywoZRlfu9dGd4kKk6k649ppCMj94mMWyPJ0/6PJ0vuw=
X-Gm-Gg: AfdE7cmpPY3x8RWKmE/bIBQqU2vuyb8rd9S+05BWi8ICbabm7E4U3Qdsq+JpkkpXd2n
	ZHcR+9c84MN1IKC029HSMeIfmly8p9We7i6xtd1QIa+nYhWWFNsIxFP7t5LVvWCBMkymi+8f24Y
	KD0gkHcUPXAsLbODdKGnHoxln0ctsIeFoFezg/MnmSp60ctAibydgE9TG+V5MXGLkvzQA58pjP0
	Nlfs+fx1/BK9Ln/PanCZzCKlEQzucbpG1jifmrdYpPSEVg3zeLceVxaAy6gpeWRhSiGt/Ka2yQP
	8eVlT/Qzpfcs4j0Kga7IXfXWH0Hw/uw5h515VN7VWQYcXpoyjWetSChO4PE5bL3CBO1JKa1wmBY
	sq2+XksdDlA/x5PQUf5c1uVXIhn/zxretg4xjBbeTfgw3DDbvpdfsz85klrCfiTK3U0fm9yp6MF
	vAkqOG2PBEURImCdWdEmW6mwmeRoCUgejZvgEAPmPX0+bjd5wQ0rOMCah6kCqkfPZ+JSo69Kaoi
	Nr4YkNqS7m1ML+r6Q==
X-Received: by 2002:a05:6a00:1f09:b0:845:e440:d0ca with SMTP id d2e1a72fcca58-84c292a0323mr13167391b3a.8.1784542482681;
        Mon, 20 Jul 2026 03:14:42 -0700 (PDT)
Received: from penguin.tail0a1999.ts.net (61-228-16-100.dynamic-ip.hinet.net. [61.228.16.100])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cb517f94c31sm4411321a12.13.2026.07.20.03.14.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 03:14:42 -0700 (PDT)
From: Shih-Yuan Lee <fourdollars@debian.org>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Mark Brown <broonie@kernel.org>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Shih-Yuan Lee <fourdollars@debian.org>
Subject: [PATCH v2 1/5] Input: applespi - use unified wait queue with timeouts for drain
Date: Mon, 20 Jul 2026 18:14:31 +0800
Message-Id: <20260720101435.13612-2-fourdollars@debian.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260720101435.13612-1-fourdollars@debian.org>
References: <20260720101435.13612-1-fourdollars@debian.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The driver currently maintains a dedicated wait queue 'drain_complete'
specifically to wait for outstanding write requests to complete.
Consolidate this with other wait events by renaming it to 'wait_queue' to
make resource management cleaner.

Furthermore, using wait_event_lock_irq() without a timeout risks blocking
the thread indefinitely during driver unbinding (remove) or PM transition
phases if the hardware fails to respond or interrupts are missed.

Replace wait_event_lock_irq() with wait_event_lock_irq_timeout() in
applespi_drain_writes() and applespi_drain_reads() with a 3-second timeout.
This ensures the driver can gracefully recover and avoid lockups under
unresponsive hardware conditions.

Signed-off-by: Shih-Yuan Lee <fourdollars@debian.org>
---
 drivers/input/keyboard/applespi.c | 32 +++++++++++++++++++++----------
 1 file changed, 22 insertions(+), 10 deletions(-)

diff --git a/drivers/input/keyboard/applespi.c b/drivers/input/keyboard/applespi.c
index b5ff71cd5a70..64bbeba85ea9 100644
--- a/drivers/input/keyboard/applespi.c
+++ b/drivers/input/keyboard/applespi.c
@@ -417,7 +417,7 @@ struct applespi_data {
 
 	bool				suspended;
 	bool				drain;
-	wait_queue_head_t		drain_complete;
+	wait_queue_head_t		wait_queue;
 	bool				read_active;
 	bool				write_active;
 
@@ -677,7 +677,7 @@ static int applespi_setup_spi(struct applespi_data *applespi)
 		return sts;
 
 	spin_lock_init(&applespi->cmd_msg_lock);
-	init_waitqueue_head(&applespi->drain_complete);
+	init_waitqueue_head(&applespi->wait_queue);
 
 	return 0;
 }
@@ -725,7 +725,7 @@ static void applespi_msg_complete(struct applespi_data *applespi,
 		applespi->write_active = false;
 
 	if (applespi->drain && !applespi->write_active)
-		wake_up_all(&applespi->drain_complete);
+		wake_up_all(&applespi->wait_queue);
 
 	if (is_write_msg) {
 		applespi->cmd_msg_queued = 0;
@@ -1415,7 +1415,7 @@ static void applespi_got_data(struct applespi_data *applespi)
 			applespi->read_active = false;
 			applespi->write_active = false;
 
-			wake_up_all(&applespi->drain_complete);
+			wake_up_all(&applespi->wait_queue);
 		}
 
 		return;
@@ -1793,21 +1793,33 @@ static int applespi_probe(struct spi_device *spi)
 
 static void applespi_drain_writes(struct applespi_data *applespi)
 {
-	guard(spinlock_irqsave)(&applespi->cmd_msg_lock);
+	unsigned long flags;
+
+	spin_lock_irqsave(&applespi->cmd_msg_lock, flags);
 
 	applespi->drain = true;
-	wait_event_lock_irq(applespi->drain_complete, !applespi->write_active,
-			    applespi->cmd_msg_lock);
+	wait_event_lock_irq_timeout(applespi->wait_queue,
+				    !applespi->write_active,
+				    applespi->cmd_msg_lock,
+				    msecs_to_jiffies(3000));
+
+	spin_unlock_irqrestore(&applespi->cmd_msg_lock, flags);
 }
 
 static void applespi_drain_reads(struct applespi_data *applespi)
 {
-	guard(spinlock_irqsave)(&applespi->cmd_msg_lock);
+	unsigned long flags;
+
+	spin_lock_irqsave(&applespi->cmd_msg_lock, flags);
 
-	wait_event_lock_irq(applespi->drain_complete, !applespi->read_active,
-			    applespi->cmd_msg_lock);
+	wait_event_lock_irq_timeout(applespi->wait_queue,
+				    !applespi->read_active,
+				    applespi->cmd_msg_lock,
+				    msecs_to_jiffies(3000));
 
 	applespi->suspended = true;
+
+	spin_unlock_irqrestore(&applespi->cmd_msg_lock, flags);
 }
 
 static void applespi_remove(struct spi_device *spi)
-- 
2.39.5

