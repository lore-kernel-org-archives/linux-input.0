Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794465478;
	b=tkeR70FDfjJJ+oX3xzjTGjNMd7A+NIDIQ9f+b5RiZs8M2GYUIIgsBClgZwrgqIic/sT9
	 DH1gqk/iEEpLQrSyOk2U8pYfR6WTuWQQ2Q6kVJMPI+Og0eoQE6HmKw/zXT/vK53Ilf7Wp
	 +ST0NkUPlxf/bJcPzCi4bsvdsOBFoFU8cWDi37I6RLzb6o66n5gvzZAjtG7VxCoxbki3V
	 S14KJOpIzZtzlDRCNvGXZCksHguP5l00qXYBE3/lhJAdrkMwJpHmzexIhsjwM6bEauQnA
	 aeyWZNXZ0YG+rcDlTtNR5vvZx6TT7/cvlZ2pCHuaUQEC+rqCvbbpJJ38iWhJNJTreFQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794465478;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=OkeeWDCkxdffvS0wSjkvgvaVXM+F7+2xZNU5w6osvGE=;
	b=xuXz0VEqlkEUk5ujtqeE7CpDlTZuBC3TyFv3rdg+7OnzqGMidpJkMLuOejIzR7tvHExo
	 +vgaZzBNg/GGc2gJgGmnPoQ3s/QavXLQFgsNhn5fJBXMZue4BaQzZZtbN2ah6SkQjhI2O
	 wqSGzEkE4IgyFPeO+6B0TtxUs/sJn0VEBO4dWbZT15uCAAYp7EfinjSOWuvo2Eav+N3JM
	 2qWGtwb6MVPty3AwDrleMUkBHnvttT8iDohQp8UKkLLD7gjrnD+vcqHBzkb0pk5lCa5/D
	 //UAuXoMFx9/FktSZDjO+wJlaMVBhw9wml5fxME0RlZ7F3HGO5ZwEPNPFb/az7UzoIA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xkYXWNaD;
	arc=none smtp.remote-ip=209.85.222.177
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC5C3606A336
	for <linux-input@vger.kernel.org>; Thu, 12 Nov 2026 06:37:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AC5C3606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xkYXWNaD
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-93f2b8cf037so347420085a.1
        for <linux-input@vger.kernel.org>; Wed, 11 Nov 2026 22:37:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794465477; x=1795070277; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OkeeWDCkxdffvS0wSjkvgvaVXM+F7+2xZNU5w6osvGE=;
        b=xkYXWNaDJJi9Ef9rHKolDilpQ2ae4Uy9NE962l5PYu/SWhfci3ZDyYpMonEmfubENd
         LOB0C9WxSuZRla6m/1REcj8tTJ9y9mTwPiFH7A/Eo0Ol4rzJ/8If8yu4SbRZl2bVifTb
         LpQZU8pM2Ni3blE5GvWscPgzdkXstAXaWI0WmRb9mOTJv6SwV6uhghIZXbL9eRjh8S4u
         U4m0nYk03jliOJcL0+5ZMoit3uJRZNMHsz4pDrVN53Kw+h5SckahhB+I9F/7ZzOHs4jM
         scV7g1Iygfi+Qn5vR28dxuoKj0PG5VkUc8bHj2XiLx438Oa5IbCX4pz4ChTRb83hK9aE
         VAcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794465477; x=1795070277;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=OkeeWDCkxdffvS0wSjkvgvaVXM+F7+2xZNU5w6osvGE=;
        b=TWIZREt3Pp7y/FMgxM9hZi/mlF7dPxTY7ZmnT5O7PGsnb8Fvnc+tA+mTKW5FPbJeBO
         jk+GFD1GWxjXQL41Nd1YEyAjA/lEaUcmGjl4VjTBhyLsavhCBGyU3GdkMD2/f1p7dVAc
         ULd10eI00MUeO1k8QzA9G4ugUOkXtfYqlLurr9wIcH416apiVWu6TMSCTh7MzgJn8yBU
         u9avWgK/AbU5HiNj7rSbvWk0xOYCkDKneA8UHQ4018+VjVZyBQLnsMWTFvhGRhb4F/kI
         hliGHIWOgzeLFi44RXpuyP73r4ZslrR0fv1y2eP4ylTlSPZ1AfdCechyhn2DkWSKOyb3
         TKmw==
X-Forwarded-Encrypted: i=1; AL+hErEC3kini61HtqVMYzCsRR/BnX772eEI4NgEyyu6iuxKhmC3r9pM2ijbNRKGtJufwtv4JU4Lr8xCIP8mWg==@vger.kernel.org
X-Gm-Message-State: APuU4Z8td/eRPGioNgvNxdj6wGtaOWs7oBaJr7Wu6cz73jw9iHNvU4yg
	AgizguQAuhEZHqt87v73xAfswTVp5U3IDSQvtfudoJarYy+7r6CjrP4=
X-Gm-Gg: AYBFou1KK/znwo6K8m1nZa4SgkXnuBX3ruHJzqhaPB/GQFkzWH+P1mhUNlRYxPZKTf5
	Ei7uW+wWc7Xd5QafpIBzudTpX89bQ7dMMmH5PH4n1ZSeUQK0CeaWSlky85mYW//CARxg6mN/4Cg
	bXfMXgsgMdkYyfRbu3dIuxqYRBmLvWIo/V9q6qzi2BEK10QUyB3ijkrgMUa/LMarcGI3nRQPnrT
	jzNe2yct3mdOD2pyaAm/NVRVq15mbcfSemIdWlzbGsO6sPr1bFNVPCsVWlhNEP9sKupLLML3+v+
	NnQhcnhkaEFXRwhLv7lfKI6ZDNJqqCiAmOQ+ubF1JqeMEuxhJ7t9lHeyBHTo841Mi2Z8tkKTMdj
	ffLzQ4fjrGr3qRlbim5eVFZIEg6ZTti6pMxhdxWSv78YsXk2WCPfH91tDcOdNKwTquoR/l9ZGXS
	CuxS8BbbMLO9iqm4m2ohas53j9Lye02g9CW+Xv4KACaX/xqaoqFokxmAZbbaw32b5a0ruwVU5l+
	pMAufdhwkjnbiVTlH4wsgMGqmtDs5bAFONrn5EsTiWv4/pS2e/qRV2d6DZslqZrxpOZyOYI0Nj1
	6+o4oa5qPRDsnA+VXkfVGxw/h546/Og8XKfLH6cR4jvUdSNa9QJHaLAOqL5Z83GmzSKZgPL4r1q
	4oJ2tAEGMmlPUGY20VOgOK5bYeyZiLNFjG3YR+saM/WES3RY6IZyg2VssjFfznQo1dBNsbfJrz4
	3quAqBGjllysYp04WrCqz3i/1WhcUdHYN9
X-Received: by 2002:a05:620a:458f:b0:93b:d7a3:45cc with SMTP id af79cd13be357-947affc1715mr809592285a.53.1794465476793;
        Wed, 11 Nov 2026 22:37:56 -0800 (PST)
Received: from localhost.localdomain (h16.44.55.139.dynamic.ip.windstream.net. [139.55.44.16])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9479e7e3c34sm658719885a.36.2026.11.11.22.37.55
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 11 Nov 2026 22:37:56 -0800 (PST)
From: Myeonghun Pak <mhun512@gmail.com>
To: even.xu@intel.com,
	xinpeng.sun@intel.com,
	jikos@kernel.org,
	bentiss@kernel.org
Cc: srinivas.pandruvada@linux.intel.com,
	mpearson-lenovo@squebb.ca,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ae878000@gmail.com
Subject: [PATCH v3 1/2] HID: intel-thc-hid: quickspi: quiesce IRQs during teardown
Date: Thu, 12 Nov 2026 01:37:51 -0500
Message-ID: <20261112T063704Z-thc-v3-1-mhun512@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20261112T063704Z-thc-v3-0-mhun512@gmail.com>
References: <20261112T063704Z-thc-v3-0-mhun512@gmail.com>
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The managed IRQ can access HID/DMA buffers or queue recovery work while
remove or probe unwind tears down those resources.

Disable and synchronize the IRQ, drain recovery work, then mask THC
interrupts before freeing the IRQ and releasing HID/DMA resources.
Track IRQ/DMA initialization for conditional probe cleanup.

Disable the IRQ before shutdown deinit as well. Keep IRQ disabling and
release outside the shared hibernation helper.

Found by a static analysis tool under development.

Fixes: 4138f21115ae ("HID: intel-thc-hid: intel-quickspi: Complete THC QuickSPI driver")
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
---

Changes in v3:
- Add blank lines in the probe error path (Even).

 drivers/hid/intel-thc-hid/intel-quickspi/pci-quickspi.c | 32 ++++++++++++++++++++++++++------
 1 file changed, 26 insertions(+), 6 deletions(-)

diff --git a/drivers/hid/intel-thc-hid/intel-quickspi/pci-quickspi.c b/drivers/hid/intel-thc-hid/intel-quickspi/pci-quickspi.c
index bf49d8ce5f07..3aa0ae81053e 100644
--- a/drivers/hid/intel-thc-hid/intel-quickspi/pci-quickspi.c
+++ b/drivers/hid/intel-thc-hid/intel-quickspi/pci-quickspi.c
@@ -600,6 +600,8 @@
 			  const struct pci_device_id *id)
 {
 	struct quickspi_device *qsdev;
+	bool dma_initialized = false;
+	bool irq_requested = false;
 	void __iomem *mem_addr;
 	int ret;
 
@@ -652,6 +654,7 @@
 					qsdev);
 	if (ret)
 		goto dev_deinit;
+	irq_requested = true;
 
 	ret = reset_tic(qsdev);
 	if (ret) {
@@ -670,17 +673,18 @@
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
@@ -695,10 +699,20 @@
 
 	return 0;
 
-dma_deinit:
-	quickspi_dma_deinit(qsdev);
 dev_deinit:
+	if (irq_requested) {
+		WRITE_ONCE(qsdev->recovery_disabled, true);
+		disable_irq(pdev->irq);
+	}
+
 	quickspi_dev_deinit(qsdev);
+
+	if (irq_requested)
+		devm_free_irq(&pdev->dev, pdev->irq, qsdev);
+
+	if (dma_initialized)
+		quickspi_dma_deinit(qsdev);
+
 disable_pci_device:
 	pci_clear_master(pdev);
 
@@ -721,9 +735,12 @@
 	if (!qsdev)
 		return;
 
+	WRITE_ONCE(qsdev->recovery_disabled, true);
+	disable_irq(pdev->irq);
+	quickspi_dev_deinit(qsdev);
+	devm_free_irq(&pdev->dev, pdev->irq, qsdev);
+
 	quickspi_hid_remove(qsdev);
-
-	quickspi_dev_deinit(qsdev);
 
 	quickspi_dma_deinit(qsdev);
 
@@ -749,6 +766,9 @@
 	qsdev = pci_get_drvdata(pdev);
 	if (!qsdev)
 		return;
+
+	WRITE_ONCE(qsdev->recovery_disabled, true);
+	disable_irq(pdev->irq);
 
 	quickspi_dev_deinit(qsdev);
 

base-commit: b3dfbde62cf1981c4638939c159dfd087b7a72e9
-- 
2.53.0
