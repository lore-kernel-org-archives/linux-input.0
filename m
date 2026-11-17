Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=82.195.75.108
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794875460;
	b=OOnzWcON4qdxFLoGf3tKf/26FFDHKHVxEIlgFMMZFLBRr1MAsP2jjUCMHhwwX+LTYx93
	 BPlQvFvHlec/UTN3mfqxnw92R3he+efcjAh2NKLY85vizlogOpaIDlRkPLXUEySJgMU1o
	 ts6COlr+a+eONS8ZEjg8CTAXg80l6ggRfaNXEE/FbTVsCx4F0b2GPrQjEhYfH6RWF62Xm
	 dXuej4klqR/Xu/d5UeQEPt+Wof3WcbxjCQy6wvK/uPRlT/F1Ob06j8plpzliHR08xQtDB
	 g+XDBI0a4JHkmdEotEuOJyWCUOHvJ/dDb35e8a0O3gOZfs8CIzxWffBzh1U4Ppvcb4w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794875460;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-Debian-User;
	bh=ZJaGE4hmAwAu3ci11rwBq8atZ3mF8O9TjUp2VfkCbf4=;
	b=H2K/gAoohpmdwiffgSh7X9Ot3V1R6Wu+Wm4mqMvoue1cbRRi6HChKQx1M1gahldmrCD1
	 WPQDukBtbGq076xkL/olEIQUdhxH11hrmJW7b0TftGpwCU2JZtq6x51fwSsV6nBKQ4qiL
	 7d6hoRN2ThdhwccdO4vCkOdQkBSN/O1jLc1aoIco432s8hJWtFc20WUC/aj4iNr+e+lMh
	 MZ9p4lF6rLZ1NCKTLBY9GjOF2wB69izDJ1WDbsANdrmlqCDWv3IcYWAXilg/VTeEwrpaD
	 5SclTfFV5efkmED4CWzwqk9ulmAY2MHxTNapa5ECVO1R7sqRoB4Od/MekMlH0AbWmrQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=debian.org;
	spf=pass smtp.mailfrom=debian.org;
	dkim=pass header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=Rug6qZeI;
	arc=none smtp.remote-ip=82.195.75.108
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEE9B606A31C;
	Tue, 17 Nov 2026 00:30:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CEE9B606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=Rug6qZeI
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Content-Transfer-Encoding:MIME-Version
	:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=ZJaGE4hmAwAu3ci11rwBq8atZ3mF8O9TjUp2VfkCbf4=; b=Rug6qZeIX2SF8N2kSW5wWPXpcE
	YM9Kbql2jDN+i6pGt00oG4yorjcWqL2awETcJvu9XXUfon/FntVFe5CURlPG/X2HePo8saH30P/Rn
	OXNUABAzDkfFFQUU1hl4rZO6YHRiRvIpYarw3Hk+ty4qcQ1fqJ8QLzyDTdr2JWP/gpmRNw/wUu6tS
	CqVPE8F01BC71uMLHauTMZDxakhvmN12SOf9nBVxELsMAgRO8GAQOS9r/A9YPY+aG6VxlaSFdgV1K
	UGMozESDyCQY42P7icBvvyA+FRIAGQ7h/dD4gNP4LF9uDJBFQbNYp4wTwpRK//aN+u0aZ1h11jw9W
	xhuVa6Uw==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <emfox@debian.org>)
	id 1xT764-0009Cw-0c;
	Tue, 17 Nov 2026 00:30:53 +0000
From: Emfox Zhou <emfox@debian.org>
To: Even Xu <even.xu@intel.com>,
	Xinpeng Sun <xinpeng.sun@intel.com>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4] HID: intel-thc-hid: intel-thc: restore PRD table capacity
Date: Tue, 17 Nov 2026 08:27:55 +0800
Message-ID: <20261117002755.936097-1-emfox@debian.org>
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
thc_reset_dma_settings() rewinds the read pointers but not those lengths:
a frame still queued when it runs is dropped, and the next frame that does
not fit runs past the end of its entry. The controller reports a buffer
overrun, which is a transfer error and leads back into the same reset,
with the table still short.

Rebuild a table before the engine that reads it is started:
thc_dma_configure() for probe, resume and the RxDMA reset, the SWDMA start
for its own table once that engine reports idle (a transfer that timed out
leaves it running), and the end of an SWDMA round trip for the receive
tables that the same reset rewound.

A drain in the threaded handler reads a table without the bus lock, so a
rebuild can land in the middle of it, and a reset does not rule the
handler out either. Give the tables a mutex taken by both, inside the bus
lock where the caller holds it, and no path takes the two in the other
order.

thc_copy_sgls_to_prd() returns early for a channel whose tables are gone.

Fixes: a688404b2e20 ("HID: intel-thc-hid: intel-thc: Add THC DMA interfaces")
Signed-off-by: Emfox Zhou <emfox@debian.org>
---
Changes in v4:
  - The tables are rebuilt under a mutex that the receive path takes as
    well: the threaded handler drains the ring outside the bus lock, so a
    rebuild could land in the middle of a read.
  - The SWDMA table is rebuilt after its engine is waited for, and the
    receive tables are rebuilt where an SWDMA round trip restarts the
    receive engine.

Link: https://lore.kernel.org/r/20261115040756.602092-1-emfox@debian.org
---
 .../intel-thc-hid/intel-thc/intel-thc-dma.c   | 31 ++++++++++++++++++-
 .../intel-thc-hid/intel-thc/intel-thc-dma.h   |  7 +++++
 2 files changed, 37 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/intel-thc-hid/intel-thc/intel-thc-dma.c b/drivers/hid/intel-thc-hid/intel-thc/intel-thc-dma.c
index c80ef8c20..413f264e3 100644
--- a/drivers/hid/intel-thc-hid/intel-thc/intel-thc-dma.c
+++ b/drivers/hid/intel-thc-hid/intel-thc/intel-thc-dma.c
@@ -211,12 +211,27 @@ static void thc_copy_sgls_to_prd(struct thc_device *dev,
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
@@ -327,6 +342,7 @@ struct thc_dma_context *thc_dma_init(struct thc_device *dev)
 		return NULL;
 
 	dev->dma_ctx = dma_ctx;
+	mutex_init(&dma_ctx->prd_lock);
 
 	dma_ctx->dma_config[THC_RXDMA1].dma_channel = THC_RXDMA1;
 	dma_ctx->dma_config[THC_RXDMA2].dma_channel = THC_RXDMA2;
@@ -491,6 +507,9 @@ int thc_dma_configure(struct thc_device *dev)
 		return -EINVAL;
 	}
 
+	/* An entry may still be short from a frame nobody read. */
+	thc_rebuild_rx_prd(dev);
+
 	for (chan = 0; chan < MAX_THC_DMA_CHANNEL; chan++) {
 		dma_set_prd_base_addr(dev,
 				      dma_ctx->dma_config[chan].prd_tbls_dma_handle,
@@ -685,6 +704,8 @@ static int thc_dma_read(struct thc_device *dev,
 	u8 read_ptr, write_ptr, prd_table_index;
 	int status;
 
+	guard(mutex)(&dev->dma_ctx->prd_lock);
+
 	if (!is_dma_buf_empty(dev, read_config, &read_ptr, &write_ptr)) {
 		prd_table_index = write_ptr & THC_POINTER_MASK;
 
@@ -765,11 +786,16 @@ static int thc_swdma_read_start(struct thc_device *dev, void *write_buff,
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
@@ -854,6 +880,9 @@ static int thc_swdma_read_completion(struct thc_device *dev)
 
 	thc_reset_dma_settings(dev);
 
+	/* The receive engine starts again just below. */
+	thc_rebuild_rx_prd(dev);
+
 	dma_set_start_bit(dev, &dev->dma_ctx->dma_config[THC_RXDMA2]);
 
 	ret = thc_interrupt_quiesce(dev, false);
diff --git a/drivers/hid/intel-thc-hid/intel-thc/intel-thc-dma.h b/drivers/hid/intel-thc-hid/intel-thc/intel-thc-dma.h
index 715423453..264cd26b7 100644
--- a/drivers/hid/intel-thc-hid/intel-thc/intel-thc-dma.h
+++ b/drivers/hid/intel-thc-hid/intel-thc/intel-thc-dma.h
@@ -6,6 +6,7 @@
 
 #include <linux/bits.h>
 #include <linux/dma-mapping.h>
+#include <linux/mutex.h>
 #include <linux/sizes.h>
 #include <linux/time64.h>
 #include <linux/types.h>
@@ -123,6 +124,9 @@ struct thc_dma_configuration {
  * struct thc_dma_context - THC DMA context
  * @thc_dma_configuration: Array of all THC Channel configures
  * @use_write_interrupts: Indicate TxDMA using interrupt or polling
+ * @prd_lock: Keeps a table from being rebuilt while the DMA read path is
+ *            using it; a sleeping lock, taken inside the bus lock where the
+ *            caller holds that one.
  * @rx_max_size_en: Temp flag to indicate THC I2C Rx max input size control feature
  *                  enabled or not, only be used during SWDMA operation.
  * @rx_int_delay_en: Temp flag to indicate THC I2C Rx interrupt delay feature
@@ -132,6 +136,9 @@ struct thc_dma_context {
 	struct thc_dma_configuration dma_config[MAX_THC_DMA_CHANNEL];
 	u8 use_write_interrupts;
 
+	/* Serialises a rebuild of the tables with the DMA read path. */
+	struct mutex prd_lock;
+
 	bool rx_max_size_en;
 	bool rx_int_delay_en;
 };

base-commit: aebb7274476403040d582c61478df8f4a7bf9cd3
