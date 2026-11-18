Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=82.195.75.108
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794979953;
	b=RMWn54JFruvQPJjdsp6wqP4EbMPwy4sRbDCe7/8dGJFOHPnq4sUVajKtKwply9XxBNUe
	 0mNti58/SDs0JIM+DXR5IC9lit9Psd+6k3YDd7UgXdf9Rnt6o98oeDmX84iB58SzbVyaG
	 k2/Vfn1qPh1qZKNnL5XyKj20TrRzCPkgGRL7YqC3YNJhws+NsJhpmmDShnmvv3X868cK2
	 eBL5Zqd0kyo9ghpw30Zte5NHdG2xbzNY5v3nGWleqMqJiF84JMZ1iGIMnX7Huc79vbPSz
	 u+q7883+cnCcYQnbptpuOGt3BV5vabgxehDK8hWZ8N7z+vJ0n7Yob5S/ouciGK+DU8g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794979953;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Debian-User;
	bh=R+QF+fqmINy5rh8QyT3ILfwAXekLTUaNL1h6LprObuA=;
	b=0No6txLoHpRMDdRJmIj/q3cKTiPUdSbLPgFDb3qdZsfjx3HQIvMfdD2Y6vAQT8qPgPzb
	 kwjgOJBLzxHaeHvYOKTObqp4qVJlBFnz59QlMGTQvXGdQRvSob6nos+feuQAKlP5iijlb
	 QD6Fm/fCdfsWVRhNxC54RoMA4XSOqp0Z4dg8R4VbMue78t6O1qDNj6Wb66JELkcRFD/83
	 21dh5XlF0IyNK7wPwqyP8ISVAzTZyaPOulyDeLhLpkRXRo/PglxU23oUP2QJGOZsCNHoU
	 IthrniqotBNVOAV7Yy0ESv8nv6oE0Oxve4cIConzMiaKlUMzGBpGfG4fF13zGmy/3Gw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=debian.org;
	spf=pass smtp.mailfrom=debian.org;
	dkim=pass header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=OP1WUKbH;
	arc=none smtp.remote-ip=82.195.75.108
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD7AB606A325;
	Wed, 18 Nov 2026 05:32:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CD7AB606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=OP1WUKbH
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=R+QF+fqmINy5rh8QyT3ILfwAXekLTUaNL1h6LprObuA=; b=OP1WUKbHleocybRoCkDWo91X0M
	f8ML4zj/dVo2wSIdRthtf2l9i6/SCo4N9Bw8iBIbQx/TUJpxwewM7KzPUhnS7c/8LQjdIrnZRFk0+
	chhRlEXNzF6DoF+blFofbt+eDPDca563DFfPBDMBLeZrHcfjqm/Fo4AviFTjMtHKQLaUrk1zLno3E
	sn0tP8HFpMObuGPdybcOKy+7F1wkAFXhZqfpg6S85veFjQibCFG3lLU271SEFIBK9etu3S9SKMNrC
	IMcC/+zvkd4MW7z1jYCrgtTpvkDXETz9dnwBdCdLrt36qsK3rtW7V8b4Zbio6rOkWFFAFgGhprpmE
	m45RC0qg==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <emfox@debian.org>)
	id 1xTYHT-00152C-1Y;
	Wed, 18 Nov 2026 05:32:28 +0000
From: Emfox Zhou <emfox@debian.org>
To: Even Xu <even.xu@intel.com>,
	Xinpeng Sun <xinpeng.sun@intel.com>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 5/5] HID: intel-thc-hid: intel-thc: budget the engine drain
Date: Wed, 18 Nov 2026 13:31:32 +0800
Message-ID: <20261118053132.253448-6-emfox@debian.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261118053132.253448-1-emfox@debian.org>
References: <20261118053132.253448-1-emfox@debian.org>
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

thc_wait_for_dma_pause() gives every engine 10 ms to report idle, but a
receive engine can be draining a whole frame. Its buffer comes from the
HIDSPI device descriptor's max_input_len, rounded up to 4 KB and capped at
16 PRD entries, so up to 64 KB; at the 2.23 MHz gear that takes about
235 ms, and a timed out pause makes thc_rxdma_reset() return before the
engines are reconfigured, leaving the controller quiesced with the
interrupts off.

Let the callers pass the budget. thc_rxdma_reset() gets one that covers a
full frame at the slowest gear. The SWDMA path keeps the old one: it
pauses the receive engines with the bus lock held and the interrupts
quiesced, and its frames are small.

thc_dma_unconfigure() needs the same budget from the other side: it stops
all four engines but returns before they report idle, and the caller
releases the tables right after. Wait for them there too, or an engine
still writing reaches pages that are already back in the allocator.

Fixes: 1d46b8d40655 ("HID: Intel-thc-hid: Intel-thc: Add API to reset read DMA")
Signed-off-by: Emfox Zhou <emfox@debian.org>
---
 .../intel-thc-hid/intel-thc/intel-thc-dma.c   | 72 ++++++++++++++-----
 .../intel-thc-hid/intel-thc/intel-thc-dma.h   |  6 ++
 2 files changed, 61 insertions(+), 17 deletions(-)

diff --git a/drivers/hid/intel-thc-hid/intel-thc/intel-thc-dma.c b/drivers/hid/intel-thc-hid/intel-thc/intel-thc-dma.c
index 41efdfaf0..d182f3c42 100644
--- a/drivers/hid/intel-thc-hid/intel-thc/intel-thc-dma.c
+++ b/drivers/hid/intel-thc-hid/intel-thc/intel-thc-dma.c
@@ -514,6 +514,10 @@ int thc_dma_configure(struct thc_device *dev)
 }
 EXPORT_SYMBOL_NS_GPL(thc_dma_configure, "INTEL_THC");
 
+static int thc_wait_for_dma_pause(struct thc_device *dev,
+				  enum thc_dma_channel channel,
+				  u32 timeout_us);
+
 /**
  * thc_dma_unconfigure - Unconfigure DMA settings for all DMA engines
  *
@@ -525,9 +529,14 @@ void thc_dma_unconfigure(struct thc_device *dev)
 
 	/*
 	 * Stop the engines first: one that is running keeps writing through
-	 * a table whose base is already gone.
+	 * a table whose base is already gone. The start bit is only a
+	 * request, so let each engine drain the frame it has in flight
+	 * before the table it writes into goes away.
 	 */
 	thc_clear_start_bits(dev);
+	for (chan = 0; chan < MAX_THC_DMA_CHANNEL; chan++)
+		thc_wait_for_dma_pause(dev, (enum thc_dma_channel)chan,
+				       THC_DMA_DRAIN_US_TIMEOUT);
 
 	for (chan = 0; chan < MAX_THC_DMA_CHANNEL; chan++) {
 		dma_set_prd_base_addr(dev, 0, &dev->dma_ctx->dma_config[chan]);
@@ -536,25 +545,48 @@ void thc_dma_unconfigure(struct thc_device *dev)
 }
 EXPORT_SYMBOL_NS_GPL(thc_dma_unconfigure, "INTEL_THC");
 
-static int thc_wait_for_dma_pause(struct thc_device *dev, enum thc_dma_channel channel)
+static int thc_wait_for_dma_pause(struct thc_device *dev,
+				  enum thc_dma_channel channel,
+				  u32 timeout_us)
 {
-	u32 ctrl_reg, sts_reg, sts;
+	u32 ctrl_reg, ctrl_bit, sts_reg, sts_bit, sts;
 	int ret;
 
-	ctrl_reg = (channel == THC_RXDMA1) ? THC_M_PRT_READ_DMA_CNTRL_1_OFFSET :
-			((channel == THC_RXDMA2) ? THC_M_PRT_READ_DMA_CNTRL_2_OFFSET :
-						   THC_M_PRT_READ_DMA_CNTRL_SW_OFFSET);
-
-	regmap_write_bits(dev->thc_regmap, ctrl_reg, THC_M_PRT_READ_DMA_CNTRL_START, 0);
+	switch (channel) {
+	case THC_RXDMA1:
+		ctrl_reg = THC_M_PRT_READ_DMA_CNTRL_1_OFFSET;
+		sts_reg = THC_M_PRT_READ_DMA_INT_STS_1_OFFSET;
+		ctrl_bit = THC_M_PRT_READ_DMA_CNTRL_START;
+		sts_bit = THC_M_PRT_READ_DMA_INT_STS_ACTIVE;
+		break;
+	case THC_RXDMA2:
+		ctrl_reg = THC_M_PRT_READ_DMA_CNTRL_2_OFFSET;
+		sts_reg = THC_M_PRT_READ_DMA_INT_STS_2_OFFSET;
+		ctrl_bit = THC_M_PRT_READ_DMA_CNTRL_START;
+		sts_bit = THC_M_PRT_READ_DMA_INT_STS_ACTIVE;
+		break;
+	case THC_SWDMA:
+		ctrl_reg = THC_M_PRT_READ_DMA_CNTRL_SW_OFFSET;
+		sts_reg = THC_M_PRT_READ_DMA_INT_STS_SW_OFFSET;
+		ctrl_bit = THC_M_PRT_READ_DMA_CNTRL_START;
+		sts_bit = THC_M_PRT_READ_DMA_INT_STS_ACTIVE;
+		break;
+	case THC_TXDMA:
+		ctrl_reg = THC_M_PRT_WRITE_DMA_CNTRL_OFFSET;
+		sts_reg = THC_M_PRT_WRITE_INT_STS_OFFSET;
+		ctrl_bit = THC_M_PRT_WRITE_DMA_CNTRL_THC_WRDMA_START;
+		sts_bit = THC_M_PRT_WRITE_INT_STS_THC_WRDMA_ACTIVE;
+		break;
+	default:
+		return -EINVAL;
+	}
 
-	sts_reg = (channel == THC_RXDMA1) ? THC_M_PRT_READ_DMA_INT_STS_1_OFFSET :
-			((channel == THC_RXDMA2) ? THC_M_PRT_READ_DMA_INT_STS_2_OFFSET :
-						   THC_M_PRT_READ_DMA_INT_STS_SW_OFFSET);
+	regmap_write_bits(dev->thc_regmap, ctrl_reg, ctrl_bit, 0);
 
 	ret = regmap_read_poll_timeout(dev->thc_regmap, sts_reg, sts,
-				       !(sts & THC_M_PRT_READ_DMA_INT_STS_ACTIVE),
+				       !(sts & sts_bit),
 				       THC_DEFAULT_RXDMA_POLLING_US_INTERVAL,
-				       THC_DEFAULT_RXDMA_POLLING_US_TIMEOUT);
+				       timeout_us);
 
 	if (ret) {
 		dev_err_once(dev->dev,
@@ -588,13 +620,15 @@ int thc_rxdma_reset(struct thc_device *dev)
 		goto end;
 	}
 
-	ret = thc_wait_for_dma_pause(dev, THC_RXDMA1);
+	ret = thc_wait_for_dma_pause(dev, THC_RXDMA1,
+				     THC_DMA_DRAIN_US_TIMEOUT);
 	if (ret) {
 		dev_err(dev->dev, "Wait for RxDMA1 pause failed during RxDMA reset\n");
 		goto end;
 	}
 
-	ret = thc_wait_for_dma_pause(dev, THC_RXDMA2);
+	ret = thc_wait_for_dma_pause(dev, THC_RXDMA2,
+				     THC_DMA_DRAIN_US_TIMEOUT);
 	if (ret) {
 		dev_err(dev->dev, "Wait for RxDMA2 pause failed during RxDMA reset\n");
 		goto end;
@@ -769,7 +803,10 @@ static int thc_swdma_read_start(struct thc_device *dev, void *write_buff,
 	if (ret)
 		return ret;
 
-	if (thc_wait_for_dma_pause(dev, THC_RXDMA1) || thc_wait_for_dma_pause(dev, THC_RXDMA2))
+	if (thc_wait_for_dma_pause(dev, THC_RXDMA1,
+				   THC_DEFAULT_RXDMA_POLLING_US_TIMEOUT) ||
+	    thc_wait_for_dma_pause(dev, THC_RXDMA2,
+				   THC_DEFAULT_RXDMA_POLLING_US_TIMEOUT))
 		return -EIO;
 
 	thc_reset_dma_settings(dev);
@@ -834,7 +871,8 @@ static int thc_swdma_read_completion(struct thc_device *dev)
 {
 	int ret;
 
-	ret = thc_wait_for_dma_pause(dev, THC_SWDMA);
+	ret = thc_wait_for_dma_pause(dev, THC_SWDMA,
+				     THC_DEFAULT_RXDMA_POLLING_US_TIMEOUT);
 	if (ret)
 		return ret;
 
diff --git a/drivers/hid/intel-thc-hid/intel-thc/intel-thc-dma.h b/drivers/hid/intel-thc-hid/intel-thc/intel-thc-dma.h
index 715423453..fa4cdc380 100644
--- a/drivers/hid/intel-thc-hid/intel-thc/intel-thc-dma.h
+++ b/drivers/hid/intel-thc-hid/intel-thc/intel-thc-dma.h
@@ -19,6 +19,12 @@
 #define THC_DEFAULT_RXDMA_POLLING_US_INTERVAL 100
 #define THC_DEFAULT_RXDMA_POLLING_US_TIMEOUT  (10 * USEC_PER_MSEC)
 
+/*
+ * A 64 KB frame takes 235 ms at the slowest gear, so 500 ms covers one with
+ * room to spare.
+ */
+#define THC_DMA_DRAIN_US_TIMEOUT  (500 * USEC_PER_MSEC)
+
 /*
  * THC needs 1KB aligned address, dest_addr is 54 bits, not 64,
  * so don't need to send the lower 10-bits of address.
