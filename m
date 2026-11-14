Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=82.195.75.108
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794681585;
	b=XeVQOUAOKY72jfyIuqLgAsHlVVgvwji0Uu0LNLBItu5E/WO9HCly2YZTx9jYSGHeo/tl
	 OX3F+SwTHhC9ZCOtXrTMVNdL9K7e37abIioqaAtgWyNPmpWd0SQUCt7v5+GflgbDdfQCS
	 MJ3ATLqhkGLJ0qzb6spIN5bwoRJHXBS/6RZ1FbdooEv36j3QRVKhzxQnJpw0nnmJivb93
	 jaNL+PlZY4GKTtBJqjRpytxeyJVeR9/YW4sav6YV4YMtT9RWCVE87liwUt7ELrUCVQASr
	 5fjnERRqVNgtFzG7eB1FDwDYaEAjL8QApLirvGbSf5/awROE1jIcx8mh6gAVQj6SxTw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794681585;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Debian-User;
	bh=YuWpr2CcEKcu4PHSHGpEYMYgI1EKEsgyRnUa/DvqO5k=;
	b=THLcZ9xY2HKI5ajiC+1Q5YzjgSqDiSETGFUGIgUMmMFYA2lv2bppDTmnNNVEscOqUPlt
	 0OZwq0ShGo68xV/AAdnF0VuP5IP53p/jGcCv2fF3uG6i5YxOrv3G7Y1NX7FV6Q6W6laMI
	 41sbryZchcomIv0kWhlUyV5csST+57cWEp6cIvQ6lnxgcc+ejNJMrpTZyPXED5m/brJsV
	 dBwxwZrwUwNhRL1JgBhcmS0aGMcVuOd5WABvV9raMbkHtwuNGwlpv2oiNrDUXXRPjxXtn
	 t93AkQvp4krjyFFwl8WHhmNim0xd7hBoxDYikjiMnRCyRr2eqPZgKL1tkBXjovfX5uQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=debian.org;
	spf=pass smtp.mailfrom=debian.org;
	dkim=pass header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=CZpe9YR3;
	arc=none smtp.remote-ip=82.195.75.108
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97D49606A331;
	Sat, 14 Nov 2026 18:39:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 97D49606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=CZpe9YR3
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=YuWpr2CcEKcu4PHSHGpEYMYgI1EKEsgyRnUa/DvqO5k=; b=CZpe9YR3TUWCA7FrQKVGX7LvDn
	R3HogNhpzUKz6AN4jx3MT8r8S0rpcuHhHeLXyh61gTkYNDrSJPBHmDSVZo47HroCOLf+gMVhEfJ2P
	faf5UljZdp5GQOFgzsl/Rh9hvEMf/xDZ/SvTm9oPMJui98OBcG5AxniiKvAW4JV3FT/wUZZC4rJCD
	nRP6k6Vptbmqf0RTtGJ+jvO4Drm2I0w1EmRtPf7VcWh2LCOCfd7Hb9/fAD5SLhRGD8VT3OZy9OB66
	/XYqikhLbWMlYUfRHVlDZwCxQGbBi1DzgffEQuu9K9JgXnsOx60ev7oOZD8kVwDBPjddqoc4iNju1
	uLFqAbIg==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <emfox@debian.org>)
	id 1xSIf5-00FkAH-1q;
	Sat, 14 Nov 2026 18:39:40 +0000
From: Emfox Zhou <emfox@debian.org>
To: Even Xu <even.xu@intel.com>,
	Xinpeng Sun <xinpeng.sun@intel.com>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/5] HID: intel-thc-hid: intel-ipts: receive reports
Date: Sun, 15 Nov 2026 02:36:21 +0800
Message-ID: <20261114183624.2379573-3-emfox@debian.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261114183624.2379573-1-emfox@debian.org>
References: <20261114183624.2379573-1-emfox@debian.org>
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
 drivers/hid/intel-thc-hid/intel-ipts/ipts.c   | 243 ++++++++++++++++++
 drivers/hid/intel-thc-hid/intel-ipts/ipts.h   |  17 ++
 .../hid/intel-thc-hid/intel-ipts/pci-ipts.c   |  44 +++-
 3 files changed, 303 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/intel-thc-hid/intel-ipts/ipts.c b/drivers/hid/intel-thc-hid/intel-ipts/ipts.c
index 2644796..ac0074a 100644
--- a/drivers/hid/intel-thc-hid/intel-ipts/ipts.c
+++ b/drivers/hid/intel-thc-hid/intel-ipts/ipts.c
@@ -5,8 +5,13 @@
  */
 
 #include <linux/delay.h>
+#include <linux/interrupt.h>
+#include <linux/minmax.h>
 #include <linux/regmap.h>
+#include <linux/sizes.h>
 #include <linux/string.h>
+#include <linux/unaligned.h>
+#include <linux/workqueue.h>
 
 #include "intel-thc-hw.h"
 #include "ipts.h"
@@ -20,6 +25,13 @@
 /* Time the controller needs after reset before it answers on the bus. */
 #define THC_IPTS_BOOT_MS		100
 
+/*
+ * thc_interrupt_handler() handles one cause per call, so a burst
+ * needs one call per cause plus the one that reports none. The
+ * bound only stops a controller that never falls quiet.
+ */
+#define THC_IPTS_IRQ_PASSES		(THC_UNKNOWN_INT + 1)
+
 static int thc_ipts_read_cfg(struct thc_ipts *idev)
 {
 	int ret, try;
@@ -127,6 +139,209 @@ static int thc_ipts_touch_set(struct thc_ipts *idev, bool enable)
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
+	/*
+	 * Allocated once, so each buffer is retried on its own: a failed
+	 * first start must not leave a NULL frame buffer for a resume.
+	 */
+	if (!idev->rx_frame) {
+		/*
+		 * The core rounds the packet size up to a page when it sets
+		 * up the engines, so the buffer has to be that large.
+		 */
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
+	/*
+	 * The pin is shared and level triggered: mask first, or it stays
+	 * asserted on the way out. The cause itself can only be read in the
+	 * thread.
+	 */
+	thc_interrupt_enable(idev->thc, false);
+
+	/* A reset in flight owns the engine, and the interrupt is ours. */
+	if (READ_ONCE(idev->recovering))
+		return IRQ_HANDLED;
+
+	/*
+	 * Nothing of ours is pending in these two states and the port is
+	 * masked: the interrupt belongs to another function on the line.
+	 */
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
+		/* Nothing was read: the ring was empty and len is still 0. */
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
+/*
+ * Run from a work item: thc_rxdma_reset() takes the bus lock, which
+ * thc_dma_write() holds while it waits for a completion this thread has to
+ * deliver, so resetting inline would stall until the write times out.
+ */
+void thc_ipts_recover(struct work_struct *work)
+{
+	struct thc_ipts *idev = container_of(work, struct thc_ipts,
+					     recover_work);
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
+		return IRQ_HANDLED;
+
+	/*
+	 * The port stays masked until the end of this handler, so a cause that
+	 * arrives in between leaves only its status bit: keep reading until
+	 * the core reports none.
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
+			/*
+			 * Keep reading: the core stops at the first cause, so
+			 * a Tx completion queued behind the error would wait
+			 * out its timeout under the bus lock.
+			 */
+			continue;
+		}
+
+		if (need_recover)
+			continue;
+
+		/*
+		 * A non-DMA cause needs no action: the core acknowledges it,
+		 * and this port moves report data through the DMA engines.
+		 */
+		if (mask & BIT(THC_RXDMA2_INT) && thc_ipts_read_frames(idev))
+			need_recover = true;
+	}
+
+	/*
+	 * The work item resets the engine and unmasks the port again; a frame
+	 * read while it rewrites the ring would corrupt the descriptors, so
+	 * ->recovering keeps the handler off the line until it is done.
+	 */
+	if (need_recover) {
+		WRITE_ONCE(idev->recovering, true);
+		schedule_work(&idev->recover_work);
+		return IRQ_HANDLED;
+	}
+
+	if (!READ_ONCE(idev->stopping))
+		thc_interrupt_enable(idev->thc, true);
+
+	/* An interrupt with no cause of ours is not ours to claim. */
+	return ret;
+}
+
 /**
  * thc_ipts_port_start - bring one port up
  * @idev: port to start
@@ -136,6 +351,9 @@ int thc_ipts_port_start(struct thc_ipts *idev)
 	u32 ctrl, hz, mode;
 	int ret;
 
+	WRITE_ONCE(idev->stopping, false);
+	WRITE_ONCE(idev->recovering, false);
+
 	ret = thc_ipts_quiesce(idev, true);
 	if (ret)
 		return ret;
@@ -208,6 +426,19 @@ int thc_ipts_port_start(struct thc_ipts *idev)
 		return ret;
 	idev->running = true;
 
+	/*
+	 * thc_interrupt_config() programs the interrupt type field to the
+	 * invalid value; starting RXDMA2 then sets it to the type the engine
+	 * expects, so the configuration has to happen first.
+	 */
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
 
@@ -220,6 +451,16 @@ void thc_ipts_port_stop(struct thc_ipts *idev)
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
+	/* Stop the controller before the buffers it writes into go away. */
 	if (idev->running)
 		thc_ipts_touch_set(idev, false);
 
@@ -228,4 +469,6 @@ void thc_ipts_port_stop(struct thc_ipts *idev)
 			  THC_M_PRT_CONTROL_OFFSET,
 			  THC_M_PRT_CONTROL_DEVRST);
 	thc_ipts_quiesce(idev, true);
+
+	thc_ipts_dma_stop(idev);
 }
diff --git a/drivers/hid/intel-thc-hid/intel-ipts/ipts.h b/drivers/hid/intel-thc-hid/intel-ipts/ipts.h
index f0493dc..f233d9c 100644
--- a/drivers/hid/intel-thc-hid/intel-ipts/ipts.h
+++ b/drivers/hid/intel-thc-hid/intel-ipts/ipts.h
@@ -8,6 +8,7 @@
 #include <linux/device.h>
 #include <linux/interrupt.h>
 #include <linux/types.h>
+#include <linux/wait.h>
 
 #include "intel-thc-dev.h"
 
@@ -108,24 +109,40 @@ static_assert(offsetof(struct thc_ipts_cfg, vendor) == 0x1c);
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
index 48046cd..161bee9 100644
--- a/drivers/hid/intel-thc-hid/intel-ipts/pci-ipts.c
+++ b/drivers/hid/intel-thc-hid/intel-ipts/pci-ipts.c
@@ -46,6 +46,7 @@ static int thc_ipts_probe(struct pci_dev *pci, const struct pci_device_id *id)
 
 	idev->dev = &pci->dev;
 	pci_set_drvdata(pci, idev);
+	INIT_WORK(&idev->recover_work, thc_ipts_recover);
 
 	ret = pcim_enable_device(pci);
 	if (ret) {
@@ -77,10 +78,42 @@ static int thc_ipts_probe(struct pci_dev *pci, const struct pci_device_id *id)
 	if (IS_ERR(idev->thc))
 		return PTR_ERR(idev->thc);
 
+	/*
+	 * Interrupt remapping rejects the MSI requests these ports send, so
+	 * take the legacy pin (shared with other functions on the PCH, hence
+	 * IRQF_SHARED); MSI is only for a platform that routes no pin.
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
+	/*
+	 * A shared line only takes handlers that agree on oneshot, and the
+	 * hardirq masks the port itself, so ask for it only if a sharer has.
+	 */
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
@@ -90,6 +123,11 @@ static int thc_ipts_probe(struct pci_dev *pci, const struct pci_device_id *id)
 		 le32_to_cpu(idev->cfg.spi_cfg), idev->max_rx, idev->max_tx);
 
 	return 0;
+
+err_vectors:
+	pci_free_irq_vectors(pci);
+
+	return ret;
 }
 
 static void thc_ipts_remove(struct pci_dev *pci)
@@ -97,6 +135,10 @@ static void thc_ipts_remove(struct pci_dev *pci)
 	struct thc_ipts *idev = pci_get_drvdata(pci);
 
 	thc_ipts_port_stop(idev);
+
+	/* The handler has to go before the vector it is bound to is freed. */
+	devm_free_irq(idev->dev, idev->irq, idev);
+	pci_free_irq_vectors(pci);
 	pci_clear_master(pci);
 }
 
