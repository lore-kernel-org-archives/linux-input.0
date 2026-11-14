Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=82.195.75.108
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794681591;
	b=ZOsY92NMVzJSzaanO0trXGYFOjZBmlmsmzlnvUE3S2r1/tvF010zAcwR3MZmqyMuy5zz
	 48V0O+VzWu4mouTsshgeCiPCQ53JUVZIGC3biaBVegejcTkkQPpAfavKBadVNoGyHbn1/
	 0kV27wFH5d+HVeVXXbj1gOVeKCdJLLJ1KvLh8q7xPbKTUXEt58sL5YJL3bi8ngoxyEvie
	 y+dd5R70IVM0fuedXB04pIeOWtguvpt4ChkWmSAlfHD8yGvUrFfTnKRsqGjLe29I9TXej
	 qt2jNL5qDKZkG1YdHX+YVBdivVmD9yXDFv7B0I6JfZrz+rxwld2w9TO6u1qWo79pplQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794681591;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Debian-User;
	bh=bMUEvOOzV/89ToizRP1ifsh7Zz7fu19xRJ3RyM3obX0=;
	b=U2v84isX/WqevnHQUv+yQ6ck5rEVB7ecH4q59YXyi0RuJg+wmjnjhSxvsSCqMascbAR9
	 PKI5/DPlhzXqt+vnRM9upnnqunI0Al5qL3C1oSm1UL/ZtVZU6KNOHx6wTc/forPkpuMu0
	 cvgvOBrWTMp8TG9cmhPBxEE36nLjbhZAlLRDTbbCixMpSWSNLYTbZIoXVTQ+477qLR2bG
	 B6zSmYdvAmhVs4Yo/ovIM3FhOsPof4ZI0ix35R3crASYscpJn7IM0RpowoLIuN4EmVVeC
	 CXWKxQUjVu1XoTigXdWhwFaBqjUDRhFpCjYYlHhT5sX+yJ2x60v8DpsZLZCdHBnFraw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=debian.org;
	spf=pass smtp.mailfrom=debian.org;
	dkim=pass header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=FBjqtGg6;
	arc=none smtp.remote-ip=82.195.75.108
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F765606A329;
	Sat, 14 Nov 2026 18:39:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8F765606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=FBjqtGg6
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=bMUEvOOzV/89ToizRP1ifsh7Zz7fu19xRJ3RyM3obX0=; b=FBjqtGg6CBK3rPKJt0Lxb6J3BC
	dy4jcwimJ9JN9pVsrcSYAWb1RJE12l33LLjhJqO7BgCttHnLDEenqosDMXbI09S1JoUHZgMqgH/mE
	9rhK3ugVYS+w1PxcSRQsBzalaFUsmjxN4AYkYbTdV+fqdLWPuEpmPIFqMV1pHyOITqiC1dsRzQhqf
	w2/VMvxs/ThT32rty+eujSh8Mc9nwnTAIa9/u3XLnW4SB5rqm1aj2svHPtHvMB85hwcsI9+7KQ9hg
	HhQSGGAEO5li1WnK/MB6wXgLI/egBy5P8F7o0zVdGhIJuOrGeRhxeM3Tfq16wAQ73mMlcGhlTZIxw
	RRUCQkBg==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <emfox@debian.org>)
	id 1xSIfB-00FkAN-2v;
	Sat, 14 Nov 2026 18:39:46 +0000
From: Emfox Zhou <emfox@debian.org>
To: Even Xu <even.xu@intel.com>,
	Xinpeng Sun <xinpeng.sun@intel.com>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/5] HID: intel-thc-hid: intel-ipts: register the HID device
Date: Sun, 15 Nov 2026 02:36:22 +0800
Message-ID: <20261114183624.2379573-4-emfox@debian.org>
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

Register a HID device for the port and let it own the handshake: the
report descriptor is not read once at probe and kept, it is asked for
over the transport whenever the HID core parses the device, and feature
reports the core asks for are fetched the same way.

A feature answer arrives as a frame of its own while the request waits, so
it can land after that request timed out and another one started. The
report ID in it is checked against the request, and the flags and the
buffer are updated together under a lock: matching an answer to a request
and consuming it have to be one step.

Teardown takes the request lock before it masks the line: a request already
inside thc_dma_write needs the interrupt that completes it, and with the
line masked first it would wait out its timeout holding the bus lock.

Input reports go straight to the input layer, and the raw report stream
is available to user space through hidraw. That is where decoding
belongs: the reports carry a heatmap, and turning it into contacts
needs floating point arithmetic the kernel cannot do.

The controller starts streaming once user space asks for it, through a
set feature request on report 5. The driver does not do that on its
own, the daemon that opens hidraw sends it.

Signed-off-by: Emfox Zhou <emfox@debian.org>
---
 drivers/hid/intel-thc-hid/intel-ipts/ipts.c   | 348 ++++++++++++++++--
 drivers/hid/intel-thc-hid/intel-ipts/ipts.h   |  47 +++
 .../hid/intel-thc-hid/intel-ipts/pci-ipts.c   |   8 +-
 3 files changed, 376 insertions(+), 27 deletions(-)

diff --git a/drivers/hid/intel-thc-hid/intel-ipts/ipts.c b/drivers/hid/intel-thc-hid/intel-ipts/ipts.c
index ac0074a..bf75f8c 100644
--- a/drivers/hid/intel-thc-hid/intel-ipts/ipts.c
+++ b/drivers/hid/intel-thc-hid/intel-ipts/ipts.c
@@ -4,7 +4,9 @@
  * SPI and carries its HID reports in a private framing.
  */
 
+#include <linux/cleanup.h>
 #include <linux/delay.h>
+#include <linux/hid.h>
 #include <linux/interrupt.h>
 #include <linux/minmax.h>
 #include <linux/regmap.h>
@@ -139,8 +141,79 @@ static int thc_ipts_touch_set(struct thc_ipts *idev, bool enable)
 				 &touch);
 }
 
+/*
+ * One frame to the controller: code, length, then the payload padded to four
+ * bytes. The frame is built in @idev->tx_frame, so callers serialise with
+ * @idev->req_lock.
+ */
+static int thc_ipts_send(struct thc_ipts *idev, u32 code, const void *data,
+			 size_t len)
+{
+	size_t padded = round_up(len, 4);
+	u8 *frame = idev->tx_frame;
+
+	if (READ_ONCE(idev->stopping))
+		return -ESHUTDOWN;
+	if (!READ_ONCE(idev->dma_ready))
+		return -EAGAIN;
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
+	WRITE_ONCE(idev->have_desc, true);
+	wake_up(&idev->wq);
+}
+
+/* The report is collected in a private buffer; the caller copies it out. */
+static void thc_ipts_feature(struct thc_ipts *idev, const u8 *data,
+			     size_t len)
+{
+	if (!len)
+		return;
+
+	/*
+	 * A request that timed out is dropped by the sender, which may be
+	 * asking for another report by now: check and copy in one step. The
+	 * ID tells an answer to an earlier request from the one asked for.
+	 */
+	spin_lock_irq(&idev->feature_lock);
+	if (!idev->feature_pending ||
+	    (idev->feature_id && data[0] != idev->feature_id)) {
+		spin_unlock_irq(&idev->feature_lock);
+		return;
+	}
+
+	len = min(len, idev->max_rx);
+	memcpy(idev->feature, data, len);
+	idev->feature_len = len;
+	idev->feature_pending = false;
+	WRITE_ONCE(idev->feature_done, true);
+	spin_unlock_irq(&idev->feature_lock);
+
+	wake_up(&idev->wq);
+}
+
 static void thc_ipts_handle_frame(struct thc_ipts *idev, size_t len)
 {
+	const u8 *payload = idev->rx_frame + THC_IPTS_RX_HDR_SIZE;
 	size_t capacity = idev->max_rx - THC_IPTS_RX_HDR_SIZE;
 	u32 code, size;
 
@@ -149,11 +222,31 @@ static void thc_ipts_handle_frame(struct thc_ipts *idev, size_t len)
 
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
@@ -182,10 +275,24 @@ static int thc_ipts_dma_start(struct thc_ipts *idev)
 		idev->rx_frame = devm_kzalloc(idev->dev,
 					      round_up(idev->max_rx, SZ_4K),
 					      GFP_KERNEL);
-		if (!idev->rx_frame)
-			return -ENOMEM;
 	}
+	if (!idev->tx_frame)
+		idev->tx_frame = devm_kzalloc(idev->dev,
+					      round_up(idev->max_tx, 4),
+					      GFP_KERNEL);
+	if (!idev->desc)
+		idev->desc = devm_kzalloc(idev->dev, idev->max_rx, GFP_KERNEL);
+	if (!idev->feature)
+		idev->feature = devm_kzalloc(idev->dev, idev->max_rx,
+					     GFP_KERNEL);
+	if (!idev->rx_frame || !idev->tx_frame || !idev->desc || !idev->feature)
+		return -ENOMEM;
 
+	/*
+	 * The sizes the controller advertises are the largest frame it sends
+	 * and the largest it accepts, which is what the engines need; the core
+	 * rounds them up to a page and derives the PRD table sizes from them.
+	 */
 	ret = thc_dma_set_max_packet_sizes(idev->thc, 0, idev->max_rx,
 					   idev->max_tx, 0);
 	if (ret)
@@ -342,6 +449,196 @@ irqreturn_t thc_ipts_thread(int irq, void *data)
 	return ret;
 }
 
+static int thc_ipts_hid_parse(struct hid_device *hdev)
+{
+	struct thc_ipts *idev = hdev->driver_data;
+	unsigned long timeout = msecs_to_jiffies(THC_IPTS_REQ_TIMEOUT_MS);
+	u64 zero = 0;
+	int ret;
+	int try;
+
+	guard(mutex)(&idev->req_lock);
+
+	for (try = 0; try < THC_IPTS_REQ_TRIES; try++) {
+		WRITE_ONCE(idev->have_desc, false);
+
+		/* The controller ignores the eight byte argument. */
+		ret = thc_ipts_send(idev, THC_IPTS_TX_GET_DESC, &zero,
+				    sizeof(zero));
+		if (ret)
+			return ret;
+
+		if (wait_event_timeout(idev->wq, READ_ONCE(idev->have_desc),
+				       timeout) &&
+		    idev->desc_len > 0)
+			return hid_parse_report(hdev, idev->desc,
+						idev->desc_len);
+	}
+
+	dev_err(idev->dev,
+		"controller did not return a report descriptor in %d tries\n",
+		try);
+
+	return -ETIMEDOUT;
+}
+
+/*
+ * A feature report is not pushed by the controller: it is asked for and comes
+ * back as a frame of its own, so the request waits for the handler.
+ */
+static int thc_ipts_get_feature(struct thc_ipts *idev, unsigned char reportnum,
+				u8 *buf, size_t len)
+{
+	int ret = -ETIMEDOUT;
+	unsigned long timeout = msecs_to_jiffies(THC_IPTS_REQ_TIMEOUT_MS);
+	int try;
+
+	guard(mutex)(&idev->req_lock);
+
+	spin_lock_irq(&idev->feature_lock);
+	WRITE_ONCE(idev->feature_done, false);
+	idev->feature_id = reportnum;
+	idev->feature_pending = true;
+	spin_unlock_irq(&idev->feature_lock);
+
+	for (try = 0; try < THC_IPTS_REQ_TRIES; try++) {
+		ret = thc_ipts_send(idev, THC_IPTS_TX_GET_FEATURE, &reportnum,
+				    1);
+		if (ret)
+			break;
+
+		if (wait_event_timeout(idev->wq, READ_ONCE(idev->feature_done),
+				       timeout)) {
+			ret = 0;
+			break;
+		}
+
+		ret = -ETIMEDOUT;
+	}
+
+	/* Give up on the answer: a reply still in flight is dropped. */
+	spin_lock_irq(&idev->feature_lock);
+	idev->feature_pending = false;
+	spin_unlock_irq(&idev->feature_lock);
+
+	if (ret) {
+		dev_err(idev->dev, "no feature report %u after %d tries\n",
+			reportnum, try);
+		return ret;
+	}
+
+	/* The payload is the report as user space writes it: ID first. */
+	len = min(len, idev->feature_len);
+	if (!len)
+		return -EPROTO;
+	memcpy(buf, idev->feature, len);
+
+	return len;
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
+/*
+ * The HID core calls all four of these unconditionally, and this transport
+ * has nothing to do when a user opens or closes the report stream.
+ */
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
@@ -439,7 +736,7 @@ int thc_ipts_port_start(struct thc_ipts *idev)
 
 	thc_interrupt_enable(idev->thc, true);
 
-	return 0;
+	return thc_ipts_hid_add(idev);
 }
 
 /**
@@ -452,23 +749,28 @@ void thc_ipts_port_stop(struct thc_ipts *idev)
 		return;
 
 	/*
-	 * Mask the line, then wait for a handler that may be holding a
-	 * frame for the HID device which is about to go away.
+	 * Requests first: one inside thc_dma_write needs the interrupt that
+	 * completes it, so it finishes before the line is masked. A new one
+	 * sees ->stopping under the same lock and backs out.
 	 */
-	WRITE_ONCE(idev->stopping, true);
-	thc_interrupt_enable(idev->thc, false);
-	synchronize_irq(idev->irq);
-	cancel_work_sync(&idev->recover_work);
-
-	/* Stop the controller before the buffers it writes into go away. */
-	if (idev->running)
-		thc_ipts_touch_set(idev, false);
-
-	idev->running = false;
-	regmap_clear_bits(idev->thc->thc_regmap,
-			  THC_M_PRT_CONTROL_OFFSET,
-			  THC_M_PRT_CONTROL_DEVRST);
-	thc_ipts_quiesce(idev, true);
+	scoped_guard(mutex, &idev->req_lock) {
+		WRITE_ONCE(idev->stopping, true);
+		thc_interrupt_enable(idev->thc, false);
+		synchronize_irq(idev->irq);
+		cancel_work_sync(&idev->recover_work);
+
+		/* Stop the controller before its buffers go away. */
+		if (idev->running)
+			thc_ipts_touch_set(idev, false);
+
+		idev->running = false;
+		regmap_clear_bits(idev->thc->thc_regmap,
+				  THC_M_PRT_CONTROL_OFFSET,
+				  THC_M_PRT_CONTROL_DEVRST);
+		thc_ipts_quiesce(idev, true);
+
+		thc_ipts_dma_stop(idev);
+	}
 
-	thc_ipts_dma_stop(idev);
+	thc_ipts_hid_remove(idev);
 }
diff --git a/drivers/hid/intel-thc-hid/intel-ipts/ipts.h b/drivers/hid/intel-thc-hid/intel-ipts/ipts.h
index f233d9c..6d5a5bf 100644
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
 
@@ -43,6 +46,13 @@
 #define THC_IPTS_CFG_TRIES		10
 #define THC_IPTS_CFG_RETRY_MS		100
 
+/* A report descriptor arrives with eight bytes of preamble in front of it. */
+#define THC_IPTS_DESC_PREAMBLE	8
+
+/* Retry budget for the two handshakes user space can trigger. */
+#define THC_IPTS_REQ_TRIES		6
+#define THC_IPTS_REQ_TIMEOUT_MS	300
+
 /* Bytes of the configuration block this driver interprets. */
 #define THC_IPTS_CFG_KNOWN		40
 
@@ -105,6 +115,17 @@ static_assert(offsetof(struct thc_ipts_cfg, vendor) == 0x1c);
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
@@ -116,6 +137,19 @@ static_assert(offsetof(struct thc_ipts_cfg, vendor) == 0x1c);
  * @max_rx: largest frame the controller may send, in bytes
  * @max_tx: largest frame the driver may send, in bytes
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
+ * @feature_lock: protects the feature report buffer and its flags
+ * @wq: waited on for a report descriptor or a feature report
+ * @req_lock: serialises request frames and the feature handshake
+ * @hid: HID device the reports are handed to, once it has been registered
  * @recover_work: resets the receive engine after a transfer error
  * @running: the controller answered and is out of reset
  * @dma_ready: DMA engines are configured and may be used
@@ -132,6 +166,19 @@ struct thc_ipts {
 	size_t			max_rx;
 	size_t			max_tx;
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
+	spinlock_t		feature_lock;	/* feature report handshake */
+	wait_queue_head_t	wq;
+	struct mutex		req_lock;	/* request frames */
+	struct hid_device	*hid;
 	struct work_struct	recover_work;
 	bool			running;
 	bool			dma_ready;
diff --git a/drivers/hid/intel-thc-hid/intel-ipts/pci-ipts.c b/drivers/hid/intel-thc-hid/intel-ipts/pci-ipts.c
index 161bee9..8f8db21 100644
--- a/drivers/hid/intel-thc-hid/intel-ipts/pci-ipts.c
+++ b/drivers/hid/intel-thc-hid/intel-ipts/pci-ipts.c
@@ -45,15 +45,15 @@ static int thc_ipts_probe(struct pci_dev *pci, const struct pci_device_id *id)
 		return -ENOMEM;
 
 	idev->dev = &pci->dev;
+	mutex_init(&idev->req_lock);
+	spin_lock_init(&idev->feature_lock);
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
 
