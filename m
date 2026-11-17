Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=82.195.75.108
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794900993;
	b=4ETjpynCyaWwiclOwmn0TQV4gVEFkFcMFwuSxP0yykZpUGn8rygoWCJ38w9BuUyBMnyw
	 RzViW4XAbYFxEXQIUB6bLBmNBAVF3R0L8po9UUBLWhehr+qo/gFh5NQVpejimWZ0KrUoK
	 UGtCcdA010+5LoSpGquaCCJpegoxGO0NbF5c5gJe1tA1g9/rq8Sm50/c+CtsYZXq9IVCM
	 3CKnapciid4KY+yuZ7hSo1D43Ymlb4o6F3PDAjSN+1O0ADUncwFiZxwWoGBF46OP4WjNo
	 nUZgg+eREQ6bCFHo7XOFruecIZMXJE2zXFkARXby/yrgnJMIlApcSO3vR4gx6YXRwXQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794900993;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Debian-User;
	bh=UdX0Fe4F2mtyBNIZF+qBzljk/0J1H1xbDeGwVEatU0s=;
	b=ggRSWN9FZ5IVDGeV14MxzMZdju+XHf/JVVO3Ie1sElIkbOyeHMJLY4NQyVfnMati4jxN
	 2Kk7e0kdVU0XSRT4w7PmKEP6o7Dk1lec6JHtwnVSXZZMdzbqVwWAIJeRysJ6GApmW9Dv4
	 R6VtzXSiGpGmjgiAXo0nFL7xRtuOODjc1GiFxO6Otln2BD8Rg12Dh1HtsAHaoaY/kjPFl
	 21FDz3/Js2yRqOODM1a+F3v0GcBrsMLFenoZTmjQJ6/EmI2ZTn/65brglnZamH5iF9XjX
	 K7GGk4FepgsjcLNjIavTMKXTVrF61KCLzLmQRxauKJ/wYb6UZv6v+F0F7EskY9+y6Rg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=debian.org;
	spf=pass smtp.mailfrom=debian.org;
	dkim=pass header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=DnViwOLo;
	arc=none smtp.remote-ip=82.195.75.108
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FE37606A32C;
	Tue, 17 Nov 2026 07:36:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2FE37606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=DnViwOLo
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=UdX0Fe4F2mtyBNIZF+qBzljk/0J1H1xbDeGwVEatU0s=; b=DnViwOLoDAcV391aTb0dDm32lY
	TzlggCBtXupHXgSK04vUPxMvHdLxH1ixiBmqIu0RisQKs1zP/WGI2f1Cxu1+pnNvOZ04dS0bDLi3q
	ha92+HE0kS5uRIpMDGA2WNL14lRkllkd2j0wm9pfNU/W16D7HRWtkxfsq4ycfhpFxTkxua1YHB3dy
	yP0s1nofoaDFET0IndlCAEaP/nFoB8G7a+mVWNWqySKsO0Jeo45TiDlDLHgBbSNd0ZYoKGutR2qoE
	ux7h0Ax0b/s1Ije2tr6xVfVl7ku4AZg4BeEmJBnXZ7eQ+tfqpy4hS75lEYEZMKs0iti+rBuE/7H1n
	PH3wBdRw==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <emfox@debian.org>)
	id 1xTDju-000NP1-0y;
	Tue, 17 Nov 2026 07:36:27 +0000
From: Emfox Zhou <emfox@debian.org>
To: Even Xu <even.xu@intel.com>,
	Xinpeng Sun <xinpeng.sun@intel.com>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v6 3/5] HID: intel-thc-hid: intel-ipts: register the HID device
Date: Tue, 17 Nov 2026 15:35:52 +0800
Message-ID: <20261117073554.11557-4-emfox@debian.org>
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

Register a HID device for the port and let it own the handshake: the
report descriptor is not read once at probe and kept, it is asked for
over the transport whenever the HID core parses the device, and feature
reports the core asks for are fetched the same way.

The report descriptor is asked for up to six times, each request waiting
300 ms. A request that finds the port masked by a reset waits for that
reset instead of spending a try, and an answer that arrived just after a
wait expired is taken rather than thrown away.

A feature answer arrives as a frame of its own while the request waits, so
it can land after that request timed out and another one started. The
answer carries the report ID back, which is not enough to tell it from the
answer to the next request for the same report: nothing on the wire says
which request a frame answers. The request is therefore sent once, and a
timeout shuts the channel until the port is started again, the only point
where controller and device are known to agree. Resets are counted so a
timeout caused by one can be told apart from a controller that never
answered, though the channel is shut either way: the answer may still turn
up later. Resetting the engine instead would drop the late answer, but the
reset does not restore the PRD table, so a frame left unread would make
the next one overrun. A send failure is kept separate and shuts nothing:
the frame never reached the wire, so no answer can be outstanding for it.

The answer is copied in the threaded handler and can be as large as a
receive frame, so the state is guarded by a mutex rather than a spinlock.

Requests are refused while a recovery is in flight: the port is masked, so
a write would wait out its one second timeout, holding the bus lock the
reset needs. Teardown refuses new requests and then waits for one already
inside thc_dma_write(), which needs the interrupt the mask takes away. The
request lock is not held across synchronize_irq(): the threaded handler can
issue a request of its own from a HID callback, and that request would wait
for the lock while the teardown waits for the handler.

Input reports go straight to the input layer, and hidraw passes the raw
stream to user space, which is where decoding belongs: the reports carry a
heatmap, and turning it into contacts needs floating point arithmetic the
kernel cannot do. The controller starts streaming once user space asks for
it, through a set feature request on report 5; the daemon that opens
hidraw sends it.

Signed-off-by: Emfox Zhou <emfox@debian.org>
---
 drivers/hid/intel-thc-hid/intel-ipts/ipts.c   | 361 +++++++++++++++++-
 drivers/hid/intel-thc-hid/intel-ipts/ipts.h   |  56 +++
 .../hid/intel-thc-hid/intel-ipts/pci-ipts.c   |   8 +-
 3 files changed, 412 insertions(+), 13 deletions(-)

diff --git a/drivers/hid/intel-thc-hid/intel-ipts/ipts.c b/drivers/hid/intel-thc-hid/intel-ipts/ipts.c
index 2265d0735..5fc396e1b 100644
--- a/drivers/hid/intel-thc-hid/intel-ipts/ipts.c
+++ b/drivers/hid/intel-thc-hid/intel-ipts/ipts.c
@@ -3,8 +3,10 @@
  * Transport for THC ports in IPTS mode: plain SPI with a private framing.
  */
 
+#include <linux/cleanup.h>
 #include <linux/delay.h>
 #include <linux/math.h>
+#include <linux/hid.h>
 #include <linux/interrupt.h>
 #include <linux/minmax.h>
 #include <linux/regmap.h>
@@ -144,8 +146,75 @@ static int thc_ipts_touch_set(struct thc_ipts *idev, bool enable)
 				 &touch);
 }
 
+/* Frames are built in @idev->tx_frame, so callers hold @req_lock. */
+static int thc_ipts_send(struct thc_ipts *idev, u32 code, const void *data,
+			 size_t len)
+{
+	size_t padded = round_up(len, 4);
+	u8 *frame = idev->tx_frame;
+
+	if (READ_ONCE(idev->stopping))
+		return -ESHUTDOWN;
+	/* The port is masked: the write would wait out its timeout. */
+	if (READ_ONCE(idev->recovering))
+		return -EAGAIN;
+	/* No engine to write into: waiting for a reset would not help. */
+	if (!READ_ONCE(idev->dma_ready))
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
+	return thc_dma_write(idev->thc, frame, THC_IPTS_TX_HDR_SIZE + padded);
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
+	idev->feature_pending = false;
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
 
@@ -154,11 +223,31 @@ static void thc_ipts_handle_frame(struct thc_ipts *idev, size_t len)
 
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
@@ -211,9 +300,19 @@ static int thc_ipts_dma_start(struct thc_ipts *idev)
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
@@ -311,6 +410,10 @@ void thc_ipts_recover(struct work_struct *work)
 	/* The reset drops whatever the engines had queued. */
 	WRITE_ONCE(idev->recover_seq, READ_ONCE(idev->recover_seq) + 1);
 	WRITE_ONCE(idev->recovering, false);
+
+	/* A request waiting out the reset is looking at that flag. */
+	wake_up(&idev->wq);
+
 	if (!READ_ONCE(idev->stopping))
 		thc_interrupt_enable(idev->thc, true);
 }
@@ -373,6 +476,234 @@ irqreturn_t thc_ipts_thread(int irq, void *data)
 	return ret;
 }
 
+static int thc_ipts_hid_parse(struct hid_device *hdev)
+{
+	struct thc_ipts *idev = hdev->driver_data;
+	unsigned long timeout = msecs_to_jiffies(THC_IPTS_REQ_TIMEOUT_MS);
+	u64 zero = 0;
+	unsigned int resets = 0;
+	int ret;
+	int try = 0;
+
+	guard(mutex)(&idev->req_lock);
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
+				    sizeof(zero));
+		if (ret == -EAGAIN) {
+			/* A reset in flight is what the send tripped on: wait
+			 * it out, that is not a request of ours.
+			 */
+			if (++resets > THC_IPTS_REQ_TRIES ||
+			    !wait_event_timeout(idev->wq,
+						!READ_ONCE(idev->recovering),
+						timeout))
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
+	if (smp_load_acquire(&idev->have_desc) && idev->desc_len > 0)
+		return hid_parse_report(hdev, idev->desc, idev->desc_len);
+
+	dev_err(idev->dev,
+		"controller did not return a report descriptor in %d tries\n",
+		try);
+
+	return -ETIMEDOUT;
+}
+
+/* A feature report comes back as a frame of its own: the request waits. */
+static int thc_ipts_get_feature(struct thc_ipts *idev, unsigned char reportnum,
+				u8 *buf, size_t len)
+{
+	unsigned long timeout = msecs_to_jiffies(THC_IPTS_REQ_TIMEOUT_MS);
+	unsigned int seq;
+	int ret;
+
+	guard(mutex)(&idev->req_lock);
+
+	/* The frame carries only the report ID, so a late answer cannot be
+	 * told from the next one's: after a timeout the channel stays shut.
+	 */
+	if (READ_ONCE(idev->feature_off))
+		return -EIO;
+
+	mutex_lock(&idev->feature_lock);
+	WRITE_ONCE(idev->feature_done, false);
+	idev->feature_id = reportnum;
+	idev->feature_pending = true;
+	mutex_unlock(&idev->feature_lock);
+
+	seq = READ_ONCE(idev->recover_seq);
+
+	/* A frame that never reached the wire says nothing about the
+	 * controller, so it is reported and the channel stays open.
+	 */
+	ret = thc_ipts_send(idev, THC_IPTS_TX_GET_FEATURE, &reportnum, 1);
+	if (ret) {
+		mutex_lock(&idev->feature_lock);
+		idev->feature_pending = false;
+		mutex_unlock(&idev->feature_lock);
+
+		return ret;
+	}
+
+	wait_event_timeout(idev->wq, READ_ONCE(idev->feature_done), timeout);
+
+	mutex_lock(&idev->feature_lock);
+	/* An answer that landed while the wait was expiring counts too. */
+	if (!idev->feature_done) {
+		/* A reset discards what the engines had queued, so an answer
+		 * that was on its way is gone and cannot be waited for.
+		 */
+		if (READ_ONCE(idev->recover_seq) != seq ||
+		    READ_ONCE(idev->recovering))
+			ret = -EIO;
+		else
+			ret = -ETIMEDOUT;
+	}
+	idev->feature_pending = false;
+	mutex_unlock(&idev->feature_lock);
+
+	if (ret) {
+		if (ret == -ETIMEDOUT)
+			dev_err(idev->dev, "no feature report %u\n", reportnum);
+
+		/* The frame may be on the wire and its answer cannot be told
+		 * from the next request's one: shut the channel until the port
+		 * restarts.
+		 */
+		WRITE_ONCE(idev->feature_off, true);
+
+		return ret;
+	}
+
+	/* The payload is the report as user space writes it: ID first. */
+	mutex_lock(&idev->feature_lock);
+	len = min(len, idev->feature_len);
+	if (len)
+		memcpy(buf, idev->feature, len);
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
+	guard(mutex)(&idev->req_lock);
+
+	ret = thc_ipts_send(idev, code, buf, len);
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
@@ -384,6 +715,7 @@ int thc_ipts_port_start(struct thc_ipts *idev)
 
 	WRITE_ONCE(idev->stopping, false);
 	WRITE_ONCE(idev->recovering, false);
+	WRITE_ONCE(idev->feature_off, false);
 
 	ret = thc_ipts_quiesce(idev, true);
 	if (ret)
@@ -476,7 +808,7 @@ int thc_ipts_port_start(struct thc_ipts *idev)
 
 	thc_interrupt_enable(idev->thc, true);
 
-	return 0;
+	return thc_ipts_hid_add(idev);
 }
 
 /**
@@ -485,11 +817,15 @@ int thc_ipts_port_start(struct thc_ipts *idev)
  */
 void thc_ipts_port_stop(struct thc_ipts *idev)
 {
-	/*
-	 * Mask the line, then wait for a handler that may be holding a
-	 * frame for the HID device which is about to go away.
+	/* Refuse new requests first, then wait for one that is already inside
+	 * thc_dma_write(): it needs the interrupt the mask below takes away.
+	 * The lock is not held across synchronize_irq(), because the threaded
+	 * handler can issue a request of its own from a HID callback.
 	 */
 	WRITE_ONCE(idev->stopping, true);
+	mutex_lock(&idev->req_lock);
+	mutex_unlock(&idev->req_lock);
+
 	thc_interrupt_enable(idev->thc, false);
 	synchronize_irq(idev->irq);
 	cancel_work_sync(&idev->recover_work);
@@ -497,7 +833,7 @@ void thc_ipts_port_stop(struct thc_ipts *idev)
 	/* A handler that read ->stopping early may have unmasked. */
 	thc_interrupt_enable(idev->thc, false);
 
-	/* Stop the controller before the buffers it writes into go away. */
+	/* Stop the controller before its buffers go away. */
 	if (idev->running)
 		thc_ipts_touch_set(idev, false);
 
@@ -505,7 +841,14 @@ void thc_ipts_port_stop(struct thc_ipts *idev)
 	/* Forced: the bit may read as clear and still need the command. */
 	regmap_write_bits(idev->thc->thc_regmap, THC_M_PRT_CONTROL_OFFSET,
 			  THC_M_PRT_CONTROL_DEVRST, 0);
-	thc_ipts_quiesce(idev, true);
 
+	/* The buffers are not devm-managed, so releasing them is the only way
+	 * back: do it even when the engine did not acknowledge the stop, and
+	 * let thc_dma_unconfigure() clear the start bits on its way out.
+	 */
+	if (thc_ipts_quiesce(idev, true))
+		dev_warn(idev->dev, "engine did not stop, releasing anyway\n");
 	thc_ipts_dma_stop(idev);
+
+	thc_ipts_hid_remove(idev);
 }
diff --git a/drivers/hid/intel-thc-hid/intel-ipts/ipts.h b/drivers/hid/intel-thc-hid/intel-ipts/ipts.h
index f0f1652d9..19dfc0387 100644
--- a/drivers/hid/intel-thc-hid/intel-ipts/ipts.h
+++ b/drivers/hid/intel-thc-hid/intel-ipts/ipts.h
@@ -6,7 +6,10 @@
 #include <linux/bits.h>
 #include <linux/build_bug.h>
 #include <linux/device.h>
+#include <linux/hid.h>
 #include <linux/interrupt.h>
+#include <linux/mutex.h>
+#include <linux/spinlock.h>
 #include <linux/types.h>
 #include <linux/wait.h>
 
@@ -39,6 +42,13 @@
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
@@ -92,6 +102,17 @@ static_assert(offsetof(struct thc_ipts_cfg, vendor) == 0x1c);
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
  * struct thc_ipts - state of one THC port in IPTS mode
  * @dev: device used for resources and logging
@@ -103,7 +124,25 @@ static_assert(offsetof(struct thc_ipts_cfg, vendor) == 0x1c);
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
+ * @req_lock: serialises request frames and the feature handshake
+ * @hid: HID device the reports are handed to, once it has been registered
  * @recover_work: resets the receive engine after a transfer error
  * @running: the controller answered and is out of reset
  * @dma_ready: DMA engines are configured and may be used
@@ -121,7 +160,24 @@ struct thc_ipts {
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
+	struct mutex		req_lock;	/* request frames */
+	struct hid_device	*hid;
 	struct work_struct	recover_work;
 	bool			running;
 	bool			dma_ready;
diff --git a/drivers/hid/intel-thc-hid/intel-ipts/pci-ipts.c b/drivers/hid/intel-thc-hid/intel-ipts/pci-ipts.c
index 005b56234..46934ac79 100644
--- a/drivers/hid/intel-thc-hid/intel-ipts/pci-ipts.c
+++ b/drivers/hid/intel-thc-hid/intel-ipts/pci-ipts.c
@@ -45,15 +45,15 @@ static int thc_ipts_probe(struct pci_dev *pci, const struct pci_device_id *id)
 		return -ENOMEM;
 
 	idev->dev = &pci->dev;
+	mutex_init(&idev->req_lock);
+	mutex_init(&idev->feature_lock);
+	init_waitqueue_head(&idev->wq);
 	pci_set_drvdata(pci, idev);
 	INIT_WORK(&idev->recover_work, thc_ipts_recover);
 
 	ret = pcim_enable_device(pci);
-	if (ret) {
-		dev_err(idev->dev,
-			"cannot enable the PCI function, error %d\n", ret);
+	if (ret)
 		return ret;
-	}
 
 	pci_set_master(pci);
 
