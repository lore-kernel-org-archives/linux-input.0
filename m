Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 461323D1CA8
	for <linux-input@vger.kernel.org>; Mon, 20 Jul 2026 09:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784538549; cv=none; b=O1hn7CaDnlKOOqum0GtDiiEoPdBA1lgBWW2OXu05jckRE6rtTo0/SnzRk8oAG4DOgUyYNHb09htT3uysBTDsTsRfkcvwPkGU0B3isNVNaAj5OJyzpud3/sAeJw5dY1tbP4xAXeKex6FepZs71dcJSNSJGFJZUnbfT1Q1AqdOhZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784538549; c=relaxed/simple;
	bh=vmF0k0EuYiPEGnCAocsDj12Z7l953oukZnNxrz/xTjU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MzI/X37I2hhNFj258f9vn1URByEn6wt3DMNXUkujPkkabVTIEOwvEj/torug+YGC4GcMfG99sQ3NCu0/K2EEvj51R9b76Q5xEHJJdNQV3l4PEUM2VIUtQ/n8UCtEgAR67ssHR+RYwGhVcpzW4GCJ7ywywk+gLHhR6njU13A5Hew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y9+W9nY9; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y9+W9nY9"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-84862b0d5aeso10759823b3a.2
        for <linux-input@vger.kernel.org>; Mon, 20 Jul 2026 02:09:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784538547; x=1785143347; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=RVeFOQVTpiRlKBlmYWsJDVlKLQYAX1ODqxNV2wyX7Ts=;
        b=Y9+W9nY9sDoajt3/KUE8GDfB3dPMMx3MNuYu/eDbc5uDApYWvRxpI/vkLJJCXT9GYp
         d1f6P2TDtpPwGvXSyuNZDhPAVwDI77LNz5zVBnOwnHcmkj/EyM2nTm/75Tl2ZO0pZ1u3
         OleI8OTbbyvz7bqxH8IwYbjAgJthFB6JSeFfIRdy6EURLKwjhQlHayllt5CyfR9L0d7/
         d28QWQsLU0AgSloCXfOlNVAgaNtc9CdxmBpAlgfVAU3dCU6KtmpEgP0pNnJcKA6fEAnu
         i2l2RHyBAHOKIOdnEZ8nSqimECUe1i6vMc++YYSgdW+s4wN3XeHnqR2WT+0PVVDizq+N
         Uqvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784538547; x=1785143347;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RVeFOQVTpiRlKBlmYWsJDVlKLQYAX1ODqxNV2wyX7Ts=;
        b=IQ2AL6P/SHy8YMoOEaqKg/dGtjzQQdUO2b5PLfv43GNRndJd7MAnToTNZNQU3IgG6Z
         2X3Zoz4XM91mgOqlhzHxBu8QggHLxQoU13NqDWntcjFECplvbnZ8qhSyBqoibItay+w8
         eA+YCf3hoVVhhmh9x3tRgzOqBK7+krGUhc/2SIRb5OG2/5z1WXGhLSHVI3z8CBT/2TY1
         Y5EmDLwfaZF2AtnEXFK6g2RIYJAlTOtfBGkckHc6HcnI2IrABFC6TTR2EN17GpiifhIa
         DSx3lB4OYwd0TDYXo0DQWE/pDghCbFMequZ+XB2qiFK5i5XIyxZF99LIiVOmJL8fSRd0
         2Z4g==
X-Gm-Message-State: AOJu0Ywjem9IKB8UheabfsSLR8VRlAnLPaRlhDSO14w6hERb+Fm8618d
	MCHHxX78Vz5o1YWLB5BODdCZnFOx6V32NXfQOf1ufTAjZFEo6TI3LKpr
X-Gm-Gg: AfdE7cmlKcc23c6h1oQyuoGsIAxNz4csUsPSKccA1mPKlfdp3CrZAzkA5CK3r7tVzp4
	OUN73/U3Ubc2ABCFan5yhD2cQd3+qm4e5VDPhx18x0RwgDqXJevAd5qw8vDLxzAhiD2ytsptpj7
	o6qLnMiXlIvZ4hHWBSduPZhIhho5/F66BUIU9oQcc8qpsp2l28ByNd9CHEf2urM7BxXYRS5xihT
	CoYQvGenLnJ9vbLuBO+kVf3rXzL2bfOs2uckEbRz3jUE5tN++oQJ5+mQolsCSxt/ggbNn1SMIBP
	ZRcsMhR6XBoCXOAXppv6Rr/fjCQxp90bugUqDPCS+bfvFlAgrYCcyzGcI0sFGveuwYxewAWfGmT
	m1zCM0d+aKk1UOCO9ct5H3AoYgflvLu4S3CwysO9ZCvdv5Jm/U1Yk6VfpXN8KQvPC8y0M7V/lIP
	8bJbQF66dhg+SkvEZwM2nenl7qcuoBxBpgpHwZhv6EV5E15Y4=
X-Received: by 2002:a05:6a00:600a:b0:847:834d:b6a6 with SMTP id d2e1a72fcca58-84c2951188amr12880529b3a.62.1784538547510;
        Mon, 20 Jul 2026 02:09:07 -0700 (PDT)
Received: from phuc-desktop.. ([183.91.15.56])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84c2bf08b7dsm5374106b3a.10.2026.07.20.02.09.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 02:09:07 -0700 (PDT)
From: phucduc.bui@gmail.com
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bui duc phuc <phucduc.bui@gmail.com>
Subject: [PATCH v2 1/2] Input: snvs_pwrkey: Improve probe error handling
Date: Mon, 20 Jul 2026 16:08:49 +0700
Message-ID: <20260720090851.230244-1-phucduc.bui@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: bui duc phuc <phucduc.bui@gmail.com>

Use dev_err_probe() for devm_clk_get_optional_enabled() to handle
deferred probe correctly.
Return the original error from platform_get_irq() instead of replacing
it with -EINVAL.
Drop the redundant error message after devm_request_irq(), as the
helper already reports request failures internally.

Signed-off-by: bui duc phuc <phucduc.bui@gmail.com>
---
 drivers/input/keyboard/snvs_pwrkey.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/input/keyboard/snvs_pwrkey.c b/drivers/input/keyboard/snvs_pwrkey.c
index 954055aaf6e2..fa08ac561bf2 100644
--- a/drivers/input/keyboard/snvs_pwrkey.c
+++ b/drivers/input/keyboard/snvs_pwrkey.c
@@ -142,16 +142,15 @@ static int imx_snvs_pwrkey_probe(struct platform_device *pdev)
 	}
 
 	clk = devm_clk_get_optional_enabled(&pdev->dev, NULL);
-	if (IS_ERR(clk)) {
-		dev_err(&pdev->dev, "Failed to get snvs clock (%pe)\n", clk);
-		return PTR_ERR(clk);
-	}
+	if (IS_ERR(clk))
+		return dev_err_probe(&pdev->dev, PTR_ERR(clk),
+				     "Failed to get snvs clock\n");
 
 	pdata->wakeup = of_property_read_bool(np, "wakeup-source");
 
 	pdata->irq = platform_get_irq(pdev, 0);
 	if (pdata->irq < 0)
-		return -EINVAL;
+		return pdata->irq;
 
 	error = of_property_read_u32(np, "power-off-time-sec", &val);
 	if (!error) {
@@ -209,10 +208,8 @@ static int imx_snvs_pwrkey_probe(struct platform_device *pdev)
 	error = devm_request_irq(&pdev->dev, pdata->irq,
 			       imx_snvs_pwrkey_interrupt,
 			       0, pdev->name, pdev);
-	if (error) {
-		dev_err(&pdev->dev, "interrupt not available.\n");
+	if (error)
 		return error;
-	}
 
 	error = input_register_device(input);
 	if (error < 0) {
-- 
2.43.0

