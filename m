Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FD1430C632
	for <linux-input@vger.kernel.org>; Mon, 20 Jul 2026 16:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784564559; cv=none; b=PuIHcJ+dSs7whqbjN8M0wAQrpbUYzAYH7lplK4WH3qyw0F5PxzF4MPNT7YCI87wMcLjWc0mz04FK5o+GPmieeHeuV9Bcapjl54HfqGADAGVOp26w/Ja89N7MnYmP52ubICiE+Pinryruugq4WF9JMlo3apHrmgYbZChq8A4fSOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784564559; c=relaxed/simple;
	bh=hrwbKfjxfMBHDEnyvfS7f8dzT8Uiy7UNqBhL2l9L0MU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ORikbGm3VXpOhG/Kr1J4iREgHrwxGc4RoIClaM9hVmt3C5pmrt58COzSH2SWUK0JrQrV9fRWFRWFjXpQjE//DQpLiGycv4y+h/1+qRkWVmWaofJmckvgjZjpsQ05qe0wG1pvQU0OO+k7doi6jFFExTMnWzrjpVpbAZmwwV+3s8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-38e3efab7e0so2836347a91.0
        for <linux-input@vger.kernel.org>; Mon, 20 Jul 2026 09:22:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784564546; x=1785169346;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=El2S4HNy2F3ZJ9jMldpD2oKA7qs4fNQFyEGd7Ijf3bs=;
        b=c3NquErWm14vDU+X54/BURNJmOUXUR2ojrI02OFfpEJp2UIXuZBvHcB2nKxVi0GvZb
         tp6TjOHbC3ec0r3yhx+YBGdXvzdFc4A3g9CAn+8pT3d5SZhvLt+6NDF5yFprxXrbB5L1
         1qSk4uxHUvryqpIkJYmcmbaZaHCGDbuGjGizlUOKDcm9xDK2EG2e98cuuKb3nzbBI5jz
         Rg3iJy2HToaQfFYIG5O7aY950MHal1sATmGMgGpg0gLJ0ow49pCfeCrTr/nGH6Mjz9ib
         3/jJSkAb08d72no4l39DFEJ8P27F5C7dlgk6PRilI+f7DdDJ1gsl9IKYYs+1Pd5JRazl
         PBvA==
X-Forwarded-Encrypted: i=1; AHgh+Rqd3MSuaCXpvzeXAmogNQPaqJtAhNqDy03LtpPsR8njzuLXOifL2AU7mnSbnBNUf3mkax3LAzE5XzkoOg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxA9wHH36K1AAlGwm90vHluwcAmXjoY/tymMIzF0R+tdusa4jyI
	fV4Q7i0hNZsOBF/3/L1GCPbgw5sBhbLEOHwDe1qaaD15VB1eObzJd8q7+b5VleTK7A==
X-Gm-Gg: AR+sD11dy1Q2caJ0QEOLs4trjVTymgB0ktmFO2cMmepkMME3g+Xxov3z8O8HAEZW4AC
	k1EW1UZelXTTQqXF/x6Y0FGAflf3cH8O/vG1myt4Uj7P5TdPa1TId712UEIJ94lFULiaBQjD67K
	bhl/2uUdOvxb0w9SE6A7Zn4MJ+aI5+9wOZ4GBRTronDdpiOwRmHA7t7kz66uCqOjYkBfgma1vvI
	lL3Wf2ium0QqXITCJ+VG6xXR9dkewn/XOPy2ckzAEvszZPbsZD2Nr/YDJ7GCpboMylZS2k08ylD
	l3hruRMv3uOi4Q2Misy2BPAFQXIk9+U/5NP2pIifYattFVT0aFHComu1RHjg3yOpqvogWIQ43My
	4AM7a2+Tcbq+4lcQ7sFXLVdaQ0ifbJj+AQtXDVs3OG6CWqtbUYeX6MFklRdp+9yvqdhy/umYUh9
	P/ExGPrzElClr7nU2sUUVLjiME5zkEMDi6RI1Zw7M8WaqO9Gi5IWlxyMjwLamoTwctip+8U0ruU
	bhYXdf5zcikw4PnoA==
X-Received: by 2002:a17:90b:2547:b0:36d:c138:e0a0 with SMTP id 98e67ed59e1d1-38e4b4d4429mr13461842a91.2.1784564545891;
        Mon, 20 Jul 2026 09:22:25 -0700 (PDT)
Received: from penguin.tail0a1999.ts.net (61-228-16-100.dynamic-ip.hinet.net. [61.228.16.100])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38e9205d358sm29366a91.3.2026.07.20.09.22.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 09:22:25 -0700 (PDT)
From: Shih-Yuan Lee <fourdollars@debian.org>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Mark Brown <broonie@kernel.org>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Shih-Yuan Lee <fourdollars@debian.org>
Subject: [PATCH v3 1/5] Input: applespi - use unified wait queue with timeouts for drain
Date: Tue, 21 Jul 2026 00:22:15 +0800
Message-Id: <20260720162219.32324-2-fourdollars@debian.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260720162219.32324-1-fourdollars@debian.org>
References: <20260720162219.32324-1-fourdollars@debian.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Consolidate wait queues by renaming drain_complete to wait_queue and use
wait_event_lock_irq_timeout() with a 3-second timeout during read and write
drains to prevent indefinite lockups during driver unbind or PM transitions
if the hardware becomes unresponsive.

If a timeout occurs while a read or write transfer is still active, issue
a warning and fallback to waiting unconditionally until the transfer completion
callback clears the active flag. This guarantees that applespi_drain_writes()
and applespi_drain_reads() never return prematurely while transfers are in flight,
preventing use-after-free (UAF) and DMA memory corruption when devres frees
the driver context and DMA buffers during unbind.

Signed-off-by: Shih-Yuan Lee <fourdollars@debian.org>
---
 drivers/input/keyboard/applespi.c | 48 ++++++++++++++++++++++++-------
 1 file changed, 38 insertions(+), 10 deletions(-)

diff --git a/drivers/input/keyboard/applespi.c b/drivers/input/keyboard/applespi.c
index b5ff71cd5a70..c501bf7e517e 100644
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
@@ -1793,21 +1793,49 @@ static int applespi_probe(struct spi_device *spi)
 
 static void applespi_drain_writes(struct applespi_data *applespi)
 {
-	guard(spinlock_irqsave)(&applespi->cmd_msg_lock);
+	unsigned long flags;
+	long ret;
+
+	spin_lock_irqsave(&applespi->cmd_msg_lock, flags);
 
 	applespi->drain = true;
-	wait_event_lock_irq(applespi->drain_complete, !applespi->write_active,
-			    applespi->cmd_msg_lock);
+	ret = wait_event_lock_irq_timeout(applespi->wait_queue,
+					  !applespi->write_active,
+					  applespi->cmd_msg_lock,
+					  msecs_to_jiffies(3000));
+	if (!ret && applespi->write_active) {
+		dev_warn(&applespi->spi->dev,
+			 "Timed out waiting for write drain, waiting unconditionally\n");
+		wait_event_lock_irq(applespi->wait_queue,
+				    !applespi->write_active,
+				    applespi->cmd_msg_lock);
+	}
+
+	spin_unlock_irqrestore(&applespi->cmd_msg_lock, flags);
 }
 
 static void applespi_drain_reads(struct applespi_data *applespi)
 {
-	guard(spinlock_irqsave)(&applespi->cmd_msg_lock);
+	unsigned long flags;
+	long ret;
 
-	wait_event_lock_irq(applespi->drain_complete, !applespi->read_active,
-			    applespi->cmd_msg_lock);
+	spin_lock_irqsave(&applespi->cmd_msg_lock, flags);
+
+	ret = wait_event_lock_irq_timeout(applespi->wait_queue,
+					  !applespi->read_active,
+					  applespi->cmd_msg_lock,
+					  msecs_to_jiffies(3000));
+	if (!ret && applespi->read_active) {
+		dev_warn(&applespi->spi->dev,
+			 "Timed out waiting for read drain, waiting unconditionally\n");
+		wait_event_lock_irq(applespi->wait_queue,
+				    !applespi->read_active,
+				    applespi->cmd_msg_lock);
+	}
 
 	applespi->suspended = true;
+
+	spin_unlock_irqrestore(&applespi->cmd_msg_lock, flags);
 }
 
 static void applespi_remove(struct spi_device *spi)
-- 
2.39.5

