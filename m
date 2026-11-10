Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794286045;
	b=OmUD4pewJN+L7vft1DrL6J+nyU7zYGxpy23KOYdyXKBJa6+YWu0OuV5K5udeCHBdtSO/
	 LIXWMcVjCQ7DNjtgm8QssHD+8KDk3tX69qpnNQilKkzu7EJsRxsCtYLHz9qFAwjGnr45O
	 JzYGPHubFy8DCcowDHQ99rl1ArVekdypk/OULcciFdzzb8SyxF/JccADjO5DfrYI0vH4/
	 7dgeZHLzywC5k+sZbfVRIkHo9ww4RuZ+d6PDagijtZMzSRcjisujcZR6BcwF8a1g+BEGg
	 pqFDAkyUlYE/F4675DKcnqNSmlaS3/Wc04l2e2iigD3/eCcwHqkTqc0NtVsJAsQVeMQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794286045;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=wC4bjhOhhN40eUTNX01dcV9nWNkEq784qFI5/5FUXkY=;
	b=t1yZ115BRCgIG4s6tftHEFeKDplo8U8YYgfZWVXSzXcUQMy/pSQD22d0o9OPgLc0MgJG
	 /NHB6W0y5yCp1N38ePWp0+PPf7d4YymgDLBgtMmxr1XS3WTzaUEpvJubOei1ADnw579Bx
	 Qn4XasLy3CpBChF6OuQEaZYw0b6S4AQPcbn7joOo13lDuHR/MqmR1kUQD5jFvkXhwbj+h
	 acCVW0eMAdmWe04lHSCDKi9tEj1MiHktrjgbeuUOs0d0aLrxsVzmjTwWoVP0GqJGojuJP
	 Yu9++SyTk7M7LCSh0SiHSzq+I30aeZyzObWqpGCllGDkRB1dBikbeWum4N+vboQ9WYw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BOKtYxA2;
	arc=none smtp.remote-ip=209.85.160.180
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2302F606A333
	for <linux-input@vger.kernel.org>; Tue, 10 Nov 2026 04:47:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2302F606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BOKtYxA2
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-5365f9a04c5so20965591cf.1
        for <linux-input@vger.kernel.org>; Mon, 09 Nov 2026 20:47:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794286044; x=1794890844; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=wC4bjhOhhN40eUTNX01dcV9nWNkEq784qFI5/5FUXkY=;
        b=BOKtYxA2Y/d5AExMzrRrxYGrgfAuorC3jD7qH8yibGS3P6VdbCYINFUliHco6MPMES
         7Bplz6JmAKdCJPtQJppbrc0Re04zFtI8Da5jrQraEQ82Ljm9WihiXnZxZxPZjY9VKMn2
         PqQblg1npSaPIa50xOLOTvjw1FaAAAsg5glHi+dUCvWBaXxWqbvhSpd1FcdXszL/DR9H
         ieOiHYslvG/vZmMHkmSVc0MYCvdEg+NtLwdr2wVjeMYK+0ex/nNGrWyOYDbrTq7t8t/T
         mX64h7WhF+YERyg/UkTCLMrR/YF7rnY8TU6OAnhvDPA1/SSA2PM8h/OoQs4/w2Ndsg8a
         VxWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794286044; x=1794890844;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wC4bjhOhhN40eUTNX01dcV9nWNkEq784qFI5/5FUXkY=;
        b=Nh4OPkD8orT9cXhI7/bqyMp4S30oivTEKqeOE2vzYx9pNV6xEtQdHCBOOQURxXQ3M3
         h7/MTag5RPLmsYuaF9rA6j9pabXje+JZFFR2G+epD4Zyt+bhWupSrYxO7V1DJdEmdOGV
         AnQyLOLxWxu4agaO3zLk0HBbUcNQkPl97PAmIS3gskMSylkIWLu0JuzL4QePVidlpTDY
         7xwKn6ALzqYimGaiWlg3+svJ37dXJCLOvjjyTtuvqr2uU3A4Wn6y1822byIgA7jkEF/Z
         ZYE2ck93eTpScgvMM4zLckhs/i/I99hyZj0HRx/xqjrZZ/xN0PhsUxEEFH+qf5o2b91G
         GjGQ==
X-Forwarded-Encrypted: i=1; AL+hErEXsH6K70hvqKp1fpzXp2mr5khC3qz6Nf4boomsoCoJUgb+mCqb/yVzVMr5kn0d83l0p+w8+NhITNn2Ug==@vger.kernel.org
X-Gm-Message-State: APuU4Z8fiCypkJcpD9tq1WaAYfDJVbcB2OsGV2yRwcsGa8nhl3/Cfr2D
	JxYyR4ZQUrqsJl+9qAprJ8rP8cdJohcaCS9YqfBHOrU87aKblRbn0MQ=
X-Gm-Gg: AYBFou3oPrqJBNWMQ7qy7NAVv+UhM16Xxd574bjuTCz8YbJDis+ZcUYOrFcr9kCv2JO
	r7WyfLsiAyy5+HSrZFOak0fzxx+5fmcgJDUm8O8FO80QyFRmGdWidrl2vkDGSXpin+oDBDJx73K
	wRRfC88sR0E8GetIH9YlY/ij/gJZ39yPmz4RALlK7RyDUDbNmhYh/rka07cJXsUNkQPoX80tfPV
	gq9kA2SiTouU9H1dGnWR2LvKRWVobYl93R2X0/64J5t/GZqNznzaO+26MpmZnKh1tLv1tDAuKji
	10Pd8WMAQwwAtq5gw+oKXXnrww6HvtIPo+yL5IHIG5vMapDbbpjilMNh7oLD8953WGGn4v7DFCo
	yHMoW/8H3pz3RKyk79u2xcGmlWpxSKcXmkEZNXrXtK4kwixppPFn4v1332YgaNRviakLko72sZ8
	dPuKHKEreYUuhGSE35T/3dTWEkThrbXutdg6iMYozA3RWxWhAhad5nZNBsvFvgTyjwgdvDM6xmS
	vXhedITQO4M9hW90GvKWL+RtT12WtbV76Tw1e1iYlNRaoAo7FlzfuatLpSNf4QvAlzqwjbGxWTz
	lGaBORC4GbR6/PQCwqb4MJZbQMPrBJ71KU6Py/CtJe8GnSdnEo8Dt3xszsA0tndUBRUsU4o571R
	peXh0S1i8WAjEkbS1OS75ETzLjUnhwf7JjjDBI7eIgqiZwjR6ONRdO2zDW1+RFp6/
X-Received: by 2002:a05:620a:468d:b0:93f:611d:a18e with SMTP id af79cd13be357-9479f376a49mr271245385a.55.1794286044122;
        Mon, 09 Nov 2026 20:47:24 -0800 (PST)
Received: from localhost.localdomain ([104.39.152.7])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9479e73ab4bsm137920185a.14.2026.11.09.20.47.22
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 09 Nov 2026 20:47:23 -0800 (PST)
From: Myeonghun Pak <mhun512@gmail.com>
To: Even Xu <even.xu@intel.com>,
	Xinpeng Sun <xinpeng.sun@intel.com>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: Myeonghun Pak <mhun512@gmail.com>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Mark Pearson <mpearson-lenovo@squebb.ca>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ijae Kim <ae878000@gmail.com>
Subject: [PATCH v2 1/2] HID: intel-thc-hid: quickspi: quiesce IRQs during teardown
Date: Mon,  9 Nov 2026 23:47:18 -0500
Message-ID: <20261109-thc-rebase-v2-1-mhun512@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261109-thc-rebase-v2-0-mhun512@gmail.com>
References: <20261109-thc-rebase-v2-0-mhun512@gmail.com>
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The managed IRQ can access HID/DMA buffers or queue recovery work while
remove or probe unwind tears down those resources.

Disable and synchronize the IRQ, drain recovery work, then mask THC
interrupts before freeing the IRQ and releasing HID/DMA resources.
Track IRQ/DMA initialization for conditional probe cleanup.

Disable the IRQ before shutdown deinit as well. Keep IRQ disabling and
release outside the shared hibernation helper.

This issue was found by our static analysis tool under development.

Fixes: 4138f21115ae ("HID: intel-thc-hid: intel-quickspi: Complete THC QuickSPI driver")
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
---
No hardware testing.

Changes in v2:
- Rebase on mainline b3dfbde62cf1. No source changes from v1.

 .../intel-thc-hid/intel-quickspi/pci-quickspi.c    | 28 +++++++++++++++++-----
 1 file changed, 22 insertions(+), 6 deletions(-)

diff --git a/drivers/hid/intel-thc-hid/intel-quickspi/pci-quickspi.c b/drivers/hid/intel-thc-hid/intel-quickspi/pci-quickspi.c
index bf49d8ce5f07bed092339e46c444538d78cffe26..acb4d2716ea7450d2852a900c3f0acc1d7570421 100644
--- a/drivers/hid/intel-thc-hid/intel-quickspi/pci-quickspi.c
+++ b/drivers/hid/intel-thc-hid/intel-quickspi/pci-quickspi.c
@@ -600,6 +600,8 @@ static int quickspi_probe(struct pci_dev *pdev,
 			  const struct pci_device_id *id)
 {
 	struct quickspi_device *qsdev;
+	bool dma_initialized = false;
+	bool irq_requested = false;
 	void __iomem *mem_addr;
 	int ret;
 
@@ -652,6 +654,7 @@ static int quickspi_probe(struct pci_dev *pdev,
 					qsdev);
 	if (ret)
 		goto dev_deinit;
+	irq_requested = true;
 
 	ret = reset_tic(qsdev);
 	if (ret) {
@@ -670,17 +673,18 @@ static int quickspi_probe(struct pci_dev *pdev,
 		dev_err(&pdev->dev, "Setup THC DMA failed, ret= %d\n", ret);
 		goto dev_deinit;
 	}
+	dma_initialized = true;
 
 	ret = quickspi_get_report_descriptor(qsdev);
 	if (ret) {
 		dev_err(&pdev->dev, "Get report descriptor failed, ret = %d\n", ret);
-		goto dma_deinit;
+		goto dev_deinit;
 	}
 
 	ret = quickspi_hid_probe(qsdev);
 	if (ret) {
 		dev_err(&pdev->dev, "Failed to register HID device, ret = %d\n", ret);
-		goto dma_deinit;
+		goto dev_deinit;
 	}
 
 	qsdev->state = QUICKSPI_ENABLED;
@@ -695,10 +699,16 @@ static int quickspi_probe(struct pci_dev *pdev,
 
 	return 0;
 
-dma_deinit:
-	quickspi_dma_deinit(qsdev);
 dev_deinit:
+	if (irq_requested) {
+		WRITE_ONCE(qsdev->recovery_disabled, true);
+		disable_irq(pdev->irq);
+	}
 	quickspi_dev_deinit(qsdev);
+	if (irq_requested)
+		devm_free_irq(&pdev->dev, pdev->irq, qsdev);
+	if (dma_initialized)
+		quickspi_dma_deinit(qsdev);
 disable_pci_device:
 	pci_clear_master(pdev);
 
@@ -721,9 +731,12 @@ static void quickspi_remove(struct pci_dev *pdev)
 	if (!qsdev)
 		return;
 
-	quickspi_hid_remove(qsdev);
-
+	WRITE_ONCE(qsdev->recovery_disabled, true);
+	disable_irq(pdev->irq);
 	quickspi_dev_deinit(qsdev);
+	devm_free_irq(&pdev->dev, pdev->irq, qsdev);
+
+	quickspi_hid_remove(qsdev);
 
 	quickspi_dma_deinit(qsdev);
 
@@ -750,6 +763,9 @@ static void quickspi_shutdown(struct pci_dev *pdev)
 	if (!qsdev)
 		return;
 
+	WRITE_ONCE(qsdev->recovery_disabled, true);
+	disable_irq(pdev->irq);
+
 	quickspi_dev_deinit(qsdev);
 
 	/* Must stop DMA before reboot to avoid DMA entering into unknown state */

base-commit: b3dfbde62cf1981c4638939c159dfd087b7a72e9
-- 
2.53.0
