Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=82.195.75.108
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794979939;
	b=ByZoRuh4+8L983cSdKr8tAtb/rVMNmq6Hgl/Ne1EmdZm8rM3ZyT9W91DyJa24/uZVg4R
	 QK2kDvNuMWTuxfnJKpVlQpy2dpu+rLRK9x6Dw8vxdf6OPFLvJ1RwDM0hk7Ib1XdgbKBre
	 AlHXdTIp5bvq+poxpaSHhgNRe2M0pF/qd92YNa5HZNxQSWuKriaicXm1SUoQGfakMkLqy
	 SB0VEKwiJfdRtiB7nHK1tWJShfZsaokfbSGyKmEvvbF+/t28tNB5mNTPz1lFMkzxPtLCj
	 r6epBvt9LlJfqLxkd26Im2vmVNCLV+EETJIUErBUop03Hz4dQvuWTggTi1u4AZmNPbQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794979939;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Debian-User;
	bh=O66WQhp15wYn61FOktozXGhiXKtOGH/hvfWxN7C9R+Y=;
	b=qbog8HQ8drQZ4iQ80BnlTad7CA50BjaXKkjGmKez4CYJspaTqPVtOjnShJSBjuldY+sm
	 lLWwgGF54KoMvF1Krh6uWjz6OG10OXYj2qi25UG59DKAnuF3Ox/89N5+jwkFXvQlYA3kl
	 RGPgq0gazBee0VtKrxMalBmAD/oxEUOVbLLeSabIOE1JGxeFGd0fbsfUzP5ufdW5LeEO/
	 oVKQUM2PLjVF0QWPEqKFg/c0Tf8rEhExP9YnVVhQ/Pr3WINE7RuYUtq8mgevyqCNPJh/M
	 brH83ST/8VbZ55P+pKKo9ZuhgKHUUM40/W976kE5KMRMDuo0pDjS69rL0bwqqtmzQKw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=debian.org;
	spf=pass smtp.mailfrom=debian.org;
	dkim=pass header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=STaNcSN9;
	arc=none smtp.remote-ip=82.195.75.108
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8511606A325;
	Wed, 18 Nov 2026 05:32:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E8511606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=STaNcSN9
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=O66WQhp15wYn61FOktozXGhiXKtOGH/hvfWxN7C9R+Y=; b=STaNcSN9s1x5BWZdq1cqtSY7zE
	+XinaOEYhRF+zM0lREauwK8OYgk0yYMZasGr2yQ0yFm3Fs7UZioGuDFzTwmMVVmVHsN07umBc81dx
	2ZEpDC7cBxmZocqM8dRW4N3lAx9jNP/12Okhpz5DT++yX+qcugNwaz3Gd5cMR3VmIbEZSyiHAxqwo
	UJVL1UIF9qBNSmnLmExMFGp7fESLyRJ4SEX4NMYVJremqunkUNPnQuvh+HvRehYnNjMGT/0cUviRM
	iGcraCv2JP6lH/qMazNVnCOxz81ItyC/LBDQofhjG1H71rX2dc3KYEVFiI/irwu+UMhF28Uvh5A8X
	wV1tjykg==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <emfox@debian.org>)
	id 1xTYHG-00151s-0i;
	Wed, 18 Nov 2026 05:32:14 +0000
From: Emfox Zhou <emfox@debian.org>
To: Even Xu <even.xu@intel.com>,
	Xinpeng Sun <xinpeng.sun@intel.com>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/5] HID: intel-thc-hid: intel-thc: stop all engines first
Date: Wed, 18 Nov 2026 13:31:30 +0800
Message-ID: <20261118053132.253448-4-emfox@debian.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261118053132.253448-1-emfox@debian.org>
References: <20261118053132.253448-1-emfox@debian.org>
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

thc_dma_unconfigure() clears the PRD base address and the control
registers of every channel, but stops only the two receive engines. The
write and software DMA engines keep their start bit, so an engine that is
still running is left pointing at a table base of zero.

Stop all four engines first, and clear the tables afterwards. The four
start clears move to thc_clear_start_bits(), next to the per channel
setter, and thc_reset_dma_settings() uses it as well, so the set of
engines is written down once.

Fixes: a688404b2e20 ("HID: intel-thc-hid: intel-thc: Add THC DMA interfaces")
Signed-off-by: Emfox Zhou <emfox@debian.org>
---
 .../intel-thc-hid/intel-thc/intel-thc-dma.c   | 33 +++++++++++--------
 1 file changed, 19 insertions(+), 14 deletions(-)

diff --git a/drivers/hid/intel-thc-hid/intel-thc/intel-thc-dma.c b/drivers/hid/intel-thc-hid/intel-thc/intel-thc-dma.c
index 704c02822..41efdfaf0 100644
--- a/drivers/hid/intel-thc-hid/intel-thc/intel-thc-dma.c
+++ b/drivers/hid/intel-thc-hid/intel-thc/intel-thc-dma.c
@@ -94,6 +94,18 @@ static void dma_set_start_bit(struct thc_device *dev,
 	}
 }
 
+static void thc_clear_start_bits(struct thc_device *dev)
+{
+	regmap_write_bits(dev->thc_regmap, THC_M_PRT_READ_DMA_CNTRL_1_OFFSET,
+			  THC_M_PRT_READ_DMA_CNTRL_START, 0);
+	regmap_write_bits(dev->thc_regmap, THC_M_PRT_READ_DMA_CNTRL_2_OFFSET,
+			  THC_M_PRT_READ_DMA_CNTRL_START, 0);
+	regmap_write_bits(dev->thc_regmap, THC_M_PRT_READ_DMA_CNTRL_SW_OFFSET,
+			  THC_M_PRT_READ_DMA_CNTRL_START, 0);
+	regmap_write_bits(dev->thc_regmap, THC_M_PRT_WRITE_DMA_CNTRL_OFFSET,
+			  THC_M_PRT_WRITE_DMA_CNTRL_THC_WRDMA_START, 0);
+}
+
 static void dma_set_prd_control(struct thc_device *dev, u8 entry_count, u8 cb_depth,
 				struct thc_dma_configuration *dma_config)
 {
@@ -267,14 +279,7 @@ static int setup_dma_buffers(struct thc_device *dev,
 static void thc_reset_dma_settings(struct thc_device *dev)
 {
 	/* Stop all DMA channels and reset DMA read pointers */
-	regmap_write_bits(dev->thc_regmap, THC_M_PRT_READ_DMA_CNTRL_1_OFFSET,
-			  THC_M_PRT_READ_DMA_CNTRL_START, 0);
-	regmap_write_bits(dev->thc_regmap, THC_M_PRT_READ_DMA_CNTRL_2_OFFSET,
-			  THC_M_PRT_READ_DMA_CNTRL_START, 0);
-	regmap_write_bits(dev->thc_regmap, THC_M_PRT_READ_DMA_CNTRL_SW_OFFSET,
-			  THC_M_PRT_READ_DMA_CNTRL_START, 0);
-	regmap_write_bits(dev->thc_regmap, THC_M_PRT_WRITE_DMA_CNTRL_OFFSET,
-			  THC_M_PRT_WRITE_DMA_CNTRL_THC_WRDMA_START, 0);
+	thc_clear_start_bits(dev);
 
 	regmap_write_bits(dev->thc_regmap, THC_M_PRT_READ_DMA_CNTRL_1_OFFSET,
 			  THC_M_PRT_READ_DMA_CNTRL_TPCPR,
@@ -518,16 +523,16 @@ void thc_dma_unconfigure(struct thc_device *dev)
 {
 	int chan;
 
+	/*
+	 * Stop the engines first: one that is running keeps writing through
+	 * a table whose base is already gone.
+	 */
+	thc_clear_start_bits(dev);
+
 	for (chan = 0; chan < MAX_THC_DMA_CHANNEL; chan++) {
 		dma_set_prd_base_addr(dev, 0, &dev->dma_ctx->dma_config[chan]);
 		dma_clear_prd_control(dev, &dev->dma_ctx->dma_config[chan]);
 	}
-
-	regmap_write_bits(dev->thc_regmap, THC_M_PRT_READ_DMA_CNTRL_1_OFFSET,
-			  THC_M_PRT_READ_DMA_CNTRL_START, 0);
-
-	regmap_write_bits(dev->thc_regmap, THC_M_PRT_READ_DMA_CNTRL_2_OFFSET,
-			  THC_M_PRT_READ_DMA_CNTRL_START, 0);
 }
 EXPORT_SYMBOL_NS_GPL(thc_dma_unconfigure, "INTEL_THC");
 
