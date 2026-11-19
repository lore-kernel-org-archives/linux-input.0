Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=82.195.75.108
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795079548;
	b=GwNkPXcRtY1Kumf17txa4FlAtpZyje+jxSylGV5xU/rmxLtWvJ01bDYjNKRmH4ssEvxP
	 iQY+6D0YGa1JQwCg/2ahV7DQtEP77v4Mhlhwqwx9rEfMRbuOZsIKVk+sJjFWpne4eC/8m
	 N2EtjqIJVmdXbJiUaY3UstfMQbVrk++Uk+2X2pX3CDkJjC8ppIFggWC4I5sryx3caC4SY
	 fD/zzeSc6x7F+lEA3AjbdiVpLEe/odzihzHSwyK+L9a9Eca/xtmT6Ttx33MiJb5KlmgHI
	 1zTsPIln3WB7AGOvGWZWKF/Jvlu3JFIjJjHDdMJPO1KfTEh7GydQ40X0A57dg0hHKaQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795079548;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Debian-User;
	bh=Bp0MGcKxQVkvveLvQD8Ni8odrXIAU1HFAuNuTqIvpjI=;
	b=Kvmrxi8h9uDRONOWkvjZgxc5VXiRJEKtKs4xkJncKX0H7eFAEBy1i2kQbwsedD09ee6A
	 uSXggIpmleLoWiU6hY3Soxl+KNzohqZbKvnaae5F1e98FybC+rXUQ58/FhlnQi87Gu56b
	 GNR/Mc84WL9MyGqllAoAWFKxbCV7TqOecDCPIVu4wir6+ULp6c1QF6yKsLAsc6TRH3gLy
	 dohQ8WSLzrZ3LuSVlIJbAvaixBnNgRX5UGlotMDh1tFZS/FVpSPCAX5ROtHDjRFjJxrsC
	 MsWopHL3ueYhFUIVCelA19v/Bm9shqdyxwiJ9lrMIX4t3HfVzzu+8kIA+pQk8UJDl4w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=debian.org;
	spf=pass smtp.mailfrom=debian.org;
	dkim=pass header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=Ju++R24F;
	arc=none smtp.remote-ip=82.195.75.108
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FC73606A325;
	Thu, 19 Nov 2026 09:12:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5FC73606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=Ju++R24F
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=Bp0MGcKxQVkvveLvQD8Ni8odrXIAU1HFAuNuTqIvpjI=; b=Ju++R24FZOusXpLeQZ9TImydOj
	arcvorToTBoA22SxvO2xVC7nlobXjRM0V+Kf6zIt/FY/4m+pTtM1yVf7kQCDft7BvEYfgIb4/ieuN
	GBH50lD4cb+tLyITf3933G0GpNCiDjiPctBkr+E6JZGO/GrQg+KMRptonORvqI01HxKqEDR5dL7RH
	B3HIwossgv0yQRS2Byq5qutCEzFzW8tgT8Np0hm/Ah2Vu3B19SEEqxnZeCKh+GhYmQiK8e1QewT4v
	Vuksxb+cfQ+a/iG8LzkWnKQsdoHCCI2qVGBoyAwTOWdTKjoeh/kSWwlmR+hmQtTZzHXLfVJEFnQJH
	mjfv6eOw==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <emfox@debian.org>)
	id 1xTyBq-001yxz-2B;
	Thu, 19 Nov 2026 09:12:23 +0000
From: Emfox Zhou <emfox@debian.org>
To: Even Xu <even.xu@intel.com>,
	Xinpeng Sun <xinpeng.sun@intel.com>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v9 2/5] HID: intel-thc-hid: intel-ipts: receive reports
Date: Thu, 19 Nov 2026 17:11:49 +0800
Message-ID: <20261119091152.470384-3-emfox@debian.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261119091152.470384-1-emfox@debian.org>
References: <20261119091152.470384-1-emfox@debian.org>
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
delivers. The port is masked as soon as the reset is queued, and the
threaded handler stops touching the status registers once the reset runs:
acknowledging a frame it is not going to read would lose the interrupt
that announces it again. The thread masks the port on entry as well,
because a sharer can queue a second run through IRQTF_RUNTHREAD with no
hardirq of ours in between. A run that is already inside can unmask just
before the wait for it returns, so the reset masks the line once more
before it touches the engines, and the thread leaves the line open only
when neither a reset nor a teardown is in flight.

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
 drivers/hid/intel-thc-hid/intel-ipts/ipts.c   | 319 ++++++++++++++++++
 drivers/hid/intel-thc-hid/intel-ipts/ipts.h   |  26 ++
 .../hid/intel-thc-hid/intel-ipts/pci-ipts.c   |  40 +++
 3 files changed, 385 insertions(+)

diff --git a/drivers/hid/intel-thc-hid/intel-ipts/ipts.c b/drivers/hid/intel-thc-hid/intel-ipts/ipts.c
index 2d14e5278..e7896b16f 100644
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
@@ -129,6 +144,283 @@ static int thc_ipts_touch_set(struct thc_ipts *idev, bool enable)
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
+	/* Nothing of ours is pending: the cause belongs to a sharer. */
+	if (!READ_ONCE(idev->dma_ready))
+		return IRQ_NONE;
+
+	/* Level triggered and shared: mask first, or it stays asserted. */
+	thc_interrupt_enable(idev->thc, false);
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
+/*
+ * Refuse new requests and queue the reset. The line stays open: a write that
+ * is already waiting for its completion needs this interrupt, and the work
+ * item takes the port once that write is done.
+ */
+static void thc_ipts_request_recover(struct thc_ipts *idev)
+{
+	if (READ_ONCE(idev->recover_pending))
+		return;
+
+	WRITE_ONCE(idev->recover_pending, true);
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
+	/*
+	 * From here the status registers belong to the reset: the threaded
+	 * handler must not acknowledge a frame it is not going to read, or the
+	 * interrupt that would announce it again never comes. The flag alone
+	 * is only a snapshot to a run that is already inside, so the mask and
+	 * the wait below are what keeps that run out.
+	 */
+	WRITE_ONCE(idev->recovering, true);
+	thc_interrupt_enable(idev->thc, false);
+	synchronize_irq(idev->irq);
+	/* A run that unmasked just before synchronize_irq() returned leaves
+	 * the line open: mask it again, the write is idempotent.
+	 */
+	thc_interrupt_enable(idev->thc, false);
+
+	if (thc_rxdma_reset(idev->thc)) {
+		/* Nothing left: keep the port masked until it restarts. */
+		dev_err(idev->dev, "cannot reset the receive engine\n");
+		return;
+	}
+
+	/* The reset drops whatever the engines had queued. A run of the
+	 * handler that sees ->recovering clear must not be turned away by
+	 * ->recover_pending afterwards, so that one is cleared first.
+	 */
+	WRITE_ONCE(idev->recover_seq, READ_ONCE(idev->recover_seq) + 1);
+	WRITE_ONCE(idev->recover_pending, false);
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
+	bool reported = false;
+	int pass;
+
+	/* Reports are handed to the HID core from here, and a driver callback
+	 * that sends a request would wait for a completion this very thread
+	 * delivers: it is recorded so the send path can tell.
+	 */
+	WRITE_ONCE(idev->irq_thread, current);
+
+	/* A sharer can queue a second run of this thread with no hardirq of
+	 * ours in between: mask again, the write is idempotent.
+	 */
+	thc_interrupt_enable(idev->thc, false);
+
+	/* The port stays masked, so a cause that arrives meanwhile leaves only
+	 * its status bit: read until the core reports none.
+	 */
+	for (pass = 0; pass < THC_IPTS_IRQ_PASSES; pass++) {
+		int mask;
+
+		/*
+		 * The reset owns the status registers while it runs: a frame
+		 * acknowledged here but not read is never announced again.
+		 */
+		if (READ_ONCE(idev->recovering)) {
+			/* Nothing acknowledged, but the line is still ours. */
+			ret = IRQ_HANDLED;
+			break;
+		}
+
+		mask = thc_interrupt_handler(idev->thc);
+
+		if (mask == BIT(THC_UNKNOWN_INT))
+			break;
+
+		ret = IRQ_HANDLED;
+		if (mask & (BIT(THC_FATAL_ERR_INT) | BIT(THC_TXN_ERR_INT))) {
+			/* An overrun raises this for every frame until the
+			 * reset takes the port: report the first one only.
+			 */
+			if (!reported) {
+				dev_err(idev->dev,
+					"transfer error, resetting the engine\n");
+				reported = true;
+			}
+			/* The teardown has its own reset to wait for. */
+			if (!READ_ONCE(idev->stopping))
+				need_recover = true;
+			/* The core stops at the first cause: a Tx completion
+			 * behind the error would time out under the bus lock.
+			 */
+			continue;
+		}
+
+		/* A reset is queued or running, or the port is going away: the
+		 * ring is not ours to read, only its status was.
+		 */
+		if (need_recover || READ_ONCE(idev->recover_pending) ||
+		    READ_ONCE(idev->recovering) ||
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
+	/* A reset unmasks when it is done and a teardown masks on its own, so
+	 * the line only stays open here while neither runs: a write already
+	 * on the wire needs the completion this handler delivers.
+	 */
+	if (!READ_ONCE(idev->recovering) && !READ_ONCE(idev->stopping))
+		thc_interrupt_enable(idev->thc, true);
+
+	return ret;
+}
+
 /**
  * thc_ipts_port_start - bring one port up
  * @idev: port to start
@@ -138,6 +430,9 @@ int thc_ipts_port_start(struct thc_ipts *idev)
 	u32 ctrl, hz, mode;
 	int ret;
 
+	WRITE_ONCE(idev->stopping, false);
+	WRITE_ONCE(idev->recovering, false);
+
 	ret = thc_ipts_quiesce(idev, true);
 	if (ret)
 		return ret;
@@ -220,6 +515,15 @@ int thc_ipts_port_start(struct thc_ipts *idev)
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
 
@@ -229,6 +533,19 @@ int thc_ipts_port_start(struct thc_ipts *idev)
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
 
@@ -237,4 +554,6 @@ void thc_ipts_port_stop(struct thc_ipts *idev)
 	regmap_write_bits(idev->thc->thc_regmap, THC_M_PRT_CONTROL_OFFSET,
 			  THC_M_PRT_CONTROL_DEVRST, 0);
 	thc_ipts_quiesce(idev, true);
+
+	thc_ipts_dma_stop(idev);
 }
diff --git a/drivers/hid/intel-thc-hid/intel-ipts/ipts.h b/drivers/hid/intel-thc-hid/intel-ipts/ipts.h
index b4ce633fc..0a14ec4e8 100644
--- a/drivers/hid/intel-thc-hid/intel-ipts/ipts.h
+++ b/drivers/hid/intel-thc-hid/intel-ipts/ipts.h
@@ -7,7 +7,9 @@
 #include <linux/build_bug.h>
 #include <linux/device.h>
 #include <linux/interrupt.h>
+#include <linux/sched.h>
 #include <linux/types.h>
+#include <linux/wait.h>
 
 #include "intel-thc-dev.h"
 
@@ -95,24 +97,48 @@ static_assert(offsetof(struct thc_ipts_cfg, vendor) == 0x1c);
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
+ * @recover_pending: a reset is wanted, refuse new requests
+ * @recovering: a reset is queued or running, ignore the interrupt
+ * @recover_seq: number of resets that ran, to tell a dropped answer apart
+ * @stopping: the port is being torn down, ignore the interrupt
+ * @irq_thread: thread the port interrupt is handled in, once it has run
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
+	bool			recover_pending;
+	bool			recovering;
+	unsigned int		recover_seq;
+	bool			stopping;
+	struct task_struct	*irq_thread;
 };
 
+irqreturn_t thc_ipts_hardirq(int irq, void *data);
+irqreturn_t thc_ipts_thread(int irq, void *data);
+void thc_ipts_recover(struct work_struct *work);
+
 int thc_ipts_port_start(struct thc_ipts *idev);
 void thc_ipts_port_stop(struct thc_ipts *idev);
 
diff --git a/drivers/hid/intel-thc-hid/intel-ipts/pci-ipts.c b/drivers/hid/intel-thc-hid/intel-ipts/pci-ipts.c
index 48046cd12..1670d116a 100644
--- a/drivers/hid/intel-thc-hid/intel-ipts/pci-ipts.c
+++ b/drivers/hid/intel-thc-hid/intel-ipts/pci-ipts.c
@@ -46,6 +46,7 @@ static int thc_ipts_probe(struct pci_dev *pci, const struct pci_device_id *id)
 
 	idev->dev = &pci->dev;
 	pci_set_drvdata(pci, idev);
+	INIT_WORK(&idev->recover_work, thc_ipts_recover);
 
 	ret = pcim_enable_device(pci);
 	if (ret) {
@@ -77,9 +78,43 @@ static int thc_ipts_probe(struct pci_dev *pci, const struct pci_device_id *id)
 	if (IS_ERR(idev->thc))
 		return PTR_ERR(idev->thc);
 
+	/*
+	 * Firmware may leave the global enable set, and the line is shared and
+	 * level triggered: mask it until a handler is in place.
+	 */
+	thc_interrupt_enable(idev->thc, false);
+
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
 
@@ -97,6 +132,11 @@ static void thc_ipts_remove(struct pci_dev *pci)
 	struct thc_ipts *idev = pci_get_drvdata(pci);
 
 	thc_ipts_port_stop(idev);
+
+	/* The handler has to go before the vector it is bound to is freed;
+	 * the vectors themselves belong to pcim_enable_device().
+	 */
+	devm_free_irq(idev->dev, idev->irq, idev);
 	pci_clear_master(pci);
 }
 
