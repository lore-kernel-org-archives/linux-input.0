Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=82.195.75.108
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795794741;
	b=4y7D9/Qp+CwaeZxBr1t/7bRCOugDq52xzD5Xl5zp0H9fXlz4cFlWei+Jo7U8Wi5VNYCV
	 mgfc6cwBlp+awPFf1Bzy8cpNRuiKmEYLLTh4fYSYgPu2bGfHNFjVXve8m2Gw53YVXh/NH
	 6YTzIKMsaRLWs5t+QQWtuG/ETVc6MGCvMfYt7EzUeS4OJcEZwIu0RwuP5xRkbnkTN2wxD
	 XVBBVffDRIe7sVgzy0zKhpA8lQbRvsfASjG+/zEXX/ORRud5XuhnCKwiKB4y16+93M3bn
	 femngsGd+cW/5zT0gNoU6pRxtixgwJP4dpFicH19n9WJxyC4CTpIqf36n3NKL0+HCdQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795794741;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Debian-User;
	bh=Aml54GtTYlRDTPhbXM5R9Hz3Z2j8mhnpTOpwmxCJxoA=;
	b=xAAKnYKh8r0zSaWEtKvLs4+MxsgB8575/2Oyox2j2ne8CoSrWNa63Op6Ur2b7AiIHdKJ
	 01lwdY/kWsCZnbp3kyH+e7cQ7F5cKLTszyXC6tJ+V3Lk/eCT7+0H+rMJ0a8CFFRATvix7
	 OX41J5roLqQ90uKscr//HUAJTgCg/Xu5Ho6AFfijCwqnmwRb3Ql/bqhESQzW/G/BNtvW4
	 bmGbQ0w7z/MYkii4AEmnoHVRIP+D7sBqwz+oi/FrpBgaMuWU8DI+ITMEb2LBjhzo25OFS
	 pPIuup1BKs+vDlB0yCPjXHoD83zJkTcobVRRs7b0u3FrSxjbt0mA/bjYA498HKbaL/A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=debian.org;
	spf=pass smtp.mailfrom=debian.org;
	dkim=pass header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=pCSx3xiM;
	arc=none smtp.remote-ip=82.195.75.108
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87FEE606A31C;
	Fri, 27 Nov 2026 15:52:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 87FEE606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=pCSx3xiM
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=Aml54GtTYlRDTPhbXM5R9Hz3Z2j8mhnpTOpwmxCJxoA=; b=pCSx3xiMOfBGNcxZOZvrZ8ut1C
	Sq2fOqXXCI0hV7vFtpq/NS1NGQnXWgkELaFGNtziX+RDaXt8lZfmUlpGSrIUPuabNne1SwLg/Q133
	24kFMGoZZ5RWL1OjuvJLvvX9mmvPcCZPY/W4rr0+84p/GbzzBKf+io1ERDjhyswpdQ5zHEvmvuk6X
	DZFbAr3bGjWYMMkZa1i4qYsibUuROdnDj4ju/8lRpk/37NRkqxpwMrLebVSFWdMPqvk0Ht/JycLo2
	goiygwrHuyRdhJ2Q29CFCTvvhIt+FhtpGIAl99iYQeQgnlvTGmVNxpqL0QFqxvFUPKzI4rmuF6SWG
	nJM7Zg2g==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <emfox@debian.org>)
	id 1xWyFD-008RsE-0D;
	Fri, 27 Nov 2026 15:52:16 +0000
From: Emfox Zhou <emfox@debian.org>
To: Even Xu <even.xu@intel.com>,
	Xinpeng Sun <xinpeng.sun@intel.com>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v10 4/6] HID: intel-thc-hid: intel-ipts: add the HID device
Date: Fri, 27 Nov 2026 23:51:38 +0800
Message-ID: <f8529097ea0778363ba902af07f910036f7f5b94.1795794049.git.emfox@debian.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1795794049.git.emfox@debian.org>
References: <cover.1795794049.git.emfox@debian.org>
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

Register a HID device and let it own the handshake: the report descriptor
is not read once at probe and kept, it is asked for over the transport
whenever the HID core parses the device, and feature reports are fetched
the same way. Both need a lock that keeps one frame on the wire at a time,
a wait queue the answer is delivered on, and buffers for the answers. The
descriptor is asked for up to six times, 300 ms each; a request that finds
the port masked by a reset waits for that reset instead of spending a try.

A feature answer arrives as a frame of its own and carries only the report
ID back, which does not tell it from the answer to the next request for
the same report: nothing on the wire says which request a frame answers.
So the request is sent once, and a timeout shuts the channel until the
port is started again, the only point where controller and device are
known to agree. A reset is counted: an answer it dropped returns -EIO and
leaves the channel open, because that frame was never left out there. The
count is taken after the request is written, so a reset that finished
before the write is not taken for one that dropped this frame.
Resetting the engine instead would drop a late answer and the frame the
reset had queued.

The state is updated under a lock, so accepting an answer and consuming it
are one step; it is a mutex, because the answer is copied in the threaded
handler and can be as large as a receive frame. The waits happen outside
it: the thread that delivers an answer calls into the HID core on its way
and would otherwise wait for a lock the waiter holds, and one that sends a
request from there waits for a completion only it can deliver, so the send
path refuses that thread and serves every other context. A second feature
request while one is outstanding is refused rather than queued, for that
reason and because its answer could not be told from the first one's.

Requests are refused while a recovery is in flight: the port is masked, so
a write would wait out its one second timeout holding the bus lock the
reset needs. Teardown refuses new requests, then waits for one already
inside thc_dma_write(), which needs the interrupt the mask takes away; the
mask follows that wait, and the line is waited on once more after the
buffers are gone. The transmit lock is not held across synchronize_irq():
the threaded handler can issue a request of its own from a HID callback.

The threaded handler leaves the line open whenever no reset is running,
teardown included: that very run is what the teardown waits for before it
masks, and masking here would take away the completion a write already on
the wire needs, which the teardown then waits for over the bus lock.

Input reports go straight to the input layer and the raw stream is
available through hidraw, where decoding belongs: the reports carry a
heatmap, and turning it into contacts needs floating point arithmetic the
kernel cannot do. The controller starts streaming once user space asks for
it, through a set feature request on report 5.

Signed-off-by: Emfox Zhou <emfox@debian.org>
---
 drivers/hid/intel-thc-hid/Kconfig             |   3 +-
 drivers/hid/intel-thc-hid/intel-ipts/ipts.c   | 480 +++++++++++++++++-
 drivers/hid/intel-thc-hid/intel-ipts/ipts.h   |  56 ++
 .../hid/intel-thc-hid/intel-ipts/pci-ipts.c   |   3 +
 4 files changed, 519 insertions(+), 23 deletions(-)

diff --git a/drivers/hid/intel-thc-hid/Kconfig b/drivers/hid/intel-thc-hid/Kconfig
index 40e3ce198..1afcc975b 100644
--- a/drivers/hid/intel-thc-hid/Kconfig
+++ b/drivers/hid/intel-thc-hid/Kconfig
@@ -48,7 +48,8 @@ config INTEL_IPTS
 	  drive the touch controller over plain SPI and carry its reports in a
 	  private framing. This driver brings such a port up and reads the
 	  controller's configuration block, which describes the report
-	  framing.
+	  framing. It then exposes the reports as a HID device, so that a
+	  decoder in user space can turn them into input events.
 
 	  Say Y/M here if you have an Intel touch controller that runs in IPTS
 	  mode. If unsure, say N.
diff --git a/drivers/hid/intel-thc-hid/intel-ipts/ipts.c b/drivers/hid/intel-thc-hid/intel-ipts/ipts.c
index f5f2cb3d2..506d2f330 100644
--- a/drivers/hid/intel-thc-hid/intel-ipts/ipts.c
+++ b/drivers/hid/intel-thc-hid/intel-ipts/ipts.c
@@ -3,7 +3,9 @@
  * Transport for THC ports in IPTS mode: plain SPI with a private framing.
  */
 
+#include <linux/cleanup.h>
 #include <linux/delay.h>
+#include <linux/hid.h>
 #include <linux/interrupt.h>
 #include <linux/minmax.h>
 #include <linux/sizes.h>
@@ -116,8 +118,100 @@ static int thc_ipts_touch_set(struct thc_ipts *idev, bool enable)
 				 &touch);
 }
 
+/*
+ * Frames are built in @idev->tx_frame, so the lock is taken here rather than
+ * by the callers: none of them may hold it across a wait.
+ */
+static int thc_ipts_send(struct thc_ipts *idev, u32 code, const void *data,
+			 size_t len, unsigned int *seq)
+{
+	size_t padded = round_up(len, 4);
+	u8 *frame = idev->tx_frame;
+	int ret;
+
+	/* The completion of a write is delivered by the threaded handler, so
+	 * one issued from there would wait out its timeout: refuse it instead,
+	 * and let the caller retry from its own context. The check is against
+	 * the thread itself, not a flag it sets: a request from any other
+	 * context is served while the handler runs.
+	 */
+	if (current == READ_ONCE(idev->irq_thread))
+		return -EBUSY;
+
+	guard(mutex)(&idev->tx_lock);
+
+	if (READ_ONCE(idev->stopping))
+		return -ESHUTDOWN;
+	/* A reset is queued or running: the write would only time out. */
+	if (READ_ONCE(idev->recover_pending) || READ_ONCE(idev->recovering))
+		return -EAGAIN;
+	/* No engine to write into: waiting for a reset would not help. */
+	if (READ_ONCE(idev->state) < THC_IPTS_DMA)
+		return -ENODEV;
+	if (THC_IPTS_TX_HDR_SIZE + padded > idev->max_tx)
+		return -EMSGSIZE;
+
+	put_unaligned_le32(code, frame);
+	put_unaligned_le32((u32)len, frame + 4);
+	memset(frame + THC_IPTS_TX_HDR_SIZE, 0, padded);
+	if (len && data)
+		memcpy(frame + THC_IPTS_TX_HDR_SIZE, data, len);
+
+	ret = thc_dma_write(idev->thc, frame, THC_IPTS_TX_HDR_SIZE + padded);
+	/*
+	 * Taken under this lock, once the frame is on the wire: a reset has to
+	 * take it before it runs, so a change from here on belongs to one that
+	 * started after the write and dropped whatever this frame was going to
+	 * get. Reading it earlier would cover a reset that the frame met on a
+	 * clean engine, and one that it did not.
+	 */
+	if (!ret && seq)
+		*seq = READ_ONCE(idev->recover_seq);
+
+	return ret;
+}
+
+static void thc_ipts_descriptor(struct thc_ipts *idev, const u8 *data,
+				size_t len)
+{
+	/* One answer per request: a late reply must not overwrite it. */
+	if (len <= THC_IPTS_DESC_PREAMBLE || READ_ONCE(idev->have_desc))
+		return;
+
+	len = min(len - THC_IPTS_DESC_PREAMBLE, idev->max_rx);
+	memcpy(idev->desc, data + THC_IPTS_DESC_PREAMBLE, len);
+	idev->desc_len = len;
+	/* The bytes and the length have to land before the flag is seen. */
+	smp_store_release(&idev->have_desc, true);
+	wake_up(&idev->wq);
+}
+
+static void thc_ipts_feature(struct thc_ipts *idev, const u8 *data,
+			     size_t len)
+{
+	if (!len)
+		return;
+
+	/* Only a frame that arrives while a request is waiting is taken. */
+	mutex_lock(&idev->feature_lock);
+	if (!idev->feature_pending ||
+	    (idev->feature_id && data[0] != idev->feature_id)) {
+		mutex_unlock(&idev->feature_lock);
+		return;
+	}
+
+	len = min(len, idev->max_rx);
+	memcpy(idev->feature, data, len);
+	idev->feature_len = len;
+	WRITE_ONCE(idev->feature_done, true);
+	mutex_unlock(&idev->feature_lock);
+
+	wake_up(&idev->wq);
+}
+
 static void thc_ipts_handle_frame(struct thc_ipts *idev, size_t len)
 {
+	const u8 *payload = idev->rx_frame + THC_IPTS_RX_HDR_SIZE;
 	size_t capacity = idev->max_rx - THC_IPTS_RX_HDR_SIZE;
 	u32 code, size;
 
@@ -126,11 +220,31 @@ static void thc_ipts_handle_frame(struct thc_ipts *idev, size_t len)
 
 	code = get_unaligned_le32(idev->rx_frame);
 	/* The header may claim more than what actually arrived. */
-	size = min_t(u32, get_unaligned_le32(idev->rx_frame + 4),
-		     capacity);
+	size = min_t(u32, get_unaligned_le32(idev->rx_frame + 4), capacity);
 	size = min_t(u32, size, len - THC_IPTS_RX_HDR_SIZE);
 
-	dev_dbg(idev->dev, "frame code %u, %u bytes\n", code, size);
+	switch (code) {
+	case THC_IPTS_RX_INPUT: {
+		struct hid_device *hdev = READ_ONCE(idev->hid);
+
+		if (hdev)
+			hid_safe_input_report(hdev, HID_INPUT_REPORT,
+					      (u8 *)payload, capacity, size, 1);
+		break;
+	}
+	case THC_IPTS_RX_DESC:
+		thc_ipts_descriptor(idev, payload, size);
+		break;
+	case THC_IPTS_RX_FEATURE:
+		thc_ipts_feature(idev, payload, size);
+		break;
+	case THC_IPTS_RX_RESET:
+		dev_warn(idev->dev, "controller asked for a reset\n");
+		break;
+	default:
+		dev_dbg(idev->dev, "frame code %u, %u bytes\n", code, size);
+		break;
+	}
 }
 
 static void thc_ipts_dma_stop(struct thc_ipts *idev)
@@ -183,9 +297,19 @@ static int thc_ipts_dma_start(struct thc_ipts *idev)
 	 */
 	ret = thc_ipts_resize(idev, &idev->rx_frame, &idev->buf_rx,
 			      round_up(idev->max_rx, SZ_4K));
+	if (!ret)
+		ret = thc_ipts_resize(idev, &idev->tx_frame, &idev->buf_tx,
+				      round_up(idev->max_tx, 4));
+	if (!ret)
+		ret = thc_ipts_resize(idev, &idev->desc, &idev->buf_desc,
+				      idev->max_rx);
+	if (!ret)
+		ret = thc_ipts_resize(idev, &idev->feature, &idev->buf_feat,
+				      idev->max_rx);
 	if (ret)
 		return ret;
 
+	/* Only RXDMA2 (in) and TXDMA (out) are used; the other two stay 0. */
 	ret = thc_dma_set_max_packet_sizes(idev->thc, 0, idev->max_rx,
 					   idev->max_tx, 0);
 	if (ret)
@@ -263,6 +387,8 @@ static void thc_ipts_request_recover(struct thc_ipts *idev)
 
 	WRITE_ONCE(idev->recover_pending, true);
 	schedule_work(&idev->recover_work);
+	/* A request waiting for the port looks at that flag. */
+	wake_up(&idev->wq);
 }
 
 /*
@@ -274,6 +400,15 @@ void thc_ipts_recover(struct work_struct *work)
 	struct thc_ipts *idev = container_of(work, struct thc_ipts,
 					     recover_work);
 
+	/*
+	 * A write that is already on the wire holds this lock and needs the
+	 * interrupt that the mask below takes away: let it finish first, or it
+	 * times out over the bus lock the reset is waiting for.
+	 */
+	mutex_lock(&idev->tx_lock);
+	WRITE_ONCE(idev->recovering, true);
+	mutex_unlock(&idev->tx_lock);
+
 	/*
 	 * From here the status registers belong to the reset: the threaded
 	 * handler must not acknowledge a frame it is not going to read, or the
@@ -281,7 +416,6 @@ void thc_ipts_recover(struct work_struct *work)
 	 * is only a snapshot to a run that is already inside, so the mask and
 	 * the wait below are what keeps that run out.
 	 */
-	WRITE_ONCE(idev->recovering, true);
 	thc_interrupt_enable(idev->thc, false);
 	synchronize_irq(idev->irq);
 	/* A run that unmasked just before synchronize_irq() returned leaves
@@ -299,6 +433,7 @@ void thc_ipts_recover(struct work_struct *work)
 		WRITE_ONCE(idev->recover_seq, READ_ONCE(idev->recover_seq) + 1);
 		WRITE_ONCE(idev->recover_pending, false);
 		WRITE_ONCE(idev->recovering, false);
+		wake_up(&idev->wq);
 		return;
 	}
 
@@ -309,6 +444,10 @@ void thc_ipts_recover(struct work_struct *work)
 	WRITE_ONCE(idev->recover_seq, READ_ONCE(idev->recover_seq) + 1);
 	WRITE_ONCE(idev->recover_pending, false);
 	WRITE_ONCE(idev->recovering, false);
+
+	/* A request waiting out the reset is looking at that flag. */
+	wake_up(&idev->wq);
+
 	if (!READ_ONCE(idev->stopping))
 		thc_interrupt_enable(idev->thc, true);
 }
@@ -354,10 +493,10 @@ irqreturn_t thc_ipts_thread(int irq, void *data)
 
 		ret = IRQ_HANDLED;
 		if (mask & (BIT(THC_FATAL_ERR_INT) | BIT(THC_TXN_ERR_INT))) {
-			/* An overrun raises this for every frame until the
-			 * reset takes the port: report the first one only.
+			/* An overrun raises this until the reset takes the
+			 * port: report the first one only.
 			 */
-			if (!reported) {
+			if (!reported && !READ_ONCE(idev->recover_pending)) {
 				dev_err(idev->dev,
 					"transfer error, resetting the engine\n");
 				reported = true;
@@ -383,24 +522,294 @@ irqreturn_t thc_ipts_thread(int irq, void *data)
 			need_recover = true;
 	}
 
-	/* The work item resets the engine and unmasks again; a frame read
-	 * meanwhile would corrupt the ring.
+	/*
+	 * The work item resets the engine in its own time; a frame read
+	 * meanwhile would corrupt the ring, so only queue the reset.
 	 */
-	if (need_recover) {
+	if (need_recover)
 		thc_ipts_request_recover(idev);
-		return IRQ_HANDLED;
-	}
 
-	/* A reset unmasks when it is done and a teardown masks on its own, so
-	 * the line only stays open here while neither runs: a write already
-	 * on the wire needs the completion this handler delivers.
+	/*
+	 * A reset unmasks when it is done, and a teardown masks on its own
+	 * after waiting for this very run. Leaving the line open here is what
+	 * a write already on the wire needs: this handler is where its
+	 * completion is delivered, and masking it away would make that write
+	 * time out over the bus lock the teardown is waiting for.
 	 */
-	if (!READ_ONCE(idev->recovering) && !READ_ONCE(idev->stopping))
+	if (!READ_ONCE(idev->recovering) && !READ_ONCE(idev->recover_pending))
 		thc_interrupt_enable(idev->thc, true);
 
 	return ret;
 }
 
+/* No reset is queued or running, and the port is not going away. */
+static bool thc_ipts_idle(const struct thc_ipts *idev)
+{
+	return !READ_ONCE(idev->recover_pending) &&
+	       !READ_ONCE(idev->recovering) &&
+	       !READ_ONCE(idev->stopping);
+}
+
+static int thc_ipts_hid_parse(struct hid_device *hdev)
+{
+	struct thc_ipts *idev = hdev->driver_data;
+	unsigned long timeout = msecs_to_jiffies(THC_IPTS_REQ_TIMEOUT_MS);
+	u64 zero = 0;
+	unsigned int retries = 0;
+	int ret;
+	int try = 0;
+
+	/* A descriptor from a previous start is not this one's. */
+	WRITE_ONCE(idev->have_desc, false);
+
+	while (try < THC_IPTS_REQ_TRIES) {
+		/* An answer that landed after a wait expired is taken here. */
+		if (smp_load_acquire(&idev->have_desc))
+			break;
+
+		/* The controller ignores the eight byte argument. */
+		ret = thc_ipts_send(idev, THC_IPTS_TX_GET_DESC, &zero,
+				    sizeof(zero), NULL);
+		/*
+		 * -EAGAIN is our own reset refusing the request. -ETIMEDOUT is
+		 * a write that was already on the wire when one started: its
+		 * completion went away with the mask. Both are worth another
+		 * try, a descriptor request carries nothing a late answer could
+		 * spoil.
+		 */
+		if (ret == -EAGAIN || ret == -ETIMEDOUT) {
+			if (++retries > THC_IPTS_REQ_TRIES ||
+			    !wait_event_timeout(idev->wq,
+						thc_ipts_idle(idev), timeout))
+				break;
+			continue;
+		}
+		if (ret)
+			return ret;
+
+		try++;
+		wait_event_timeout(idev->wq, READ_ONCE(idev->have_desc),
+				   timeout);
+	}
+
+	/* Pairs with the release in thc_ipts_descriptor(). */
+	if (smp_load_acquire(&idev->have_desc) && idev->desc_len > 0) {
+		/* The receive buffer holds more than a descriptor may be. */
+		if (idev->desc_len > HID_MAX_DESCRIPTOR_SIZE) {
+			dev_err(idev->dev,
+				"report descriptor of %zu bytes is too large\n",
+				idev->desc_len);
+			return -EINVAL;
+		}
+
+		return hid_parse_report(hdev, idev->desc, idev->desc_len);
+	}
+
+	dev_err(idev->dev, "controller did not return a report descriptor\n");
+
+	return -ETIMEDOUT;
+}
+
+/* A feature report comes back as a frame of its own: the request waits. */
+static int thc_ipts_get_feature(struct thc_ipts *idev, unsigned char reportnum,
+				u8 *buf, size_t len)
+{
+	unsigned long timeout = msecs_to_jiffies(THC_IPTS_REQ_TIMEOUT_MS);
+	/* Given by the send below, which only a frame that went out gets. */
+	unsigned int seq = 0;
+	int ret;
+
+	/*
+	 * One request at a time, and the wait below happens without a lock: a
+	 * request issued from a HID callback in the handler thread would be
+	 * waiting for an answer only that very thread can deliver. The gate is
+	 * released by whoever takes the answer, not by the frame that brings
+	 * it, or a second request could be answered into this one's buffer.
+	 */
+	mutex_lock(&idev->feature_lock);
+
+	/* The frame carries only the report ID, so a late answer cannot be
+	 * told from the next one's: after a timeout the channel stays shut.
+	 */
+	if (idev->feature_off) {
+		mutex_unlock(&idev->feature_lock);
+		return -EIO;
+	}
+	if (idev->feature_pending) {
+		mutex_unlock(&idev->feature_lock);
+		return -EBUSY;
+	}
+
+	WRITE_ONCE(idev->feature_done, false);
+	idev->feature_id = reportnum;
+	idev->feature_pending = true;
+	mutex_unlock(&idev->feature_lock);
+
+	/* A refusal happens before anything is written, so the channel stays
+	 * open for it; a timeout is a different matter, see below.
+	 */
+	ret = thc_ipts_send(idev, THC_IPTS_TX_GET_FEATURE, &reportnum, 1, &seq);
+	if (ret) {
+		mutex_lock(&idev->feature_lock);
+		idev->feature_pending = false;
+
+		/* The start bit was written before the wait, so the frame may
+		 * well be on the wire: its answer cannot be told from the next
+		 * request's one.
+		 */
+		if (ret == -ETIMEDOUT)
+			WRITE_ONCE(idev->feature_off, true);
+		mutex_unlock(&idev->feature_lock);
+
+		if (ret == -ETIMEDOUT)
+			dev_err(idev->dev, "feature report %u not acknowledged\n",
+				reportnum);
+
+		return ret;
+	}
+
+	wait_event_timeout(idev->wq, READ_ONCE(idev->feature_done) ||
+			   READ_ONCE(idev->recover_seq) != seq ||
+			   READ_ONCE(idev->recover_pending) ||
+			   READ_ONCE(idev->recovering) ||
+			   READ_ONCE(idev->stopping), timeout);
+
+	mutex_lock(&idev->feature_lock);
+	/* An answer that landed while the wait was expiring counts too. */
+	if (!idev->feature_done) {
+		/* A reset discards what the engines had queued, so an answer
+		 * that was on its way is gone and cannot be waited for.
+		 */
+		if (READ_ONCE(idev->recover_seq) != seq ||
+		    READ_ONCE(idev->recover_pending) ||
+		    READ_ONCE(idev->recovering) ||
+		    READ_ONCE(idev->stopping))
+			ret = -EIO;
+		else
+			ret = -ETIMEDOUT;
+
+		idev->feature_pending = false;
+		/* Only a timeout leaves a frame out there: after a reset the
+		 * answer was dropped and the channel is still in step.
+		 */
+		if (ret == -ETIMEDOUT)
+			WRITE_ONCE(idev->feature_off, true);
+		mutex_unlock(&idev->feature_lock);
+
+		if (ret == -ETIMEDOUT)
+			dev_err(idev->dev, "no feature report %u\n", reportnum);
+
+		return ret;
+	}
+
+	/* The payload is the report as user space writes it: ID first. */
+	len = min(len, idev->feature_len);
+	if (len)
+		memcpy(buf, idev->feature, len);
+	idev->feature_pending = false;
+	mutex_unlock(&idev->feature_lock);
+
+	return len ?: -EPROTO;
+}
+
+static int thc_ipts_hid_raw_request(struct hid_device *hdev,
+				    unsigned char reportnum, __u8 *buf,
+				    size_t len, unsigned char rtype,
+				    int reqtype)
+{
+	struct thc_ipts *idev = hdev->driver_data;
+	u32 code;
+	int ret;
+
+	if (!buf || !len)
+		return -EINVAL;
+
+	if (reqtype == HID_REQ_GET_REPORT && rtype == HID_FEATURE_REPORT)
+		return thc_ipts_get_feature(idev, reportnum, buf, len);
+
+	if (reqtype != HID_REQ_SET_REPORT ||
+	    (rtype != HID_OUTPUT_REPORT && rtype != HID_FEATURE_REPORT))
+		return -EOPNOTSUPP;
+
+	code = rtype == HID_OUTPUT_REPORT ? THC_IPTS_TX_OUTPUT :
+					    THC_IPTS_TX_SET_FEATURE;
+
+	ret = thc_ipts_send(idev, code, buf, len, NULL);
+	if (ret)
+		return ret;
+
+	/* raw_request returns the byte count, which hidraw forwards. */
+	return (int)len;
+}
+
+/* The HID core calls these unconditionally; nothing to do in this mode. */
+static int thc_ipts_hid_start(struct hid_device *hdev)
+{
+	return 0;
+}
+
+static void thc_ipts_hid_stop(struct hid_device *hdev)
+{
+}
+
+static int thc_ipts_hid_open(struct hid_device *hdev)
+{
+	return 0;
+}
+
+static void thc_ipts_hid_close(struct hid_device *hdev)
+{
+}
+
+static const struct hid_ll_driver thc_ipts_ll_driver = {
+	.start		= thc_ipts_hid_start,
+	.stop		= thc_ipts_hid_stop,
+	.open		= thc_ipts_hid_open,
+	.close		= thc_ipts_hid_close,
+	.parse		= thc_ipts_hid_parse,
+	.raw_request	= thc_ipts_hid_raw_request,
+};
+
+static void thc_ipts_hid_remove(struct thc_ipts *idev)
+{
+	if (!READ_ONCE(idev->hid))
+		return;
+
+	hid_destroy_device(idev->hid);
+	WRITE_ONCE(idev->hid, NULL);
+}
+
+static int thc_ipts_hid_add(struct thc_ipts *idev)
+{
+	struct hid_device *hdev;
+	int ret;
+
+	hdev = hid_allocate_device();
+	if (IS_ERR(hdev))
+		return PTR_ERR(hdev);
+
+	hdev->ll_driver = &thc_ipts_ll_driver;
+	hdev->bus = BUS_PCI;
+	hdev->vendor = idev->vendor;
+	hdev->product = idev->product;
+	hdev->version = le32_to_cpu(idev->cfg.revision) & 0xffff;
+	hdev->dev.parent = idev->dev;
+	hdev->driver_data = idev;
+	snprintf(hdev->name, sizeof(hdev->name), "intel-ipts %04X:%04X",
+		 idev->vendor, idev->product);
+	strscpy(hdev->phys, dev_name(idev->dev), sizeof(hdev->phys));
+
+	ret = hid_add_device(hdev);
+	if (ret) {
+		hid_destroy_device(hdev);
+		return ret;
+	}
+
+	WRITE_ONCE(idev->hid, hdev);
+
+	return 0;
+}
+
 /**
  * thc_ipts_port_start - bring one port up
  * @idev: port to start
@@ -412,7 +821,9 @@ int thc_ipts_port_start(struct thc_ipts *idev)
 	int ret;
 
 	WRITE_ONCE(idev->stopping, false);
+	WRITE_ONCE(idev->recover_pending, false);
 	WRITE_ONCE(idev->recovering, false);
+	WRITE_ONCE(idev->feature_off, false);
 
 	ret = thc_interrupt_quiesce(idev->thc, true);
 	if (ret)
@@ -506,6 +917,11 @@ int thc_ipts_port_start(struct thc_ipts *idev)
 
 	thc_interrupt_enable(idev->thc, true);
 
+	ret = thc_ipts_hid_add(idev);
+	if (ret)
+		return ret;
+	WRITE_ONCE(idev->state, THC_IPTS_UP);
+
 	return 0;
 }
 
@@ -515,26 +931,46 @@ int thc_ipts_port_start(struct thc_ipts *idev)
  */
 void thc_ipts_port_stop(struct thc_ipts *idev)
 {
-	/*
-	 * Mask the line, then wait for a handler that may be holding a
-	 * frame for the HID device which is about to go away.
+	/* Refuse new requests first, then wait for one that is already inside
+	 * thc_dma_write(): the completion it waits for comes through the
+	 * handler this teardown is about to mask. The lock is not held across
+	 * synchronize_irq(), because the threaded handler can issue a request
+	 * of its own from a HID callback.
 	 */
 	WRITE_ONCE(idev->stopping, true);
+	wake_up(&idev->wq);
+	mutex_lock(&idev->tx_lock);
+	mutex_unlock(&idev->tx_lock);
+
 	thc_interrupt_enable(idev->thc, false);
 	synchronize_irq(idev->irq);
 	cancel_work_sync(&idev->recover_work);
 
-	/* A handler that read ->stopping early may have unmasked. */
+	/* A run that was already in flight may have unmasked on its way out. */
 	thc_interrupt_enable(idev->thc, false);
 
-	/* Stop the controller before the buffers it writes into go away. */
+	/* Stop the controller before its buffers go away. */
 	if (READ_ONCE(idev->state) >= THC_IPTS_CONFIG)
 		thc_ipts_touch_set(idev, false);
 
 	/* Forced: the bit may read as clear and still need the command. */
 	thc_port_reset_hold(idev->thc);
-	thc_interrupt_quiesce(idev->thc, true);
 
+	/* The buffers are not devm-managed, so releasing them is the only way
+	 * back: do it even when the engine did not acknowledge the stop, and
+	 * let thc_dma_unconfigure() clear the start bits on its way out.
+	 */
+	if (thc_interrupt_quiesce(idev->thc, true))
+		dev_warn(idev->dev, "engine did not stop, releasing anyway\n");
 	thc_ipts_dma_stop(idev);
 	WRITE_ONCE(idev->state, THC_IPTS_DOWN);
+
+	/* ->state drops below THC_IPTS_DMA before the buffers are released,
+	 * and a handler woken before that still looks at the ring: wait for
+	 * it once more, then mask what it may have left open.
+	 */
+	synchronize_irq(idev->irq);
+	thc_interrupt_enable(idev->thc, false);
+
+	thc_ipts_hid_remove(idev);
 }
diff --git a/drivers/hid/intel-thc-hid/intel-ipts/ipts.h b/drivers/hid/intel-thc-hid/intel-ipts/ipts.h
index d5b6e6316..75153d694 100644
--- a/drivers/hid/intel-thc-hid/intel-ipts/ipts.h
+++ b/drivers/hid/intel-thc-hid/intel-ipts/ipts.h
@@ -6,8 +6,11 @@
 #include <linux/bits.h>
 #include <linux/build_bug.h>
 #include <linux/device.h>
+#include <linux/hid.h>
 #include <linux/interrupt.h>
+#include <linux/mutex.h>
 #include <linux/sched.h>
+#include <linux/spinlock.h>
 #include <linux/types.h>
 #include <linux/wait.h>
 
@@ -40,6 +43,13 @@
 #define THC_IPTS_CFG_TRIES		10
 #define THC_IPTS_CFG_RETRY_MS		100
 
+/* A report descriptor arrives with eight bytes of preamble in front of it. */
+#define THC_IPTS_DESC_PREAMBLE	8
+
+/* Retry budget for the report descriptor handshake. */
+#define THC_IPTS_REQ_TRIES		6
+#define THC_IPTS_REQ_TIMEOUT_MS	300
+
 #define THC_IPTS_CFG_KNOWN		40
 
 /* The block as far as this driver reads it, padded to its full size. */
@@ -94,6 +104,17 @@ static_assert(offsetof(struct thc_ipts_cfg, device_id) == 0x14);
 #define THC_IPTS_RX_HDR_SIZE		64
 #define THC_IPTS_TX_HDR_SIZE		8
 
+/* Frame codes. The same numbers mean different things per direction. */
+#define THC_IPTS_RX_INPUT		3
+#define THC_IPTS_RX_FEATURE		4
+#define THC_IPTS_RX_DESC		5
+#define THC_IPTS_RX_RESET		7
+
+#define THC_IPTS_TX_SET_FEATURE	3
+#define THC_IPTS_TX_GET_FEATURE	4
+#define THC_IPTS_TX_OUTPUT		5
+#define THC_IPTS_TX_GET_DESC		7
+
 /**
  * enum thc_ipts_state - how far the port has been brought up
  * @THC_IPTS_DOWN: no controller, no buffers, no HID device
@@ -125,7 +146,25 @@ enum thc_ipts_state {
  * @max_rx: largest frame the controller may send, in bytes
  * @max_tx: largest frame the driver may send, in bytes
  * @buf_rx: allocated size of @rx_frame
+ * @buf_tx: allocated size of @tx_frame
+ * @buf_desc: allocated size of @desc
+ * @buf_feat: allocated size of @feature
  * @rx_frame: buffer for one received frame, including its header
+ * @tx_frame: buffer for one frame to send, including its header
+ * @desc: copy of the report descriptor, past its preamble
+ * @desc_len: length of @desc
+ * @have_desc: a descriptor arrived and has not been consumed yet
+ * @feature: buffer a feature report is collected in
+ * @feature_len: length of the report in @feature
+ * @feature_id: report ID that was asked for, checked against the answer
+ * @feature_pending: a feature report was asked for and has not arrived yet
+ * @feature_done: a feature report arrived and has not been consumed yet
+ * @feature_off: a request timed out and no more are taken until the port
+ *	restarts
+ * @feature_lock: protects the feature report buffer and its flags
+ * @wq: waited on for a report descriptor or a feature report
+ * @tx_lock: serialises writes into @tx_frame
+ * @hid: HID device the reports are handed to, once it has been registered
  * @recover_work: resets the receive engine after a transfer error
  * @state: how far the port has been brought up, see enum thc_ipts_state
  * @recover_pending: a reset is wanted, refuse new requests
@@ -144,7 +183,24 @@ struct thc_ipts {
 	size_t			max_rx;
 	size_t			max_tx;
 	size_t			buf_rx;
+	size_t			buf_tx;
+	size_t			buf_desc;
+	size_t			buf_feat;
 	u8			*rx_frame;
+	u8			*tx_frame;
+	u8			*desc;
+	size_t			desc_len;
+	bool			have_desc;
+	u8			*feature;
+	size_t			feature_len;
+	u8			feature_id;
+	bool			feature_pending;
+	bool			feature_done;
+	bool			feature_off;
+	struct mutex		feature_lock;	/* feature report handshake */
+	wait_queue_head_t	wq;
+	struct mutex		tx_lock;	/* transmit frame */
+	struct hid_device	*hid;
 	struct work_struct	recover_work;
 	enum thc_ipts_state	state;
 	bool			recover_pending;
diff --git a/drivers/hid/intel-thc-hid/intel-ipts/pci-ipts.c b/drivers/hid/intel-thc-hid/intel-ipts/pci-ipts.c
index d3c06b09a..d147ebca1 100644
--- a/drivers/hid/intel-thc-hid/intel-ipts/pci-ipts.c
+++ b/drivers/hid/intel-thc-hid/intel-ipts/pci-ipts.c
@@ -46,6 +46,9 @@ static int thc_ipts_probe(struct pci_dev *pci, const struct pci_device_id *id)
 		return -ENOMEM;
 
 	idev->dev = &pci->dev;
+	mutex_init(&idev->tx_lock);
+	mutex_init(&idev->feature_lock);
+	init_waitqueue_head(&idev->wq);
 	pci_set_drvdata(pci, idev);
 	INIT_WORK(&idev->recover_work, thc_ipts_recover);
 
