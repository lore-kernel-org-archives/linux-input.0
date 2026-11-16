Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=82.195.75.108
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794835932;
	b=JrJ54PodkwqmxyGHc4UFI7GDcZaLzfFpKswtAEr2kcTn8GwV0LqlIuYO+NNxLTAYY41Z
	 kmxwdKT768/RZKLg8i56TxH7w+6n/jPCErsC0disalO1GeWxmxLfVWRzD3q/8IBZEyd/s
	 U+SrdCZIjeKEZxDrwoztCM92C27roFYkJdLd3ZMuN98vWG6HRn4KsI+t4FL971nkXb6tl
	 edVr0l7QDh+tFJuIbNdEJPU0wMIKLM3ggDysJfjTUwD4a36G1gR3LumhmVPL/0FL26voT
	 Bq+iwvvIRAdwJ9QTPGj7aExMRXl2dPRqFzny+x5cv7eyTUUKBP7S8Tg2MOhbByFxCUA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794835932;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Debian-User;
	bh=CuigUoXzcxtfp7cDRhGDVJuTzYDUgteXb5DFzwjuBU8=;
	b=tdKt/0eIrY2a68RRKeU9Vo986Rc38BWMkAVtLeDijXf4toN2QtISen3TfW9xg19KLqVO
	 rdgjr6PhHbV6+4pRssf39VpIwHhUCdav2RT4zMSlCdj5TLvuS0O5Lb1K87DugWmBA/sL+
	 yaHtrz5aXPzafRaOv9jBawEw1asr8bEOP4GXgWGSje0AlikwPqe0/e36NB8XDeDlQsiYv
	 ZsEU4mgcAEGaGdwAZDbLaI6mvQAkh1i14i+9/xGs+3dYDFQe/jiIllGTmHpk+tRCwsjKI
	 NMU6Gn1l8tN4UhEJOXqWV46bv7nNi3i+4hbd5Iif0inST5gqr0T23ZF9hrFs7zOEyyg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=debian.org;
	spf=pass smtp.mailfrom=debian.org;
	dkim=pass header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=GzX44fSq;
	arc=none smtp.remote-ip=82.195.75.108
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F309A606A330;
	Mon, 16 Nov 2026 13:32:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F309A606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=GzX44fSq
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=CuigUoXzcxtfp7cDRhGDVJuTzYDUgteXb5DFzwjuBU8=; b=GzX44fSqUGfM4965LLu2Z+yC/L
	3zHdM2Pr3dyW363KdaHcOB2hdqkL4KmLjVzMkVK3awHoRgqsCmCAFCyMb0iQnBZZNpJBV4ORK3GyQ
	6/Jlz+u6NN2mFCPSlQIkz+Frk3pjkpTxp08MSb6XUnIwSbPc0PD/xj6joZoM1yr+w6zkncCKx2ZqZ
	mCHQ3Hhj6/vByW1BpZdQ4LPW6HOIRbcfxR3GSYAKmnV+BSmQ3G/ZR/eo1SharvMACJDswIIooSVpP
	mx7SA3MOxGV/Z/FA1FBzrE+9942y3mFOlHxz9hq+W+qVJ8g/dCEJw0cnDEoVTxFuOIXeMe05FOyUR
	qL5AzPMA==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <emfox@debian.org>)
	id 1xSwoZ-00HCU5-0n;
	Mon, 16 Nov 2026 13:32:07 +0000
From: Emfox Zhou <emfox@debian.org>
To: Even Xu <even.xu@intel.com>,
	Xinpeng Sun <xinpeng.sun@intel.com>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/5] HID: intel-thc-hid: intel-thc: free the failed channel
Date: Mon, 16 Nov 2026 21:31:29 +0800
Message-ID: <20261116133132.1282020-3-emfox@debian.org>
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

thc_dma_allocate() unwinds with "while (chan--)". The condition is read
before the decrement, so the first channel released is the one before the
failure, and the failed channel keeps the PRD tables and the
scatter-gather lists it did manage to allocate.

Unwind through thc_dma_release() instead, which walks every channel and
skips the ones that were never set up, and free a scatter-gather list that
was allocated but never mapped: sgl_alloc() leaves one behind when its
entry count is too large.

That leaves release_dma_buffers() with a configuration whose prd_tbls may
still be NULL, which its unconditional memset() does not survive. Clear the
tables only when there are any.

Fixes: a688404b2e20 ("HID: intel-thc-hid: intel-thc: Add THC DMA interfaces")
Signed-off-by: Emfox Zhou <emfox@debian.org>
---
 .../hid/intel-thc-hid/intel-thc/intel-thc-dma.c   | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/hid/intel-thc-hid/intel-thc/intel-thc-dma.c b/drivers/hid/intel-thc-hid/intel-thc/intel-thc-dma.c
index c0dc44e26..704c02822 100644
--- a/drivers/hid/intel-thc-hid/intel-thc/intel-thc-dma.c
+++ b/drivers/hid/intel-thc-hid/intel-thc/intel-thc-dma.c
@@ -297,20 +297,20 @@ static void release_dma_buffers(struct thc_device *dev,
 		return;
 
 	for (i = 0; i < config->prd_tbl_num; i++) {
-		if (!config->sgls[i] || !config->sgls_nent[i])
+		if (!config->sgls[i])
 			continue;
 
-		dma_unmap_sg(dev->dev, config->sgls[i],
-			     config->sgls_nent_pages[i],
-			     config->dir);
+		if (config->sgls_nent[i])
+			dma_unmap_sg(dev->dev, config->sgls[i],
+				     config->sgls_nent_pages[i],
+				     config->dir);
 
 		sgl_free(config->sgls[i]);
 		config->sgls[i] = NULL;
 	}
 
-	memset(config->prd_tbls, 0, prd_tbls_size);
-
 	if (config->prd_tbls) {
+		memset(config->prd_tbls, 0, prd_tbls_size);
 		dma_free_coherent(dev->dev, prd_tbls_size, config->prd_tbls,
 				  config->prd_tbls_dma_handle);
 		config->prd_tbls = NULL;
@@ -425,8 +425,7 @@ int thc_dma_allocate(struct thc_device *dev)
 	return 0;
 
 release_bufs:
-	while (chan--)
-		release_dma_buffers(dev, &dev->dma_ctx->dma_config[chan]);
+	thc_dma_release(dev);
 
 	return ret;
 }
