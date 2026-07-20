Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52B3D4398E0
	for <linux-input@vger.kernel.org>; Mon, 20 Jul 2026 16:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784564561; cv=none; b=nOANQoIEIwN0HnrZirL/EuiaXA54O/UCzklc0NqPiG5Qg9N6LsKW9lijVuXoE9w+DtbpXdPG9Te/L23HFcbPsQ6BkzbwNxRgcISQh4iFUjwDmFOX8KRqUICW6MzJ7f33E5DyCBP68rtrKiRs//W+ulVi9HZvCV9AJuDMhuBZ+fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784564561; c=relaxed/simple;
	bh=V6U73O55j87WWMKBgA3iBdB1uBtOCakg5nSbkbbd0Zk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FKgNgQRFr9d9pa1elphK7mYG0N3Qhgb4jnkywO4ji9aVfRHjVSP79z52f74Hi+1neIAEOBHg4cowXm5zgwCWssIE4l/XtKTdUKo0HQYztTS5k4qiqxNvu9rJzTXWkPfIhMMlm3wcgRt4NwrofHkOMusKaO2ngpSwAsFfK6XlyTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-382ef647e20so9789360a91.1
        for <linux-input@vger.kernel.org>; Mon, 20 Jul 2026 09:22:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784564552; x=1785169352;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=bqJobqE4ILhTlySWbCodoBRjay5MfDN8IuFjxNUP+Sc=;
        b=JVv4+cHHsxsKnFnhjy5tm7vkTpUavU0IsOOj7oNkSwqGdVad2x8ZzGsdv/teSYMlDy
         dpdHvF9gYvTZgYtu7p6Ku1/XF9Dexvz8KOi0jqSDEnJbjb+a1OTZhwC4/GrMLuyXGmlH
         nr3TZNGgRHQYoe1H/9wTa24ZWB8xWB30vgVVfABDzf/RLTmgsoY1q7BHTQPPwIxvrEMr
         VyzwjiGLQCPwr0GsKrymYLUin6Uh4rMMrah/RrHfMxNVSSgQ5lZKDSwjKAwn8cZRCiNQ
         fqx0RVFxIZqW7JdO9fF+e7tPHclNZWRqIV/faxW1WtBUws9cD9Q+4vzVtOhXLVcMNL5x
         jfTw==
X-Forwarded-Encrypted: i=1; AHgh+RoWWsgEEIP4YIKJ/6ntqQsg/WIdjZmbiTyDxjYieT398xjT0rA9ZWGJW3eoFnCWaZ1mto7aveAQ+2/zzA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxr/g2R4yDekcauR0CG78UI1kLXknmVFZKV/Ih4T1B7E81vNJ6/
	MP9idof3vhXgE1BlSaBkEh3B4fG2cN2VcXX3JK9o0TYvWkzzoAzGXzI=
X-Gm-Gg: AR+sD13M6ZaCMK+1vmKcQ6t3W6kpwTB+0Jx1j9fCTK+/Ng29dj7SrXzIFl54tGXbAYj
	5gluqfY8RKyU2dMI0s3onwVLhVsaaZNNMFhdZheOBRMizUCznsgsXZXQmpqlh5sSNwbYNq2BvBp
	3FD2SJeejkmNZPPR4vtrdkRGxiljoZQ9ur14dMw+txMJ4KTWZbaX7YhrCbYiCl1DR1hQeZRQxnw
	FlyRIVKYRxP1NWtRvG+crURaFzsL1tCn4SOKAZxmYIWoxzQpqNgvU05DUUM7PzO1JP1qTlJGsER
	r0bhXbRDRTLA4P3h88iY+OnlKa2kb8FzHZhw2/UN+KY8+tnI+SmmAgOQdWocYjeMetzs43INNkm
	ZDR7jMTsH4Pa0J/7hl+YVRvUxlpWgiJws1dAxLCXqTIl6v4AD0yiI8+WgQEokrOp6V5xBI6gUZs
	Z6Gqmleq8GahM/nZ2I1cY1WQx3v5HMhlG2ZjR/naCTsrZRnBVq0dYgpxeHx5bTZu4qaGhhGgveZ
	XP8nr2ZCOY64H53XA==
X-Received: by 2002:a17:90b:57c5:b0:38e:2860:253f with SMTP id 98e67ed59e1d1-38e4b447cd5mr15478935a91.12.1784564552370;
        Mon, 20 Jul 2026 09:22:32 -0700 (PDT)
Received: from penguin.tail0a1999.ts.net (61-228-16-100.dynamic-ip.hinet.net. [61.228.16.100])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38e9205d358sm29366a91.3.2026.07.20.09.22.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 09:22:32 -0700 (PDT)
From: Shih-Yuan Lee <fourdollars@debian.org>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Mark Brown <broonie@kernel.org>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Shih-Yuan Lee <fourdollars@debian.org>
Subject: [PATCH v3 5/5] Input: applespi - fix use-after-free in applespi_remove()
Date: Tue, 21 Jul 2026 00:22:19 +0800
Message-Id: <20260720162219.32324-6-fourdollars@debian.org>
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

Replace the separate read and write drain helpers with a single barrier using
cancel_spi and wait_event_lock_irq_timeout(). Wait for outstanding asynchronous
SPI operations to complete before tearing down the driver context.

Disable GPE and remove the GPE handler prior to setting cancel_spi = true.
This prevents level-triggered GPE interrupt storms where applespi_notify()
repeatedly attempts applespi_async() and gets rejected with -ESHUTDOWN while
the hardware interrupt line remains asserted.

If the 3-second wait times out while SPI transfers are still outstanding, issue
a warning and fallback to waiting unconditionally until all transfers complete,
guaranteeing that applespi_remove() never returns prematurely while transfers
are active.

Signed-off-by: Shih-Yuan Lee <fourdollars@debian.org>
---
 drivers/input/keyboard/applespi.c | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/drivers/input/keyboard/applespi.c b/drivers/input/keyboard/applespi.c
index a21e89f30387..602780842124 100644
--- a/drivers/input/keyboard/applespi.c
+++ b/drivers/input/keyboard/applespi.c
@@ -1939,14 +1939,29 @@ static void applespi_drain_reads(struct applespi_data *applespi)
 static void applespi_remove(struct spi_device *spi)
 {
 	struct applespi_data *applespi = spi_get_drvdata(spi);
+	unsigned long flags;
+	long ret;
 
-	applespi_drain_writes(applespi);
-
+	/* Disable GPE and remove handler first to prevent interrupt storm */
 	acpi_disable_gpe(NULL, applespi->gpe);
 	acpi_remove_gpe_handler(NULL, applespi->gpe, applespi_notify);
 	device_wakeup_disable(&spi->dev);
 
-	applespi_drain_reads(applespi);
+	/* Prevent any new SPI transfers and wait for outstanding ones */
+	spin_lock_irqsave(&applespi->cmd_msg_lock, flags);
+	applespi->cancel_spi = true;
+	ret = wait_event_lock_irq_timeout(applespi->wait_queue,
+					  !applespi_async_outstanding(applespi),
+					  applespi->cmd_msg_lock,
+					  msecs_to_jiffies(3000));
+	if (!ret && applespi_async_outstanding(applespi)) {
+		dev_warn(&applespi->spi->dev,
+			 "Timed out waiting for SPI transfers to drain, waiting unconditionally\n");
+		wait_event_lock_irq(applespi->wait_queue,
+				    !applespi_async_outstanding(applespi),
+				    applespi->cmd_msg_lock);
+	}
+	spin_unlock_irqrestore(&applespi->cmd_msg_lock, flags);
 
 	debugfs_remove_recursive(applespi->debugfs_root);
 }
-- 
2.39.5

