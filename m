Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=82.195.75.108
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794701473;
	b=LC0u0iw10oFYamZzhXSJSzOgdtXIn7qcxKpImSoOr0fn5AKHpN3iniA3OLyF0SrqXi9h
	 VLYYZ3mUSed0YNUg9GM3uMBjidpIDDGr6eKzhRhA8HL+uzWwVqY60koXxAWBOpkHY9jFA
	 9tXtFw0nIX3JhB4j0xEIAGxelQDAn5oiOVfmFc4ZITc2Rk8OHaAKS0EcbblhgwoXWQDyo
	 snID+6iMx/4CH6K2Y+YPE3ADgsjV6ZDxBGHa5Mbi3XENpzFWFFrqP5WUBjotD0mlmEnAJ
	 C8qn8CnNyF1jZnA1k1FLGUwmgyeG81IkZgORAU8Qeg0P67Gq10C8I3/NtUEp7rFCYqQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794701473;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-Debian-User;
	bh=DP8Fud0aitYtm0WeT7qB38AzPuoqfPmxd/HrKwDPkJY=;
	b=qqnsKkrHbjq8P3TmbyqIov98mCOCmiNhfrrJ1vOWvLofwk0cDs1X+hm8AhZBqlBxn0ua
	 xsaB67TemEFB7OXVVGMnNVIHOaGnlZ4MsXvMtUokMF8AirWM95xH2NCU+ZtFomdERdGuF
	 cXWdP7s39l+duUUM563xIjgazPLjlcYj/SwVvneAmHAMYdkY4aLpmASWr6VkHkv6NpQU9
	 /xMFC40uZUPXtFK9JrypyefXknkuktHBEDNrmuwOydsMVifQxlWbLN9ehErRCZt6s/+QM
	 XUyObbUK3kuDHjWxD6BLJRRjlGf3qwRk5UjxWCiXXldxfE+ixoJo97uF66FVwwgR0lg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=debian.org;
	spf=pass smtp.mailfrom=debian.org;
	dkim=pass header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b="faxk/Djw";
	arc=none smtp.remote-ip=82.195.75.108
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C92AA606A329;
	Sun, 15 Nov 2026 00:11:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C92AA606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=faxk/Djw
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Content-Transfer-Encoding:MIME-Version
	:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=DP8Fud0aitYtm0WeT7qB38AzPuoqfPmxd/HrKwDPkJY=; b=faxk/Djw7exjo2IIJq14qNYzS5
	LMvHbWbuUNAjrA9PlCALaBgEdhUEapXaK29XABsPX/0NBp6jIFgCcSg3B3d52teAHIJfpJlmi4s+H
	2sF58//HLJDaSnu0baDdd5AjQNFePCMZXE+wPiqFbAWGLpCEh6VCjv7E1KZN6brzx0I07EJ3rSsxY
	quUffal8jUt6bYnzoevdMigZre9EpoyXppoGk5NFBouKO7vuyYr9rwGntrODpVpCXeX9o8PWB9uhs
	hwm8uQ2M6h63+dyxjSZM+0/rb3lFl5eeG76V7HfTljX0c5G98EeAnCQW7P3JpD96scKXBWLD2Gn5q
	2A1RpQTA==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <emfox@debian.org>)
	id 1xSNpp-00FvGQ-37;
	Sun, 15 Nov 2026 00:11:06 +0000
From: Emfox Zhou <emfox@debian.org>
To: Even Xu <even.xu@intel.com>,
	Xinpeng Sun <xinpeng.sun@intel.com>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] HID: intel-thc-hid: intel-thc: restore PRD table capacity
Date: Sun, 15 Nov 2026 08:11:00 +0800
Message-ID: <20261115001100.313270-1-emfox@debian.org>
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

The controller writes the frame length into the PRD entry it filled and
marks the end of the frame there; only the read path puts the capacity
back. thc_reset_dma_settings() rewinds the read pointers, so the ring
reads as empty while the entries keep those lengths, and the next frame
that does not fit runs past the end of its table: the controller reports
a buffer overrun, which is a transfer error and leads back into the same
reset, with the tables untouched.

Restore the receive tables where the pointers are rewound, which covers
the RxDMA reset, the resume path and the SWDMA round trips in one place.
Every caller has the engines paused: the reset and the SWDMA paths wait
for them, a resume finds them stopped by the suspend, and a probe has
just rebuilt the tables anyway. thc_copy_sgls_to_prd() returns early for
a channel that has no tables.

Fixes: 1d46b8d40655 ("HID: Intel-thc-hid: Intel-thc: Add API to reset read DMA")
Signed-off-by: Emfox Zhou <emfox@debian.org>
---
Changes in v2:
  - Move the restore into thc_reset_dma_settings() so every pointer rewind
    is covered, and add the Fixes tag.

Link: https://lore.kernel.org/r/20261114231733.3916070-1-emfox@debian.org
---
 drivers/hid/intel-thc-hid/intel-thc/intel-thc-dma.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/hid/intel-thc-hid/intel-thc/intel-thc-dma.c b/drivers/hid/intel-thc-hid/intel-thc/intel-thc-dma.c
index c80ef8c20..544bf3a6b 100644
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
@@ -285,6 +288,16 @@ static void thc_reset_dma_settings(struct thc_device *dev)
 	regmap_write_bits(dev->thc_regmap, THC_M_PRT_READ_DMA_CNTRL_SW_OFFSET,
 			  THC_M_PRT_READ_DMA_CNTRL_TPCPR,
 			  THC_M_PRT_READ_DMA_CNTRL_TPCPR);
+
+	if (!dev->dma_ctx)
+		return;
+
+	/*
+	 * Pointers back at the start while the entries keep the lengths the
+	 * controller wrote: restore the capacity for the frames that follow.
+	 */
+	thc_copy_sgls_to_prd(dev, &dev->dma_ctx->dma_config[THC_RXDMA1]);
+	thc_copy_sgls_to_prd(dev, &dev->dma_ctx->dma_config[THC_RXDMA2]);
 }
 
 static void release_dma_buffers(struct thc_device *dev,

base-commit: 7475ea8b58616b33c04afb976cf0fbaad9dd63fb
