Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795754848;
	b=B+3AdPnfyHYYDZI8hv3w7j6OOTX/ocEgpipZ1qlfC39iMj1mTchabkrn/0IUnpMbxrWB
	 ywee3StighhQK07aK6al3ZdCMpp/bDlAq7a2xniOYrXBlea1Ka43mO1SBqqUxkfmAZp/Z
	 +TxWIYNpofxtw5nO6CUtawfXMN48EDb1IYl2OGclIOJ5R5xj/9L+vqxPRS+v06AlOHtcb
	 7Qk82mBMXUUQfow8f4U+oGEnHOm64QXbNbid6GUePiu3sKKCtMgPXYPMAv3yUrNV9+dTG
	 /cyGscbWDLNN8FpJIuafu0m8R3CVJ5SOww8hYYW8OrI6CPTRIubJzitFAJx6mQ8hW9Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795754848;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=hhWbnd1GeIVZ9hq0Bu34JgMJF0xS6SzA2+sYatBHwFs=;
	b=v8u3GiTQJAdN6v3YXMxvs+/RBJ8EjYLPCjDxOM1XjJxFnB0gn6TUskXAubifG55OHZpT
	 J2RIzJGlziNUREex5IHW9zcuLIBe9A0M56oJvgA1mqbgB0KmnoGrqUfCVCB6U9sTo0OV8
	 hoET2asQ+UtuqqD+fX3YkxICkYfriCB9v1m7NdR+jbEiCMmg5U1/h4vwCtB895MPrLUgm
	 Y7FSMrzrfGXnygCSK8lahlYnxwqPXDuWsVa+nI+X7eB/rVE94Nk/Rywpr9lOTHaTftRLD
	 W8Ci+hM58L9YErWPKzRv12Lb22pc/AKRQ5nRdFLb1VGRzmsSiuutIGlnME/UxKVOzVA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AMG77+b2;
	arc=none smtp.remote-ip=74.125.82.180
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93E3C606A31C
	for <linux-input@vger.kernel.org>; Fri, 27 Nov 2026 04:47:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 93E3C606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AMG77+b2
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-3866a784546so10519742eec.0
        for <linux-input@vger.kernel.org>; Thu, 26 Nov 2026 20:47:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795754848; x=1796359648; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hhWbnd1GeIVZ9hq0Bu34JgMJF0xS6SzA2+sYatBHwFs=;
        b=AMG77+b22JuIdGerH9kErHw+7ek4I23A2vLZan8A+0NggyvcIxby4Tg8V6DMuEOkzh
         QtT835xYS4w5Mt5xmRwcrbosW+/E3hW77ZNASyEn+0x3nsWmFAgiWh6aF3UFj2uAnhkH
         hf6k5JiOyqRvUoBTjzBLPgdtEIYrpXm24q1m4fqptOeV6KOmRjDCQ6nuBtlfuh+2hoJs
         iIZIYWiADDbAK46bGZe7RYt2mtxWipnFtQ80+mcPcM0zwFLohV610QHbLYAWJ99RioiW
         YNxrRRj439oYxpDSTBIc47QJTYVuq+VVu3yCKzyKvByYwsxjyuheD6+YUKDtlveYqtJJ
         /OVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795754848; x=1796359648;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=hhWbnd1GeIVZ9hq0Bu34JgMJF0xS6SzA2+sYatBHwFs=;
        b=MCudfVXm954T0K4Yv2RD0wtnoVXFVeEIYs1CU9q29eUZ8xenSeZss3KwHO8YLYAoS2
         BXFMADlR+/PAZrLkwt7y07OFRKYuZ6p5ww1NJIyU0+gjyOxWNDp0Lqv9PdwruLLrVnsR
         Trvpa3PUStbwXquZslBZqQ0sQ0TIOJpsfnyz/jMKM+SKtdFjsqawSLYoC/d+h+ncbnWV
         +YTtB6AT/P+Qm8drl0AVO2STclAGTA7bVE5Y3rY9jYS8FS87QQ8Q2yOnQTu79+nD6nQR
         TkelhuCEkapGEDJjHsIqFu1U+yMi0sblQLFV1cy5lMzIy7IJrseKXRCWBrLmkx/jJSyV
         J0fA==
X-Gm-Message-State: APuU4Z9LbtdDhcDbKfGLdGFhJy3HDjJoR1R2Pf7LcqfOZFnktGxEy81W
	P+ImxCubUGkdx0a+g9n/ikW1wKJNmPJuU8RDwfso2/h+4Ya76+PbFgWt
X-Gm-Gg: AZFdTZeBHhGLWLtu+Ijg9n3nTKWKBnjz64QdleiWMKaSGcDFtin9/7RzTek78zYBz0S
	YkImGH49ajk4FbFlrs02MuN9qEtfn3BQStOkM5LzpEbCyFGbwMdsNkMS8fQsVoYHogwZbTRQmit
	5D/uv/vie4EEFRRPVzvTKj960MsIbqipBeX/CDWh+1wBfTddHxrPf+66QDC7PvsTlK0et9Z5nGN
	sy6nBBC03VMIpJbnPSlSqR+gAyHvVNL2qCD1W/qJto5a+t2IVaaZdAuUqkyOfHakDrQB9FpusEU
	8cRHplosYYRMIojzICDK1QXKtlMt6TT5ndONLIAIEIEqfWkpS7sPX1cwPFLbylhuj6RqDJomoqp
	jJZt8OROWJXiqeelV7+UQpqeqwQjh8+znEOtW/HECLeV3EAjc8ski0o6dekO3t3Ih9XOv+dLy+E
	dLoPlbD23Il6xC+zdudATe7jrcny1+YSp1pB7EVzU+qAQ2zpHhWU6gzxJcCGR5o5MYj1gdSTe9C
	6Qnj4E+VrMGs6++mnqNNjDMHs1ZUV5INaQ+sLMSxVKJZw1Q/XUycCYQSZX5OmQvGZI/AWf71QSJ
	3feEbbl3u6JVtJa+zcqkCS3NX/0/JKF9
X-Received: by 2002:a05:7301:d809:20b0:386:b070:6f1c with SMTP id 5a478bee46e88-386b0707151mr14752841eec.21.1795754847629;
        Thu, 26 Nov 2026 20:47:27 -0800 (PST)
Received: from archlinux ([114.79.176.131])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-38567cafec4sm77084648eec.26.2026.11.26.20.47.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 20:47:27 -0800 (PST)
From: Gururaj Naik <gururajnaik166@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Basavaraj Natikar <basavaraj.natikar@amd.com>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2 1/2] HID: amd_sfh: Limit DMA mask to 32 bits on pre-SFH1.1 MP2
Date: Fri, 27 Nov 2026 10:17:16 +0530
Message-ID: <20261127044717.129941-2-gururajnaik166@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261127044717.129941-1-gururajnaik166@gmail.com>
References: <20261127044717.129941-1-gururajnaik166@gmail.com>
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

Commit c45d2b54cc73 ("HID: amd_sfh: Use dma_set_mask_and_coherent()")
switched from dma_set_mask() to dma_set_mask_and_coherent() with a
64-bit mask, allowing dmam_alloc_coherent() to return sensor DMA
buffers above 4 GiB.

On a Dell Inspiron 7405 2n1 (Ryzen 7 4700U Renoir, PCI ID 1022:15e4),
enabling sensors with a coherent DMA buffer above 4 GiB (e.g.
0x110ff9000) causes MCE hardware memory corruption faults in active
memory. Limiting the DMA mask to DMA_BIT_MASK(32) ensures buffers are
allocated below 4 GiB and eliminates the MCE faults.

Set the 32-bit DMA mask only for pre-SFH1.1 MP2 devices (mp2_ver <
MP2_VER_1_1), leaving 64-bit DMA unchanged for SFH 1.1 and newer.

Fixes: c45d2b54cc73 ("HID: amd_sfh: Use dma_set_mask_and_coherent()")
Cc: stable@vger.kernel.org
Signed-off-by: Gururaj Naik <gururajnaik166@gmail.com>
---
 drivers/hid/amd-sfh-hid/amd_sfh_pcie.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/amd-sfh-hid/amd_sfh_pcie.c b/drivers/hid/amd-sfh-hid/amd_sfh_pcie.c
index 1d129f30b48a..fafba3ec9ced 100644
--- a/drivers/hid/amd-sfh-hid/amd_sfh_pcie.c
+++ b/drivers/hid/amd-sfh-hid/amd_sfh_pcie.c
@@ -484,7 +484,11 @@ static int amd_mp2_pci_probe(struct pci_dev *pdev, const struct pci_device_id *i
 
 	privdata->mmio = pcim_iomap_table(pdev)[2];
 	pci_set_master(pdev);
-	rc = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64));
+
+	privdata->mp2_ver = (enum amd_mp2_version)id->driver_data;
+	rc = dma_set_mask_and_coherent(&pdev->dev,
+				       privdata->mp2_ver >= MP2_VER_1_1 ?
+				       DMA_BIT_MASK(64) : DMA_BIT_MASK(32));
 	if (rc) {
 		dev_err(&pdev->dev, "failed to set DMA mask\n");
 		return rc;
@@ -498,7 +502,6 @@ static int amd_mp2_pci_probe(struct pci_dev *pdev, const struct pci_device_id *i
 	if (rc)
 		return rc;
 
-	privdata->mp2_ver = (enum amd_mp2_version)id->driver_data;
 	if (privdata->mp2_ver >= MP2_VER_1_1) {
 		privdata->sfh1_1_ops = &sfh1_1_ops;
 		if (boot_cpu_data.x86 >= 0x1A)
-- 
2.56.0

