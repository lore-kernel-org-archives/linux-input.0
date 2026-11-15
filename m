Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=82.195.75.108
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794715700;
	b=sgsYG2QdE1aP4Wlpvth8xjAbd2zidh8u0UbsALmZxJYDqkJ+UeNFCPQAtpmCe0a2sRQT
	 wwcihMDT6PngC0GNcA2oOlniYGgjXWw28qgNSIsbyyz5kWiUvrKubGVd909aEs0CFNFyf
	 p9OZktdhtXIaOF/YjzoVm22qgeP6PX4hynEVZqtBTMhM6nvdlXIQ+RYAI51dDYhouyd/S
	 ZizAlDTqaGPx5uhyySywg/ozX17LfcIyGIc51JERwrCrLsrHp+xnHe0OemOUhZA/S9euD
	 1EZmmgLUjXv7Vk+/OZA8CeAziwA8XiNGs7NCdrUHIa9jExmJKFDZKnYnNlWY4RuIkyQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794715700;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-Debian-User;
	bh=O1aNnud1hC5sF5Cj79XKOT6k43FxwiLQRFJz6PwV4w0=;
	b=tCuONMqKJhSFAt/Q+LcpDBJwqKV7HQo+cfCTz0tO9iO4dJrAzc2LsaCo2rSB63MYsUYF
	 cZD4TbPwFtMQ7JiRpMXC1YpQWt+/62QyHtylNtgs5c1DhMuSIJAJPjW623Ho5Wx6FOe3g
	 4VEmHOZ0vM1aW28HuEyKdRp/BDVitLOka32jIqhFcZMoOeYflxrPBKWNOWCYY8gutD4ZW
	 WAzn6hJiYvT97+ZSauqw4sB0PVpYrny5VHXGNmTma6Jw+iwUQEI1IF6lueNmdgFWTnOWy
	 cI6EKsm+F9iXCeiwXbw3SLu75tiK3lipXQPNbge4vTJcbvVdxrZs3Xad+FzDJx3mVfg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=debian.org;
	spf=pass smtp.mailfrom=debian.org;
	dkim=pass header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=FOskF0Jr;
	arc=none smtp.remote-ip=82.195.75.108
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E72FD606A323;
	Sun, 15 Nov 2026 04:08:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E72FD606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=FOskF0Jr
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Content-Transfer-Encoding:MIME-Version
	:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=O1aNnud1hC5sF5Cj79XKOT6k43FxwiLQRFJz6PwV4w0=; b=FOskF0JrODUjr+o/LBTmc+f6S8
	jIyccQpozHnowAORmzMCJnXljGXDwUclaAQzJNfuxGL+oRQrcL2qwVOKi61uDdObZjGPqZQcQIhr/
	9KCgVhAfv2OwAJeerZkLpp54zuDMJt74jOczCHYl4JOVuzYPFofzk18+8Y/FoMIreHPaQIG1+xImK
	6uovcA7q990kaDNF4KEBQM2rE1h0zfCTFIIqdkPqJY9XXbrrRL9lChWEdENZqoWR1XHJ6VhoNVuie
	Gf5bUhZs+cLYnRp4hhiOad6G5UeiJXjhvu6Q5hXEK0xMkxsJR/Ftpp3YdiFBtZIST/H0c2RRZw0zv
	tt3PsFOw==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <emfox@debian.org>)
	id 1xSRXJ-00G33F-0Q;
	Sun, 15 Nov 2026 04:08:13 +0000
From: Emfox Zhou <emfox@debian.org>
To: Even Xu <even.xu@intel.com>,
	Xinpeng Sun <xinpeng.sun@intel.com>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3] HID: intel-thc-hid: intel-thc: restore PRD table capacity
Date: Sun, 15 Nov 2026 12:07:56 +0800
Message-ID: <20261115040756.602092-1-emfox@debian.org>
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

Rebuild the receive tables in thc_dma_configure(), after the pointers are
rewound and before the engines are started again, which covers probe, the
RxDMA reset and the resume path. All four engines are stopped at that
point, so nothing reads the tables while they are written, and
thc_copy_sgls_to_prd() returns early for a channel whose tables are gone.

Fixes: a688404b2e20 ("HID: intel-thc-hid: intel-thc: Add THC DMA interfaces")
Signed-off-by: Emfox Zhou <emfox@debian.org>
---
Changes in v3:
  - Restore the tables from thc_dma_configure() rather than from
    thc_reset_dma_settings(): the reset also runs on the SWDMA path, where
    nothing stops a reader.
  - Do not touch a table that has already been released.
  - v1 was posted under an older subject.

Link: https://lore.kernel.org/r/20261115001100.313270-1-emfox@debian.org
---
 drivers/hid/intel-thc-hid/intel-thc/intel-thc-dma.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/hid/intel-thc-hid/intel-thc/intel-thc-dma.c b/drivers/hid/intel-thc-hid/intel-thc/intel-thc-dma.c
index c80ef8c20..64fd890e5 100644
--- a/drivers/hid/intel-thc-hid/intel-thc/intel-thc-dma.c
+++ b/drivers/hid/intel-thc-hid/intel-thc/intel-thc-dma.c
@@ -211,6 +211,9 @@ static void thc_copy_sgls_to_prd(struct thc_device *dev,
 {
 	unsigned int i;
 
+	if (!config->is_enabled || !config->prd_tbls)
+		return;
+
 	memset(config->prd_tbls, 0, array_size(PRD_TABLE_SIZE, config->prd_tbl_num));
 
 	for (i = 0; i < config->prd_tbl_num; i++)
@@ -491,6 +494,10 @@ int thc_dma_configure(struct thc_device *dev)
 		return -EINVAL;
 	}
 
+	/* Pointers rewound, entries still short: restore before restart. */
+	thc_copy_sgls_to_prd(dev, &dma_ctx->dma_config[THC_RXDMA1]);
+	thc_copy_sgls_to_prd(dev, &dma_ctx->dma_config[THC_RXDMA2]);
+
 	for (chan = 0; chan < MAX_THC_DMA_CHANNEL; chan++) {
 		dma_set_prd_base_addr(dev,
 				      dma_ctx->dma_config[chan].prd_tbls_dma_handle,

base-commit: 7475ea8b58616b33c04afb976cf0fbaad9dd63fb
