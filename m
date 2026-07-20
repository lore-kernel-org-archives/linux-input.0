Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5D4C3E450D
	for <linux-input@vger.kernel.org>; Mon, 20 Jul 2026 10:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784542504; cv=none; b=jz3r6o1mfa8wXdsjfcLuXmqvsJE9Bl3O+tnG+majQ//prmYuD33ba8RsRy7pEJ2m0YEAL7UxQOJ05eD01abZAV9PClreTHwIk7H/HYn9xE2Tl4ozeBY5AQbHl5WFjqUWnX2bRWng1D289u4hTwYGv76nFOMNiKACrITkMqD5Vk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784542504; c=relaxed/simple;
	bh=zBFAtScCtJz6J3LkuunkpMbvy3Vysw16nLyJL24kSuA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UOKj8yC2vMPJaSZ+0F/08sTsI+IE4N2vdcNYxlgoInFI+CdgDHjEY6vIAoyhv7NExFBuP82Tyq0qw9Pj0VTsWfPX0a/PA/q1Zp0UwVj8ohNl234IxkXKYMhbKZwRvGQS1FJcL9JEhyj8f3fkQkVQVlQ3JrqlLunaQB/HwqBw3zE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-c9c26a5fb98so2322478a12.0
        for <linux-input@vger.kernel.org>; Mon, 20 Jul 2026 03:14:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784542487; x=1785147287;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=1BlyvrkmFv1hwh49RhEdK1f4LtTECBvTt9R0UVOVdkA=;
        b=Amn3Gf9SP9cB2v3SqijpEBj/DhtsmnorlfAylGyhmsnHwkJam5Fi8hKd/C+BdR3oqc
         vleeFTsJu2E4/YNQoABtVDewwJ4Lj+xuwkuKBdTsRgB7DjeT0K0ETLj9Tfr4EQGAakTR
         MpH8UaNubLlkq8IqZJMdOg1Xk5DJC024+eF4fGhg0JX47gz9bIOPF2fTAe2pewmAPJsS
         kuoTrco39N0BacoJrGCVUY8bkdDOr/fjHPb3Ac9TtFRQjeHh93BEseLc2ttyeKroA4jT
         kyGy31DqD+WrEv7yCZ08HezO+BjZEKaoFlMgtd9y5ZmzY1lEecscXzLtx8V+Uz7xGIMq
         N5XQ==
X-Forwarded-Encrypted: i=1; AHgh+RpESCK4X0AWZxCaVknOsY8hHQfbc5mbwNCb0+fHh4Wjb6UwjJWKey30Pv08nKDjrqDCRA4L14BdM/0RWg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwJq5mRUHIzAQPnaOe0GG6nzSuSiL1157PLrN2jjTXWMY1WIS4a
	irYaMT5WQO+p9jahTryNq72wJTSZTGTzhx/SqdWig7goeQvyBPx20z4=
X-Gm-Gg: AfdE7cklB5LD7AIHHL3IitGzuV4wfL5iFRrmOm1Y5AOcqBKStJ+ZixziM/dStFqHfSp
	ajkP5xv5G+EjscC9RRcEwRX+35pPTjXUBmdw6gFyEVj9kace8mAv13ngJlfsyzvHtySSE9ypDWG
	uR06S27h2uK9qIrfAETLfNRQ7l90iYRAB6h12yNoTCh8iiE8B4C3C8R10UsiCofHTydvA50DruF
	Y9aplOLBte8sO5bQYh79tDfL4y0NoGSYvvB8W2EAJqSzqs3Sp8VdP/QJnp/AisEr/fiuevGb8G2
	lcikfQlk8Ggcat84ffMDKyTrp6JnynuFjQBN337zA4bUy/2gaDGtel54axXEIdG42clNFq2pPdl
	dClSyEoo2BI7K+BfRBt2YQNboWgct8Cv3JFNUWoyz8vahhLuzzevCAgM9KhftYLq348IlEn4B+H
	p/6hwCV1o1rFDNiWF6wq8qRYfnE09mfH9z9hy6muZ0ZCuRcmooIqXm9lQl9PK5+fDMuEysn+ED3
	3cwv+L+pGevVseBPA==
X-Received: by 2002:a05:6a20:258a:b0:3bf:aa54:4cbc with SMTP id adf61e73a8af0-3c38dbb8287mr19933105637.26.1784542486563;
        Mon, 20 Jul 2026 03:14:46 -0700 (PDT)
Received: from penguin.tail0a1999.ts.net (61-228-16-100.dynamic-ip.hinet.net. [61.228.16.100])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cb517f94c31sm4411321a12.13.2026.07.20.03.14.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 03:14:46 -0700 (PDT)
From: Shih-Yuan Lee <fourdollars@debian.org>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Mark Brown <broonie@kernel.org>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Shih-Yuan Lee <fourdollars@debian.org>
Subject: [PATCH v2 3/5] Input: applespi - register touchpad synchronously in probe
Date: Mon, 20 Jul 2026 18:14:33 +0800
Message-Id: <20260720101435.13612-4-fourdollars@debian.org>
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

Touchpad registration is currently deferred to an asynchronous worker
applespi_worker(). This asynchronous registration introduces race
conditions if debugfs or other properties are accessed before the worker
completes, or if the driver is unbound while the worker is active.

Remove the workqueue and the asynchronous worker. Perform touchpad
registration synchronously during driver probe.

Wait up to 3 seconds for the touchpad information command packet response
using wait_event_timeout(). If the response times out, log a warning and
fallback to keyboard-only mode. If registration fails, gracefully unwind GPE
handlers and wait for outstanding SPI transactions to complete.

To prevent data races between the interrupt handler and the probe thread,
protect the 'have_tp_info' flag and 'rcvd_tp_info' structure under the
cmd_msg_lock in applespi_handle_cmd_response().

Signed-off-by: Shih-Yuan Lee <fourdollars@debian.org>
---
 drivers/input/keyboard/applespi.c | 52 +++++++++++++++++++++----------
 1 file changed, 36 insertions(+), 16 deletions(-)

diff --git a/drivers/input/keyboard/applespi.c b/drivers/input/keyboard/applespi.c
index a8f8d5370e95..42b7f87ef2cd 100644
--- a/drivers/input/keyboard/applespi.c
+++ b/drivers/input/keyboard/applespi.c
@@ -427,7 +427,7 @@ struct applespi_data {
 	}				spi_complete[2];
 	bool				cancel_spi;
 
-	struct work_struct		work;
+	bool				have_tp_info;
 	struct touchpad_info_protocol	rcvd_tp_info;
 
 	struct dentry			*debugfs_root;
@@ -1388,26 +1388,20 @@ applespi_register_touchpad_device(struct applespi_data *applespi,
 	return 0;
 }
 
-static void applespi_worker(struct work_struct *work)
-{
-	struct applespi_data *applespi =
-		container_of(work, struct applespi_data, work);
-
-	applespi_register_touchpad_device(applespi, &applespi->rcvd_tp_info);
-}
-
 static void applespi_handle_cmd_response(struct applespi_data *applespi,
 					 struct spi_packet *packet,
 					 struct message *message)
 {
+	unsigned long flags;
+
 	if (packet->device == PACKET_DEV_INFO &&
 	    le16_to_cpu(message->type) == 0x1020) {
-		/*
-		 * We're not allowed to sleep here, but registering an input
-		 * device can sleep.
-		 */
+		spin_lock_irqsave(&applespi->cmd_msg_lock, flags);
 		applespi->rcvd_tp_info = message->tp_info;
-		schedule_work(&applespi->work);
+		applespi->have_tp_info = true;
+		spin_unlock_irqrestore(&applespi->cmd_msg_lock, flags);
+
+		wake_up_all(&applespi->wait_queue);
 		return;
 	}
 
@@ -1675,6 +1669,7 @@ static int applespi_probe(struct spi_device *spi)
 	acpi_handle spi_handle = ACPI_HANDLE(&spi->dev);
 	acpi_status acpi_sts;
 	int sts, i;
+	unsigned long flags;
 	unsigned long long gpe, usb_status;
 
 	/* check if the USB interface is present and enabled already */
@@ -1692,8 +1687,6 @@ static int applespi_probe(struct spi_device *spi)
 
 	applespi->spi = spi;
 
-	INIT_WORK(&applespi->work, applespi_worker);
-
 	/* store the driver data */
 	spi_set_drvdata(spi, applespi);
 
@@ -1821,6 +1814,20 @@ static int applespi_probe(struct spi_device *spi)
 	/* trigger touchpad setup */
 	applespi_init(applespi, false);
 
+	/* set up the touchpad as a separate input device if info is received */
+	sts = wait_event_timeout(applespi->wait_queue,
+				 READ_ONCE(applespi->have_tp_info),
+				 msecs_to_jiffies(3000));
+	if (!sts) {
+		dev_warn(&applespi->spi->dev,
+			 "Timed out waiting for touchpad info, continuing keyboard-only\n");
+	} else {
+		sts = applespi_register_touchpad_device(applespi,
+							&applespi->rcvd_tp_info);
+		if (sts)
+			goto cancel_spi;
+	}
+
 	/*
 	 * By default this device is not enabled for wakeup; but USB keyboards
 	 * generally are, so the expectation is that by default the keyboard
@@ -1853,6 +1860,19 @@ static int applespi_probe(struct spi_device *spi)
 			    &applespi_tp_dim_fops);
 
 	return 0;
+
+cancel_spi:
+	acpi_disable_gpe(NULL, applespi->gpe);
+	acpi_remove_gpe_handler(NULL, applespi->gpe, applespi_notify);
+
+	spin_lock_irqsave(&applespi->cmd_msg_lock, flags);
+	applespi->cancel_spi = true;
+	wait_event_lock_irq(applespi->wait_queue,
+			    !applespi_async_outstanding(applespi),
+			    applespi->cmd_msg_lock);
+	spin_unlock_irqrestore(&applespi->cmd_msg_lock, flags);
+
+	return sts;
 }
 
 static void applespi_drain_writes(struct applespi_data *applespi)
-- 
2.39.5

