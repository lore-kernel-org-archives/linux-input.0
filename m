Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=82.195.75.108
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794835940;
	b=fv5QiCDfEDXJtsf/yrshdbHji82DHODK2dQJA7NgPYKwh/vBHtpo8zZlEf6KYpsEjddH
	 68FTwRkVu1NTwMLlD9MXQhbSyJhc5QmFi1rchZV66iqMdyF42D05e2yIed7D4cllxA9yX
	 YGuIQM1ZjmwW7kuGzCIKJZ6+IkvwRNLD9yUAAaJJH+K+VVRUtx9NUfXTp8624LQMnAXwM
	 2PdvvNpxDrO6oCgrfy3BpQdZzUZX0bjUkbpBxmw0V0xLCD8fSuD2B8LqmUq5JhjmRc4AL
	 VL8reUrmGfTlFcVlcSzjoNMtqVOcqMbWSQOLlec/yy7sQkxQolq8ea/GapVUkLF+cRg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794835940;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Debian-User;
	bh=O66WQhp15wYn61FOktozXGhiXKtOGH/hvfWxN7C9R+Y=;
	b=c51eVnfLsBLu/qjoId7ljhzcmjGiKuSUbRsu6uSiaNQ5gZvB7JhxGuRTYHBBZ763ADYi
	 Szv1Xpc8gbWpKGj8X44PwDRzSj91ZQh3vdsRW3tl0f9n8WqaWoGDa3g1wgPJGV/IVXv8L
	 4tg2RTgwCckWG75T0wcUmYb1op9ZfJou8kbtXtsjO5qSCU4XXpbRFCTFiwNUDnErfzqqx
	 xuilasMdfEUNrAlwIOcuGh8947vYlqxnv/XRXBZ5s2dm1Zz+V5Wz1TRy51sZ/7qR7bC0v
	 /8C1kbUxN6oK4UYYUvkh61370st7M+Uk0YLIoqDWCBUx2dfQD34yasiNCHfbCAqP7qA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=debian.org;
	spf=pass smtp.mailfrom=debian.org;
	dkim=pass header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=GzzlgmWJ;
	arc=none smtp.remote-ip=82.195.75.108
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3786606A31C;
	Mon, 16 Nov 2026 13:32:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C3786606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=GzzlgmWJ
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=O66WQhp15wYn61FOktozXGhiXKtOGH/hvfWxN7C9R+Y=; b=GzzlgmWJp3Cs73nfbH/R3aMSKI
	4e2JttXs8IyU1kF9hnqkoJdo35ecRYqlXnwtTrbKvTLTmnlEmtmcQd1EKC68/NEGFkWm0KWjs3EVh
	XPZ222oKgxYO47lnJ6x8joeMo4tXXEkLSSppyrCXVnP6GDisDqUfDZj1Vlju+qZFmCRnZkjAK5ZsU
	uFSD4IzUpz/KAdnAZ5pY5zhieY0pvPExj82wb6SytYa2PrHalcJ2eZhqXIkFwW1aks7Cs4cC16o4S
	rEFz7jYq+BTMioG8E81pLtrQNcY0UgdQs0vt1fkDP+ale4dMo1BBb0tkqpS5iNp6rK4OeglfD+MPd
	SNfyk82w==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <emfox@debian.org>)
	id 1xSwog-00HCUB-2V;
	Mon, 16 Nov 2026 13:32:15 +0000
From: Emfox Zhou <emfox@debian.org>
To: Even Xu <even.xu@intel.com>,
	Xinpeng Sun <xinpeng.sun@intel.com>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/5] HID: intel-thc-hid: intel-thc: stop all engines first
Date: Mon, 16 Nov 2026 21:31:30 +0800
Message-ID: <20261116133132.1282020-4-emfox@debian.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261116133132.1282020-1-emfox@debian.org>
References: <20261116133132.1282020-1-emfox@debian.org>
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
index 704c02822..41efdfaf0 100644
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
 
