Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 548F73B6BFA
	for <linux-input@vger.kernel.org>; Mon, 20 Jul 2026 08:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784537462; cv=none; b=B8WSWo4Mm+Hc9hQQn4tkB7TSosE5+ixP4liTDjsbdb4jM+ggDvxIdcSM2kOuUJZkOtSEmXK3oS+VQEVV1CO0mBvYMC+yCq7QZhG3lz6nh1aHjDhjpcpIr/NErFKd9rrVhsLOcYUbHAKhc9KJ+Edwdknj9A6ANXvHOx8jXup1G3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784537462; c=relaxed/simple;
	bh=q7kJgh8keeCRIwJrR8H/n08QBFbTY9PzZESfFKvXmSo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Hg5kDIDO1FgMEPzjVU0cCTQ8/sL/+ct8enEZeGf9p4JIvblaLbJscigz0L2gn9ohCyHbi+DV+wVIC9nLBOjrCdsSsVRYl3daVYlU6lPspUukAw+vRUKKQJ3IDpoFQpH5Z+t0Z1KGVLiJSHUJ3yq5QOJDw1ke2eM2F4mvo3Drocw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LNH5z7X1; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LNH5z7X1"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2ce87c7e3bbso110507415ad.1
        for <linux-input@vger.kernel.org>; Mon, 20 Jul 2026 01:51:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784537460; x=1785142260; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=z8LwcWoWGLCI831fd789rD8Iavw9l5DWusKbkwiJuUs=;
        b=LNH5z7X1XFzqCdBFJ+jlRFx/Xq6eApn8tJK1blyO7iD1RnYrfyyaSBSFndvjTqpNQW
         8xaFwNvQuWWl0660tfLmjBcZImvrAkJX7d66EcYbaAvvO7ugNQSbiqXE+OsOTLmoMZXN
         qivia4RnJ2vN3oVVDsbjB/Onp2BDkOYS81Jbf1hqOMhCyuo16CJIbT3tU1pd/rGRPlat
         2Y016UnGnboVS0ge3ok5NVRaPNMTql9V044wI0r+us29Y+HXX2KUwkEQjCt5YziD2qwn
         uj3cICtFWOXqmlSnhQ8hHnmeSjM+G25cZerYLAJuTyp4RqtaGkjZ+a0bCox/dhZVBF7s
         nXkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784537460; x=1785142260;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=z8LwcWoWGLCI831fd789rD8Iavw9l5DWusKbkwiJuUs=;
        b=Yhx56qFvJMw/LCt3oSXbmfkQJASeHLu6UxY4tXb3DfoVA0PsqFw2ujpn4q77dGSBiU
         L0+1oXuwwZN7Xg4iRk/giqyySftgt4Svt4PiKXqh1Y3YsL9GBdEHe3W2pjqBCeuHQkDk
         zMPlAPgVuRA68OaHDUnlXt6/NfrDOXhIWdhkyVtmTGTrMLo1uUplSrDHk4c0Nc2GHBcf
         JOcyIXcv3fxyAumktGlzROCCf5T5zWDdYbHzizh18Vvh0zfJn+mz80pSTlGwfQqXk3QJ
         SZXaQ7SSiHICy3ntNE/XDrFfQwluSuY+RnsjibxQv24GfTrEJ0l4jF4R7QIpa0xhvkiQ
         nH0w==
X-Gm-Message-State: AOJu0YyvtGO7WamyI8uEeqUg10hyZI9J2DKGIE9dq0mbDaL3vG1YdNVx
	KrNInFc7oWxBr/DPF41L563Xoz676bLdOibQObK+Y81wNfSKcmOQOFu0
X-Gm-Gg: AfdE7cm5VlTDrAv2JWFboDkJF1Yo3qNmwSr0FVnGtlxJAX17/W2Irxk3TfKaBl7ntuy
	1jGGBkfKf4aFNyaHSoZshxKT/YTJ4APXXocJyxsB0Xxg5r9UEWYG2dzobsQs0lbLwMSzJOsc7aK
	rpL78AaClTZHkDTK9zwYtzVXs4qn3UeRUKIboBa4bkNyYnn+/YK6P56yFlny6uZxpRrCFr2bFLj
	kglagIEhGSOg4ebPdoVKBORs/DxYoLNQugQ+V57IRaEfJihLoprJNlPPuN4WfgthvEXZWvWX1TA
	YepwVYn+t0GVvArVRPQ4HOYH3sXqEtmukplwSske2xCjprUPa1DEvjdNYeVNzGZLQMnkfAAntBr
	IGME2kocGwxMV5WTzUaQXyCuKCuXJd1mf6y2pMybeFDsuz554u0MfTJuWJrshxp2P3jQk7wW+X+
	anfNCYqPK7tM09yZMsJT4J/KS4hQknu1oRkiUc
X-Received: by 2002:a17:902:ef01:b0:2cc:d192:50b5 with SMTP id d9443c01a7336-2cf349aa87emr149181495ad.34.1784537460556;
        Mon, 20 Jul 2026 01:51:00 -0700 (PDT)
Received: from phuc-desktop.. ([183.91.15.56])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf346da095sm52955985ad.49.2026.07.20.01.50.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 01:51:00 -0700 (PDT)
From: phucduc.bui@gmail.com
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bui duc phuc <phucduc.bui@gmail.com>
Subject: [PATCH 2/2] Input: st-keyscan: Improve probe error handling
Date: Mon, 20 Jul 2026 15:50:41 +0700
Message-ID: <20260720085041.224896-2-phucduc.bui@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260720085041.224896-1-phucduc.bui@gmail.com>
References: <20260720085041.224896-1-phucduc.bui@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: bui duc phuc <phucduc.bui@gmail.com>

Use dev_err_probe() for devm_clk_get() so deferred probe errors are
handled correctly.
Drop the redundant error message after devm_request_irq(), since the
helper already reports request failures internally.

Signed-off-by: bui duc phuc <phucduc.bui@gmail.com>
---
 drivers/input/keyboard/st-keyscan.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/input/keyboard/st-keyscan.c b/drivers/input/keyboard/st-keyscan.c
index e53ef4c670e4..d86f6f16ae1b 100644
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
@@ -192,10 +191,8 @@ static int keyscan_probe(struct platform_device *pdev)
 
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

