Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DA6675809
	for <linux-input@vger.kernel.org>; Sat, 29 Aug 2026 11:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788001944; cv=none; b=Z/bKhHkqa8JZavO+yOHnmu8ddm+qyXFNmnMdihqnBvCPAzVQ4aoM7XRbor6CvrucpEaqwGPjocLskiU0WwD7Kn8Gi/pIIH50YYXKwbuR6H0RQOYXoBuaWLodUCYgOGB5F46SELdWgWEJ+KnxtwnjotyEdRF0GnxlylwPSfpIW6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788001944; c=relaxed/simple;
	bh=GxdbHbwCaVFUavLR6/16oLPoUM2RZzRBfzpbxZHk8xg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=M9ZJ3bq2BuW5H6Vzh/PnoBWyZsrD+ClTwNofrfNq7ZNbYH9Ec9zmDmjgtYru0MonTM53lBiXnUsNgEMaEj2h2jNPzocaEkpTrbnEqqfDPUd8y5m9BsBicnKyt/Ae3Crkt310SO0+Zt3hEMVCPQVmQXaPzL8tIkZUfs9/IiO3Aa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nnINr5pR; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nnINr5pR"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-cc1c3d79b9bso1681088a12.3
        for <linux-input@vger.kernel.org>; Sat, 29 Aug 2026 04:12:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788001942; x=1788606742; darn=vger.kernel.org;
        h=content-disposition:content-type:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xlR8FklCQr2wqwqO7g29e1twf0coajmx1f1mj8tHeD8=;
        b=nnINr5pRNTwW87YB5rCO14Lzh6pjf3ITZHcbzkJtW8eav+8BrVbp13GgaRGShJdoB1
         0/MoYHX+SlkJOYM5FY86JhaECmhIOfLfCzvC0FsuNB1qV0OxCloF+K08zysLMBl6D0n+
         u0idW5Efzm5ErgR+CeVPr7F7Sz85QZ8Y3l6IiLh9+Chjth7UGZIE8MJ3ZfNEBZCWuTUd
         SxNyuIJXlyzdNspHvKri/Fa1kRRvly/TGA8v0BWLtHdaUFSLxrySbH2eBxaxLEHX4fmD
         7/yq22xpx96RXyfJVLJJiNVD+KfqQreqC9vDmMy/ATq41GKdBPfjTML53b0Y817jwo3a
         kN+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788001942; x=1788606742;
        h=content-disposition:content-type:mime-version:message-id:subject:cc
         :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xlR8FklCQr2wqwqO7g29e1twf0coajmx1f1mj8tHeD8=;
        b=PPldBh9RXKqzd7MfLKVjlfpFE3h1aDET7EdfsbyFZcfOYFSuWPNvzR2Disn54cK9oE
         WRLx5+tm/amhPRNCv4acQ9EF3aQ+qn52bKYITXFBjpvqZzKtvJh1m0LAqFWGEXIz0Koy
         imWAOopADNBSmdD/rWeGKTcN50uZY9i0CCCa2vXtJRPo7LpvHBAWwz0tvv7UM2VcLiBj
         z0SZWDIoLCwQqxVEIKNqbKv3uGbk878j2BFY+0pHADJ/o01Wn55nb2/dGwB1rNCu/W+d
         tfWc252fA5xE3QtsgLKmcGOURn+O88TJVNW/D+OY2zi8Qs7BOOcUA0iDqE0nerDGEOkc
         71sg==
X-Gm-Message-State: AFuF++k0PjnmPvnoAg1838178YLZlC/FwT9yxVAsQqTRqHskbzacEOSz
	+b+bt3Ce7eTvfj18K82tfDT0EF1KNC5E90jOciiEINp7SJJLkX6tppJ+EWuh+fxS
X-Gm-Gg: AYBFou3mpXSH4SkX6LGaNuTyZVUBtLPNd5xCrQrGGnKzIJrRsX7QcUidDc/s4MmMfS6
	KtECjrWb9P/lIBIOUCfL1/r5Lp36d1DwULNBr0THTiCH8X4Q9iQJK8vbi7yiKEjczJCyoe1fNpF
	pk7ClrnsTnSfxCDudskiDvodfJQ5KnYlfBSPeC1s7wdC8+c0L2+3UtStWAo7z4PKy37EXglJ/vV
	SZCPjJs9YgZW+z0slSWWNy1wBbWV6Lfp09H39gnidh+WugV++A2A8mMP+NXQ7ZAcMHmYMknGOwb
	UNKimsY1K4l3VyQd2z75fcAfVwT7yrOWkDW4wBqoODl3nwp/PiEvYUlGgC9qcFu6URFBSnqJuBK
	kmlo4hR9MXKvI1p7atRBtbVFSjydc2RvTRew17BHgWp5xZDHQlg36A/Yw5bRxn+7CgzLMi4ESxf
	U3QGEVn66y6Spsji8CJzVHL0kyFmwl5H8qYbOoRLvHZ4bSC/uVryhRdh0W3SK5lkX6M9bquatIe
	QOqb2zN/V6Sc0I0DqUS5sTTNPwN+Q==
X-Received: by 2002:a17:90b:3e48:b0:37d:f206:a2ac with SMTP id 98e67ed59e1d1-396d0ebd7fbmr24874526a91.7.1788001942436;
        Sat, 29 Aug 2026 04:12:22 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:54de:b26f:8c97:cc89])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3286f9595bbsm16627505eec.14.2026.08.29.04.12.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Aug 2026 04:12:21 -0700 (PDT)
Date: Sat, 29 Aug 2026 04:12:18 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: linux-input@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Input: st-keyscan - disable interrupt while clock is gated
Message-ID: <apK-PZ5c97mCxBSC@google.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The driver gates off its peripheral clock when the input device is not
open and during system suspend without wakeup. However, the interrupt is
requested without IRQF_NO_AUTOEN and remains unmasked when the device is
stopped. If a pending or spurious interrupt fires while the clock is
disabled, keyscan_isr() will attempt to read the matrix state register
with the clock gated off, triggering a bus fault (synchronous external
abort) and panicking the system.

Request the interrupt with IRQF_NO_AUTOEN, enable it in keyscan_start(),
and disable it in keyscan_stop() prior to gating the clock. Drop the
pointless clock enable/stop sequence in keyscan_probe(), leaving the
clock gated and hardware untouched until the device is opened.

Fixes: 062589b13991 ("Input: add st-keyscan driver")
Reported-by: sashiko-bot@kernel.org
Assisted-by: LLM
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/keyboard/st-keyscan.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/drivers/input/keyboard/st-keyscan.c b/drivers/input/keyboard/st-keyscan.c
index ebeda020ffe1..6101bf53379a 100644
--- a/drivers/input/keyboard/st-keyscan.c
+++ b/drivers/input/keyboard/st-keyscan.c
@@ -75,6 +75,8 @@ static int keyscan_start(struct st_keyscan *keypad)
 
 	writel(KEYSCAN_CONFIG_ENABLE, keypad->base + KEYSCAN_CONFIG_OFF);
 
+	enable_irq(keypad->irq);
+
 	return 0;
 }
 
@@ -82,6 +84,8 @@ static void keyscan_stop(struct st_keyscan *keypad)
 {
 	writel(0, keypad->base + KEYSCAN_CONFIG_OFF);
 
+	disable_irq(keypad->irq);
+
 	clk_disable(keypad->clk);
 }
 
@@ -177,20 +181,12 @@ static int keyscan_probe(struct platform_device *pdev)
 		return dev_err_probe(&pdev->dev, PTR_ERR(keypad_data->clk),
 				     "cannot get clock\n");
 
-	error = clk_enable(keypad_data->clk);
-	if (error) {
-		dev_err(&pdev->dev, "failed to enable clock\n");
-		return error;
-	}
-
-	keyscan_stop(keypad_data);
-
 	keypad_data->irq = platform_get_irq(pdev, 0);
 	if (keypad_data->irq < 0)
 		return keypad_data->irq;
 
-	error = devm_request_irq(&pdev->dev, keypad_data->irq, keyscan_isr, 0,
-				 pdev->name, keypad_data);
+	error = devm_request_irq(&pdev->dev, keypad_data->irq, keyscan_isr,
+				 IRQF_NO_AUTOEN, pdev->name, keypad_data);
 	if (error)
 		return error;
 
-- 
2.55.0.897.gb25b4bd76c-goog


-- 
Dmitry
