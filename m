Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=82.195.75.108
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795791620;
	b=n4YTXyDEmiIJItXAjsxvAfe+VUSdN5+eZn9gxj4C9ER1/nKswE2Dllb0UpUTK2xeDKVK
	 EDIJP+BuPrrqjgphy+CdAPlEY6ZnB1cHEccF5P1oXZoRtgZrK9nSkNGAix2nrL9+dTM6W
	 OOoPImI6NMnP4Xpd5g+tCSqCLyxrNT8UH/1xaF8Wv30rwmOmz1I57Bhd2CXXKM8QAWxbl
	 2ljIBBVh7rmiqFO1YMllVW4tqBi/dvZ706dGo1CuFuq4ovmeWwk/s858aiMOQCgsGgSSi
	 YVibspEgG8E6gdz4je8Upm03ffk9gFcd9MUjRxn04zeeX952k5PhOL7n+xqZqycjxKQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795791620;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Debian-User;
	bh=P9CplHC/CQQCVSddM/IkzWxssrpRgw2+qmqvAcoperU=;
	b=tPzszAwxS+JYn9dzSVBjkB/X5fYAvALXQrr9rOtmB703yjniE3NxvZ3FOuaqu7lVbvzb
	 l4hUGF654Y1o5A0wB/joPp1ErqTPTgiTuqszBISUOqq+C53firi4tPz/TVr6N/IQpx7sg
	 uiBubkHDnh9Hz1XeQDr3jZdQ64581h+Rtw7WwebbZC8/kfA4TwWEes2D0tMalppUmNAlo
	 FrN76djAql7Qq9tzitl1WGvg8Bw0ASvnfznLI8Q0PlYhrbm0oSa9g1biwvlfAykdbUzxP
	 OK+edsYk9GrLA0pBf6pBgX748LBnt4bO1d8ZIkKtq0J3CyspsHdn9W4DydOzrFLXvag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=debian.org;
	spf=pass smtp.mailfrom=debian.org;
	dkim=pass header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=S+vds8rB;
	arc=none smtp.remote-ip=82.195.75.108
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 869B1606A321;
	Fri, 27 Nov 2026 15:00:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 869B1606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=S+vds8rB
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=P9CplHC/CQQCVSddM/IkzWxssrpRgw2+qmqvAcoperU=; b=S+vds8rBtVvYQr5u3/J43grNio
	qDOlED/MsglbbTa4RhOpCcJ4IKObIDMHj2ssXyfQlUeRYyIcmOx6fi7YmP0dl3DiLalmqebWeV/Fr
	r4DkPQ5ezz4+nIwavng5GyOxQlxN2ludOhRT9PN1XGrRFQkFRszOr7OFfcqxNZk/2bURom1E9J+jm
	a1vkwiSMG7YOS0s4Hbn8vHj5g8fTHgI2nSKansa8GPVNuxNl5Jv00DzGOAf8xwzWw9nXsBWJuNGiR
	9c3uxZC2+fxm9o8RHan52EkpBrHWRcdxYFDNXV2JBkJoi5crozODJCGquF2bA9f/2Q6jGPv7DSKQe
	ft0xEdSA==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <emfox@debian.org>)
	id 1xWxQt-008Q1Y-1X;
	Fri, 27 Nov 2026 15:00:16 +0000
From: Emfox Zhou <emfox@debian.org>
To: Even Xu <even.xu@intel.com>,
	Xinpeng Sun <xinpeng.sun@intel.com>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 5/5] HID: intel-thc-hid: intel-thc: budget the receive drain
Date: Fri, 27 Nov 2026 22:59:21 +0800
Message-ID: <517c8d7e990ffe87dae3570f9f8676e057b614a7.1795791500.git.emfox@debian.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1795791500.git.emfox@debian.org>
References: <cover.1795791500.git.emfox@debian.org>
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
index 607e21c3e..01b96c00d 100644
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
@@ -807,7 +811,10 @@ static int thc_swdma_read_start(struct thc_device *dev, void *write_buff,
 	if (ret)
 		return ret;
 
-	if (thc_wait_for_dma_pause(dev, THC_RXDMA1) || thc_wait_for_dma_pause(dev, THC_RXDMA2))
+	if (thc_wait_for_dma_pause(dev, THC_RXDMA1,
+				   THC_DEFAULT_RXDMA_POLLING_US_TIMEOUT) ||
+	    thc_wait_for_dma_pause(dev, THC_RXDMA2,
+				   THC_DEFAULT_RXDMA_POLLING_US_TIMEOUT))
 		return -EIO;
 
 	thc_reset_dma_settings(dev);
@@ -872,7 +879,8 @@ static int thc_swdma_read_completion(struct thc_device *dev)
 {
 	int ret;
 
-	ret = thc_wait_for_dma_pause(dev, THC_SWDMA);
+	ret = thc_wait_for_dma_pause(dev, THC_SWDMA,
+				     THC_DEFAULT_RXDMA_POLLING_US_TIMEOUT);
 	if (ret)
 		return ret;
 
diff --git a/drivers/hid/intel-thc-hid/intel-thc/intel-thc-dma.h b/drivers/hid/intel-thc-hid/intel-thc/intel-thc-dma.h
index f6152b420..bdf44583b 100644
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
