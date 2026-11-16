Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=82.195.75.108
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794835954;
	b=ko2H0E18GKQKVzAuw7STTlNjX6qwYX4QyrsNTmM+auFGXYxybUI9qHbS9vsT40UWJI2B
	 m8bOGaTVdJJ2iEb+bLjpRARYRBnn2l8xrWXgTmDVW81bvM9VLTWJvvojmsMi0fLEK3vnl
	 MEUdskGyNM6Fwb2RzfuGdfeEYqnBFlXX78Tga/zX7qfvHvoBhZkARggARITZVYS6/lmpd
	 f2xMHjXCMtFrSbAjJAzOXJ5C+XiU89XkXIq4cq6WJfPMAeRBTI1VZS+miUEEUXJZdMp2T
	 tBDTBpxuUxPb6QajM8hWzxx+ZUG0PCClKfqKM57C0G5qcXuhUpStUSll+EDU0Ah7rpA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794835954;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Debian-User;
	bh=jRE7R2gplNPXvMeDZFwYe1WY1elQKyKA0phFJISFMrU=;
	b=1DOcdbPR9lkAJldK73QcwYzXwdM+UIvxD4xiE0zpB3xpS5r2vGxZB4f1J0vlM3su/IWx
	 yDLHaC4o2+fCSIo3gy1X7Mter0z4zDtAJrWZEgaAJ+N87ABGG5LFhe3MZXtX3FjKUXeWg
	 lUgCiJaY/alruJKhZhROoObRMwPll+8j44xcBumjGehZIFXpiw1QtLA+FtiNq0EsCgjlm
	 NI1rB78qAsbNv7V0g0RggoCcyL3reZ86YiItfjQvvgAnwuxuSWC/4W+tPMphtBJBlsJAs
	 n+kt6MTeDnMysCNfPw9ZfeuZlKAOJMDWU84D6z7xrBFkob0HyzLxpY76/0dt/7Fo7Jg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=debian.org;
	spf=pass smtp.mailfrom=debian.org;
	dkim=pass header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b="eWLNzz/T";
	arc=none smtp.remote-ip=82.195.75.108
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3DB9606A323;
	Mon, 16 Nov 2026 13:32:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E3DB9606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=eWLNzz/T
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=jRE7R2gplNPXvMeDZFwYe1WY1elQKyKA0phFJISFMrU=; b=eWLNzz/TSq3SUtbbmp4w7SCalK
	V+ug5o0QiYlr6k4epYX8jmH6c7uTlgVMGrv6RTOBfFLH1kaP7IloCsiYzI+4AR2lLYUxhH6GmTxrg
	rpyA/f4dn+KBJRnFmGfCx1oIY1FqihQbO89ho5mjtXuRorpDpxy7zj8ihDxhT2Pahu3YD68+jBYgh
	uWpbGlXzf7pOuA9h4Smmvay9GoRSrQTklzGmeOQbJ3XcxHjAmO8emWcZnB/2Zex2W03DJKqsXZLTf
	SYLjNJUhl3QsFoaaR2tkACzg451Bz/jq7oYkNiZd8OF+4+zOjFC+dPL3PhB5oRT3hpxi2Y/xJunNQ
	GnMEPx/w==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <emfox@debian.org>)
	id 1xSwou-00HCUV-2Y;
	Mon, 16 Nov 2026 13:32:29 +0000
From: Emfox Zhou <emfox@debian.org>
To: Even Xu <even.xu@intel.com>,
	Xinpeng Sun <xinpeng.sun@intel.com>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 5/5] HID: intel-thc-hid: intel-thc: budget the receive drain
Date: Mon, 16 Nov 2026 21:31:32 +0800
Message-ID: <20261116133132.1282020-6-emfox@debian.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261116133132.1282020-1-emfox@debian.org>
References: <20261116133132.1282020-1-emfox@debian.org>
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

thc_wait_for_dma_pause() gives every engine 10 ms to report idle, but a
receive engine can be draining a whole frame. Its buffer comes from the
HIDSPI device descriptor's max_input_len, rounded up to 4 KB and capped at
16 PRD entries, so up to 64 KB; at the 2.23 MHz gear that takes about
235 ms, and a timed out pause makes thc_rxdma_reset() return before the
engines are reconfigured, leaving the controller quiesced with the
interrupts off.

Let the callers pass the budget. thc_rxdma_reset() gets one that covers a
full frame at the slowest gear. The SWDMA path keeps the old one: it
pauses the receive engines with the bus lock held and the interrupts
quiesced, and its frames are small.

Fixes: 1d46b8d40655 ("HID: Intel-thc-hid: Intel-thc: Add API to reset read DMA")
Signed-off-by: Emfox Zhou <emfox@debian.org>
---
 .../intel-thc-hid/intel-thc/intel-thc-dma.c   | 20 +++++++++++++------
 .../intel-thc-hid/intel-thc/intel-thc-dma.h   |  5 +++++
 2 files changed, 19 insertions(+), 6 deletions(-)

diff --git a/drivers/hid/intel-thc-hid/intel-thc/intel-thc-dma.c b/drivers/hid/intel-thc-hid/intel-thc/intel-thc-dma.c
index 41efdfaf0..1e68b8845 100644
--- a/drivers/hid/intel-thc-hid/intel-thc/intel-thc-dma.c
+++ b/drivers/hid/intel-thc-hid/intel-thc/intel-thc-dma.c
@@ -536,7 +536,9 @@ void thc_dma_unconfigure(struct thc_device *dev)
 }
 EXPORT_SYMBOL_NS_GPL(thc_dma_unconfigure, "INTEL_THC");
 
-static int thc_wait_for_dma_pause(struct thc_device *dev, enum thc_dma_channel channel)
+static int thc_wait_for_dma_pause(struct thc_device *dev,
+				  enum thc_dma_channel channel,
+				  u32 timeout_us)
 {
 	u32 ctrl_reg, sts_reg, sts;
 	int ret;
@@ -554,7 +556,7 @@ static int thc_wait_for_dma_pause(struct thc_device *dev, enum thc_dma_channel c
 	ret = regmap_read_poll_timeout(dev->thc_regmap, sts_reg, sts,
 				       !(sts & THC_M_PRT_READ_DMA_INT_STS_ACTIVE),
 				       THC_DEFAULT_RXDMA_POLLING_US_INTERVAL,
-				       THC_DEFAULT_RXDMA_POLLING_US_TIMEOUT);
+				       timeout_us);
 
 	if (ret) {
 		dev_err_once(dev->dev,
@@ -588,13 +590,15 @@ int thc_rxdma_reset(struct thc_device *dev)
 		goto end;
 	}
 
-	ret = thc_wait_for_dma_pause(dev, THC_RXDMA1);
+	ret = thc_wait_for_dma_pause(dev, THC_RXDMA1,
+				     THC_RXDMA_DRAIN_US_TIMEOUT);
 	if (ret) {
 		dev_err(dev->dev, "Wait for RxDMA1 pause failed during RxDMA reset\n");
 		goto end;
 	}
 
-	ret = thc_wait_for_dma_pause(dev, THC_RXDMA2);
+	ret = thc_wait_for_dma_pause(dev, THC_RXDMA2,
+				     THC_RXDMA_DRAIN_US_TIMEOUT);
 	if (ret) {
 		dev_err(dev->dev, "Wait for RxDMA2 pause failed during RxDMA reset\n");
 		goto end;
@@ -769,7 +773,10 @@ static int thc_swdma_read_start(struct thc_device *dev, void *write_buff,
 	if (ret)
 		return ret;
 
-	if (thc_wait_for_dma_pause(dev, THC_RXDMA1) || thc_wait_for_dma_pause(dev, THC_RXDMA2))
+	if (thc_wait_for_dma_pause(dev, THC_RXDMA1,
+				   THC_DEFAULT_RXDMA_POLLING_US_TIMEOUT) ||
+	    thc_wait_for_dma_pause(dev, THC_RXDMA2,
+				   THC_DEFAULT_RXDMA_POLLING_US_TIMEOUT))
 		return -EIO;
 
 	thc_reset_dma_settings(dev);
@@ -834,7 +841,8 @@ static int thc_swdma_read_completion(struct thc_device *dev)
 {
 	int ret;
 
-	ret = thc_wait_for_dma_pause(dev, THC_SWDMA);
+	ret = thc_wait_for_dma_pause(dev, THC_SWDMA,
+				     THC_DEFAULT_RXDMA_POLLING_US_TIMEOUT);
 	if (ret)
 		return ret;
 
diff --git a/drivers/hid/intel-thc-hid/intel-thc/intel-thc-dma.h b/drivers/hid/intel-thc-hid/intel-thc/intel-thc-dma.h
index 715423453..fccaac122 100644
--- a/drivers/hid/intel-thc-hid/intel-thc/intel-thc-dma.h
+++ b/drivers/hid/intel-thc-hid/intel-thc/intel-thc-dma.h
@@ -19,6 +19,11 @@
 #define THC_DEFAULT_RXDMA_POLLING_US_INTERVAL 100
 #define THC_DEFAULT_RXDMA_POLLING_US_TIMEOUT  (10 * USEC_PER_MSEC)
 
+/*
+ * 235 ms for a 64 KB frame at the slowest gear, so this covers a whole one.
+ */
+#define THC_RXDMA_DRAIN_US_TIMEOUT  (500 * USEC_PER_MSEC)
+
 /*
  * THC needs 1KB aligned address, dest_addr is 54 bits, not 64,
  * so don't need to send the lower 10-bits of address.
