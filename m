Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE23C39B951
	for <linux-input@vger.kernel.org>; Mon, 20 Jul 2026 10:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784542506; cv=none; b=stc4QaCK/0hW4hdnAlGWW31EVgVYe1/QCMahT44eOab/HDKU5atN2CfcFTml4SXEahJE7YLYOq4Oz0r02yrf55PeCPT4rLzPDy0ItFnAMTOJDHOal5ht8wmrcSukx38oXU406DZfY0XUHOpy+ghUO7z66VB8Xn+APct7GSMvJO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784542506; c=relaxed/simple;
	bh=JXokrE38sgfKHFjs6siu/55oNnmhzpQI+mIVcZk7QiY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LXVa0a9ONTN6NZ3viqpRnderPz+9VXgt4VGUNbpMkkl5VX94YIur0BJBLaGYmyM1qwiwh0rr1H45ROQ2BQvABoeOCMwla7NDkrKOj+OeyVA8FkJvDUxKl91IgsBUvczVNkc5VM4b+HCLOL0871vwlg/yhM3HsFlSvEffnSjILfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-ca913a601fbso6701008a12.3
        for <linux-input@vger.kernel.org>; Mon, 20 Jul 2026 03:14:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784542490; x=1785147290;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=RF1ftOMQ+N1bAoeZkI0/wgbxDAI/VKJ5VcqnqJwi0CQ=;
        b=FBFR3ScQFKY9Ddyt6pk+pDLVaZXzJuN8T9v1RKfzZXymZjDNNL21s97LJGLSqT4/Rp
         EW3rxB/SeUUhmOQga1Zs0Eb+TDIcYUl0kVjupm8i/faX6saKAFy+Y1URPhLNuS/cVm0H
         t/anUlD1RtDU2MjNwIW8Liq3F47CLcaTQ8hsniRtHIEhY98G0/9R8cQ4VRLbuchW0Pi9
         j50k4yKv6hxap1dKPeTPMUniy0xQ9Oybq9IRvSfWAIatPimSIN0uAGnDjBRTZHbJx2ob
         C7ruMMLYqqcKQ1AfuH3bIPXXEvRAkjGQmxJ1uGdIWpWQHnW7OcMAMzsLJl03fN6yIOTa
         Ax6A==
X-Forwarded-Encrypted: i=1; AHgh+Rq/KVw7Jxm2C4ejNkChXPNq4+JSQ896YqRVtllV5qXzHaFUWDZUxf5yZcXCddMuIAylQoVbAz1xU3EvKg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwXTxD3QRaWVJMhtJ9uV/NIQ2M5ouEVYa/wuGOFTzGwVxRyR8kE
	1GrT9TDkHT5jJgbEeKiy8UUOgr5wjdJPpETkTM88Jtro6yGliLdQp/8mslA7coaxpg==
X-Gm-Gg: AfdE7ck3dU3ZW+/oYBOVqKaGSzN1NtgBwfji14pZ1HSrH3h9aU27yApU18Zbr4aAvoz
	ujmbGx+4mzDc/vpAf4LXW/poMAH4dEKA/iw3HLTmGwryJsWCZbzG8nLr/l9qvxJRbWcpkpPLqXd
	AKLZ1KjXY0onNXvE65JZtertEjqV8a3OWzjBN1o1J6/PVSqqw+X7TEtPRNvS+OSvYNj7uj1/b+H
	DzKaJUXKZ5btOJThFkabdRRKDkl0bDArdjkLB5uNA1thdnu+glfgrpdRxRPkXWD6reoo/VGTO4D
	8n+luzMS+exTwQfB8nXnsoDcDdnOnxzM/hFRrneoSztrcJdt/u+aHwKVDh1ATrG1n8exGp1rWet
	2BfCzmzcbdZT/nQQfgS3EdpC/v986rfHuglWJxizOg5DP2p1V5hREmbQbWKNxolaRiPTFPv67Qc
	Oue9vdAHhLz2O4stKqcO3+zCRrGHyfTKcXuGxpsuKyY9HiWIXFPxEIVkzdok96zV6nW8E5gupNv
	L+KlagGam+B5Wb+qA==
X-Received: by 2002:a05:6a21:9206:b0:3c3:7ac4:dac0 with SMTP id adf61e73a8af0-3c3ad5d4f0fmr15037185637.13.1784542490168;
        Mon, 20 Jul 2026 03:14:50 -0700 (PDT)
Received: from penguin.tail0a1999.ts.net (61-228-16-100.dynamic-ip.hinet.net. [61.228.16.100])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cb517f94c31sm4411321a12.13.2026.07.20.03.14.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 03:14:49 -0700 (PDT)
From: Shih-Yuan Lee <fourdollars@debian.org>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Mark Brown <broonie@kernel.org>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Shih-Yuan Lee <fourdollars@debian.org>
Subject: [PATCH v2 5/5] Input: applespi - fix use-after-free in applespi_remove()
Date: Mon, 20 Jul 2026 18:14:35 +0800
Message-Id: <20260720101435.13612-6-fourdollars@debian.org>
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
 drivers/input/keyboard/applespi.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/input/keyboard/applespi.c b/drivers/input/keyboard/applespi.c
index 95a8f790eaff..088337f060b2 100644
--- a/drivers/input/keyboard/applespi.c
+++ b/drivers/input/keyboard/applespi.c
@@ -1910,15 +1910,22 @@ static void applespi_drain_reads(struct applespi_data *applespi)
 static void applespi_remove(struct spi_device *spi)
 {
 	struct applespi_data *applespi = spi_get_drvdata(spi);
+	unsigned long flags;
 
-	applespi_drain_writes(applespi);
+	/* Prevent any new SPI transfers and wait for outstanding ones */
+	spin_lock_irqsave(&applespi->cmd_msg_lock, flags);
+	applespi->cancel_spi = true;
+	wait_event_lock_irq_timeout(applespi->wait_queue,
+				    !applespi_async_outstanding(applespi),
+				    applespi->cmd_msg_lock,
+				    msecs_to_jiffies(3000));
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

