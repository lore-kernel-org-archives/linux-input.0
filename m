Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C23A82641EE
	for <linux-input@vger.kernel.org>; Wed, 27 May 2026 00:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779842763; cv=none; b=OxnNyNXKn+M0TYqhWgcHeDVpZFKbRof5OQDDEhy8c9b2hlmvcbOOgm4rkQINov/kVEiUg5Mzg4xIJptsUMg0VdIsFjkVuApJB6lqE+yBTj1JyfcdEUAFeaITrAY+82HjmO/j9Fl98V/YDUcQjDWgabCFhNLIlTi/mM7QOR66TEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779842763; c=relaxed/simple;
	bh=Bn1htifDFvdqLQpyJKhO0AyLQDMJSMocQOzxJZJiq5w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DHWNAu7kGvigIhLTbn3+0hXgcKXebJSorWTG20yxSyyo+jdt881l31kr1WZZQa86M1TU7jr0pjmR/N2wkHWhWI4X4Clie6e2C0bcUBM/oibiIbuB64nkLaDDp4HV0PQP46GRSocsQAbFxfwxwHjNOzZP+6iRjCfGH88URR9yuno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PI1wNtaW; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PI1wNtaW"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-3695bf7d082so9993359a91.0
        for <linux-input@vger.kernel.org>; Tue, 26 May 2026 17:46:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779842761; x=1780447561; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/qmpMpDGto5NskeOa7RLSttaP2uOAMocijbFFRGCfIw=;
        b=PI1wNtaWrNhAu50nauSLNejNQYZ2tkIhd6uVy2AOr4OVvm0a/3/xg7STVNT6djurzh
         8zuWHSdRqts8DmtKAblHTn6pg74v5Y41NRD9p/GxfOBh1nQ0/cCixNMK3+5HH3rxXPOt
         tbNjj26S38Fqph8qjaYNnaAKM8jciwzNVzvECPB+jHzVgttu21wbztsPqZ3SqGELEqyO
         qK+SHYKBGfE/3Z2btelGwe13U/EIBZgRvxiIvgG+mSuEYh1y+6P51EcRs4UH7zlZ9k/f
         +IX+zKTGcj+PCtK+IWb45nCWLp4w5ZtxW2Y5/jjQjBDxOwvo10gF6gdQDWhj2RO9aANY
         Ry9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779842761; x=1780447561;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/qmpMpDGto5NskeOa7RLSttaP2uOAMocijbFFRGCfIw=;
        b=NbWm9ayUItXRydDU5X95kNNMAUFUz9xZTbkix8F6P0CGYl2RPckRFNFd9e7m8nHhLl
         Dq1utt1DBMfRp4Mvpq4olax1UyhKHQTlvCVE2qOrGZbchB8Xnf+CHRjDVBSk4He+3xpX
         WuFUtGj9YijHwYe1thXwHmuZtvcsBE3P8L+Fgu2FKp+U2knURuISVy/d1eq6Jj335j7G
         ebGvQJ3BOcRlk84D7YHJ43OxiLLEi9zPDR+qq7sQxX70Ev0040zeZnR9tsvOFQC7h/Ix
         OOkPPU/Hzv9dJmKDt7A74zfA+Xv2R4AVnlpoKYxebxpfcu8suNK52w7O7QrMy//lkN+3
         R91w==
X-Gm-Message-State: AOJu0Yzrr/jNBhT0Dd2MOG5aCLExuyU81dYSvJ4LZx2SDexX+TlAIzJ1
	0ALCjfozhev7DvA6K47GAJ3ibJ1/KpY8w6zIRXyyrkpGV8nerN5lBO8kYdbvDg==
X-Gm-Gg: Acq92OG6AvMGXeut+V7VltrSHHdxgkd/khJXcWFBIHJ34DfjHiEtrKKM1Ds91CiOPXY
	LsfeHv095wD1WMG73P4sBkhocWHnjKjcOSCPyA50Py9jtb4JnE9aRbH5IibuIlJdqy8zYkA/wWC
	I1hiKyHi2Byr5iiW1isht7ybC3ZVDYA8Mt8+3+xNcRVa0jTEi5VA0hTSeoZNp0Li0MCPP9rmUsj
	xRpoeHQRXusibAO0H0g58mtJkaXr6gfwawNRXYqQ1M6CGUEwJzx8+IZXxE9PIt9tvoirglsNgw7
	8DFxrKkAgZOs2y1O4yronfQYy5Z8Gy6SwkplIShTecOvatsPSTFNl/BuSdO5VS8CmT4OCE8+zQx
	fqf6xgwRxrmNhDPxdBNFR5GSW/7jWQAo0tn53IdoxlMcsyxxXEUCL6dACbV/uAVufl6znoVRDx5
	LLF1OUUUeTrI8zAcEXDIZR8YD+iqFSxU8FKroKjJKBe4ZoTTH31vK/9DNYjCvQO90oxLmMgZt7R
	JDtin4QVB/wDOANvgP7FJEYXUfEo+7WNWA=
X-Received: by 2002:a17:903:41c9:b0:2bd:5ab:af95 with SMTP id d9443c01a7336-2beb023584amr219157495ad.0.1779842761021;
        Tue, 26 May 2026 17:46:01 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2beb58b2ea3sm138552635ad.43.2026.05.26.17.45.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 17:46:00 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-input@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-kernel@vger.kernel.org (open list:ARM/Mediatek SoC support),
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/Mediatek SoC support),
	linux-mediatek@lists.infradead.org (moderated list:ARM/Mediatek SoC support)
Subject: [PATCH] Input: mtk-pmic-keys - match loop with count
Date: Tue, 26 May 2026 17:45:43 -0700
Message-ID: <20260527004543.22875-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

of_get_available_child_count is used along with
for_each_child_of_node_scoped, which can cause a mismatch when keys have
a disabled status.

If a disabled child node exists in the device tree alongside available ones,
the loop could execute more times than the initial validation accounted for.
This might increment the index variable past the allocated array bounds,
leading to out-of-bounds accesses on irqnames[] and keys->keys[].

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/input/keyboard/mtk-pmic-keys.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/keyboard/mtk-pmic-keys.c b/drivers/input/keyboard/mtk-pmic-keys.c
index c78d9f6d97c4..5d4ebbafd276 100644
--- a/drivers/input/keyboard/mtk-pmic-keys.c
+++ b/drivers/input/keyboard/mtk-pmic-keys.c
@@ -363,7 +363,7 @@ static int mtk_pmic_keys_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
-	for_each_child_of_node_scoped(node, child) {
+	for_each_available_child_of_node_scoped(node, child) {
 		keys->keys[index].regs = &mtk_pmic_regs->keys_regs[index];
 
 		keys->keys[index].irq =
-- 
2.54.0

