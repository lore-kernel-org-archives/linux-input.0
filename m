Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=82.195.75.108
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794698295;
	b=YfGyeDRunHq6MfzDzUuqrjx1ltffQx/TgwqhR8BP/kQLQW12dmQ71WHU4hQip+usKt/r
	 84eKedAAMX59hq+W+eriMpjXglgGHMQyS7nSTdsqN7+a/+fx9ijfk+8kRG08zxuMtcJgg
	 8AwVuYAq8N3Y+Wxf5ahBDOheJqFosBpE5blUYpRoIBYFf/yziDYpkS6C9zW5zXwiSxHi2
	 0L4KcR9k2eWvvKt37+VyyUadc8S/Uvg7skO4BwtOzBXAdU7Xly6ysVp5xfAh0oiuY5/E7
	 SIjKw52OcCq7K1Q470720FdgvV9Sih7xLk4/6PkRnFu0V66+BA5CZSM4U4If+zVCRJA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794698295;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-Debian-User;
	bh=Vi/p4fUVhpFjb9s6Vzfmbzm5sEOD5y84qq3KlrB9vm0=;
	b=F9xdeG2vXCUeyasaV9oH1GwK22Ml/HP0cixl8u9RTZkCZL90EYtOjzQpXICs4Uu8/xmC
	 ZHCHIRSejrZ8jlR/L76Z6RHFOEZN5PoAWNShhERb8JTlOhAMHinpmqStb4tTsizOPnPgX
	 Sux/60ITqqq0XXlFQAK77EkfXGUGt+POm91HE1mOBOHb879GPIwAsOwoNatsx9gdnvtnE
	 dSXKgcsL1yaV19A56rFVz4Z3GBphDSB4B5idz7swruRuEe0Yy+7ID/sk4QC0qF4ShKK6G
	 /Qqvs/XNuFntfcUU9qhVKxoGL4qsaUYz8v9ROdPv2qnx9KQZNqQPrfPLGAea/n8MrXQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=debian.org;
	spf=pass smtp.mailfrom=debian.org;
	dkim=pass header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=dezgWBh2;
	arc=none smtp.remote-ip=82.195.75.108
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9032B606A327;
	Sat, 14 Nov 2026 23:18:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9032B606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=dezgWBh2
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Content-Transfer-Encoding:MIME-Version
	:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=Vi/p4fUVhpFjb9s6Vzfmbzm5sEOD5y84qq3KlrB9vm0=; b=dezgWBh2FEc4ztJF/MRQz6EXXn
	8/1nD5ixSfz7+6+7Bj1cnhTvdVx6E38/olpPH1kWA28uLzTbiSpU/kkpJwRhKEVs90HwPH3bpP2Ol
	FICPuf28tt09gn3L73uVnLrqhfwjdx91iep0c4PM1X24H93u22u2kbMnuM8FFDgucIZmSe8ZcmwtO
	1x7nGSFF17mGg69HX7aZ5OKBGmoHNfO1pFC/rie4oASn8bEu2WSp+HXgPF3NYLJSepx8VEkbdYnoE
	yx5aqF0lXg5++8tE37oB/gs7ltRMacI2kId4zt4JyYebiVT3epal7IdKu8XzNavVKlhyeWxupeqJz
	MqD7Kc0g==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <emfox@debian.org>)
	id 1xSN0a-00FtUe-09;
	Sat, 14 Nov 2026 23:18:08 +0000
From: Emfox Zhou <emfox@debian.org>
To: Even Xu <even.xu@intel.com>,
	Xinpeng Sun <xinpeng.sun@intel.com>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] HID: intel-thc-hid: intel-thc: rewrite PRD tables on reset
Date: Sun, 15 Nov 2026 07:17:33 +0800
Message-ID: <20261114231733.3916070-1-emfox@debian.org>
X-Mailer: git-send-email 2.55.0
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

RxDMA reset takes the DMA configuration down and puts it back, but leaves
the PRD entries as the controller wrote them. A frame that was queued and
not read keeps its shortened length, so the next frame runs past the end of
the table: the controller reports a buffer overrun, which is a transfer
error and leads back into the same reset, with the tables still untouched.

Write the receive tables again while both engines are paused, before the
configuration starts them. The configuration is the wrong place for it: on
resume it runs with a frame that arrived before the suspend still queued.

Signed-off-by: Emfox Zhou <emfox@debian.org>
---
 drivers/hid/intel-thc-hid/intel-thc/intel-thc-dma.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/hid/intel-thc-hid/intel-thc/intel-thc-dma.c b/drivers/hid/intel-thc-hid/intel-thc/intel-thc-dma.c
index c80ef8c20..28a1aa97b 100644
--- a/drivers/hid/intel-thc-hid/intel-thc/intel-thc-dma.c
+++ b/drivers/hid/intel-thc-hid/intel-thc/intel-thc-dma.c
@@ -211,6 +211,9 @@ static void thc_copy_sgls_to_prd(struct thc_device *dev,
 {
 	unsigned int i;
 
+	if (!config->is_enabled)
+		return;
+
 	memset(config->prd_tbls, 0, array_size(PRD_TABLE_SIZE, config->prd_tbl_num));
 
 	for (i = 0; i < config->prd_tbl_num; i++)
@@ -598,6 +601,10 @@ int thc_rxdma_reset(struct thc_device *dev)
 
 	thc_dma_unconfigure(dev);
 
+	/* Still paused: the configuration starts the receive engine again. */
+	thc_copy_sgls_to_prd(dev, &dev->dma_ctx->dma_config[THC_RXDMA1]);
+	thc_copy_sgls_to_prd(dev, &dev->dma_ctx->dma_config[THC_RXDMA2]);
+
 	ret = thc_dma_configure(dev);
 	if (ret) {
 		dev_err(dev->dev, "Re-config DMA failed during RxDMA reset\n");

base-commit: 7475ea8b58616b33c04afb976cf0fbaad9dd63fb
