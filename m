Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B3CC3F7A9B
	for <linux-input@vger.kernel.org>; Mon, 27 Jul 2026 10:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785147103; cv=none; b=GNB7NHeYgirRhfN+QQbffW4h1hwX7DlS8T2XPnSfQHZKGU2DfcK039KpxL1Mypo6EuzGhYvCcGsexkB9Luqkiuad8KmCvOaUq10aBW7fFv22pOVpmKj6gji7Dhaq/bfe5HUYcyOTuWDfaXplFYop4K2iCuwqOSlR88oBfoEcxIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785147103; c=relaxed/simple;
	bh=h4ePA5ka0qPaYWNth0UkRXFMBqyoFond9v7BO689f6c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lOzf799vDOeHCoJWwLKcdUzGlu1SQGET2kAE+LVvqm3bEMEKPZ3CUKpOJ259NOVdg/uCfWRQOHiEQxhFmLCB2leGu0UplWrMOsqsZlGAyaEu6B7CugmYEvoDz3cXWCLD4XV/H/xdU3DWFfqP4+n9JHq36qIJmhcip1Yflolj6rA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TYiLzo3f; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TYiLzo3f"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2cee9b74ee1so19295475ad.3
        for <linux-input@vger.kernel.org>; Mon, 27 Jul 2026 03:11:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785147100; x=1785751900; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=q5qn90GNuN/EhDc4YngJiHFWLzHAwHWxWP2/U2lR8lo=;
        b=TYiLzo3fxTLEB4o907wy3k2UedGuMilJCz46xDmw9JT7faHt2JuYQWQKOGfoIElkTu
         eS95oZ4GJPwOToEhkI0OJOD6KMikUM+XbXLl+VL7dIung8ss+6qu3//QVP0KVi1UTmwl
         JE4if+DeCNMujDk8rufknSGFIjSIKlOabufJEbFBz6VtXmphR8kgRsxnEeBb3C5q4aYV
         nXZcTGHERMIxLXRruFzGGifCu87KjRNZg59HED+RPShG8oU/HNo1lMTPT8gl3ZEwQeTJ
         jyYnmQtSE9CTU3O6at8o2cYCDeX/5/KOtvCOB0p+8TBMPfbwCwPpyQ77qBxzvztV1vwD
         Qbyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785147100; x=1785751900;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=q5qn90GNuN/EhDc4YngJiHFWLzHAwHWxWP2/U2lR8lo=;
        b=nEmsOHhiKEvIjRs2dkrJxXuywEHXV7qTa6TeXaE04SIxvqKGVO/RKG17FUjBCY8t7a
         gF2iygXlbfdJPtMLR0bz8Qn0Im4+XUblPuWf342TkiYILMhk3XghrDLfHp69lVJYOrsp
         4Ncj2qfgpVkhDmb1bZ2gpAEfSxOP8ZdBiqwUofR1UY8Y9CXe3Ft9ZRQ61fOy6MFO8nBw
         YC5sSFYzA7XuGtLt2XdhtWfY61ioR6YJZ41Qe/U0sadpZRJwIUG/yKs6HWU125JKsW6s
         uFcCsFrcKrtaeVTQtGlApRIIBJOjEfCMG1/rMznCeqgVtSLJIyg6GySwMs6CQOweiz6o
         JsaQ==
X-Gm-Message-State: AOJu0YxqQ+fapAeHsyuR2NcmZ765v21VTiAqV7MgpplqV8O3UaB14850
	+fIWyeGCVJQxrFjGhmXbyTRp2pS9XgxKGkjQCjJx8uDZPzEzBlQe1GLaxESqDA==
X-Gm-Gg: AR+sD11bQSi+cqfsFFnL4S0RWl087Ch45jVK0wPs3u/hL8+E+vxLEKjddVhG5Kub1za
	KbURIu1TWPhn+kS0qUuJEB3ldt7CBKbG81UcNczWSTgHrI64bEPSOFk+CnyFvde/XPiVDRCudlk
	RhnHCruq63bbQd/fXvAbIntz8HvVEDLlDa8WEQH+URdtdQBnb+GBq/Mf4ZSKov+6qtA5c2ZyBwm
	VDH4jMiVVYxZPsFFdS7dY7kiQQs2fgoa4ZRlES40h2nfH8tcDflVTUH2plTB3GMUooVdqLOCyY5
	pq+Q28mFsJOL83O1WlSnUTL/3Hf1WvuSYMMxSpbhFB/GBsYJwMSjr1RKzCkVwEbAsmNgBpxbefO
	JWlSxaeQ3k09g4+5S2hUcdzcFmDdmUBJBgR3Rn5tLI9qsWFkgL+YdlLhYa+R4fBk0BxaAIzHxCd
	rox27nGh5WZHOzoA11jITe/ZryMlpaVl73lCLaqnNM63Qu7zqXLyCPN7YXTawmVyc1J5D6PqDPY
	O8h5UlSv83sCdgUh5oGWg==
X-Received: by 2002:a17:902:da4d:b0:2cc:6817:d9b1 with SMTP id d9443c01a7336-2cfde8a52a7mr73228775ad.41.1785147099838;
        Mon, 27 Jul 2026 03:11:39 -0700 (PDT)
Received: from phuc-desktop.. ([183.91.15.56])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cfde59bb5asm32371125ad.8.2026.07.27.03.11.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 03:11:39 -0700 (PDT)
From: phucduc.bui@gmail.com
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bui duc phuc <phucduc.bui@gmail.com>
Subject: [PATCH v2 2/2] Input: st-keyscan: Improve probe error handling
Date: Mon, 27 Jul 2026 17:11:25 +0700
Message-ID: <20260727101125.28291-2-phucduc.bui@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260727101125.28291-1-phucduc.bui@gmail.com>
References: <20260727101125.28291-1-phucduc.bui@gmail.com>
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
Drop the redundant error message after devm_request_irq(), since the
helper already reports request failures internally.
Return the original error from platform_get_irq() instead of replacing
it with -EINVAL.

Signed-off-by: bui duc phuc <phucduc.bui@gmail.com>
---

Changes in v2:
 - Clarify the commit message to better describe the purpose of 
   using dev_err_probe()
 
 drivers/input/keyboard/st-keyscan.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/input/keyboard/st-keyscan.c b/drivers/input/keyboard/st-keyscan.c
index e53ef4c670e4..8e9bac339dc4 100644
--- a/drivers/input/keyboard/st-keyscan.c
+++ b/drivers/input/keyboard/st-keyscan.c
@@ -173,10 +173,9 @@ static int keyscan_probe(struct platform_device *pdev)
 		return PTR_ERR(keypad_data->base);
 
 	keypad_data->clk = devm_clk_get(&pdev->dev, NULL);
-	if (IS_ERR(keypad_data->clk)) {
-		dev_err(&pdev->dev, "cannot get clock\n");
-		return PTR_ERR(keypad_data->clk);
-	}
+	if (IS_ERR(keypad_data->clk))
+		return dev_err_probe(&pdev->dev, PTR_ERR(keypad_data->clk),
+				     "cannot get clock\n");
 
 	error = clk_enable(keypad_data->clk);
 	if (error) {
@@ -188,14 +187,12 @@ static int keyscan_probe(struct platform_device *pdev)
 
 	keypad_data->irq = platform_get_irq(pdev, 0);
 	if (keypad_data->irq < 0)
-		return -EINVAL;
+		return keypad_data->irq;
 
 	error = devm_request_irq(&pdev->dev, keypad_data->irq, keyscan_isr, 0,
 				 pdev->name, keypad_data);
-	if (error) {
-		dev_err(&pdev->dev, "failed to request IRQ\n");
+	if (error)
 		return error;
-	}
 
 	error = input_register_device(input_dev);
 	if (error) {
-- 
2.43.0

