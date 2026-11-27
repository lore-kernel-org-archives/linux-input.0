Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=82.195.75.108
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795791592;
	b=DOs+GK64u+k2GIL7hxVBtYU5DOQb/cOfJv2nZh2jPtgfyS2q3s9+T+etkzxO5Dt01FNF
	 7vVkSEq1dnAxBllJHwBBD7R0Kflakb0mbdFZaqDl0+NSP3yhrQckHr3xlZac0wjZCufcJ
	 I/YcU9tSrBYRKthq9q9uIMCjZgWY6Rnd8/FjVgsJsDaScpFd9e7bCPPc0+ULZANVCMxs6
	 gMrQQsOCjLLeLaMPOoPIxsdaZ4uJo8Co1lHzlxpemw+nt5db5ZTZW66GYgC9URuHw5cLC
	 j32c7ptYxUYB43PBdHgX/NaDgZB7DAU9v/clpQUnxYbZcJwJx5EvNN9huRQbRqgt8cg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795791592;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Debian-User;
	bh=O7v/y8yAioWFqsoLE62d9/WzIQU4+wJNca36cZg8eGU=;
	b=OXjJ1qLe/3SlPZYkpNNQWPMt4jTicB0W2KRLX+anR2xUPVxNWpbC5PKQCVx/QVSkhqRu
	 HeSmeeUYVFEnXiNzPLZKEpl8IYJ+UR3gHvHtFpUaHo0K3qUefDLbp1122tXV+rszhRlg9
	 opHKBeh3YM0w95eI81DpKhGHpYeQzVTg1yP3xsIbyspnm8Kop6/7f5iKE2sFuapmgbJfz
	 m17Y7V8oErFMVP4lL9XUr4uVIoYcOHYPv0uk1FWqPcQ1gynidtIATLDRYPmWOCn1wCQFb
	 sqS3dthA6Ewab6Tor5nUf1IFujuIECl+633hs8K6zrSJBIktwmTjos1Ju1WQXxzDv0g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=debian.org;
	spf=pass smtp.mailfrom=debian.org;
	dkim=pass header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=MmhkrhlK;
	arc=none smtp.remote-ip=82.195.75.108
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC658606A329;
	Fri, 27 Nov 2026 14:59:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EC658606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=MmhkrhlK
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=O7v/y8yAioWFqsoLE62d9/WzIQU4+wJNca36cZg8eGU=; b=MmhkrhlKptj7seqNXqkc6BwpsG
	jG//cFF7T3oHeHszb9qn+w3O/nfdUGcAv13sXXm1nIYnaphExjW0wko/a+xlPtGmrXKJNuxo0miAu
	gPdruB3DYw+fpU8nIo8TQ4Rfdv9BcA2liAB8GvCFWGoy4b5K7WQ3Ymyh6LYXNiVYghDcagb9dpWY0
	nOJZ2Jty9jTHDdC6D1Ajg9QKyFe3SIx9JqJ2/tCNx7xDJvVa7b/d006mBNyBs7Zl3vUFMLOgyjRFi
	Hzwg9Fpu7QezhfeOOla/I7o9k8AxpUdyadI0aLlOdCIMbdrXEbB3LPrACR5WE70xymXFVTkSBjsWv
	zrMU/t0Q==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <emfox@debian.org>)
	id 1xWxQQ-008Q0J-2v;
	Fri, 27 Nov 2026 14:59:47 +0000
From: Emfox Zhou <emfox@debian.org>
To: Even Xu <even.xu@intel.com>,
	Xinpeng Sun <xinpeng.sun@intel.com>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/5] HID: intel-thc-hid: intel-thc: free the failed channel
Date: Fri, 27 Nov 2026 22:59:18 +0800
Message-ID: <138387c77a8dcef2f755a8fda73fbd37d7bf1096.1795791500.git.emfox@debian.org>
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
index 3093524f3..15a2966f7 100644
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
