Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=82.195.75.108
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795791603;
	b=ibQZm9zRrSBd+cieA+hXCf8hVj0sb6atE+DYD9B8ZnxQKP4LahMJ3jjyqUlEFOOKoveY
	 3CO2zH3Flf5cZjRm8LOJQdrzP+JAhKVwepSKtO8BI+Av8Thnk3Bl6PAGPVH6J0joA7rfZ
	 vUnnLYOZ95xCyII4iYdSaDl1pah2neBFpWKz+rlzN1OjOebMrv9pnOCEVGcDSJ2aY57tj
	 SHZ6I7NoQpcMvx4tldJG60P4CJ4cHDZF2zfpCpCpleo8lJZUE9amcS+ccKygnoB1OOIGU
	 TGZrXyjYgnYtaw3NlGtRbs27tXnlfks0fyVaLNNQSEdnSrqjiw+2G1XMk/XS4ehdsYg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795791603;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Debian-User;
	bh=Q9a2iLmkh9/QMweQuYwygX1Z9v0WNXBOpABFDXzHVnI=;
	b=Xw5gxazeWvVF8WPUXg6mUEvqOQfGoszDUxlp+19t3ZbVI6aaOAjPJOTt/NhZEyAxryVo
	 eg1r4nB4kJZ+AcuOfnsEkHYZDRXue8e8jh3S6x4j13DcvB8riAbC8PZoomfSYbz1MKtfR
	 Ph3WUKLD/5snKIbNLO64tnV9ZRTY0tU3fbdkFBo7f52JVhJaJvxPYSHVpf0uAq7v2YQeF
	 +8REgILbSJgYQ+TnCsWz8yh2pcqPKKs+gRLq77Q2OZ7Pequne/Xvy6owuRRziUOUR99k9
	 7/RO+/6IjBKlaOKS2ZG/hpEX7A83hHEfP8+C91RBWcwdYyL9K/SJrfLaLbb2nG2pEBQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=debian.org;
	spf=pass smtp.mailfrom=debian.org;
	dkim=pass header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b="Q0/1PA37";
	arc=none smtp.remote-ip=82.195.75.108
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2DD4606A329;
	Fri, 27 Nov 2026 15:00:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E2DD4606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=Q0/1PA37
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=Q9a2iLmkh9/QMweQuYwygX1Z9v0WNXBOpABFDXzHVnI=; b=Q0/1PA37fdQ+h3tYI4t0OocsB4
	fJPhYeiECo3HTnLnsCk2RBE4kgoEvafRdsakSehAmDlTvj3HTb//wbNvRiIIdrt2jNotJF2Isxtbc
	BYteadZ1SlQSmORvqNEagakKsNOVLVLzITMOk8jYFvupVlodHtI8x5XCSjoKjVEPpctsE3WkjtM/N
	1JBMWa6g5xSEzdQ6f8VyodiugLR4FNEcoJV1wC56ijiKBdl6wdw/LYVRy6TqGy9t5NxuLvE771LDr
	bdA9nJJjJ5G6BjyODhn+kW2XJSFMR7Ni+pTZLx53wfAdL5srx0ekP0p9CPGdoY3DOFZtIQBHQbIUw
	wTTy+Ieg==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <emfox@debian.org>)
	id 1xWxQb-008Q0k-1i;
	Fri, 27 Nov 2026 14:59:58 +0000
From: Emfox Zhou <emfox@debian.org>
To: Even Xu <even.xu@intel.com>,
	Xinpeng Sun <xinpeng.sun@intel.com>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/5] HID: intel-thc-hid: intel-thc: stop all engines first
Date: Fri, 27 Nov 2026 22:59:19 +0800
Message-ID: <5ff3f08251fb99b988e7a3443b753b6c9cd58bf4.1795791500.git.emfox@debian.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1795791500.git.emfox@debian.org>
References: <cover.1795791500.git.emfox@debian.org>
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
X-Debian-User: emfox

thc_dma_unconfigure() clears the PRD base address and the control
registers of every channel, but stops only the two receive engines. The
write and software DMA engines keep their start bit, so an engine that is
still running is left pointing at a table base of zero.

Stop all four engines first, and clear the tables afterwards. The four
start clears move to thc_clear_start_bits(), next to the per channel
setter, and thc_reset_dma_settings() uses it as well, so the set of
engines is written down once.

Fixes: a688404b2e20 ("HID: intel-thc-hid: intel-thc: Add THC DMA interfaces")
Signed-off-by: Emfox Zhou <emfox@debian.org>
---
 .../intel-thc-hid/intel-thc/intel-thc-dma.c   | 33 +++++++++++--------
 1 file changed, 19 insertions(+), 14 deletions(-)

diff --git a/drivers/hid/intel-thc-hid/intel-thc/intel-thc-dma.c b/drivers/hid/intel-thc-hid/intel-thc/intel-thc-dma.c
index 15a2966f7..607e21c3e 100644
--- a/drivers/hid/intel-thc-hid/intel-thc/intel-thc-dma.c
+++ b/drivers/hid/intel-thc-hid/intel-thc/intel-thc-dma.c
@@ -94,6 +94,18 @@ static void dma_set_start_bit(struct thc_device *dev,
 	}
 }
 
+static void thc_clear_start_bits(struct thc_device *dev)
+{
+	regmap_write_bits(dev->thc_regmap, THC_M_PRT_READ_DMA_CNTRL_1_OFFSET,
+			  THC_M_PRT_READ_DMA_CNTRL_START, 0);
+	regmap_write_bits(dev->thc_regmap, THC_M_PRT_READ_DMA_CNTRL_2_OFFSET,
+			  THC_M_PRT_READ_DMA_CNTRL_START, 0);
+	regmap_write_bits(dev->thc_regmap, THC_M_PRT_READ_DMA_CNTRL_SW_OFFSET,
+			  THC_M_PRT_READ_DMA_CNTRL_START, 0);
+	regmap_write_bits(dev->thc_regmap, THC_M_PRT_WRITE_DMA_CNTRL_OFFSET,
+			  THC_M_PRT_WRITE_DMA_CNTRL_THC_WRDMA_START, 0);
+}
+
 static void dma_set_prd_control(struct thc_device *dev, u8 entry_count, u8 cb_depth,
 				struct thc_dma_configuration *dma_config)
 {
@@ -267,14 +279,7 @@ static int setup_dma_buffers(struct thc_device *dev,
 static void thc_reset_dma_settings(struct thc_device *dev)
 {
 	/* Stop all DMA channels and reset DMA read pointers */
-	regmap_write_bits(dev->thc_regmap, THC_M_PRT_READ_DMA_CNTRL_1_OFFSET,
-			  THC_M_PRT_READ_DMA_CNTRL_START, 0);
-	regmap_write_bits(dev->thc_regmap, THC_M_PRT_READ_DMA_CNTRL_2_OFFSET,
-			  THC_M_PRT_READ_DMA_CNTRL_START, 0);
-	regmap_write_bits(dev->thc_regmap, THC_M_PRT_READ_DMA_CNTRL_SW_OFFSET,
-			  THC_M_PRT_READ_DMA_CNTRL_START, 0);
-	regmap_write_bits(dev->thc_regmap, THC_M_PRT_WRITE_DMA_CNTRL_OFFSET,
-			  THC_M_PRT_WRITE_DMA_CNTRL_THC_WRDMA_START, 0);
+	thc_clear_start_bits(dev);
 
 	regmap_write_bits(dev->thc_regmap, THC_M_PRT_READ_DMA_CNTRL_1_OFFSET,
 			  THC_M_PRT_READ_DMA_CNTRL_TPCPR,
@@ -518,16 +523,16 @@ void thc_dma_unconfigure(struct thc_device *dev)
 {
 	int chan;
 
+	/*
+	 * Stop the engines first: one that is running keeps writing through
+	 * a table whose base is already gone.
+	 */
+	thc_clear_start_bits(dev);
+
 	for (chan = 0; chan < MAX_THC_DMA_CHANNEL; chan++) {
 		dma_set_prd_base_addr(dev, 0, &dev->dma_ctx->dma_config[chan]);
 		dma_clear_prd_control(dev, &dev->dma_ctx->dma_config[chan]);
 	}
-
-	regmap_write_bits(dev->thc_regmap, THC_M_PRT_READ_DMA_CNTRL_1_OFFSET,
-			  THC_M_PRT_READ_DMA_CNTRL_START, 0);
-
-	regmap_write_bits(dev->thc_regmap, THC_M_PRT_READ_DMA_CNTRL_2_OFFSET,
-			  THC_M_PRT_READ_DMA_CNTRL_START, 0);
 }
 EXPORT_SYMBOL_NS_GPL(thc_dma_unconfigure, "INTEL_THC");
 
