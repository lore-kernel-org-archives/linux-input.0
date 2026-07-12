Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23FA9346E64
	for <linux-input@vger.kernel.org>; Sun, 12 Jul 2026 16:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783872941; cv=none; b=Pj8UCfbnMgDRet+0BEjxS9t7pXqe1IXZPWVt4wMdhbww4toMWNe0LiFaYhDQTCL/9uN/MkQAa0wNZM5ATSGUG4vFuv7xl9ALqokTL3wHWtonCkruVFtsmUeafauyBdJbEdTteSQMNwQUrZjvkzs3Mfk5eO4Kzquos6YvCOdeyv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783872941; c=relaxed/simple;
	bh=YkAhctjX+TRHvC1ZFnsLlQGb8ZTd9WYXbJyc3v4lB3Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ow0d4FfbOPYNnvu+b2VYpiKjw2mFKKKgK4GHSZzRJmIzw0Ch0x07D/BbE7z7HFGT9z0m0iRdU8R4afEfioLoIw43EC1+IGA14OlymPg1yiUM6u3x9F0qyKUydErZBYcjpbHauH+MDvHY4s5YXP/pWpw+6VSZ0OWQYkViMUThhEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-38101f85591so2463095a91.1
        for <linux-input@vger.kernel.org>; Sun, 12 Jul 2026 09:15:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783872938; x=1784477738;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=dfAnMuMswVnnhGzvqvLgApeSRSFXVyqWjYS4NcNieRE=;
        b=r+PTwXgs71Di0HdX87bxMFraRgykpCokp0OHlXdrj9PIWUF1x3L6mB1vlvFDepHPvi
         JBCr2S/+wQn4cRfrxAen3zDJ4HrQfv1MabEwJhdxwttdPgLPM/ml3X5OidZKZPoxgM07
         xqv7BIfaMsP+tEscSJXLt7NlsDesZJpq6W2ih2QSXyOqUDMz4Cs3/SHPvES6sKXyakCj
         NHyc8D9mrLPkySKHx75Mh+4x1MYvA7o7ydVtcmg2mJ4RD470VzUjUCaUB6AR1cq7g9bq
         4sQW9ahTBfYUbPPhDrqV6OEs6LwyF1d6OJsiWgcsjB/5JaPTGYxIdMePou3P4st04MFL
         2q/A==
X-Gm-Message-State: AOJu0YyWZWzsEme5iag83T9xvdSIJhuGbQ5r+TTvl8wBrm8N7hOS37fH
	ZRGDcqQI8uN9B0LG9ZVTJUz+OJittRsrlpy2SMsfHCOm4H0vkCQ+2to7862nPpc=
X-Gm-Gg: AfdE7clR0dIH9Gaka2c7cbe5xygq0bQxaEIAkNOj9xd78Ddkvue0uPNGovcs3tZ53H9
	tlnN4RBhZRrMDlcnSm7y8M7ImXieZL0rAwQ3QzFj4BYqF9FkqP8y4nssU1Ft4/6Ygr+abPgcCvV
	9m3B8XsWMnnMeM45hTrKgz8DqNm0BGvppC4oZBZ0U9ZImEYT9OnTCz7pPeNJhADUhCfpw0zTMOQ
	nLaPZH+Bgq5CCSTZ7YjBvbkV+vyp1xeQz4uRigdMebQV52ddLeeef0ldpecR8XaF7FW2zd/0aik
	0ypQkSWOE5l9UsOOONKD9ulbkLOukodh9kkxbh5B57QOk3WU+HBUfPBkg3Mqym+X0WtwU95b073
	zrX5x9wSsWYy70EstylcceEzXjklUoOLtiP5pSvvwR4e5mufiXuoUenLrIz7vECgl8wWAW72z4x
	oIy6Ml8jNc5cFNFg77CWMxR0v6H8AeFgktBADc6GryNZtN8WyOo/0iyGodAEZZ+EcZ3HhJQ0oJm
	uKIfp35TS4ulFH+xNEDTypxaITd
X-Received: by 2002:a17:90b:54cb:b0:36b:de66:92c3 with SMTP id 98e67ed59e1d1-38d15361ac4mr11183841a91.10.1783872938070;
        Sun, 12 Jul 2026 09:15:38 -0700 (PDT)
Received: from penguin.tail0a1999.ts.net (61-228-44-142.dynamic-ip.hinet.net. [61.228.44.142])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3118389d9bcsm51034331eec.20.2026.07.12.09.15.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jul 2026 09:15:37 -0700 (PDT)
From: Shih-Yuan Lee <fourdollars@debian.org>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Shih-Yuan Lee <fourdollars@debian.org>
Subject: [PATCH 2/2] Input: applespi - fix use-after-free in applespi_remove()
Date: Mon, 13 Jul 2026 00:15:27 +0800
Message-Id: <20260712161527.7350-3-fourdollars@debian.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260712161527.7350-1-fourdollars@debian.org>
References: <20260712161527.7350-1-fourdollars@debian.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

applespi_remove() called applespi_drain_writes() to wait for in-flight
write transfers, then immediately called acpi_disable_gpe() and
acpi_remove_gpe_handler().  However it then called applespi_drain_reads()
*after* the GPE handler was removed, which races with any read SPI
completion callback that could still reference the applespi struct
already being torn down.

Moreover, the two drain helpers use separate wait paths that can miss
each other: a read completion arriving just after drain_writes() returns
but before drain_reads() is called will set read_active, and the
subsequent drain_reads() will then wait on a wait_queue that nobody will
ever wake because the GPE is already gone.

Fix by replacing the two separate drain calls with a single barrier
using the existing cancel_spi + wait_event_lock_irq mechanism:

  - Set cancel_spi = true under the spinlock so that applespi_async()
    immediately rejects new SPI submissions and wakes the wait queue
    once all outstanding operations have drained.
  - Wait for !applespi_async_outstanding() before proceeding with
    teardown.
  - Disable the GPE and remove its handler only after all in-flight SPI
    transfers have completed, eliminating the use-after-free window.

Fixes: 0b7a8ac72fc1 ("Input: applespi - add driver for Apple SPI keyboard and touchpad")
Signed-off-by: Shih-Yuan Lee <fourdollars@debian.org>
---
 drivers/input/keyboard/applespi.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/input/keyboard/applespi.c b/drivers/input/keyboard/applespi.c
index c1065a6ba96c..1f5cc2b4dc30 100644
--- a/drivers/input/keyboard/applespi.c
+++ b/drivers/input/keyboard/applespi.c
@@ -1900,15 +1900,21 @@ static void applespi_drain_reads(struct applespi_data *applespi)
 static void applespi_remove(struct spi_device *spi)
 {
 	struct applespi_data *applespi = spi_get_drvdata(spi);
+	unsigned long flags;
 
-	applespi_drain_writes(applespi);
+	/* Prevent any new SPI transfers and wait for outstanding ones */
+	spin_lock_irqsave(&applespi->cmd_msg_lock, flags);
+	applespi->cancel_spi = true;
+	wait_event_lock_irq(applespi->wait_queue,
+			    !applespi_async_outstanding(applespi),
+			    applespi->cmd_msg_lock);
+	spin_unlock_irqrestore(&applespi->cmd_msg_lock, flags);
 
+	/* Disable GPE and remove handler */
 	acpi_disable_gpe(NULL, applespi->gpe);
 	acpi_remove_gpe_handler(NULL, applespi->gpe, applespi_notify);
 	device_wakeup_disable(&spi->dev);
 
-	applespi_drain_reads(applespi);
-
 	debugfs_remove_recursive(applespi->debugfs_root);
 }
 
-- 
2.39.5

