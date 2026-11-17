Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=82.195.75.108
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794900985;
	b=GQ+E0+4LAFQUtA7JkdX4g4MKW3qZdwsDJINdysU4cIs9I7yDpiC6+AKpoCQ3M/W2f09h
	 1tCOPcExtXHzYyW4x0Lm1LKNPoQLg09fdDFkHoTElvQBl+7X9kM4zHWuTpmI9HQHbMj0t
	 fqfNe1YnJ3dCrSgiOVIeCgDZqyQk4/cwt3ctjrM5lywoCFHTp9cvQczzjok2osya5Akn4
	 sC0v0YZwq1G4opUch7uldAx/EwpM+rHLmQ0nNGzLxqN0aW0si1eQsEcKBQ6hfak7SaV6m
	 GBQBjWIJkbdhuEPVKy5kGUCYdEEfKi0yqkUq1+8sl9Or8fZQUfUZV5VeBnaqKISctXA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794900985;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Debian-User;
	bh=s9z/PWjFI7UY7fo/DZTDkp4zGy914HZwjI5QHREfL/w=;
	b=nPkj1hgqNR28Wajy+5MqtZNgmw+H9qmFMUIYyMdkECy8UQlDi3hKbcP3sWZUiPPAxL6B
	 kQc+93B0CoGzMH+0L+REf4feJ0nRnS6OraRe7YCh0cxWchiR0NZuZbo4ndABfgvXCyX0l
	 rsy3Z/aGNWjWOoxn46r3pYn4hmk3po8AnE/u3A+Z1NumlrKMFtIH1b/UDvTSqJteXDZsc
	 Cybyw5HCb5GlYN4hiylh7tidMJzHxEylxo14KZkWLf2kP5a6oa7UVIbo+NzHmXI1icDj4
	 7sQ1XmCFv0PirfYq86mI+3BR4/zrrfsd46Jtvm1x+boh/vu3zbCuVbv9AV4nc+r4+lg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=debian.org;
	spf=pass smtp.mailfrom=debian.org;
	dkim=pass header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=WjAEWq8b;
	arc=none smtp.remote-ip=82.195.75.108
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55D64606A323;
	Tue, 17 Nov 2026 07:36:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 55D64606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=WjAEWq8b
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=s9z/PWjFI7UY7fo/DZTDkp4zGy914HZwjI5QHREfL/w=; b=WjAEWq8b+H6j6JkJtADM5N1Jjq
	BSIrdC4+ShAq/MQ9LZEfQRE30P7rLGT0P946TrQB+gzpGItLnMMHqrcM1TvlFGveRKH1eT9vzjwO7
	Q3k3RhVk46DkYjUsVmJHt23jF6wcdLHacpAGvBNZQW34B1HxH4rkPpVlPJ0g1dc91JDqfV66RLk7O
	5rdNYcaq9cBDLrm3vsvaMG5c2xzR0lezmcnrWE/9/dZMgwl4BeEZ3fvxc5FO4yHd6ogoyzn+jg8EJ
	rMYMIg/PX8yhWZhpl3IIoFJ33YgGYRzqb3c9XfM96YuIa5xEXBe5EYGCqMr2A/4p0j4MwYC2kdbDb
	UeI9fWXA==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <emfox@debian.org>)
	id 1xTDjn-000NOj-0U;
	Tue, 17 Nov 2026 07:36:19 +0000
From: Emfox Zhou <emfox@debian.org>
To: Even Xu <even.xu@intel.com>,
	Xinpeng Sun <xinpeng.sun@intel.com>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v6 2/5] HID: intel-thc-hid: intel-ipts: receive reports
Date: Tue, 17 Nov 2026 15:35:51 +0800
Message-ID: <20261117073554.11557-3-emfox@debian.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261117073554.11557-1-emfox@debian.org>
References: <20261117073554.11557-1-emfox@debian.org>
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

Configure the receive and transmit DMA engines, take the port interrupt
and decode the frames that arrive.

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
handler: thc_rxdma_reset() takes the bus lock, and the core's write path
holds that lock while it waits for the very completion the handler
delivers. The port stays masked while that item runs, so a run that still
reaches the thread only drains the status registers and leaves the ring
alone: masking alone would not stop it, as another function on the shared
pin can wake the handler. The thread masks the port on entry as well,
because a sharer can queue a second run through IRQTF_RUNTHREAD with no
hardirq of ours in between.

Every frame carries a code and a length in front of the payload. The
receive side decodes that header and logs each frame.

Three details of the bring-up are worth spelling out:

  - The interrupt configuration has to be applied before the DMA engines
    are started: it programs the device interrupt type field to the
    invalid value, and starting the receive engine then replaces that
    field with the type it expects. The other order would leave the
    invalid value in place.

  - An event that arrives while the thread runs leaves nothing behind but
    its status bit, so the handler drains the status registers instead of
    trusting a single delivery: a write completion taken for granted this
    way makes the next transfer wait for a completion that never comes,
    and the port stays unusable until it is reset.

  - Bulk transfers have no address phase, so the SPI opcode is zero. The
    opcodes the HIDSPI path uses make this controller ignore the frames
    altogether.

The frame size the controller reports is bounded by the receive ring, one
page per PRD entry: a port that asks for a larger buffer is refused with
an explicit error instead of failing in sgl_alloc().

The reset covers the host side only and leaves the PRD table descriptors
the controller rewrites in place: taking a frame puts its entry back, but
a frame that is not read keeps the length the controller wrote, and the
next frame that does not fit ends in a PRD overrun. intel-quickspi and
intel-quicki2c recover through the same call and have the same gap.
Restoring those descriptors is the core's job, not this driver's, and a
separate change to intel-thc does it.

Signed-off-by: Emfox Zhou <emfox@debian.org>
---
 drivers/hid/intel-thc-hid/intel-ipts/ipts.c   | 271 ++++++++++++++++++
 drivers/hid/intel-thc-hid/intel-ipts/ipts.h   |  21 ++
 .../hid/intel-thc-hid/intel-ipts/pci-ipts.c   |  34 +++
 3 files changed, 326 insertions(+)

diff --git a/drivers/hid/intel-thc-hid/intel-ipts/ipts.c b/drivers/hid/intel-thc-hid/intel-ipts/ipts.c
index 696a33d17..2265d0735 100644
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
@@ -17,9 +22,19 @@
 /* Slowest clock the core can program, used until the controller is read. */
 #define THC_IPTS_BOOT_SPI_HZ		THC_IPTS_SPI_MIN_HZ
 
+/* One page per PRD entry; a larger frame cannot be received. */
+#define THC_IPTS_RX_MAX			(PRD_ENTRIES_NUM * SZ_4K)
+
 /* Time the controller needs after reset before it answers on the bus. */
 #define THC_IPTS_BOOT_MS		100
 
+/*
+ * The core stops at the first error cause and reports the rest as a mask, so
+ * reading until it finds nothing can take a pass per cause plus one that
+ * confirms the status is drained.
+ */
+#define THC_IPTS_IRQ_PASSES		(THC_UNKNOWN_INT + 1)
+
 static int thc_ipts_read_cfg(struct thc_ipts *idev)
 {
 	int ret, try;
@@ -129,6 +144,235 @@ static int thc_ipts_touch_set(struct thc_ipts *idev, bool enable)
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
+static int thc_ipts_resize(struct thc_ipts *idev, u8 **buf, size_t *have,
+			   size_t want)
+{
+	u8 *p;
+
+	if (*have >= want)
+		return 0;
+
+	p = devm_krealloc(idev->dev, *buf, want, GFP_KERNEL);
+	if (!p)
+		return -ENOMEM;
+
+	*buf = p;
+	*have = want;
+
+	return 0;
+}
+
+static int thc_ipts_dma_start(struct thc_ipts *idev)
+{
+	int ret;
+
+	/*
+	 * The receive ring has one page per PRD entry and the core refuses a
+	 * frame that needs more: bound it here, or the port fails with a bare
+	 * allocation error from sgl_alloc().
+	 */
+	if (idev->max_rx > THC_IPTS_RX_MAX) {
+		dev_err(idev->dev, "receive buffer of %zu bytes is too large\n",
+			idev->max_rx);
+		return -ENODEV;
+	}
+
+	/*
+	 * A resume can report larger limits than the probe did, and the
+	 * engines would then write past the end. Follow them on every start;
+	 * the receive buffer is rounded up because the core rounds to a page.
+	 */
+	ret = thc_ipts_resize(idev, &idev->rx_frame, &idev->buf_rx,
+			      round_up(idev->max_rx, SZ_4K));
+	if (ret)
+		return ret;
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
+	/* Nothing of ours is pending: the cause belongs to a sharer. */
+	if (!READ_ONCE(idev->dma_ready))
+		return IRQ_NONE;
+
+	/*
+	 * A reset or a teardown in flight still gets the thread: the status it
+	 * drains is where a pending transmit completion is delivered, and a
+	 * write waiting for that one holds the bus lock the reset needs.
+	 */
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
+/* Publish the reset before masking: a sender that misses the flag starts a
+ * write whose completion the mask then takes away.
+ */
+static void thc_ipts_request_recover(struct thc_ipts *idev)
+{
+	if (READ_ONCE(idev->recovering))
+		return;
+
+	WRITE_ONCE(idev->recovering, true);
+	thc_interrupt_enable(idev->thc, false);
+	schedule_work(&idev->recover_work);
+}
+
+/*
+ * From a work item: the reset waits for the bus lock a pending write holds
+ * until the threaded handler delivers its completion.
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
+	/* The reset drops whatever the engines had queued. */
+	WRITE_ONCE(idev->recover_seq, READ_ONCE(idev->recover_seq) + 1);
+	WRITE_ONCE(idev->recovering, false);
+	if (!READ_ONCE(idev->stopping))
+		thc_interrupt_enable(idev->thc, true);
+}
+
+irqreturn_t thc_ipts_thread(int irq, void *data)
+{
+	struct thc_ipts *idev = data;
+	irqreturn_t ret = IRQ_NONE;
+	bool need_recover = false;
+	int pass;
+
+	/* A sharer can queue a second run of this thread with no hardirq of
+	 * ours in between: mask again, the write is idempotent. The port then
+	 * stays masked, so a cause that arrives meanwhile leaves only its
+	 * status bit.
+	 */
+	thc_interrupt_enable(idev->thc, false);
+
+	for (pass = 0; pass < THC_IPTS_IRQ_PASSES; pass++) {
+		int mask = thc_interrupt_handler(idev->thc);
+
+		if (mask == BIT(THC_UNKNOWN_INT))
+			break;
+
+		ret = IRQ_HANDLED;
+		if (mask & (BIT(THC_FATAL_ERR_INT) | BIT(THC_TXN_ERR_INT))) {
+			dev_err(idev->dev,
+				"transfer error, resetting the engine\n");
+			/* The teardown has its own reset to wait for. */
+			if (!READ_ONCE(idev->stopping))
+				need_recover = true;
+			/* The core stops at the first cause: a Tx completion
+			 * behind the error would time out under the bus lock.
+			 */
+			continue;
+		}
+
+		/* A reset is in flight or the port is going away: the ring is
+		 * not ours to read, only its status was.
+		 */
+		if (need_recover || READ_ONCE(idev->recovering) ||
+		    READ_ONCE(idev->stopping))
+			continue;
+
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
+	if (!READ_ONCE(idev->stopping) && !READ_ONCE(idev->recovering))
+		thc_interrupt_enable(idev->thc, true);
+
+	return ret;
+}
+
 /**
  * thc_ipts_port_start - bring one port up
  * @idev: port to start
@@ -138,6 +382,9 @@ int thc_ipts_port_start(struct thc_ipts *idev)
 	u32 ctrl, hz, mode;
 	int ret;
 
+	WRITE_ONCE(idev->stopping, false);
+	WRITE_ONCE(idev->recovering, false);
+
 	ret = thc_ipts_quiesce(idev, true);
 	if (ret)
 		return ret;
@@ -220,6 +467,15 @@ int thc_ipts_port_start(struct thc_ipts *idev)
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
 
@@ -229,6 +485,19 @@ int thc_ipts_port_start(struct thc_ipts *idev)
  */
 void thc_ipts_port_stop(struct thc_ipts *idev)
 {
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
 
@@ -237,4 +506,6 @@ void thc_ipts_port_stop(struct thc_ipts *idev)
 	regmap_write_bits(idev->thc->thc_regmap, THC_M_PRT_CONTROL_OFFSET,
 			  THC_M_PRT_CONTROL_DEVRST, 0);
 	thc_ipts_quiesce(idev, true);
+
+	thc_ipts_dma_stop(idev);
 }
diff --git a/drivers/hid/intel-thc-hid/intel-ipts/ipts.h b/drivers/hid/intel-thc-hid/intel-ipts/ipts.h
index b4ce633fc..f0f1652d9 100644
--- a/drivers/hid/intel-thc-hid/intel-ipts/ipts.h
+++ b/drivers/hid/intel-thc-hid/intel-ipts/ipts.h
@@ -8,6 +8,7 @@
 #include <linux/device.h>
 #include <linux/interrupt.h>
 #include <linux/types.h>
+#include <linux/wait.h>
 
 #include "intel-thc-dev.h"
 
@@ -95,24 +96,44 @@ static_assert(offsetof(struct thc_ipts_cfg, vendor) == 0x1c);
  * struct thc_ipts - state of one THC port in IPTS mode
  * @dev: device used for resources and logging
  * @thc: shared THC core context
+ * @irq: interrupt line of the port
  * @cfg: configuration block last read from the controller
  * @vendor: vendor ID the controller reports for its HID device
  * @product: product ID the controller reports for its HID device
  * @max_rx: largest frame the controller may send, in bytes
  * @max_tx: largest frame the driver may send, in bytes
+ * @buf_rx: allocated size of @rx_frame
+ * @rx_frame: buffer for one received frame, including its header
+ * @recover_work: resets the receive engine after a transfer error
  * @running: the controller answered and is out of reset
+ * @dma_ready: DMA engines are configured and may be used
+ * @recovering: a reset is queued or running, ignore the interrupt
+ * @recover_seq: number of resets that ran, to tell a dropped answer apart
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
+	size_t			buf_rx;
+	u8			*rx_frame;
+	struct work_struct	recover_work;
 	bool			running;
+	bool			dma_ready;
+	bool			recovering;
+	unsigned int		recover_seq;
+	bool			stopping;
 };
 
+irqreturn_t thc_ipts_hardirq(int irq, void *data);
+irqreturn_t thc_ipts_thread(int irq, void *data);
+void thc_ipts_recover(struct work_struct *work);
+
 int thc_ipts_port_start(struct thc_ipts *idev);
 void thc_ipts_port_stop(struct thc_ipts *idev);
 
diff --git a/drivers/hid/intel-thc-hid/intel-ipts/pci-ipts.c b/drivers/hid/intel-thc-hid/intel-ipts/pci-ipts.c
index 48046cd12..005b56234 100644
--- a/drivers/hid/intel-thc-hid/intel-ipts/pci-ipts.c
+++ b/drivers/hid/intel-thc-hid/intel-ipts/pci-ipts.c
@@ -46,6 +46,7 @@ static int thc_ipts_probe(struct pci_dev *pci, const struct pci_device_id *id)
 
 	idev->dev = &pci->dev;
 	pci_set_drvdata(pci, idev);
+	INIT_WORK(&idev->recover_work, thc_ipts_recover);
 
 	ret = pcim_enable_device(pci);
 	if (ret) {
@@ -77,9 +78,37 @@ static int thc_ipts_probe(struct pci_dev *pci, const struct pci_device_id *id)
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
+		return ret;
+	}
+
 	ret = thc_ipts_port_start(idev);
 	if (ret) {
 		thc_ipts_port_stop(idev);
+		devm_free_irq(idev->dev, idev->irq, idev);
 		return ret;
 	}
 
@@ -97,6 +126,11 @@ static void thc_ipts_remove(struct pci_dev *pci)
 	struct thc_ipts *idev = pci_get_drvdata(pci);
 
 	thc_ipts_port_stop(idev);
+
+	/* The handler has to go before the vector it is bound to is freed;
+	 * the vectors themselves belong to pcim_enable_device().
+	 */
+	devm_free_irq(idev->dev, idev->irq, idev);
 	pci_clear_master(pci);
 }
 
