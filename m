Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C29CC38C421
	for <linux-input@vger.kernel.org>; Mon, 20 Jul 2026 08:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784537459; cv=none; b=qSBssnS8OYSt5bCTx9d20zLZYMujfZMH2/3ZGlQWyM3mRC/+a9ptNDQVad2s20AknZyBMiLYW+YUOI2hfkGRa7ySjvF78B/mGSeuOg+LcD77cLzrs9DWdIy+7PALdMjMvxhxeB2II+MbodYy+UrrJQRELCRyzEwnwe8uZ4Tb30c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784537459; c=relaxed/simple;
	bh=vmF0k0EuYiPEGnCAocsDj12Z7l953oukZnNxrz/xTjU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=E4rNS7yIwV6QwXfKh5Losv1olJTjed0oUUlpDgczB4ZYQQQIS4r5jS4ADk+NRuyUSSHnXT0luEtPJ3iwL5N/fUF5+9yR88PmBaX7c+gmel4BD9luU77MCcqT0FdZAayQccKkoUpEz9pjg/5S7bhZFPmIUjA7dGw6bejxElLk1Do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mjq7pu1m; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mjq7pu1m"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2cc97653887so107798155ad.1
        for <linux-input@vger.kernel.org>; Mon, 20 Jul 2026 01:50:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784537457; x=1785142257; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=RVeFOQVTpiRlKBlmYWsJDVlKLQYAX1ODqxNV2wyX7Ts=;
        b=mjq7pu1mNVfVuLz2dvWI7VfU0UignorDk3fquv4tOw/Jcj03OO3RxHkDRsRL5hsnjH
         TG89xqhU97r2C71Ort4hNjLy62a4jmfeCOXLF0MlyM7j5SFJetOYScbPq/Kk0S81Z5D1
         lXeiM95iVeqL9Zdkc2v8AFX1XtX1kx6rYmxwW1ZCVlaMDtT/369Zv0voY+s6tFgLB3L6
         u6tDXnmKLI0OuM8csML858TILec6rDmBu5Mme8DuKbWvOYncAIs3ZnuNuofUcKtu0v20
         LUoq7FgHaeXB0A2eZhJbhvpm0p9FIA/7cu3UE0vZnUB3ttvYvNxUfwm8/Fprdr8mgpD/
         IAug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784537457; x=1785142257;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RVeFOQVTpiRlKBlmYWsJDVlKLQYAX1ODqxNV2wyX7Ts=;
        b=k5fqVEVtJeHJ1wc4LCG8UCYWHFqZwh1p8B1wSMFRr7SG7ckKOlA2G+dVDmm/pw7/E1
         S5jrl7ajC57PIQgVp2Uk3eBlpLmca1fiLkfw+0O5DyOse1OUUJfc17fUutCf78OI72bZ
         UyIqFU67VvJSyy8KzueuWmzezZ3jSBAy0wHenH4D7yvXjbrYU3g/G2QfWFeXWuSAr4Yn
         jfeGtSoi0Q/IKl6/GUTRU5KB194B4aQQ8G2JdYvNpg9mD1ig3TAwNWvppE7By9DrWrX4
         SMEassGhLSH2r5d5v2N8mL27tqOKGhN5gtF6zu4a8SEfr/QXoW1rP23j9bUIM0FVclYF
         yUEQ==
X-Gm-Message-State: AOJu0YwPi+S8PTPPbs1IQsj7xuvOewBL3YDWmOsI0AvAMqTtEN/Xg7lT
	9DDkzFuMlkfGx0PMrDJJog2eYoHZjV9Bw4rFIbzZSWDEGFVJQsYxdEdS
X-Gm-Gg: AfdE7clo8oF4U9wjxy2a+8Fm+X2ZIGDYW9wRmP/NAm+Yn7v0waBwvyhVHlmWPzN1cvu
	tSyK87ISzFbqvTtmx38HZAMWgY3YDfURJfrHfuuadYsm1ppJn+CWFx5Ir5Bgi8BlA0oAQd3O/CP
	kFTNai//JizhqB+Pvx7hhjmutki/M+Kz0RKw5zHN9146d6YClKe0pveO7t7ti2snXJbruAYyhAP
	Q725tCzEQ/cFjvWDyOZfuYNay0BbAV/dfdMAHkWp7aN+/57aMv/byP0aj38DI/Ex9wCfPzD81fN
	dguMiMMDeMeYaENuezbvhJYE63zRitym4FlGmqKBk/y6u6EDw71ALULntUi4e96O1tsqE6XMIkk
	Im6oNrL+EtDLjS/1UcfQyJ+5I6uClZsNdtRmym9gd1OWeinDecLUgcZqptp1TitB2QHPLdTTfCn
	EP7h3J/vUONMcVMYsPnXbgilyj+Oi0IFJqcmaJ
X-Received: by 2002:a17:902:ea0d:b0:2ce:f9db:a9e0 with SMTP id d9443c01a7336-2cf34887b36mr146940535ad.16.1784537457051;
        Mon, 20 Jul 2026 01:50:57 -0700 (PDT)
Received: from phuc-desktop.. ([183.91.15.56])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf346da095sm52955985ad.49.2026.07.20.01.50.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 01:50:56 -0700 (PDT)
From: phucduc.bui@gmail.com
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bui duc phuc <phucduc.bui@gmail.com>
Subject: [PATCH 1/2] Input: snvs_pwrkey: Improve probe error handling
Date: Mon, 20 Jul 2026 15:50:40 +0700
Message-ID: <20260720085041.224896-1-phucduc.bui@gmail.com>
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

