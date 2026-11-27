Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=82.195.75.108
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795793866;
	b=LiKTkQX9XUY1q2cUoVpXeqareS9j42YgBl3Mvgp8gCVM5XHqzLsOgmIAlwZTSmah/OOj
	 NPXBPnd2Lx5DHhyLXzt/lQcex+G7gPAh08fwVm8a3pJoXTuUc/1sHFDJ6VIfHF5RPr+rb
	 AVIU3BS2IFuFWdIw5uYaWBbcMIyddE/xWl4lFp7D8f/QLBexTP5XANkYBb4qDUUrzJoZw
	 ukHwAnSViKVKwQbHu48ZE4rmdCZlhgz05dr2Kc4mJQVnoFLhCegPjwRU+WiF1eIxxFkmu
	 KiUZzptimGC+OZXtEQcIwIVV6C8UV8FIumXlHDOaG3nf2eJkkZ9WkAtelSy7l4D8pBA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795793866;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-Debian-User;
	bh=40IfIjt+cs8vbIRYBoOFGDCwQVGdCC0bIu3Fu+/Kwts=;
	b=4ns55ey9NbcCd5MQqx8PWaBQAlPhwrMKIQ0nC+QiNqIj0ovuVzU9PF+tNNOG3JP/Ms8I
	 Yk/NhwD9maw6DM5oN9SM4rJDgYfnBqIQp6Ba4HyZ9PsoLBihz9wyLXf/Y1vRNYZK/Nv9A
	 oG4R05QduL3l9amFUMIcuBlGh8wCp9H3vBPtXd4zwd18JpfhZ2Px2+vX2MKOH07vQftHa
	 z1IOjcITNaxIsdL7WP3bEUFx1sWR4d4yMr8En1XV+CE4k0NtkUrrmGZAcoR0p7Qgj8r8t
	 OAtiSfDq+2a4unJ0oX+ls5qJYH4wNfgZPh8Rx1xxjBPEcJIrREY3itL6zRhlurDirug==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=debian.org;
	spf=pass smtp.mailfrom=debian.org;
	dkim=pass header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=ebNdc76v;
	arc=none smtp.remote-ip=82.195.75.108
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8F10606A31C;
	Fri, 27 Nov 2026 15:37:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C8F10606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=ebNdc76v
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Content-Transfer-Encoding:MIME-Version
	:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=40IfIjt+cs8vbIRYBoOFGDCwQVGdCC0bIu3Fu+/Kwts=; b=ebNdc76v+F9HTGaSBMP4M4tAx/
	AS7gSp2gT+iqehbJtPCpSc5CL2L7unlh44NChaDLCdRl4MqMni8Bx2OOj1Zl8T+j7yb6OyJJgmsJN
	j8rCz7Y4jzhUmjpZH+eb97IZRGXzcg4r58ZI2KShSVaGft9qgHwKJLDthu2aa7PyblaHGL9HgrgDl
	TcWB2UuNND5lgRp5L4cAfQuY+CGfTGEZj17vRcghTXzSdHJRrka7z0n9cP2A3MP6lsAe5S4qyLqSX
	ytoouLjAbm3gl+uTyt03x5F5hxPcasJtt3uh3FCjyTEej9Nj8uZwjqcw8aogbXgn9Bh2nmFgtiNdr
	woO8IfbA==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <emfox@debian.org>)
	id 1xWy14-008RNP-2G;
	Fri, 27 Nov 2026 15:37:39 +0000
From: Emfox Zhou <emfox@debian.org>
To: Even Xu <even.xu@intel.com>,
	Xinpeng Sun <xinpeng.sun@intel.com>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v8] HID: intel-thc-hid: intel-thc: restore PRD table capacity
Date: Fri, 27 Nov 2026 23:37:32 +0800
Message-ID: <20261127234500.424242-1-emfox@debian.org>
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

Nothing is read while an engine is stopped: thc_dma_read() returns with
*read_len cleared before it touches the buffer, and thc_copy_sgls_to_prd()
returns early for a channel whose tables are gone.

Fixes: a688404b2e20 ("HID: intel-thc-hid: intel-thc: Add THC DMA interfaces")
Signed-off-by: Emfox Zhou <emfox@debian.org>
---

Changes in v8:
 - Dropped the duplicated *read_len = 0 in thc_dma_read().
 - Dropped 2/2 ("quickspi, quicki2c: skip an empty read"): Even Xu's
   safe DMA read series covers the read path, and a stopped engine now
   returns before the buffer is touched. A caller that ignores the
   returned length sees the last frame, which is what those guards
   covered.
 - Rebased onto the DMA lifetime fixes series, applied first:

     [PATCH v3 0/5] HID: intel-thc-hid: intel-thc: DMA lifetime fixes
     https://lore.kernel.org/linux-input/cover.1795791500.git.emfox@debian.org/

Link to v7: https://lore.kernel.org/r/20261117105427.319242-1-emfox@debian.org/

 .../intel-thc-hid/intel-thc/intel-thc-dma.c   | 84 ++++++++++++++++++-
 .../intel-thc-hid/intel-thc/intel-thc-dma.h   |  8 ++
 2 files changed, 89 insertions(+), 3 deletions(-)

diff --git a/drivers/hid/intel-thc-hid/intel-thc/intel-thc-dma.c b/drivers/hid/intel-thc-hid/intel-thc/intel-thc-dma.c
index 01b96c00d..8bff8d5b3 100644
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
 
 static void thc_clear_start_bits(struct thc_device *dev)
@@ -223,12 +244,27 @@ static void thc_copy_sgls_to_prd(struct thc_device *dev,
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
@@ -278,6 +314,15 @@ static int setup_dma_buffers(struct thc_device *dev,
 
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
 	thc_clear_start_bits(dev);
 
@@ -332,6 +377,7 @@ struct thc_dma_context *thc_dma_init(struct thc_device *dev)
 		return NULL;
 
 	dev->dma_ctx = dma_ctx;
+	mutex_init(&dma_ctx->prd_lock);
 
 	dma_ctx->dma_config[THC_RXDMA1].dma_channel = THC_RXDMA1;
 	dma_ctx->dma_config[THC_RXDMA2].dma_channel = THC_RXDMA2;
@@ -445,6 +491,8 @@ void thc_dma_release(struct thc_device *dev)
 {
 	int chan;
 
+	guard(mutex)(&dev->dma_ctx->prd_lock);
+
 	for (chan = 0; chan < MAX_THC_DMA_CHANNEL; chan++)
 		release_dma_buffers(dev, &dev->dma_ctx->dma_config[chan]);
 }
@@ -488,13 +536,15 @@ int thc_dma_configure(struct thc_device *dev)
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
@@ -523,6 +573,8 @@ void thc_dma_unconfigure(struct thc_device *dev)
 {
 	int chan;
 
+	guard(mutex)(&dev->dma_ctx->prd_lock);
+
 	/*
 	 * Stop the engines first: one that is running keeps writing through
 	 * a table whose base is already gone.
@@ -530,6 +582,7 @@ void thc_dma_unconfigure(struct thc_device *dev)
 	thc_clear_start_bits(dev);
 
 	for (chan = 0; chan < MAX_THC_DMA_CHANNEL; chan++) {
+		WRITE_ONCE(dev->dma_ctx->dma_config[chan].is_started, false);
 		dma_set_prd_base_addr(dev, 0, &dev->dma_ctx->dma_config[chan]);
 		dma_clear_prd_control(dev, &dev->dma_ctx->dma_config[chan]);
 	}
@@ -547,7 +600,13 @@ static int thc_wait_for_dma_pause(struct thc_device *dev,
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
@@ -703,6 +762,18 @@ static int thc_dma_read(struct thc_device *dev,
 
 	*read_len = 0;
 
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
 
@@ -814,11 +885,16 @@ static int thc_swdma_read_start(struct thc_device *dev, void *write_buff,
 	if (thc_wait_for_dma_pause(dev, THC_RXDMA1,
 				   THC_DEFAULT_RXDMA_POLLING_US_TIMEOUT) ||
 	    thc_wait_for_dma_pause(dev, THC_RXDMA2,
+				   THC_DEFAULT_RXDMA_POLLING_US_TIMEOUT) ||
+	    thc_wait_for_dma_pause(dev, THC_SWDMA,
 				   THC_DEFAULT_RXDMA_POLLING_US_TIMEOUT))
 		return -EIO;
 
 	thc_reset_dma_settings(dev);
 
+	/* A transfer that timed out left its frame length in the entry. */
+	thc_copy_sgls_to_prd(dev, &dev->dma_ctx->dma_config[THC_SWDMA]);
+
 	/*
 	 * Max input size control feature is only available for RxDMA, it must keep disabled
 	 * during SWDMA operation, and restore to previous state after SWDMA is done.
@@ -904,6 +980,8 @@ static int thc_swdma_read_completion(struct thc_device *dev)
 
 	thc_reset_dma_settings(dev);
 
+	thc_rebuild_rx_prd(dev);
+
 	dma_set_start_bit(dev, &dev->dma_ctx->dma_config[THC_RXDMA2]);
 
 	ret = thc_interrupt_quiesce(dev, false);
diff --git a/drivers/hid/intel-thc-hid/intel-thc/intel-thc-dma.h b/drivers/hid/intel-thc-hid/intel-thc/intel-thc-dma.h
index bdf44583b..ecbe32d8a 100644
--- a/drivers/hid/intel-thc-hid/intel-thc/intel-thc-dma.h
+++ b/drivers/hid/intel-thc-hid/intel-thc/intel-thc-dma.h
@@ -6,6 +6,7 @@
 
 #include <linux/bits.h>
 #include <linux/dma-mapping.h>
+#include <linux/mutex.h>
 #include <linux/sizes.h>
 #include <linux/time64.h>
 #include <linux/types.h>
@@ -94,6 +95,7 @@ struct thc_prd_table {
  * @dma_channel: DMA channel for current DMA configuration
  * @prd_tbls_dma_handle: DMA buffer handle
  * @dir: Direction of DMA for this config
+ * @is_started: The engine is running, so the ring may be read
  * @prd_tbls: PRD tables for current DMA
  * @sgls: Array of pointers to scatter-gather lists
  * @sgls_nent_pages: Number of pages per scatter-gather list
@@ -110,6 +112,7 @@ struct thc_dma_configuration {
 	dma_addr_t prd_tbls_dma_handle;
 	enum dma_data_direction dir;
 	bool is_enabled;
+	bool is_started;
 
 	struct thc_prd_table *prd_tbls;
 	struct scatterlist *sgls[PRD_TABLES_NUM];
@@ -128,6 +131,8 @@ struct thc_dma_configuration {
  * struct thc_dma_context - THC DMA context
  * @thc_dma_configuration: Array of all THC Channel configures
  * @use_write_interrupts: Indicate TxDMA using interrupt or polling
+ * @prd_lock: Keeps the DMA read path off the tables while they are
+ *            rebuilt, armed, stopped or released
  * @rx_max_size_en: Temp flag to indicate THC I2C Rx max input size control feature
  *                  enabled or not, only be used during SWDMA operation.
  * @rx_int_delay_en: Temp flag to indicate THC I2C Rx interrupt delay feature
@@ -137,6 +142,9 @@ struct thc_dma_context {
 	struct thc_dma_configuration dma_config[MAX_THC_DMA_CHANNEL];
 	u8 use_write_interrupts;
 
+	/* Taken inside the bus lock, never the other way round. */
+	struct mutex prd_lock;
+
 	bool rx_max_size_en;
 	bool rx_int_delay_en;
 };

base-commit: 4f048c56c2697000105a75c28b918ae76f11fcef
prerequisite-patch-id: 1921888f4500ace81255e73142f40b89e4a75fd2
prerequisite-patch-id: e87bd84cb62f9d122e80b0636ec02103ee4eef96
prerequisite-patch-id: 682e6eeea6eb7792c7b2f00b14226cb9a3d1c56c
prerequisite-patch-id: efd51e0ca2778c5028ba030ddfaee6da5a82622d
prerequisite-patch-id: 1fa0e32622986734adb7ce7040400f169bc26f2b
