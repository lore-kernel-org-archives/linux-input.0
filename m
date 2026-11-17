Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=82.195.75.108
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794911263;
	b=Hh2+HsCWifXTreD/l+estaXjzDBwsLK7RyVsoQ1yfTN+P/PQ+WdaXwXlKP2ChFVcqnlg
	 bgYHB89k5QgiQ1IsrAetC4r8Jxw3tIXM5ESGEA+2xBXHJv/hVIo/zNBKUjj/P34ZpUMvz
	 PGBNFmmaDigz7r2mL0RJIXaLN8d//8NrDJeSiuEALC4CzN4EMyldLZUb2ia2wzvCpkPsK
	 g8ZiTcrD5LoVWThFe+17un7VR3yJUaZt5rsQiDrgXs981oSByJ/8MCMJpWoH/gvIEPCEg
	 0LZGqGxAoy+NiKfZq5Is7R0UweLeE138/UissCizDF9myBW4SS1z4KMo4DM+uFZ1SfA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794911263;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Debian-User;
	bh=KiST8IO1b4IBzaq9lTqCYVzv03lj0S/hXVkQJW2AS+c=;
	b=04GSSzxzx8mZPFYL6zdTwBIzaYO/FXlHtSrdmkSt3DHdzKRPNjhfZKhTOgB+zCY7pXcM
	 8R3wXt/s+/TrAL1mlkVwNSFAs0d/xZkOQK5z11g2unCrzzF91ey9APQDZKQ049O2ekuUX
	 Z8F+iEq/6mC6nGyAeGNSaT3Z9lEtWz+bZHczWbv9TBlscrvQLtdZ3F/OwUWfwoNi8LEl1
	 wlOlCyZsxKziVNPP7JhYv6tsNKoA9aYK0YW5/Ct9Huctbo0AA0Wd2/6ouTTxZUi8HpTEL
	 d9Yo9UX9k8kYMlvWyEhpDmtERzvCKgmME7lvugpDglvukri8GMkrQhbuXNHLusn1sAw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=debian.org;
	spf=pass smtp.mailfrom=debian.org;
	dkim=pass header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=Pad39Uhr;
	arc=none smtp.remote-ip=82.195.75.108
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC011606A895;
	Tue, 17 Nov 2026 10:27:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CC011606A895
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=Pad39Uhr
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=KiST8IO1b4IBzaq9lTqCYVzv03lj0S/hXVkQJW2AS+c=; b=Pad39UhrIgJZtw3u92WnmHxA1N
	Z4Sw4bCmUJOHPxMCGGf6/Mgh7+hU0aZmHAHfyLWqnuwE7XtvrZdeOTtEFqYSrzW9EsAVI/dizdL+a
	YhNSwPwiOa74EvLI4XTlJm3FYXujIKyPkiGDqeD24lyKc5MlSPvnmnm9KaB+Qj6GpswYISippLOOK
	IHr+aJ/EtneEgroT/C5xnC1oMNAX9pN7TNowrZjiPVOBgyNq4iM1LdA9WgMfLp/fecF//3Y/VIDUs
	bpnvYwMA9q6as1m6L2k7r5Ninu+KdUpYNyRIroL0VZcjnNUSDsrbg4unGnCgTtRH70crWPaCNC8fB
	SPzNyk5g==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <emfox@debian.org>)
	id 1xTGPZ-000T3z-2d;
	Tue, 17 Nov 2026 10:27:38 +0000
From: Emfox Zhou <emfox@debian.org>
To: Even Xu <even.xu@intel.com>,
	Xinpeng Sun <xinpeng.sun@intel.com>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v6 1/2] HID: intel-thc-hid: intel-thc: restore PRD table capacity
Date: Tue, 17 Nov 2026 18:27:25 +0800
Message-ID: <20261117102726.271503-2-emfox@debian.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261117102726.271503-1-emfox@debian.org>
References: <20261117102726.271503-1-emfox@debian.org>
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

The controller writes the frame length into the PRD entry it filled and
marks the end of the frame there; only a read puts the capacity back.
thc_reset_dma_settings() rewinds the read pointers but not those lengths,
and stops the engines: a frame still queued when it runs is dropped, the
next frame that does not fit runs past the end of its entry, and the
controller reports a buffer overrun, a transfer error that leads back
into the same reset with the table still short.

Rebuild a table before the engine that reads it is started: on probe,
resume and the RxDMA reset, on the SWDMA start once that engine is idle,
and where an SWDMA round trip restarts the receive engine.

A drain in the threaded handler reads a table without the bus lock. The
rebuild, the arming, and every path that stops an engine or moves its
pointers run without that lock as well, so a drain can land in the middle
of any of them and read an entry of a ring that was already rewound. Give
the tables a mutex taken by all of them, inside the bus lock where the
caller holds it; no path takes the two in the other order.

The rewind leaves the read pointer at the start and the write pointer
where the last frame left it, so the ring reads as non-empty while the
engine is stopped and a drain would take an entry that was never written.
Record whether an engine runs, and read the ring only while it is set: the
flag is published under that same lock, after the control register is read
back, so a drain sees either a stopped engine or an armed one.

thc_dma_read() clears *read_len when it takes nothing, because callers
read that even when the read succeeds, and thc_copy_sgls_to_prd() returns
early for a channel whose tables are gone.

Fixes: a688404b2e20 ("HID: intel-thc-hid: intel-thc: Add THC DMA interfaces")
Signed-off-by: Emfox Zhou <emfox@debian.org>
---
 .../intel-thc-hid/intel-thc/intel-thc-dma.c   | 89 ++++++++++++++++++-
 .../intel-thc-hid/intel-thc/intel-thc-dma.h   |  8 ++
 2 files changed, 93 insertions(+), 4 deletions(-)

diff --git a/drivers/hid/intel-thc-hid/intel-thc/intel-thc-dma.c b/drivers/hid/intel-thc-hid/intel-thc/intel-thc-dma.c
index c80ef8c20..944db6150 100644
--- a/drivers/hid/intel-thc-hid/intel-thc/intel-thc-dma.c
+++ b/drivers/hid/intel-thc-hid/intel-thc/intel-thc-dma.c
@@ -30,10 +30,20 @@ static void dma_set_start_bit(struct thc_device *dev,
 			      struct thc_dma_configuration *dma_config)
 {
 	u32 ctrl, mask, mbits, data, offset;
+	bool reads_ring;
 
 	if (!dma_config->is_enabled)
 		return;
 
+	/*
+	 * Arm and publish under the lock the read path takes: a ring that was
+	 * just rewound still reads as non-empty, so a reader in between would
+	 * copy an entry the engine never wrote. TxDMA reads no ring.
+	 */
+	reads_ring = dma_config->dma_channel != THC_TXDMA;
+	if (reads_ring)
+		mutex_lock(&dev->dma_ctx->prd_lock);
+
 	switch (dma_config->dma_channel) {
 	case THC_RXDMA1:
 	case THC_RXDMA2:
@@ -92,6 +102,17 @@ static void dma_set_start_bit(struct thc_device *dev,
 	default:
 		break;
 	}
+
+	if (reads_ring) {
+		/*
+		 * The mutex orders the flag, not the write to the device:
+		 * read the register back so the arming lands first.
+		 */
+		regmap_read(dev->thc_regmap, dma_config->dma_cntrl, &ctrl);
+
+		WRITE_ONCE(dma_config->is_started, true);
+		mutex_unlock(&dev->dma_ctx->prd_lock);
+	}
 }
 
 static void dma_set_prd_control(struct thc_device *dev, u8 entry_count, u8 cb_depth,
@@ -211,12 +232,27 @@ static void thc_copy_sgls_to_prd(struct thc_device *dev,
 {
 	unsigned int i;
 
+	guard(mutex)(&dev->dma_ctx->prd_lock);
+
+	if (!config->is_enabled || !config->prd_tbls)
+		return;
+
 	memset(config->prd_tbls, 0, array_size(PRD_TABLE_SIZE, config->prd_tbl_num));
 
 	for (i = 0; i < config->prd_tbl_num; i++)
 		thc_copy_one_sgl_to_prd(dev, config, i);
 }
 
+/*
+ * A frame that is never read leaves its entry short, and the engine reads
+ * the table again on every start: put the capacity back.
+ */
+static void thc_rebuild_rx_prd(struct thc_device *dev)
+{
+	thc_copy_sgls_to_prd(dev, &dev->dma_ctx->dma_config[THC_RXDMA1]);
+	thc_copy_sgls_to_prd(dev, &dev->dma_ctx->dma_config[THC_RXDMA2]);
+}
+
 static int setup_dma_buffers(struct thc_device *dev,
 			     struct thc_dma_configuration *config,
 			     enum dma_data_direction dir)
@@ -266,6 +302,15 @@ static int setup_dma_buffers(struct thc_device *dev,
 
 static void thc_reset_dma_settings(struct thc_device *dev)
 {
+	struct thc_dma_context *dma_ctx = dev->dma_ctx;
+	int chan;
+
+	guard(mutex)(&dma_ctx->prd_lock);
+
+	/* The rewind below discards the queue, so no read may start. */
+	for (chan = 0; chan < MAX_THC_DMA_CHANNEL; chan++)
+		WRITE_ONCE(dma_ctx->dma_config[chan].is_started, false);
+
 	/* Stop all DMA channels and reset DMA read pointers */
 	regmap_write_bits(dev->thc_regmap, THC_M_PRT_READ_DMA_CNTRL_1_OFFSET,
 			  THC_M_PRT_READ_DMA_CNTRL_START, 0);
@@ -327,6 +372,7 @@ struct thc_dma_context *thc_dma_init(struct thc_device *dev)
 		return NULL;
 
 	dev->dma_ctx = dma_ctx;
+	mutex_init(&dma_ctx->prd_lock);
 
 	dma_ctx->dma_config[THC_RXDMA1].dma_channel = THC_RXDMA1;
 	dma_ctx->dma_config[THC_RXDMA2].dma_channel = THC_RXDMA2;
@@ -441,6 +487,8 @@ void thc_dma_release(struct thc_device *dev)
 {
 	int chan;
 
+	guard(mutex)(&dev->dma_ctx->prd_lock);
+
 	for (chan = 0; chan < MAX_THC_DMA_CHANNEL; chan++)
 		release_dma_buffers(dev, &dev->dma_ctx->dma_config[chan]);
 }
@@ -484,13 +532,15 @@ int thc_dma_configure(struct thc_device *dev)
 	struct thc_dma_context *dma_ctx = dev->dma_ctx;
 	int chan;
 
-	thc_reset_dma_settings(dev);
-
 	if (!dma_ctx) {
 		dev_err_once(dev->dev, "Cannot do DMA configure because DMA context is NULL\n");
 		return -EINVAL;
 	}
 
+	thc_reset_dma_settings(dev);
+
+	thc_rebuild_rx_prd(dev);
+
 	for (chan = 0; chan < MAX_THC_DMA_CHANNEL; chan++) {
 		dma_set_prd_base_addr(dev,
 				      dma_ctx->dma_config[chan].prd_tbls_dma_handle,
@@ -519,7 +569,10 @@ void thc_dma_unconfigure(struct thc_device *dev)
 {
 	int chan;
 
+	guard(mutex)(&dev->dma_ctx->prd_lock);
+
 	for (chan = 0; chan < MAX_THC_DMA_CHANNEL; chan++) {
+		WRITE_ONCE(dev->dma_ctx->dma_config[chan].is_started, false);
 		dma_set_prd_base_addr(dev, 0, &dev->dma_ctx->dma_config[chan]);
 		dma_clear_prd_control(dev, &dev->dma_ctx->dma_config[chan]);
 	}
@@ -541,7 +594,13 @@ static int thc_wait_for_dma_pause(struct thc_device *dev, enum thc_dma_channel c
 			((channel == THC_RXDMA2) ? THC_M_PRT_READ_DMA_CNTRL_2_OFFSET :
 						   THC_M_PRT_READ_DMA_CNTRL_SW_OFFSET);
 
-	regmap_write_bits(dev->thc_regmap, ctrl_reg, THC_M_PRT_READ_DMA_CNTRL_START, 0);
+	{
+		guard(mutex)(&dev->dma_ctx->prd_lock);
+
+		WRITE_ONCE(dev->dma_ctx->dma_config[channel].is_started, false);
+		regmap_write_bits(dev->thc_regmap, ctrl_reg,
+				  THC_M_PRT_READ_DMA_CNTRL_START, 0);
+	}
 
 	sts_reg = (channel == THC_RXDMA1) ? THC_M_PRT_READ_DMA_INT_STS_1_OFFSET :
 			((channel == THC_RXDMA2) ? THC_M_PRT_READ_DMA_INT_STS_2_OFFSET :
@@ -685,6 +744,21 @@ static int thc_dma_read(struct thc_device *dev,
 	u8 read_ptr, write_ptr, prd_table_index;
 	int status;
 
+	/* The caller may look at this when nothing was read. */
+	*read_len = 0;
+
+	guard(mutex)(&dev->dma_ctx->prd_lock);
+
+	/*
+	 * Nothing in the ring is ours until the engine is started: after a
+	 * reset the pointers alone say nothing about what was written.
+	 */
+	if (!READ_ONCE(read_config->is_started)) {
+		if (read_finished)
+			*read_finished = 1;
+		return 0;
+	}
+
 	if (!is_dma_buf_empty(dev, read_config, &read_ptr, &write_ptr)) {
 		prd_table_index = write_ptr & THC_POINTER_MASK;
 
@@ -765,11 +839,16 @@ static int thc_swdma_read_start(struct thc_device *dev, void *write_buff,
 	if (ret)
 		return ret;
 
-	if (thc_wait_for_dma_pause(dev, THC_RXDMA1) || thc_wait_for_dma_pause(dev, THC_RXDMA2))
+	if (thc_wait_for_dma_pause(dev, THC_RXDMA1) ||
+	    thc_wait_for_dma_pause(dev, THC_RXDMA2) ||
+	    thc_wait_for_dma_pause(dev, THC_SWDMA))
 		return -EIO;
 
 	thc_reset_dma_settings(dev);
 
+	/* A transfer that timed out left its frame length in the entry. */
+	thc_copy_sgls_to_prd(dev, &dev->dma_ctx->dma_config[THC_SWDMA]);
+
 	/*
 	 * Max input size control feature is only available for RxDMA, it must keep disabled
 	 * during SWDMA operation, and restore to previous state after SWDMA is done.
@@ -854,6 +933,8 @@ static int thc_swdma_read_completion(struct thc_device *dev)
 
 	thc_reset_dma_settings(dev);
 
+	thc_rebuild_rx_prd(dev);
+
 	dma_set_start_bit(dev, &dev->dma_ctx->dma_config[THC_RXDMA2]);
 
 	ret = thc_interrupt_quiesce(dev, false);
diff --git a/drivers/hid/intel-thc-hid/intel-thc/intel-thc-dma.h b/drivers/hid/intel-thc-hid/intel-thc/intel-thc-dma.h
index 715423453..d05d16ea1 100644
--- a/drivers/hid/intel-thc-hid/intel-thc/intel-thc-dma.h
+++ b/drivers/hid/intel-thc-hid/intel-thc/intel-thc-dma.h
@@ -6,6 +6,7 @@
 
 #include <linux/bits.h>
 #include <linux/dma-mapping.h>
+#include <linux/mutex.h>
 #include <linux/sizes.h>
 #include <linux/time64.h>
 #include <linux/types.h>
@@ -89,6 +90,7 @@ struct thc_prd_table {
  * @dma_channel: DMA channel for current DMA configuration
  * @prd_tbls_dma_handle: DMA buffer handle
  * @dir: Direction of DMA for this config
+ * @is_started: The engine is running, so the ring may be read
  * @prd_tbls: PRD tables for current DMA
  * @sgls: Array of pointers to scatter-gather lists
  * @sgls_nent_pages: Number of pages per scatter-gather list
@@ -105,6 +107,7 @@ struct thc_dma_configuration {
 	dma_addr_t prd_tbls_dma_handle;
 	enum dma_data_direction dir;
 	bool is_enabled;
+	bool is_started;
 
 	struct thc_prd_table *prd_tbls;
 	struct scatterlist *sgls[PRD_TABLES_NUM];
@@ -123,6 +126,8 @@ struct thc_dma_configuration {
  * struct thc_dma_context - THC DMA context
  * @thc_dma_configuration: Array of all THC Channel configures
  * @use_write_interrupts: Indicate TxDMA using interrupt or polling
+ * @prd_lock: Keeps the DMA read path off the tables while they are
+ *            rebuilt, armed, stopped or released
  * @rx_max_size_en: Temp flag to indicate THC I2C Rx max input size control feature
  *                  enabled or not, only be used during SWDMA operation.
  * @rx_int_delay_en: Temp flag to indicate THC I2C Rx interrupt delay feature
@@ -132,6 +137,9 @@ struct thc_dma_context {
 	struct thc_dma_configuration dma_config[MAX_THC_DMA_CHANNEL];
 	u8 use_write_interrupts;
 
+	/* Taken inside the bus lock, never the other way round. */
+	struct mutex prd_lock;
+
 	bool rx_max_size_en;
 	bool rx_int_delay_en;
 };
