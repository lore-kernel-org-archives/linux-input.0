Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C63742E739E
	for <linux-input@vger.kernel.org>; Tue, 14 Jul 2026 01:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783993995; cv=none; b=SpVE6QJqQR/zzFSScF7l/l1Teu91//3GHmN+dFcDorYDDM+td7idEE/bCkhidugFONepzGK+2nk0xZWbSZGF8fjtBtdWZXf8wkjlnA07eTwelbNWkiWxOBqGxGztpJ97ba+zwYWqv01ZSORnevLrj/S8ZpDyIuRcCodZ9g9vF6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783993995; c=relaxed/simple;
	bh=nceC0hmI7gnrKlCwFmW9hhPM3YwKU3Uv7aUIfSfOMGU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ojLVs/O23ezgl4jGz3hQJY0AjBZJgnXI8/lX8XsGu/CWKIyGd9WKBXRJNEg6MT/cUBfQoRP7iMC6Qd4mgCUQSb0z9m78Scd6Xzd95DTzBL8QT2OQ6BzaFuejJMPQvJepjdbSiIxFYSWQrAFd/SdJby1kpOHB56j3dUICLAPzkGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cCrzxpSR; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cCrzxpSR"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2cea3004256so33318295ad.0
        for <linux-input@vger.kernel.org>; Mon, 13 Jul 2026 18:53:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783993993; x=1784598793; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=T2A8arpZDqHhEs/PE619EoRrshu6mW64v0SHJBL4XzA=;
        b=cCrzxpSRAflt2otLRzkX47V+7zJevatwt6u1h/X/CbDsy7wL+ztEpJSh3Qj+UfFr12
         Fe7FqoIckua2rSCRL9/4EIzOuKHwqubcZ7Z2Yw84B4h/CW7dFgRUBrGpRIf0YXUK6IFZ
         Q2L4ElrDzi9cX0s9TM7omhLVo3m5YXeHC9UMhYkEd5RuSoyTorzFPZtkdmJSfOreRRXt
         V2Me4MC7Wi0zam0qXa5SdSIczAcl33mPsi9Cn4L4Z8e/JnhamZJOUHe81g97U7mLaKrj
         AGzCW0BfLACOyGf9pjbComAYQYyEAdOVb7LDyq9r6DoGQHfhUrAEfqF+hXZihJk3MDp6
         bocw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783993993; x=1784598793;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=T2A8arpZDqHhEs/PE619EoRrshu6mW64v0SHJBL4XzA=;
        b=FQ4/CRsvOZOOt0hcVnN1p+P0Y1hbarRBDId61y6l6AVVIfEb9BsbUH4kkhpDMW0vMN
         Caiv0FccoLDvMOgbS5hw0B/2A6uV5589C0HO4SkhOB5RcweWQz/xH4sKvo6aCCPAcslv
         ZGk0C6OYwC7ffw8f51N4XdqxrXWufJY12czQukdgHUkMlCMd4zTcV26B0EZTi8tKArHx
         Y6u7KMNcjLXlsdP0OUEPIOXVW6+zilZ/yV8rd2VWeOrg58Dfx3b7yS+7Fk+fNupivXD9
         lmQF+/VKcJU6SzpnNtbSPLpaDhN22BFq5B8MYmZolcTVTfhqyu6caXTWF5/rRmbxO8UM
         YJbg==
X-Gm-Message-State: AOJu0YxJFRXWcqxMo36eTInT0FNyk34RAHo4SiuCwBldyHkUTDi9IlK7
	TMjirnxPLkJc727vLOaRHqFZc9ZQZcAbeH6iiwsm6NQ8yZ7S2Exl5Tv3wvOKGQ==
X-Gm-Gg: AfdE7clmz4iC5jL6MHJ2qRlh+Ls4j4WMPsk11hrORU9GHy+rPk1P++ne5MQrm6oAjRN
	+BSksA3CfjnRdTvZ77bLoDuEcjh1pAdZxhzGXE4MbT9dmKRWPCZrB6yM9ZvFieEqamesBbNkY1L
	VWfGTWBNHOwn8P5d/AlCuBgTm6r/boUZKhApvD+DncRD33QwZ/CZ4t4FMhcFgLwvCf6haqLteE0
	qUEI1AvK6s12ggRybDYZDwUQVcXqu/swFFsAcu+wsA4xBv1WmPzDdT5B30g4PlKYs9lSkG+r5cl
	4cqJVaO+SwkvZSBJyy3R39pW31NA/MFBf3rNu4OngYkm/I5pIsriWCmRw6VCQP7Wz79bdQcRM8H
	XSQvh17oMYp3V51z2lUUA6RgSIQzf6QAI5qlqqVRiOTSQE+7bhQSgM0YN2Izw7O8Ev3sAh2SvKT
	NbKE22BX0d4bta8xvOojpWZ5FgayMNlrE3EhTKFJufKpPuaO75ltp8penyW4geOZlj+HTcK9060
	7Wz
X-Received: by 2002:a05:6a20:d04b:b0:3bf:9142:ba3a with SMTP id adf61e73a8af0-3c35701fc6emr276940637.26.1783993993074;
        Mon, 13 Jul 2026 18:53:13 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:e15f:5d5f:580b:f2e9])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b93ae3b45sm22503093c88.15.2026.07.13.18.53.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 18:53:12 -0700 (PDT)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: linux-input@vger.kernel.org
Cc: Krzysztof Kozlowski <krzk@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] Input: samsung-keypad - clean up wakeup configuration logic
Date: Mon, 13 Jul 2026 18:53:05 -0700
Message-ID: <20260714015309.2140694-1-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.55.0.795.g602f6c329a-goog
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When checking if the device can wake the system, we should pull the
device_may_wakeup() check to the caller instead of repeating it inside
the toggle_wakeup() handler. Furthermore, when configuring the wakeup,
we should safely ensure we write to the registers in the correct order:
configure the interrupt receiver before enabling the peripheral's wake
functionality, and vice-versa.

Assisted-by: Antigravity:gemini-3.1-pro
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/keyboard/samsung-keypad.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/input/keyboard/samsung-keypad.c b/drivers/input/keyboard/samsung-keypad.c
index 17127269e3f0..a578f429d100 100644
--- a/drivers/input/keyboard/samsung-keypad.c
+++ b/drivers/input/keyboard/samsung-keypad.c
@@ -492,15 +492,14 @@ static void samsung_keypad_toggle_wakeup(struct samsung_keypad *keypad,
 
 	val = readl(keypad->base + SAMSUNG_KEYIFCON);
 	if (enable) {
+		enable_irq_wake(keypad->irq);
 		val |= SAMSUNG_KEYIFCON_WAKEUPEN;
-		if (device_may_wakeup(&keypad->pdev->dev))
-			enable_irq_wake(keypad->irq);
+		writel(val, keypad->base + SAMSUNG_KEYIFCON);
 	} else {
 		val &= ~SAMSUNG_KEYIFCON_WAKEUPEN;
-		if (device_may_wakeup(&keypad->pdev->dev))
-			disable_irq_wake(keypad->irq);
+		writel(val, keypad->base + SAMSUNG_KEYIFCON);
+		disable_irq_wake(keypad->irq);
 	}
-	writel(val, keypad->base + SAMSUNG_KEYIFCON);
 
 	clk_disable(keypad->clk);
 }
@@ -516,7 +515,8 @@ static int samsung_keypad_suspend(struct device *dev)
 	if (input_device_enabled(input_dev))
 		samsung_keypad_stop(keypad);
 
-	samsung_keypad_toggle_wakeup(keypad, true);
+	if (device_may_wakeup(dev))
+		samsung_keypad_toggle_wakeup(keypad, true);
 
 	return 0;
 }
@@ -529,7 +529,8 @@ static int samsung_keypad_resume(struct device *dev)
 
 	guard(mutex)(&input_dev->mutex);
 
-	samsung_keypad_toggle_wakeup(keypad, false);
+	if (device_may_wakeup(dev))
+		samsung_keypad_toggle_wakeup(keypad, false);
 
 	if (input_device_enabled(input_dev))
 		samsung_keypad_start(keypad);
-- 
2.55.0.795.g602f6c329a-goog

