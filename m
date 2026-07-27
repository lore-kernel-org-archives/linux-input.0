Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0C1F371D11
	for <linux-input@vger.kernel.org>; Mon, 27 Jul 2026 10:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785147099; cv=none; b=sBKhbpfsKoZEDbGtky39WinXq+9AaXtyC3dAu4GzB1sycBKQjCc4zFD2uuKHqInwzjPRIwgmTpeHB/9l7pV7y6opfJGs73m6rXjar7nnK+OPKkkmi3asCv5G+XyupOwTn8J5D6NSqpSV6PWuIppylvKNlcmEX0GtxL6XUPI6wyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785147099; c=relaxed/simple;
	bh=W4kKHuYIhn0a0CzjI58hAjUFZcNrXpir/68Zy+q6ZWE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fge5MvPXJ+RFMcDYVksnVAtMKg2BRGv5Hwd/VuALGHJDHLSsyLGolPYcUzJ4yJYUq2O68lBaXBeP9uw2R68oqpgpZ9HG4ckF8yb0G+ohHAQWOzxElgK9MDpoEm3CLUD+3HqWBcZAzDB/KFjQnycqhHpsFxfPOjW23HWnmEM2h2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VRhRpbvz; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VRhRpbvz"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2cee9b74ee1so19295135ad.3
        for <linux-input@vger.kernel.org>; Mon, 27 Jul 2026 03:11:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785147097; x=1785751897; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=CqxpEyBKTfjNC2pGfm3K4mlLSsR7OW6H572VDTFwp8E=;
        b=VRhRpbvzYVCAWBCWIcjTVHq9fvTaAgL2WOVw4WoCLFBGOFkxlABQ4wwbr24dDQHj9w
         o7XmqhjA/5kPls90RcYbvWjYx7X33fBxTv7aZv6/7ZSae5TW0D/XOBWk1ehikMeNtj19
         ONdErz29/NtYMCZkWy/QZfosriE4byX81noqj+XvvA5PgkTa54k2IhXiHzAUwjpS3iXA
         9xYgBudD0yrmc7VRUZCRSrIgurUEPdhZazmO6wKgX4etEAEurgU+yrC9Sr9qjzZ25Mtu
         CPK1GWSOea1rH0x6AW4oGyvGqE1mGclj5Ca5y4vWL6K8hXXbug3tf1hrW7s0mDydErG/
         CjIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785147097; x=1785751897;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CqxpEyBKTfjNC2pGfm3K4mlLSsR7OW6H572VDTFwp8E=;
        b=GZtzsY3+oBBuTijAhEOKfBXpDTOhgkPsuZp1tBuvPv+GUI54CHSm54mm205TcUlb0b
         dqIfBBd2GRXAtpgzI2xfPQERbTRJc3F0BsSoGPYyZX/1xFwh9sCbMkb+wOrnZ3Bd7vLV
         CouxHZkWasgS8AHv23FYsDvg+7FXDStlXbeYWsYWmSZtEWcLxVeaY37kPODNeo9a7oqb
         9EdjSUzx0cAYLjLzaYT5NCM4Jd3Bwseiigd8ODolonOSyo0ihCX2pyh+EOElNuzgvTK6
         kQLhMQibXOOsOVlFEGCpcrGtvyiu43WvR3Rg6A3sSUUDPGg7Tu8Yeh81wsF1f6LosYLN
         LovA==
X-Gm-Message-State: AOJu0Yx+9ITI+7AsweuC/xGH0P0zc6uSDgVJw7aONA5LC9EoOlv6F6lx
	wrQANleOZbxCPy8YoXGjm78IUfrNQYKjPaer0G6+o2fAN4NgUHjwWj0q
X-Gm-Gg: AR+sD10jWDimL7SNGtlVmNLI4cqwoiL3upjMP09QSPzgqD/bGqTe4ZIeNSCI4CZ6PUB
	yLfBcDxHjoygz8Jj34ZXum2LIfSUWVCSFoKDpiY4SKl+fdrfzFaoNM9y4zg3dXE9Ag4ynjKg3yU
	DX8/E7PaLPQiXyS2eMYtNQzykI17H1JtNCCdOhUdUZpTvqnLTHMC+NOnIUkSldysO6Uqcn9bQwB
	RtujjxaxRumGPNVsfAehy8A6HpsIhHljPWDjQ/wY2JYzBIKzzR1I5s/V07QV4wLQ5IDTee/ZUA1
	9tTPxYb3VWhPmCEFgnEKW7ZgOWMh8p8Re7E5Q7pFKuQX5zfwrj6uNt+h/SXIIqoGc4Co4F0xTdH
	RjK57m+Y7F3g1rsmeOG8zNCcQIuag+AqmZhcwGrD9UvkfD51n7Ln1fDpJJ8P4+wbKRLrCfxdoLx
	HJMWydGT1D3udrdJtdCH/UgqvPf2uJVQy9o4cXqyO31CDYszv7oSe7zxR+Str5xTuUHr54JAcO3
	QKW5fbgq0ohSyCysi4FykFU3bSxEDCO
X-Received: by 2002:a17:902:d485:b0:2c9:cf5d:d9bc with SMTP id d9443c01a7336-2cfde88614emr75673535ad.35.1785147096942;
        Mon, 27 Jul 2026 03:11:36 -0700 (PDT)
Received: from phuc-desktop.. ([183.91.15.56])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cfde59bb5asm32371125ad.8.2026.07.27.03.11.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 03:11:36 -0700 (PDT)
From: phucduc.bui@gmail.com
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bui duc phuc <phucduc.bui@gmail.com>
Subject: [PATCH v2 1/2] Input: snvs_pwrkey: Improve probe error handling
Date: Mon, 27 Jul 2026 17:11:24 +0700
Message-ID: <20260727101125.28291-1-phucduc.bui@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: bui duc phuc <phucduc.bui@gmail.com>

Use dev_err_probe() for devm_clk_get() to prevent log spam when probe
returns -EPROBE_DEFER.
Return the original error from platform_get_irq() instead of replacing
it with -EINVAL.
Drop the redundant error message after devm_request_irq(), as the
helper already reports request failures internally.

Signed-off-by: bui duc phuc <phucduc.bui@gmail.com>
---

Changes in v2:
 - Clarify the commit message to better describe the purpose of 
   using dev_err_probe()

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

