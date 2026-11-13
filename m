Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794605747;
	b=wFVoN/zgTAf/qdWYaoaLAbP9QgZdcqMm2+amg2RHGTDLyUafmZVauKff5+rOxaIMikXq
	 HJb6J6gV2fK3MxdmTnGj9SHkhtjrK+NhXb+W/pM/mEqmJFuGNTBmPJelTBtnwUpLuaHim
	 FqxuA7UCCgn6xxgvOKdCpB26zZQSCZrbDC8W0RtSCyDoipS1NkSZj0X00majUqOZXUANO
	 Eyh2ru6ZmhEDRD2/8AhvtAAx9TVMvAC2YLPQREBMhgFqX89KP2lepIfUXaq4fdGjy71p+
	 guKE5CCMgLjOnqBYC7tbw13IslMG74iub6GIkg6PvmgGLIbLOChEIVIfkNaOJ1Mw56w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794605747;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=JcHwPtvXCz4X6Lgdx5cLzKzorC7aWVYxZdjGw/lnPm4=;
	b=227IUQHFuhcKwmmpQI/LMQScK2/JjC4FpyS+XcE+/oTby7zI/3Wylfco9oiV07rcZvWC
	 gufigAc53pW0Pr9pjvBBPAHalNOnqRYoP48fLqmpyXjTQ04efgTCaTcuc6yFUtNklUpI+
	 0Ts9+K3Brnr843fdauwRxAWOLHja1wYmsihpDQeoc70KV5xjhlQDlGP8LH6X7PjFiTbp7
	 qzx1ZNXWRmfozTB/OjkOfxwgI0iWCPQ2tJlumEyLMsNtjwkXgf1gnzNrrhtaYaeBS4Wgc
	 jnvcV3KS0rUooNJJWCJatv61S/Fsvsf8RYCln4mJU0+1IEsfEBOtH6bYnFX0BJ8FfpQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Z3vXLpZh;
	arc=none smtp.remote-ip=74.125.82.170
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 021AB606A8A2
	for <linux-input@vger.kernel.org>; Fri, 13 Nov 2026 21:35:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 021AB606A8A2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Z3vXLpZh
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-33fb4680717so4241659eec.1
        for <linux-input@vger.kernel.org>; Fri, 13 Nov 2026 13:35:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794605743; x=1795210543; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=JcHwPtvXCz4X6Lgdx5cLzKzorC7aWVYxZdjGw/lnPm4=;
        b=Z3vXLpZh95kij132HiANDtpjQeVWWLe7AcQLnHwahV+PgOvaonNk/Ydr1nPIisgCFZ
         xDf3MP1Tx3gmxinqvax61c+wInqwkTxquk2nxvngk/pRkeMr0/Ub4xSnMzQW9rTg9byZ
         B7/VZB15lIevt9N9v4i87/1ODvvYU5VzTuDQaSI7cC3CwNhdYpW7OdPqUS7+61WHbYYC
         sTTwvqvYfuq5Ng65xQpKPALZhnlqbEGm85yM3DdaB18YcmcG0oacei76t/TB6MNnrCie
         cENdxiDEsf6DIfcKAK9syrp3YHY2/OEb684fkyZYDvcMlii6JFTWwZIVFL4RCUB4hJCN
         vfxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794605743; x=1795210543;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JcHwPtvXCz4X6Lgdx5cLzKzorC7aWVYxZdjGw/lnPm4=;
        b=nT0pBwtSvPREYgf+N3v2djbBpq514idPImER1XZiZohQ0RPmkhQzOYAINPHFh8gdhs
         hQM4RV6SZc41ygtiYjL2/MWbunDxHHlS9i4g3ys+9hx+bVtF7N+0jbDGF3VUaFsuRL1D
         oNl4pb5/Hy3VqblNmzeNGBXUpid6WzyzOznPtet4IAUgjlobT8vYpSPxQDrHQ/CdTcYW
         oFO8D+WUdej0BHc0oJRxZjSBd6sFTpdz4u4GjUCdg40q6DuUUXQVbn9hZfoJeYBKNZJS
         hPWsHeF9uItyaFWe5mPOl8OWrRfHWBfi6IwPzIcVv15KnfLyzeIkY40oBFNghVinpW6L
         Vw4w==
X-Gm-Message-State: APuU4Z8eL9X+xCiNggnP0vGAD4IcTYjzD4YlrldPbrtcnaTyzCqYFZbE
	shUfJhuDM81pHh1swYBAfajWcHtF6dSHUD66kFeEQjhFIh/bFR0rf3BU8W3yHaJ1
X-Gm-Gg: AYBFou3+M0rz0lsVtL9Ro+FxPx1p/spBotHVCCqT5OYKqlc1t0+RNTOzup7SWYQNvhb
	Zsqe58GCmHZyOnMo/QPLE5Be+g3TBMqPaaXx7hcLnP3oJFh70B4ylRbgYwjGnZbYV5AxG4vD7yn
	NnsEY1SbXpCyeUCWWPepcP+ILWD7r/Ie9POuNkoD4JsZnU4Ku9sLGku8C8LIe2AhwmtEBTLwEhh
	DlWtvwPHM41KCNNJwV0m9BM7UBSgvJQ71JDklzmYeozi50LoYEw8DmWnHz+PooGrGWM0Y+eynzv
	z/GxOMSauMKFNw5roW/F7Xm7lVmtTO6bcAgbjOT9ZT3LdLNKQSyubNahw0Jd1lvHy8N3szrV+4X
	mZX8v/DdImiNes5aj0YVjd41DS49so1a8/aR864MmcisqH1Po8tVkGM02mZQYgIB6nPFvu9yq2K
	egMUaXR+um+xPntSFvkuUqbF5DGulQ0NTUrbNInRdqJdyBFtVpgwnuhf5zXxdkPIo4rkDo6NzJ5
	0s/NNyldJbHILaz/zMMYfBvefjMVN4oSAZ/JuE507Aqi0jc9yVoR4Apibre9Kdm9ko0VXyu3STh
	sNK9JPWQegZsybgrAaPXSbKvoitlc+5v
X-Received: by 2002:a05:7301:1506:b0:372:eab:d700 with SMTP id 5a478bee46e88-37963953befmr3347957eec.1.1794605743047;
        Fri, 13 Nov 2026 13:35:43 -0800 (PST)
Received: from archlinux ([182.48.212.144])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3795378c2fesm10137339eec.1.2026.11.13.13.35.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 13:35:42 -0800 (PST)
From: WhiteDoor6767 <gururajnaik166@gmail.com>
To: linux-input@vger.kernel.org
Cc: jikos@kernel.org,
	benjamin.tissoires@redhat.com,
	Basavaraj.Natikar@amd.com,
	Sandeep.singh@amd.com,
	Gururaj Naik <gururajnaik166@gmail.com>
Subject: [PATCH 1/4] HID: amd_sfh: Fix 32-bit DMA mask truncation on Renoir MP2
Date: Sat, 14 Nov 2026 03:05:30 +0530
Message-ID: <20261113213533.13139-1-gururajnaik166@gmail.com>
X-Mailer: git-send-email 2.56.0
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

From: Gururaj Naik <gururajnaik166@gmail.com>

AMD Renoir MP2 Sensor Fusion Hub uses a 32-bit DMA engine. In upstream
kernels, calling dma_set_mask_and_coherent() with DMA_BIT_MASK(64)
resulted in allocations above 4GB (e.g. 0x110ff9000). The Renoir MP2
hardware silently truncated the upper 32 bits and performed DMA to
0x10ff9000, corrupting active user/kernel memory and causing MCE
hardware memory corruption faults and bad swap offset panics.

Restricting the DMA mask to DMA_BIT_MASK(32) ensures all DMA allocations
remain in the 32-bit physical address space, restoring stability.

Signed-off-by: Gururaj Naik <gururajnaik166@gmail.com>
---
 drivers/hid/amd-sfh-hid/amd_sfh_pcie.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/amd-sfh-hid/amd_sfh_pcie.c b/drivers/hid/amd-sfh-hid/amd_sfh_pcie.c
index 1234567..89abcdef 100644
--- a/drivers/hid/amd-sfh-hid/amd_sfh_pcie.c
+++ b/drivers/hid/amd-sfh-hid/amd_sfh_pcie.c
@@ -298,7 +298,7 @@ static int amd_mp2_pci_probe(struct pci_dev *pdev, const struct pci_device_id *
 	pci_set_master(pdev);
 
-	rc = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64));
+	rc = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32));
 	if (rc) {
 		dev_err(&pdev->dev, "failed to set DMA mask\n");
 		return rc;
-- 
2.48.1
