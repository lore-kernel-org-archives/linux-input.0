Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794465480;
	b=dvHk8Rp6zqrQIfXy/XF0DapT+3XedPHxk+/yAk/9WkPi1/08MLuo3UNceI4sXxE6qkoT
	 3BJHVq3weigkpZuze7McdgCqZiFtvn18FaN0PBzV4H4KLEY3wo1+uAtMHMv2wsWbWdyVB
	 4YG8lKTARu5g7cHWqdsOsqWI/dBGQKP/57PQiSyLcn6QozX9vql4YB6VJfQJ22XBMD+Rd
	 l8KafMqLHkuAHwve1s8qGvGl2cxGrOaY7/gQza7wq2XO14pgQQLnSofCA83Meyyh/hu39
	 XFwl1iuJr7q1+Uk268nu0sA6FzxBA7f7dVSGM/u8FEY+jg61oyQtTzRflrMUmCI84aw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794465480;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=IjW8FjpBB738idIMh2c2G0UwubAUjehXMvdNt5zGIgI=;
	b=SvDXBI3csnzPoBvYsHALE1CvlTnd0fE/ai1jjW3zhDFL79tqRcDGzncF5QcqNeBr2JDx
	 DPDuZmH6dPFrCddJQxyg74EGbkrJl/rkDHPoGIms6s0UYtpGgfBToeOGEtx8hJeJiyiOu
	 x6XXP+ocnRS9d6yjwrN3Ypj2/X33aK/GqM71PG0e0TWGmwhyytQW5kcDcCZYButl1nMRO
	 4//U/VoNp9TXMIlHH3eCbQVsoynB+m/PoE40VqTjtIIcd6oGYoYG2PgAzvmHohltjeGkL
	 FPQ9WnnfXD6tHjgQ3hjRW0/cc2Hit6bv3P5tFirZegh+Z8rVcoVBq1CtzfkCP3DXPVg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=La9hR4Km;
	arc=none smtp.remote-ip=209.85.222.173
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2131606A88F
	for <linux-input@vger.kernel.org>; Thu, 12 Nov 2026 06:37:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D2131606A88F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=La9hR4Km
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-945e6d9ceeaso336214185a.0
        for <linux-input@vger.kernel.org>; Wed, 11 Nov 2026 22:37:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794465479; x=1795070279; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IjW8FjpBB738idIMh2c2G0UwubAUjehXMvdNt5zGIgI=;
        b=La9hR4Km7gw+WIla7x4BOBrH4IeJMFTXN7rjLTKymGzp7MH5i5iPiCor/+Oyp9DFdK
         RFAVj9huTmOQQ4vrJuNtmSfdERUOYt6gNI13X/lp4sBYMAgL5h0Yxz+7r2W5gCOpyufG
         ZFdkwYRTbjGYG+VOjdL9Gz9Uet9wuzU1iXiDe2MgnBjgUUI2qzBw0L6sjjn1JAsedbiK
         lGYoCKXiHVrCCfxA3KHHH88ggqnq+gvYAabHNPiFPSqA2KGBQ5loHc+x1sK4BtaqSqtz
         vHx03UkOAhn+EqjI5Nu1lBC+c/XRTdIHLltR6cB0k+7z0VYqEVHrV6T5aWcuFYHaoYFP
         S/9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794465479; x=1795070279;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=IjW8FjpBB738idIMh2c2G0UwubAUjehXMvdNt5zGIgI=;
        b=XiuiQMAuzBKuLNmWk5wr10VZf+NBarnnMbZeJCFAK11+6IWwZqsznPbYnIhkSBpNjM
         Np3/wlYF8b28tRZvC4/Iitlxh76UrWrHMDviKh3o1yeTLacCny5RA4NgeEFMje/CNLR/
         fa2X+WkDCIZsk7MMuCSD1bCIal1e4ts+sWyU3+S1cInbTjA+8rRjCA2hrmqwBdfhJo2U
         cxjS9jOE6JAguKUAr1tr7WxnjOjuuaz1Lelqobka1X/r18L50RuUszSSWAeehNgFEybJ
         xPve/Z51qC77bfY2iJU5Z9gahIWjqlXcClS5POKAtqbp/fMYw8HlCLkS4JykH/yNmrMZ
         g5GA==
X-Forwarded-Encrypted: i=1; AL+hErHQQUddhyZiFVPd1aAHDFX40e79usUuZ/cH1CUbp6g0/987p2CLZ+BpyuQSofhvLoSy56Gpauy8IjmJDw==@vger.kernel.org
X-Gm-Message-State: APuU4Z8HqfudlHLHYPwCk9iiyTv23wiayoqQsotowVw/dkGJw9sHDjP+
	9VyovxUV/TGZsORMnlgbX7x4h5nkdEGfDIP9e4owHdqSxaNSZ0lSWb0=
X-Gm-Gg: AYBFou3OeYfMKJtsI0XGZ2yaCrdNz3ls2QS2gfc5VXSY0nfM7yoLbV7wB9J6h46VbCL
	GI8NuFpxmjBOvS2w8diLmzdtsyw4uCQg9w7t4lGU1iLowH2AfBAJxdCDTZRtvYSlebi72Sqj2sW
	oNi/Ue302EOhIzCxyUy66CcHR/44CEcIoDOCn/vPAqrLPS9B4kKnpqz8pynS0ZuAsXek9t86ZvX
	OLDY2dmQPncWRkvEUGybg3mVb13ox0gocah3qq+IoLnlvW7w+pCxKxB4sxi//alFltXAimzf9J5
	SJIhp52r9MqjF5de37fCI2Ghuqw4bsSrlOu528AvP700cqRI5xFQ44El1w5qePOaMK2bDS9PGu+
	+jkauveKZOqZR/IRahHtEkQS16rT46yI/BzmdZxb6YB9X2oVm3ithjXkwVkIax7HvhsWU8Vb8am
	/Ryk5dtM0gj67W/3qGdtkHF6bQZXTRIRZez3TKTQTN6p0oPbqu0jKEKac+AHSSyeEXG891ifVm5
	RyWqCij/+/dAwfksvIpYcfKFd18RL37KCTxvxalUu4n8tUyJwAC1/5Fqk+9ZzE6QTvI7o+BENvR
	gjsDI1G0toTd4qQMAsvkvyF9xVAXhJ8yLHywKglUaajkc0rcQ8cx6ad9FSZ5eM08qR9GcVx0Pwc
	FGYEBfwd0WlGNjrMAh3hZZe2VG0aW2ngjU+Cg8gwQ9d99bL0ApESUREoXjOOiPFqFTBObRY3R5N
	jiBBkPco8PObKLn9I7pVz58NEvjVojfnDm
X-Received: by 2002:a05:620a:440d:b0:93f:5f83:2ca7 with SMTP id af79cd13be357-947affbcac7mr813036885a.52.1794465478806;
        Wed, 11 Nov 2026 22:37:58 -0800 (PST)
Received: from localhost.localdomain (h16.44.55.139.dynamic.ip.windstream.net. [139.55.44.16])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9479e7e3c34sm658719885a.36.2026.11.11.22.37.56
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 11 Nov 2026 22:37:57 -0800 (PST)
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
Subject: [PATCH v3 2/2] HID: intel-thc-hid: quicki2c: quiesce IRQs during teardown
Date: Thu, 12 Nov 2026 01:37:52 -0500
Message-ID: <20261112T063704Z-thc-v3-2-mhun512@gmail.com>
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

Fixes: 66b59bfce6d9 ("HID: intel-thc-hid: intel-quicki2c: Complete THC QuickI2C driver")
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
---

Changes in v3:
- Add blank lines in the probe error path (Even).

 drivers/hid/intel-thc-hid/intel-quicki2c/pci-quicki2c.c | 32 ++++++++++++++++++++++++++------
 1 file changed, 26 insertions(+), 6 deletions(-)

diff --git a/drivers/hid/intel-thc-hid/intel-quicki2c/pci-quicki2c.c b/drivers/hid/intel-thc-hid/intel-quicki2c/pci-quicki2c.c
index 29319b6227f3..84e458fdd69c 100644
--- a/drivers/hid/intel-thc-hid/intel-quicki2c/pci-quicki2c.c
+++ b/drivers/hid/intel-thc-hid/intel-quicki2c/pci-quicki2c.c
@@ -652,6 +652,8 @@
 {
 	const struct quicki2c_ddata *ddata = (const struct quicki2c_ddata *)id->driver_data;
 	struct quicki2c_device *qcdev;
+	bool dma_initialized = false;
+	bool irq_requested = false;
 	void __iomem *mem_addr;
 	int ret;
 
@@ -704,6 +706,7 @@
 					qcdev);
 	if (ret)
 		goto dev_deinit;
+	irq_requested = true;
 
 	ret = quicki2c_get_device_descriptor(qcdev);
 	if (ret) {
@@ -722,6 +725,7 @@
 		dev_err(&pdev->dev, "Setup THC DMA failed, ret= %d\n", ret);
 		goto dev_deinit;
 	}
+	dma_initialized = true;
 
 	ret = thc_interrupt_quiesce(qcdev->thc_hw, false);
 	if (ret)
@@ -742,13 +746,13 @@
 	ret = quicki2c_get_report_descriptor(qcdev);
 	if (ret) {
 		dev_err(&pdev->dev, "Get report descriptor failed, ret = %d\n", ret);
-		goto dma_deinit;
+		goto dev_deinit;
 	}
 
 	ret = quicki2c_hid_probe(qcdev);
 	if (ret) {
 		dev_err(&pdev->dev, "Failed to register HID device, ret = %d\n", ret);
-		goto dma_deinit;
+		goto dev_deinit;
 	}
 
 	qcdev->state = QUICKI2C_ENABLED;
@@ -763,10 +767,20 @@
 
 	return 0;
 
-dma_deinit:
-	quicki2c_dma_deinit(qcdev);
 dev_deinit:
+	if (irq_requested) {
+		WRITE_ONCE(qcdev->recovery_disabled, true);
+		disable_irq(pdev->irq);
+	}
+
 	quicki2c_dev_deinit(qcdev);
+
+	if (irq_requested)
+		devm_free_irq(&pdev->dev, pdev->irq, qcdev);
+
+	if (dma_initialized)
+		quicki2c_dma_deinit(qcdev);
+
 disable_pci_device:
 	pci_clear_master(pdev);
 
@@ -788,9 +802,12 @@
 	if (!qcdev)
 		return;
 
+	WRITE_ONCE(qcdev->recovery_disabled, true);
+	disable_irq(pdev->irq);
+	quicki2c_dev_deinit(qcdev);
+	devm_free_irq(&pdev->dev, pdev->irq, qcdev);
+
 	quicki2c_hid_remove(qcdev);
-
-	quicki2c_dev_deinit(qcdev);
 
 	quicki2c_dma_deinit(qcdev);
 
@@ -814,6 +831,9 @@
 	qcdev = pci_get_drvdata(pdev);
 	if (!qcdev)
 		return;
+
+	WRITE_ONCE(qcdev->recovery_disabled, true);
+	disable_irq(pdev->irq);
 
 	quicki2c_dev_deinit(qcdev);
 

base-commit: b3dfbde62cf1981c4638939c159dfd087b7a72e9
-- 
2.53.0
