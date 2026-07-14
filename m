Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 093B9370ACC
	for <linux-input@vger.kernel.org>; Tue, 14 Jul 2026 01:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783993996; cv=none; b=uQ9ErPo4/BbdkIRhYwwxL15kW5FqyPtBWy6GCN2FseVDB5sVACnTnkHppqQHeVRDQiqlHj5oDrUmznfwKaQIyrG+6pH0tnLChOmRh9lrS+0jyANgX+wvf8GiO7QR/OE9XxnfSuVMGmk1Ik/cdQvfzUI276Ej99pa9vITO7fcFeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783993996; c=relaxed/simple;
	bh=YwCKNi9HORlnSHohukkixXXpVHplsu608EdMkdhjrro=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XVJkrxv8sjFhfQBhtZVlE+PilgaGcexpT/DGpB7KRzYp+QX2DXZiLi2PUcgze1QkUJkQ6nVRpc8ggrcOQN2uOWbE+WCgQfkUPt24m7XH/vL7nv0D2rleccybLnEUZSEAyd4tuypt4hDwr5dUlupKa4DuHFiGxovWZ0Uald6OnI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fz0/okfz; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fz0/okfz"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-c9e607d81fcso251093a12.2
        for <linux-input@vger.kernel.org>; Mon, 13 Jul 2026 18:53:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783993994; x=1784598794; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rMD2T0mMQ4/FSeALpiC8nsd8FBsQVCO1o6ymyIsfh3U=;
        b=fz0/okfzVBW2Ke8HPgqLoHHVgxWyuvqAdfzCZNA7W3wmlMm5YeO7HenFkregrAHIZM
         VC9whkZUGB/PVIniwOpz+lEIfiFka0LZSM6eLsOnDaNXNGhWNOOFo6t//RU9P9uczSDc
         6Us8Fwfzuwjb5YWW/PQ+VKCwWSpnkABZ5noZXG3fBs1bsgdpffBl3WFKHSOOpn+lGv8q
         tdz77qhGG8eXX7Z4yeOD5GPrGzO7cbdsDPK2U68r8rUn/wLxhPMpnoqbc2o5l22ITxZ/
         3wKbVqB6TroUTYF8GdNbjOWIc8My8/bE5CwHnxdNn0mMXiIiqhM7D/PVR1FZKjZSvY9m
         ffUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783993994; x=1784598794;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=rMD2T0mMQ4/FSeALpiC8nsd8FBsQVCO1o6ymyIsfh3U=;
        b=HGs1XO8V8ZEuQ8eSoKiX8txcfD1fj6Q04bzeeYyxgt2md1XfPyWN1H8aCjROOmOUqV
         jC9xcuPdY7dYILlmAl2aFt4aze8AYG9TY8PitXYG4xbfK+VPfB341eYkS5LsYIhKx0x0
         QhLyxQDzx8oe31gK0IsVUk+Mw/m1yb80KmT1VvkyXD4YecFbDmhRZKE5ieoEzvTk7LQJ
         EK/Dg5scUK9OrZSsGTJhLAvVuv2pneDeBiMcrqwFytQRax0sXfMx5L1/6RgIjUwT9kvk
         gONF3bJqpkxFKDHVajlb4NbeIWMjOZNFBzzMsB21WcHKI3rsjDoTDys9U1lhO8KJAGor
         2Fdg==
X-Gm-Message-State: AOJu0Yw5QFgMO0A9sWrsyIG9GDPA8mCOruApL6cfQIZwWSSM0rqy/ws+
	iKxqhXVyn/dl168XV5yDYOxX1T2s3DWSmO2kj7idlfs+BuNSThH8CL7pPC/XJg==
X-Gm-Gg: AfdE7ck+luMFEdefrlVXoMKgvhl1V2NO/Smv2qFyByoqjvq5joRv7RNV3dMhZo9+gQc
	g44XXm0eFH9I4XZJJ2S+EM7DHTDxFFoaUfDXgq7wrkQNYUPGlh61gSjCdiCp2sqZ+nHLXBwVr5K
	6YSOEmA9vzDuUNJn8XoCiOP7kS0hqfWSqXy9OSlJhd/sJ7oTJjzqzAwGmB+WlSUAMaoR6XeerLm
	vinckDlaIQAIVD5ja5PPsSE/+mfN9J3MImNuMUCuit0sj7ahQCJEATBAYkoaxFHdGG1JoiXluC2
	04s47iwdUFSAeOM25baWMJnMFXSwsYJk3Hh4lwJGswra4UQx/wq+iyh24NWU92wMVZP7gtep69e
	jTrm1VYGKR70UHPoFnZ+n2Gz+S/DmrrGK3gMLTtp8g8BmAP6O3nZ6rDVszJvnOrDYe4l63JpDaQ
	I2fK/qBS8Y2P+lrxkbActFTpehALG0NeavDYMY7/uK1K7g9Zu74UaeQwY+lGsto5TelCbdWhq9L
	y/W
X-Received: by 2002:a05:6a21:694:b0:3c0:9c19:b27b with SMTP id adf61e73a8af0-3c110cf96d5mr11954673637.73.1783993994263;
        Mon, 13 Jul 2026 18:53:14 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:e15f:5d5f:580b:f2e9])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b93ae3b45sm22503093c88.15.2026.07.13.18.53.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 18:53:13 -0700 (PDT)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: linux-input@vger.kernel.org
Cc: Krzysztof Kozlowski <krzk@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] Input: samsung-keypad - keep interrupt disabled while closed
Date: Mon, 13 Jul 2026 18:53:06 -0700
Message-ID: <20260714015309.2140694-2-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.55.0.795.g602f6c329a-goog
In-Reply-To: <20260714015309.2140694-1-dmitry.torokhov@gmail.com>
References: <20260714015309.2140694-1-dmitry.torokhov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The driver requests the interrupt during probe, which by default enables
it. If the bootloader left the keypad interrupts enabled, or if a
spurious interrupt fires early before the driver is fully initialized
and clocks are enabled, the interrupt handler will attempt to read
registers and may cause a synchronous external abort.

Fix this by requesting the interrupt with IRQF_NO_AUTOEN, keeping it
disabled during probe. Enable the interrupt in samsung_keypad_start()
when the device is opened and ready, and disable it in
samsung_keypad_stop() when the device is closed. Remove the redundant
re-enabling of the interrupt at the end of samsung_keypad_stop().

Additionally, manually clear the pending interrupt status during system
resume when the device is closed to avoid immediate resume.

Fixes: 0fffed27f92d ("Input: samsung-keypad - Add samsung keypad driver")
Assisted-by: Antigravity:gemini-3.1-pro
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/keyboard/samsung-keypad.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/input/keyboard/samsung-keypad.c b/drivers/input/keyboard/samsung-keypad.c
index a578f429d100..88e733c1eabe 100644
--- a/drivers/input/keyboard/samsung-keypad.c
+++ b/drivers/input/keyboard/samsung-keypad.c
@@ -183,6 +183,8 @@ static void samsung_keypad_start(struct samsung_keypad *keypad)
 	writel(0, keypad->base + SAMSUNG_KEYIFCOL);
 
 	pm_runtime_put(&keypad->pdev->dev);
+
+	enable_irq(keypad->irq);
 }
 
 static void samsung_keypad_stop(struct samsung_keypad *keypad)
@@ -206,12 +208,6 @@ static void samsung_keypad_stop(struct samsung_keypad *keypad)
 
 	clk_disable(keypad->clk);
 
-	/*
-	 * Now that chip should not generate interrupts we can safely
-	 * re-enable the handler.
-	 */
-	enable_irq(keypad->irq);
-
 	pm_runtime_put(&keypad->pdev->dev);
 }
 
@@ -412,7 +408,8 @@ static int samsung_keypad_probe(struct platform_device *pdev)
 	}
 
 	error = devm_request_threaded_irq(&pdev->dev, keypad->irq, NULL,
-					  samsung_keypad_irq, IRQF_ONESHOT,
+					  samsung_keypad_irq,
+					  IRQF_ONESHOT | IRQF_NO_AUTOEN,
 					  dev_name(&pdev->dev), keypad);
 	if (error) {
 		dev_err(&pdev->dev, "failed to register keypad interrupt\n");
@@ -499,6 +496,9 @@ static void samsung_keypad_toggle_wakeup(struct samsung_keypad *keypad,
 		val &= ~SAMSUNG_KEYIFCON_WAKEUPEN;
 		writel(val, keypad->base + SAMSUNG_KEYIFCON);
 		disable_irq_wake(keypad->irq);
+
+		if (keypad->stopped)
+			writel(~0x0, keypad->base + SAMSUNG_KEYIFSTSCLR);
 	}
 
 	clk_disable(keypad->clk);
-- 
2.55.0.795.g602f6c329a-goog

