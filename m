Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9251D34FF78
	for <linux-input@vger.kernel.org>; Tue, 14 Jul 2026 05:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784007595; cv=none; b=JrBDxyEiXzILNuICuUt09IbbnLK7EFE/neM+lwIMRzKsrW6bT+gqAjEGARfXll4a89r1n3WH9+O/FMj8SZUwjmV0ngh0W3ignqQdeq+o6p1I0Y7BAJIzJN9MG91AtHkLWPsAzyPAmLqmFg2TYAUSQ8MUGYCDNJ59OmqUN/yuhlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784007595; c=relaxed/simple;
	bh=dAktNI0ywwV7Ui1PNrhlu9qMQfmJlP/Ob++z04sLTSA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MP7IKwf8mTO3SlR5IlGLQPYFGJSjAm9DtytOQXq0cvJtbkR/h2JXRToNR0TKpJfJBtGD9A1R7eDuQu+xWOQl5OxZB0HPIajXcCdhNLMtiU53B+8oCpzeQMuLdxN0Mg6AIjynY1nxs6RYYVTpI3uTAZmmwXWzBWkYUlLTOONJqK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SEFv0YV+; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SEFv0YV+"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-8423f236418so520825b3a.1
        for <linux-input@vger.kernel.org>; Mon, 13 Jul 2026 22:39:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784007591; x=1784612391; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8Hpfl3qQrnbgXRzky8j4lTj5LtUOfsjsIX2OOcbfit8=;
        b=SEFv0YV+T24O0lhWBpsUD6gRLb4EGNiRkz8H+Z30B/PejXIXncBhCf2g4GxYIeNEge
         M8dJopFPkX4TzKVbItSZ/VmytTrIs6WTucwpVG+kdLXKd0NssFrCt+SGOuojWVLkGpy9
         aR4Fka4HU3cu1juv1u5Lxgk9/3UrEmq+NiF7YWUiq/CceRG9hoDilAIJ6RQZjNN9yQUF
         ouFSBXs8R0EWIucMwJzHII1tmxVVxbP7gv4dKUibYWTutUrYv0C+PIWq/1zXV0/fX9LU
         xJm9GazGAa7h0Dz0D3jPzSZYXWt/dTtguDwuU/1llH/p/iR6/Mzn/AX1QMmQrSlo4vNI
         aggA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784007591; x=1784612391;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8Hpfl3qQrnbgXRzky8j4lTj5LtUOfsjsIX2OOcbfit8=;
        b=UHydWAnj5lCTA9PmxDrl+Dlo6NfhT4788Un+LsrowdMKuJBD5/WecZUFuWYoJnTRLe
         gNqwgSGaUPVMdBj9p8ft45M7Le0yLEWEg/510zySb4YHh22lkJtfakIIDvzyiIjWT1nh
         g+c9wBs4x3Fc2zQozfx9Au+ktO4b7ZnVuvTtNZTi2IkN6WzsZZ1GYptY4M/nWuupFq0W
         miJ99wb+vPmwyqlyCNtOSNxu2ZUb85ZWbu4liLzlSC/VX3t0muNmOZvPRHYPx1Fh5gV/
         53jP88VJiTwCvf2pWjvQQ3PmGRv/+p5fbUogan4aM5mH1eXYvHBjSh07lIcPU9VpE184
         8FXA==
X-Gm-Message-State: AOJu0Ywdiqe02yFq2QSghRiDtl8F49xMi7JWTZLph+a82eeMXWWDxBuJ
	HJKvLiV+4tOAn6qSKcI/NfYtwOzoAdCrFZVu9HIJDP2Md8Fua9e/+F7+YASvfw==
X-Gm-Gg: AfdE7cmtkZHTwOI/leg1CdYcSE4f+ARJwV4U/XcjxdIlJ4P5EwtSNAF7tVsqDJA+Vw7
	sVzZvPfeo82E0kr39+jAk9V7nL6kKR43oaycr1NItLn+3A6KnpL1wY0zW/2y/ZbQyGtFMOxENfF
	1hfGSONEY/AD+dQpQtPZHJzPkTZyDYabV6zn/u+fDUvhM+L3fz4nXNyqoXS/3fRYBwiNALaYC+h
	e78unYJdOjlyaUlc8sJ/Xn0wgPiw2aC9sT0tjGRFLTttpnTeT7B9YFMsLNAj3Vb6slGI0KcjdP0
	r/qQAEs65IB0l/IZaCiiQkRhCIkEjInoiWLf/HH8O/OF1QbqXKm8fhsJn/LpnybHGdL1iSAT6tS
	T/fTUAsmgNQVGGgCc2wuMZQjyf8di/V5XK+S/F4aKLV48r8Q0dg5qYwnR4HJgdmdVISiagAGpN9
	jDEIh1ahnx5zShnM0cTeD0mdviP0kfrfetvEEa+2O0YFn7ff81AR6nTF2CS1E95Lf8ndE1rXcnU
	SrS
X-Received: by 2002:a05:6a20:394a:b0:3bf:c2ce:972b with SMTP id adf61e73a8af0-3c110b6344bmr13408459637.50.1784007591135;
        Mon, 13 Jul 2026 22:39:51 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:e15f:5d5f:580b:f2e9])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b9a67c217sm18127165c88.8.2026.07.13.22.39.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 22:39:50 -0700 (PDT)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date: Mon, 13 Jul 2026 22:39:39 -0700
Subject: [PATCH v2 3/3] Input: samsung-keypad - use pm_runtime_active guard
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260713-samsung-kp-irq-v2-3-acc84b6daf9a@gmail.com>
References: <20260713-samsung-kp-irq-v2-0-acc84b6daf9a@gmail.com>
In-Reply-To: <20260713-samsung-kp-irq-v2-0-acc84b6daf9a@gmail.com>
To: linux-input@vger.kernel.org
Cc: Krzysztof Kozlowski <krzk@kernel.org>, linux-kernel@vger.kernel.org
X-Mailer: b4 0.16-dev-b242f

Simplify the driver by using the block-scope guard(pm_runtime_active)
instead of manually invoking pm_runtime_get_sync() and
pm_runtime_put().

Assisted-by: Antigravity:gemini-3.5-flash
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/keyboard/samsung-keypad.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/input/keyboard/samsung-keypad.c b/drivers/input/keyboard/samsung-keypad.c
index a51f0f639e9e..deffa98749c0 100644
--- a/drivers/input/keyboard/samsung-keypad.c
+++ b/drivers/input/keyboard/samsung-keypad.c
@@ -142,7 +142,7 @@ static irqreturn_t samsung_keypad_irq(int irq, void *dev_id)
 	unsigned int row_state[SAMSUNG_MAX_COLS];
 	bool key_down;
 
-	pm_runtime_get_sync(&keypad->pdev->dev);
+	guard(pm_runtime_active)(&keypad->pdev->dev);
 
 	do {
 		readl(keypad->base + SAMSUNG_KEYIFSTSCLR);
@@ -158,8 +158,6 @@ static irqreturn_t samsung_keypad_irq(int irq, void *dev_id)
 
 	} while (key_down && !keypad->stopped);
 
-	pm_runtime_put(&keypad->pdev->dev);
-
 	return IRQ_HANDLED;
 }
 
@@ -167,7 +165,7 @@ static void samsung_keypad_start(struct samsung_keypad *keypad)
 {
 	unsigned int val;
 
-	pm_runtime_get_sync(&keypad->pdev->dev);
+	guard(pm_runtime_active)(&keypad->pdev->dev);
 
 	/* Tell IRQ thread that it may poll the device. */
 	keypad->stopped = false;
@@ -182,8 +180,6 @@ static void samsung_keypad_start(struct samsung_keypad *keypad)
 	/* KEYIFCOL reg clear. */
 	writel(0, keypad->base + SAMSUNG_KEYIFCOL);
 
-	pm_runtime_put(&keypad->pdev->dev);
-
 	enable_irq(keypad->irq);
 }
 
@@ -191,7 +187,7 @@ static void samsung_keypad_stop(struct samsung_keypad *keypad)
 {
 	unsigned int val;
 
-	pm_runtime_get_sync(&keypad->pdev->dev);
+	guard(pm_runtime_active)(&keypad->pdev->dev);
 
 	/* Signal IRQ thread to stop polling and disable the handler. */
 	keypad->stopped = true;
@@ -207,8 +203,6 @@ static void samsung_keypad_stop(struct samsung_keypad *keypad)
 	writel(val, keypad->base + SAMSUNG_KEYIFCON);
 
 	clk_disable(keypad->clk);
-
-	pm_runtime_put(&keypad->pdev->dev);
 }
 
 static int samsung_keypad_open(struct input_dev *input_dev)

-- 
2.55.0.795.g602f6c329a-goog

