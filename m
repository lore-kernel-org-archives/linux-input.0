Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=82.195.75.108
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794699785;
	b=er9I7EPSgp+Kay3z9y+LhsbDZc/lRYPWtgpcLBPZlwTf8kxBiX87ZKaJsLIVYsgwX+b5
	 Cxn5+5ExFdg7adwB6ws2o1ysMLtAXi7s5nIse4PPcct1QnOUALnVLA51qDKoMVlDBwgNC
	 jrCPKCvSTsKB5pNeG9eowlLqFWJZMSwvNPvY7aumOMq33xebEP5tfBJh1uUT6pBRI3SVw
	 RdvxlU2jlv+GBl5KEiLg1vPdxsrRuf1wE7Iqrdj2Km+Aq6Pukz0Ki627n8K24+F/ba9cD
	 7PE4GOr+Z/7CkIyBW1F4eulxQVXMMeLRPsGwPRbf/ygJ0695hejZQ7u8ezAEKjW3wIg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794699785;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Debian-User;
	bh=IYdeI27PDzRbGqCKt9s9DmgYXNKSY/1mfSqH+vAlUtI=;
	b=ygMd/plf+r7hXK51d8vYuK8BUYIjQHYMQVhjpTepBjFzR1GGgvmJ1Pb38nQ+X1Cs7VCx
	 s8ebmKKyogBwpwgf33ATuL5AxL+FPBTkmHrW1t6RCr8OUjhfIfRoMGAXXWtizOBK9Qa04
	 dEw8nYoGlSsf0kK4f/DeXgPUEqFqYn2g8XGKy7tPIoCE1CSG2XANzVpygcDUY/OOSHFn5
	 h2EzgHhJui4qUXn8ohIQ3w52gW/zlJ52zRBn3DdQQfGGCdN4zJEtT3TXMCzNW2VR14zXz
	 4RJKM87DtcewpX44wwLFyVpwWn7t9fKbvyknmpG2a4fjs5SVIGEAkTcopQiXnSWDsKg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=debian.org;
	spf=pass smtp.mailfrom=debian.org;
	dkim=pass header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=pgmKkgbA;
	arc=none smtp.remote-ip=82.195.75.108
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93679606A881;
	Sat, 14 Nov 2026 23:43:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 93679606A881
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=pgmKkgbA
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=IYdeI27PDzRbGqCKt9s9DmgYXNKSY/1mfSqH+vAlUtI=; b=pgmKkgbAh9HeDtET2P8XurWPh4
	AZApYhtyEMRQQRts/YIyqm4rsDniQPL6ismM//ri54BcTq4aJ3u8J07GlNLUKQT2GgPCGq4pbhGzB
	TvtR9hIB0YvTue/Dwj/63cJcH0WPNSOQQwcZzcONs5zTREX/h9fzSL5R1dDASgxpl6twyiWECdwha
	ryWS7cIyk2vrbzNPdyGSjZ/wBukbmw31otYR2BaIHYkjjvRafx1U8QaUeH/9TFFSnt3PcJWbeNg8A
	qOPoavGIIf8BL1u9GHwxuOuZNY+1O4vv+wAsDF2G80PDLPwrVkqVo5Bbn/nG7s8Q99VOO4ucfv8kf
	2VrQg5Vw==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <emfox@debian.org>)
	id 1xSNOd-00FuFn-16;
	Sat, 14 Nov 2026 23:42:59 +0000
From: Emfox Zhou <emfox@debian.org>
To: Even Xu <even.xu@intel.com>,
	Xinpeng Sun <xinpeng.sun@intel.com>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 2/5] HID: intel-thc-hid: intel-ipts: receive reports
Date: Sun, 15 Nov 2026 07:42:39 +0800
Message-ID: <20261114234242.177387-3-emfox@debian.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261114234242.177387-1-emfox@debian.org>
References: <20261114234242.177387-1-emfox@debian.org>
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

Take the port one step further: configure the two DMA engines, one for
the frames the controller sends and one for the frames the host sends,
and register the interrupt that reports them.

Interrupt remapping rejects the MSI requests these ports send: the
requester ID in them is 01:05.0, neither the port's own function nor a
valid DMA alias for it, so only the legacy interrupt pin works once
remapping is on. MSI is the fallback for a platform that does not route
that pin. The pin is shared with other functions on the PCH, and such a
line only takes handlers that agree on oneshot, so the request asks for
it only if a sharer uses it. The hardirq masks the port itself, so a
foreign interrupt costs at most a few register reads in the thread, and
is reported as not handled.

Transfer errors are recovered from a work item and not from the threaded
handler: thc_rxdma_reset() takes the bus lock, and a pending
thc_dma_write() holds that lock while it waits for the very completion the
handler has to deliver. The port stays masked while that item runs and the
handler ignores the line, so the reset cannot race with a frame being read:
masking alone would not help, as another function on the shared pin can
still wake the handler.

That reset covers the host side only, and it leaves the PRD table
descriptors the controller rewrites in place. Taking a frame puts its
entry back, but a frame that is not read keeps the length the controller
wrote, and the next frame that does not fit ends in a PRD overrun.
intel-quickspi and intel-quicki2c recover through the same call and have
the same gap; the fix belongs in the core. A controller that stopped
answering needs DEVRST, which a reload does.

Every frame carries a code and a length in front of the payload. The
receive side decodes that header and logs each frame.

Three details are worth spelling out:

  - The interrupt configuration has to be applied before the DMA
    engines are started: it programs the device interrupt type field to
    the invalid value, and starting the receive engine then replaces that
    field with the type it expects. The other order would leave the
    invalid value in place.

  - The line is masked while the threaded handler runs, and an event
    that arrives in that window leaves nothing behind but its status
    bit. The handler therefore drains the status registers instead of
    trusting a single delivery: a write completion taken for granted
    this way makes the next transfer wait for a completion that never
    comes, and the port stays unusable until it is reset.

  - Bulk transfers have no address phase, so the SPI opcode is zero.
    The opcodes the HIDSPI path uses make this controller ignore the
    frames altogether.

Signed-off-by: Emfox Zhou <emfox@debian.org>
---
 drivers/hid/intel-thc-hid/intel-ipts/ipts.c   | 229 ++++++++++++++++++
 drivers/hid/intel-thc-hid/intel-ipts/ipts.h   |  17 ++
 .../hid/intel-thc-hid/intel-ipts/pci-ipts.c   |  40 ++-
 3 files changed, 285 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/intel-thc-hid/intel-ipts/ipts.c b/drivers/hid/intel-thc-hid/intel-ipts/ipts.c
index b0e3fe8ea..76224f444 100644
--- a/drivers/hid/intel-thc-hid/intel-ipts/ipts.c
+++ b/drivers/hid/intel-thc-hid/intel-ipts/ipts.c
@@ -5,8 +5,13 @@
 
 #include <linux/delay.h>
 #include <linux/math.h>
+#include <linux/interrupt.h>
+#include <linux/minmax.h>
 #include <linux/regmap.h>
+#include <linux/sizes.h>
 #include <linux/string.h>
+#include <linux/unaligned.h>
+#include <linux/workqueue.h>
 
 #include "intel-thc-hw.h"
 #include "ipts.h"
@@ -20,6 +25,11 @@
 /* Time the controller needs after reset before it answers on the bus. */
 #define THC_IPTS_BOOT_MS		100
 
+/*
+ * thc_interrupt_handler() handles one cause per call; one more finds none.
+ */
+#define THC_IPTS_IRQ_PASSES		(THC_UNKNOWN_INT + 1)
+
 static int thc_ipts_read_cfg(struct thc_ipts *idev)
 {
 	int ret, try;
@@ -122,6 +132,198 @@ static int thc_ipts_touch_set(struct thc_ipts *idev, bool enable)
 				 &touch);
 }
 
+static void thc_ipts_handle_frame(struct thc_ipts *idev, size_t len)
+{
+	size_t capacity = idev->max_rx - THC_IPTS_RX_HDR_SIZE;
+	u32 code, size;
+
+	if (len < THC_IPTS_RX_HDR_SIZE)
+		return;
+
+	code = get_unaligned_le32(idev->rx_frame);
+	/* The header may claim more than what actually arrived. */
+	size = min_t(u32, get_unaligned_le32(idev->rx_frame + 4),
+		     capacity);
+	size = min_t(u32, size, len - THC_IPTS_RX_HDR_SIZE);
+
+	dev_dbg(idev->dev, "frame code %u, %u bytes\n", code, size);
+}
+
+static void thc_ipts_dma_stop(struct thc_ipts *idev)
+{
+	if (!idev->dma_ready)
+		return;
+
+	WRITE_ONCE(idev->dma_ready, false);
+	thc_dma_unconfigure(idev->thc);
+	thc_dma_release(idev->thc);
+}
+
+static int thc_ipts_dma_start(struct thc_ipts *idev)
+{
+	int ret;
+
+	/* Allocated once: a start that failed must not leave a NULL buffer. */
+	if (!idev->rx_frame) {
+		/* The core rounds the packet size up to a page. */
+		idev->rx_frame = devm_kzalloc(idev->dev,
+					      round_up(idev->max_rx, SZ_4K),
+					      GFP_KERNEL);
+		if (!idev->rx_frame)
+			return -ENOMEM;
+	}
+
+	ret = thc_dma_set_max_packet_sizes(idev->thc, 0, idev->max_rx,
+					   idev->max_tx, 0);
+	if (ret)
+		return ret;
+
+	ret = thc_dma_allocate(idev->thc);
+	if (ret)
+		return ret;
+
+	ret = thc_dma_configure(idev->thc);
+	if (ret) {
+		thc_dma_release(idev->thc);
+		return ret;
+	}
+
+	WRITE_ONCE(idev->dma_ready, true);
+
+	return 0;
+}
+
+irqreturn_t thc_ipts_hardirq(int irq, void *data)
+{
+	struct thc_ipts *idev = data;
+
+	/* Level triggered and shared: mask first, or it stays asserted. */
+	thc_interrupt_enable(idev->thc, false);
+
+	/* A reset in flight: the port is masked, so this is not ours. */
+	if (READ_ONCE(idev->recovering))
+		return IRQ_NONE;
+
+	/* Nothing of ours is pending: the cause belongs to a sharer. */
+	if (READ_ONCE(idev->stopping) || !READ_ONCE(idev->dma_ready))
+		return IRQ_NONE;
+
+	return IRQ_WAKE_THREAD;
+}
+
+static int thc_ipts_read_frames(struct thc_ipts *idev)
+{
+	for (;;) {
+		int finished = 0;
+		size_t len = 0;
+
+		if (thc_rxdma_read(idev->thc, THC_RXDMA2, idev->rx_frame,
+				   &len, &finished)) {
+			dev_warn_once(idev->dev,
+				      "cannot read a frame from the engine\n");
+			return -EIO;
+		}
+
+		if (!len)
+			break;
+
+		thc_ipts_handle_frame(idev, len);
+		if (finished)
+			break;
+	}
+
+	return 0;
+}
+
+/* Mask first: a handler that hit the error may unmask on its way out. */
+static void thc_ipts_request_recover(struct thc_ipts *idev)
+{
+	thc_interrupt_enable(idev->thc, false);
+
+	if (READ_ONCE(idev->recovering))
+		return;
+
+	WRITE_ONCE(idev->recovering, true);
+	schedule_work(&idev->recover_work);
+}
+
+/*
+ * From a work item: the reset waits for the bus lock a pending write holds
+ * until this handler delivers its completion.
+ */
+void thc_ipts_recover(struct work_struct *work)
+{
+	struct thc_ipts *idev = container_of(work, struct thc_ipts,
+					     recover_work);
+
+	/* A handler may have unmasked after the error; keep it masked. */
+	thc_interrupt_enable(idev->thc, false);
+
+	if (thc_rxdma_reset(idev->thc)) {
+		/* Nothing left: keep the port masked until it restarts. */
+		dev_err(idev->dev, "cannot reset the receive engine\n");
+		return;
+	}
+
+	WRITE_ONCE(idev->recovering, false);
+	if (!READ_ONCE(idev->stopping))
+		thc_interrupt_enable(idev->thc, true);
+}
+
+irqreturn_t thc_ipts_thread(int irq, void *data)
+{
+	struct thc_ipts *idev = data;
+	irqreturn_t ret = IRQ_NONE;	/* no cause of ours yet */
+	bool need_recover = false;
+	int pass;
+
+	/* A reset is in flight; the engine state is not ours to read. */
+	if (READ_ONCE(idev->recovering))
+		return IRQ_NONE;
+
+	/* The port stays masked, so a cause that arrives meanwhile leaves only
+	 * its status bit: read until the core reports none.
+	 */
+	for (pass = 0; pass < THC_IPTS_IRQ_PASSES; pass++) {
+		int mask = thc_interrupt_handler(idev->thc);
+
+		/* The core reports this one when no cause is pending. */
+		if (mask == BIT(THC_UNKNOWN_INT))
+			break;
+
+		ret = IRQ_HANDLED;
+		if (mask & (BIT(THC_FATAL_ERR_INT) | BIT(THC_TXN_ERR_INT))) {
+			dev_err(idev->dev,
+				"transfer error, resetting the engine\n");
+			need_recover = true;
+			/* The core stops at the first cause: a Tx completion
+			 * behind the error would time out under the bus lock.
+			 */
+			continue;
+		}
+
+		if (need_recover)
+			continue;
+
+		/* Not a DMA cause: nothing to read for this port. */
+		if (mask & BIT(THC_RXDMA2_INT) && thc_ipts_read_frames(idev))
+			need_recover = true;
+	}
+
+	/* The work item resets the engine and unmasks again; a frame read
+	 * meanwhile would corrupt the ring.
+	 */
+	if (need_recover) {
+		thc_ipts_request_recover(idev);
+		return IRQ_HANDLED;
+	}
+
+	if (!READ_ONCE(idev->stopping))
+		thc_interrupt_enable(idev->thc, true);
+
+	return ret;
+}
+
 /**
  * thc_ipts_port_start - bring one port up
  * @idev: port to start
@@ -131,6 +333,9 @@ int thc_ipts_port_start(struct thc_ipts *idev)
 	u32 ctrl, hz, mode;
 	int ret;
 
+	WRITE_ONCE(idev->stopping, false);
+	WRITE_ONCE(idev->recovering, false);
+
 	ret = thc_ipts_quiesce(idev, true);
 	if (ret)
 		return ret;
@@ -203,6 +408,15 @@ int thc_ipts_port_start(struct thc_ipts *idev)
 		return ret;
 	idev->running = true;
 
+	/* Sets the type field to invalid; RXDMA2 start writes the real one. */
+	thc_interrupt_config(idev->thc);
+
+	ret = thc_ipts_dma_start(idev);
+	if (ret)
+		return ret;
+
+	thc_interrupt_enable(idev->thc, true);
+
 	return 0;
 }
 
@@ -215,6 +429,19 @@ void thc_ipts_port_stop(struct thc_ipts *idev)
 	if (!idev->thc)
 		return;
 
+	/*
+	 * Mask the line, then wait for a handler that may be holding a
+	 * frame for the HID device which is about to go away.
+	 */
+	WRITE_ONCE(idev->stopping, true);
+	thc_interrupt_enable(idev->thc, false);
+	synchronize_irq(idev->irq);
+	cancel_work_sync(&idev->recover_work);
+
+	/* A handler that read ->stopping early may have unmasked. */
+	thc_interrupt_enable(idev->thc, false);
+
+	/* Stop the controller before the buffers it writes into go away. */
 	if (idev->running)
 		thc_ipts_touch_set(idev, false);
 
@@ -223,4 +450,6 @@ void thc_ipts_port_stop(struct thc_ipts *idev)
 			  THC_M_PRT_CONTROL_OFFSET,
 			  THC_M_PRT_CONTROL_DEVRST);
 	thc_ipts_quiesce(idev, true);
+
+	thc_ipts_dma_stop(idev);
 }
diff --git a/drivers/hid/intel-thc-hid/intel-ipts/ipts.h b/drivers/hid/intel-thc-hid/intel-ipts/ipts.h
index 97b96ca27..3132195c3 100644
--- a/drivers/hid/intel-thc-hid/intel-ipts/ipts.h
+++ b/drivers/hid/intel-thc-hid/intel-ipts/ipts.h
@@ -8,6 +8,7 @@
 #include <linux/device.h>
 #include <linux/interrupt.h>
 #include <linux/types.h>
+#include <linux/wait.h>
 
 #include "intel-thc-dev.h"
 
@@ -103,24 +104,40 @@ static_assert(offsetof(struct thc_ipts_cfg, vendor) == 0x1c);
  * struct thc_ipts - state of one THC port in IPTS mode
  * @dev: device used for resources and logging
  * @thc: shared THC core context
+ * @irq: interrupt line of the port
  * @cfg: configuration block last read from the controller
  * @vendor: vendor ID the controller reports for its HID device
  * @product: product ID the controller reports for its HID device
  * @max_rx: largest frame the controller may send, in bytes
  * @max_tx: largest frame the driver may send, in bytes
+ * @rx_frame: buffer for one received frame, including its header
+ * @recover_work: resets the receive engine after a transfer error
  * @running: the controller answered and is out of reset
+ * @dma_ready: DMA engines are configured and may be used
+ * @recovering: a reset is queued or running, ignore the interrupt
+ * @stopping: the port is being torn down, ignore the interrupt
  */
 struct thc_ipts {
 	struct device		*dev;
 	struct thc_device	*thc;
+	int			irq;
 	struct thc_ipts_cfg	cfg;
 	u16			vendor;
 	u16			product;
 	size_t			max_rx;
 	size_t			max_tx;
+	u8			*rx_frame;
+	struct work_struct	recover_work;
 	bool			running;
+	bool			dma_ready;
+	bool			recovering;
+	bool			stopping;
 };
 
+irqreturn_t thc_ipts_hardirq(int irq, void *data);
+irqreturn_t thc_ipts_thread(int irq, void *data);
+void thc_ipts_recover(struct work_struct *work);
+
 int thc_ipts_port_start(struct thc_ipts *idev);
 void thc_ipts_port_stop(struct thc_ipts *idev);
 
diff --git a/drivers/hid/intel-thc-hid/intel-ipts/pci-ipts.c b/drivers/hid/intel-thc-hid/intel-ipts/pci-ipts.c
index 48046cd12..34029e9eb 100644
--- a/drivers/hid/intel-thc-hid/intel-ipts/pci-ipts.c
+++ b/drivers/hid/intel-thc-hid/intel-ipts/pci-ipts.c
@@ -46,6 +46,7 @@ static int thc_ipts_probe(struct pci_dev *pci, const struct pci_device_id *id)
 
 	idev->dev = &pci->dev;
 	pci_set_drvdata(pci, idev);
+	INIT_WORK(&idev->recover_work, thc_ipts_recover);
 
 	ret = pcim_enable_device(pci);
 	if (ret) {
@@ -77,10 +78,38 @@ static int thc_ipts_probe(struct pci_dev *pci, const struct pci_device_id *id)
 	if (IS_ERR(idev->thc))
 		return PTR_ERR(idev->thc);
 
+	/*
+	 * Interrupt remapping rejects the MSI these ports ask for, so take the
+	 * shared legacy pin; MSI is for a platform that routes no pin.
+	 */
+	ret = pci_alloc_irq_vectors(pci, 1, 1, PCI_IRQ_INTX);
+	if (ret < 0) {
+		dev_warn(idev->dev, "no interrupt pin, falling back to MSI\n");
+		ret = pci_alloc_irq_vectors(pci, 1, 1,
+					    PCI_IRQ_MSI | PCI_IRQ_MSIX);
+	}
+	if (ret < 0) {
+		dev_err(idev->dev, "no interrupt vector, error %d\n", ret);
+		return ret;
+	}
+
+	idev->irq = pci_irq_vector(pci, 0);
+
+	/* Oneshot only if a sharer has it: the hardirq masks the port. */
+	ret = devm_request_threaded_irq(idev->dev, idev->irq, thc_ipts_hardirq,
+					thc_ipts_thread,
+					IRQF_SHARED | IRQF_COND_ONESHOT,
+					KBUILD_MODNAME, idev);
+	if (ret) {
+		dev_err(idev->dev, "cannot get the interrupt, error %d\n", ret);
+		goto err_vectors;
+	}
+
 	ret = thc_ipts_port_start(idev);
 	if (ret) {
 		thc_ipts_port_stop(idev);
-		return ret;
+		devm_free_irq(idev->dev, idev->irq, idev);
+		goto err_vectors;
 	}
 
 	dev_info(idev->dev, "controller %04x:%04x rev %u, firmware 0x%08x\n",
@@ -90,6 +119,11 @@ static int thc_ipts_probe(struct pci_dev *pci, const struct pci_device_id *id)
 		 le32_to_cpu(idev->cfg.spi_cfg), idev->max_rx, idev->max_tx);
 
 	return 0;
+
+err_vectors:
+	pci_free_irq_vectors(pci);
+
+	return ret;
 }
 
 static void thc_ipts_remove(struct pci_dev *pci)
@@ -97,6 +131,10 @@ static void thc_ipts_remove(struct pci_dev *pci)
 	struct thc_ipts *idev = pci_get_drvdata(pci);
 
 	thc_ipts_port_stop(idev);
+
+	/* The handler has to go before the vector it is bound to is freed. */
+	devm_free_irq(idev->dev, idev->irq, idev);
+	pci_free_irq_vectors(pci);
 	pci_clear_master(pci);
 }
 
