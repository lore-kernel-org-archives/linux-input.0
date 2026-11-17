Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=82.195.75.108
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794907948;
	b=3z7yYjns++Ke9d620sSwYqu1XSY5/ZXm2cG7Qjd14mH4JpdsseS2dxKm6l6dFbNUlFOB
	 kw6hVAQS1iLo7GBjNHJEqG7unw+3Km/BNFdN0hpxHL6llqMt1A3LUVgekES/+LmVQrmiI
	 QLmI836wIvKx4H3fE4rnPYCPQ28Ca333zObOxcQQGglbiBZJNlIhcNL2J3PtkHGuosWJ0
	 v+CKZwIjeavfXnDgRWkM6p1+LaCQclawHrT0lacojsMlh5H98KN8bcTeLroEHDQTqmHUa
	 GSOsmKRryPK5IYUXarVeEiOwPZrBe2u+MZaAUNSMsu7nlfx81zuwQQlODCZ69V9bsUg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794907948;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-Debian-User;
	bh=8bkD69yTwnKx7DlArY2inwp1NwExUGNQNDtsHAkilWU=;
	b=hfJxr6QQZjZWDScbbsWcWi8oKaxqQ7a1Ubj0njnk3j7KkJ74bn4dvCyIxNlYq7i3OsCw
	 dgtUjJfIqWD5thtQuxlKPxQ9hrGnluyN0icUzEcpLyIrz3bHgQbtQKhskNJq5RjFN0j9G
	 AfnL3GJFrKTnsSg5NzKrdtEYloaATGgWiMWiy1Y2U2HwSTyUQF3cwmEs4hsYLJ3hn093z
	 B5shs295ypAK54WoNoMuk6ljoyVxO+SmlD0JNhkUGmQRFn/Uck6fSO24eWNFBHG+Dqa3C
	 +yUz24PdcDYuEOEARVeObEi2TdVAoQjdHSk9OZ3ua249M8+GYhincK2blEDMtfpJObg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=debian.org;
	spf=pass smtp.mailfrom=debian.org;
	dkim=pass header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=fcZQ1CLs;
	arc=none smtp.remote-ip=82.195.75.108
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E26E3606A31C;
	Tue, 17 Nov 2026 09:32:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E26E3606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=fcZQ1CLs
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Content-Transfer-Encoding:MIME-Version
	:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=8bkD69yTwnKx7DlArY2inwp1NwExUGNQNDtsHAkilWU=; b=fcZQ1CLsid25gwysOYc1Smy1zu
	PUXhotkiedfENGpt2GjqQeDAPCyAv4WuT4Es8qgjBmQzDz+0zDWhhKdQy1UyvU90Vo+kRZ7m6JN8e
	l6Mz/uHwgK+888MZhIhg9FSloxts++PhOS3tVkDehmOyX7yk2tWxPDb7X5xNIRfvNoFf9Kb8NCwC+
	kXmUkyvZoafAHA6PkDt37zV1+TL8jeroWRpss5AA8l/aGLsAIRyMZ9+r359q3+w2UOiCMJ6Dz5e+A
	dMb0AE1PdKZkQbCitVyjrQ+4E3dmNQOpYTTvUiGdJJvyMCuxuOv7Yblqo/9bd4OsKAzahOSlVlyW1
	zzAm2Q1A==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <emfox@debian.org>)
	id 1xTFY3-000R3Y-1y;
	Tue, 17 Nov 2026 09:32:20 +0000
From: Emfox Zhou <emfox@debian.org>
To: Even Xu <even.xu@intel.com>,
	Xinpeng Sun <xinpeng.sun@intel.com>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5] HID: intel-thc-hid: intel-thc: restore PRD table capacity
Date: Tue, 17 Nov 2026 17:32:12 +0800
Message-ID: <20261117093212.4122283-1-emfox@debian.org>
X-Mailer: git-send-email 2.55.0
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
controller reports a buffer overrun. That is a transfer error and leads
back into the same reset, with the table still short.

Rebuild a table before the engine that reads it is started: for probe,
resume and the RxDMA reset, for the SWDMA start once that engine reports
idle (a timed-out transfer leaves it running), and for the receive tables
where an SWDMA round trip restarts the receive engine.

A drain in the threaded handler reads a table without the bus lock, so a
rebuild can land in the middle of it. The tables get a mutex taken by the
rebuild, by that drain and by the arming, inside the bus lock where the
caller holds it; no path takes the two in the other order.

The rewind leaves the read pointer at the start and the write pointer
where the last frame left it, so the ring reads as non-empty while the
engine is stopped and a drain would take an entry that was never written.
Record whether an engine runs, and read the ring only while it is set: the
flag is published under that same lock, after the control register is read
back, so a drain sees either a stopped engine or an armed one.

thc_dma_read() leaves *read_len untouched when it takes nothing, which its
callers do not expect, and thc_copy_sgls_to_prd() returns early for a
channel whose tables are gone.

Fixes: a688404b2e20 ("HID: intel-thc-hid: intel-thc: Add THC DMA interfaces")
Signed-off-by: Emfox Zhou <emfox@debian.org>
---
Changes in v5:
  - A read of the ring is refused while its engine is stopped: the rewind
    moves the read pointer back but leaves the write pointer where the
    last frame left it, so a drain arriving before the restart would take
    an entry that was never written. The flag covers every channel that
    reads the ring, SWDMA included, and is published under the read lock
    after the arming, with the control register read back first.
  - thc_dma_read() clears *read_len when it reads nothing.

Changes in v4:
  - The tables are rebuilt under a mutex that the receive path takes as
    well: the threaded handler drains the ring outside the bus lock, so a
    rebuild could land in the middle of a read.
  - The SWDMA table is rebuilt after its engine is waited for, and the
    receive tables are rebuilt where an SWDMA round trip restarts the
    receive engine.

Link: https://lore.kernel.org/r/20261117003247.940876-1-emfox@debian.org
---
 .../intel-thc-hid/intel-thc/intel-thc-dma.c   | 75 ++++++++++++++++++-
 .../intel-thc-hid/intel-thc/intel-thc-dma.h   |  7 ++
 2 files changed, 81 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/intel-thc-hid/intel-thc/intel-thc-dma.c b/drivers/hid/intel-thc-hid/intel-thc/intel-thc-dma.c
index c80ef8c20..e315989a4 100644
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
@@ -266,6 +302,14 @@ static int setup_dma_buffers(struct thc_device *dev,
 
 static void thc_reset_dma_settings(struct thc_device *dev)
 {
+	struct thc_dma_context *dma_ctx = dev->dma_ctx;
+	int chan;
+
+	/* The rewind below discards the queue, so no read may start. */
+	if (dma_ctx)
+		for (chan = 0; chan < MAX_THC_DMA_CHANNEL; chan++)
+			WRITE_ONCE(dma_ctx->dma_config[chan].is_started, false);
+
 	/* Stop all DMA channels and reset DMA read pointers */
 	regmap_write_bits(dev->thc_regmap, THC_M_PRT_READ_DMA_CNTRL_1_OFFSET,
 			  THC_M_PRT_READ_DMA_CNTRL_START, 0);
@@ -327,6 +371,7 @@ struct thc_dma_context *thc_dma_init(struct thc_device *dev)
 		return NULL;
 
 	dev->dma_ctx = dma_ctx;
+	mutex_init(&dma_ctx->prd_lock);
 
 	dma_ctx->dma_config[THC_RXDMA1].dma_channel = THC_RXDMA1;
 	dma_ctx->dma_config[THC_RXDMA2].dma_channel = THC_RXDMA2;
@@ -491,6 +536,9 @@ int thc_dma_configure(struct thc_device *dev)
 		return -EINVAL;
 	}
 
+	/* An entry may still be short from a frame nobody read. */
+	thc_rebuild_rx_prd(dev);
+
 	for (chan = 0; chan < MAX_THC_DMA_CHANNEL; chan++) {
 		dma_set_prd_base_addr(dev,
 				      dma_ctx->dma_config[chan].prd_tbls_dma_handle,
@@ -520,6 +568,7 @@ void thc_dma_unconfigure(struct thc_device *dev)
 	int chan;
 
 	for (chan = 0; chan < MAX_THC_DMA_CHANNEL; chan++) {
+		WRITE_ONCE(dev->dma_ctx->dma_config[chan].is_started, false);
 		dma_set_prd_base_addr(dev, 0, &dev->dma_ctx->dma_config[chan]);
 		dma_clear_prd_control(dev, &dev->dma_ctx->dma_config[chan]);
 	}
@@ -541,6 +590,7 @@ static int thc_wait_for_dma_pause(struct thc_device *dev, enum thc_dma_channel c
 			((channel == THC_RXDMA2) ? THC_M_PRT_READ_DMA_CNTRL_2_OFFSET :
 						   THC_M_PRT_READ_DMA_CNTRL_SW_OFFSET);
 
+	WRITE_ONCE(dev->dma_ctx->dma_config[channel].is_started, false);
 	regmap_write_bits(dev->thc_regmap, ctrl_reg, THC_M_PRT_READ_DMA_CNTRL_START, 0);
 
 	sts_reg = (channel == THC_RXDMA1) ? THC_M_PRT_READ_DMA_INT_STS_1_OFFSET :
@@ -685,6 +735,21 @@ static int thc_dma_read(struct thc_device *dev,
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
 
@@ -765,11 +830,16 @@ static int thc_swdma_read_start(struct thc_device *dev, void *write_buff,
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
@@ -854,6 +924,9 @@ static int thc_swdma_read_completion(struct thc_device *dev)
 
 	thc_reset_dma_settings(dev);
 
+	/* The receive engine starts again just below. */
+	thc_rebuild_rx_prd(dev);
+
 	dma_set_start_bit(dev, &dev->dma_ctx->dma_config[THC_RXDMA2]);
 
 	ret = thc_interrupt_quiesce(dev, false);
diff --git a/drivers/hid/intel-thc-hid/intel-thc/intel-thc-dma.h b/drivers/hid/intel-thc-hid/intel-thc/intel-thc-dma.h
index 715423453..16972d073 100644
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
@@ -123,6 +126,7 @@ struct thc_dma_configuration {
  * struct thc_dma_context - THC DMA context
  * @thc_dma_configuration: Array of all THC Channel configures
  * @use_write_interrupts: Indicate TxDMA using interrupt or polling
+ * @prd_lock: Serialises a table rebuild with the DMA read path
  * @rx_max_size_en: Temp flag to indicate THC I2C Rx max input size control feature
  *                  enabled or not, only be used during SWDMA operation.
  * @rx_int_delay_en: Temp flag to indicate THC I2C Rx interrupt delay feature
@@ -132,6 +136,9 @@ struct thc_dma_context {
 	struct thc_dma_configuration dma_config[MAX_THC_DMA_CHANNEL];
 	u8 use_write_interrupts;
 
+	/* Taken inside the bus lock, never the other way round. */
+	struct mutex prd_lock;
+
 	bool rx_max_size_en;
 	bool rx_int_delay_en;
 };

base-commit: aebb7274476403040d582c61478df8f4a7bf9cd3
