Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=82.195.75.108
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794979932;
	b=n/U6j5rq/a+EyHG5AZMd4AXDIIKvSIeFoCQUSryJf+/zpzBJg7+0YQZJEQ81bPGShzX0
	 dYo9dW+XB7n0oabAMaYiP3IGbtNzrxiTtgf5k5zKLlpAI0W2c4/eG58+GPwHbDEv3eYJM
	 yxA7Gp9U13kCmVIGhgy39Q/6o96ck3XNu9lPHf9df9bUf8VFXpm6hg4EzZy6gkaDmiNOm
	 WJ1Hh413Y/sZ/3guqbnYOufczfgzavQ7M6mOEN4QnFVe5++IPHxbw+gsge2tuBk2KRKvH
	 DgF550ZyFyxZ5orZj/0EldQR1zobDCDc4qwEim001oH7/ROB1zB9wgA33F/hvlBfjQQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794979932;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Debian-User;
	bh=CuigUoXzcxtfp7cDRhGDVJuTzYDUgteXb5DFzwjuBU8=;
	b=Xi2zvslB8UWZtkGJdQutheNBCqqrJoH/RmWdVql/2VOiUS6IsoWnx9dF9RJfRlL8mq30
	 Ori1+VBzUewcJzKw8UOkujmYJiBuZyVLQX8oEulM4PCwVbQMinpZ0q0xQU5jHlLHX/Ffj
	 ZjvxjXJOSTTQUH+wFifk6toLeNxS0LGaqX1mqn/KAljiHku60Eecx3jsAf/sNNgzd10XJ
	 671Hqs+zwdpvsQfYFYA8RTwB5MpGAAJ/n/6hOSrK44+p8BEr08PbvHU6pbO8/IeWgTUgY
	 nVko/OiNfQSQCfTd4kd4wQWKSCoQqx2Cifk/BMVxuPME9t9yxMwh+XvSCMfLtKZqxeg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=debian.org;
	spf=pass smtp.mailfrom=debian.org;
	dkim=pass header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=okHoPfJI;
	arc=none smtp.remote-ip=82.195.75.108
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5535B606A33B;
	Wed, 18 Nov 2026 05:32:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5535B606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=okHoPfJI
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=CuigUoXzcxtfp7cDRhGDVJuTzYDUgteXb5DFzwjuBU8=; b=okHoPfJIDJII7ZN6lf3Egf226i
	kpvudIE4VlO7z6YZhJNRxQPyhXNZQN+M6v5Gg1/2pZ7dNemGTzYEaCv31yAPV769hBTpHKl7AqZ5m
	H76UbR3PCtPSYM8/0hzpeEzksoJ0Ut21XpX3tekqAR6gxJV3v8blDcDy2XAoZm988PXM82PY0DzPN
	NK35Gwe0nbbNZKcE9uNrRR5OEAzR1YA8LUCdbj6we6iLGPoVaTThyBWPZUymNqVx9G42jDB3wVyiQ
	JM4+dm87wjUew6ALYa6WpA67GzAzfZGkWWClB7SFQAsupuTa/lcjgAPoucYUwNtZkL1Z3iPMKuO16
	nvHQ+m2w==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <emfox@debian.org>)
	id 1xTYH9-00151m-31;
	Wed, 18 Nov 2026 05:32:08 +0000
From: Emfox Zhou <emfox@debian.org>
To: Even Xu <even.xu@intel.com>,
	Xinpeng Sun <xinpeng.sun@intel.com>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/5] HID: intel-thc-hid: intel-thc: free the failed channel
Date: Wed, 18 Nov 2026 13:31:29 +0800
Message-ID: <20261118053132.253448-3-emfox@debian.org>
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
