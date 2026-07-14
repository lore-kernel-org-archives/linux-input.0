Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9243C34C130
	for <linux-input@vger.kernel.org>; Tue, 14 Jul 2026 05:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784007596; cv=none; b=UNmRxn8HSXfwZVtjq2x22mJ0RaXinCI/XOrTTqpiizQKOx2II41iwOqomCqymys6duxvRJYNJ9zosLQmpf/106Ija03+x8ONc7UkysqqWq+mzWerdv6963Q38SC5jp52ot+FCgFarc4r32aJ5rpx3vNm9O8ynoO8BNSFts5G3+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784007596; c=relaxed/simple;
	bh=ksw10MQovv3Metf03wMB728pff5hzZhCYxZu07ghQIc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aAHTNj32Pf3bpciw+/UbUL9QwjHDrVk1Goy1QATUYaZeNE5SW+kHpS2ZiyDoMrPxh5rQjzoLvLiCrhuv+TXmMT2Wn6EKnkfo43V3rVIfbIGgd9JPSBdKzAD6UXVdcR8OjSLb0WMEr2cuFNgROuO8h2vXWfJYDlgYPS0zxJIrzZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qINKFo6O; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qINKFo6O"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-c9ef3e1337fso2606827a12.2
        for <linux-input@vger.kernel.org>; Mon, 13 Jul 2026 22:39:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784007590; x=1784612390; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=k2lHS08yiSSbdpwwu4OaOpdnqnXLqyVO0+OVfh2Ctyo=;
        b=qINKFo6OpNVBoCHje1Zg5mGB1zsj3VPN6BlxI4hGVMD0HTS3i9ITxc7QZJhI9OTGG0
         5YAkCY/7y7t5PiQ6UavnNAlrY2J8i4BQk6FHniyo4dv2x1KXNxFiqr7vUttjLI/d0ybO
         Z6rGGLfuhZnTCgPKs6rJc0MNJA98biWybOgAqv46mnL51brlvvlJHDbbvhW7bX+44sQP
         sfxVVgdALaEtPMv5sJbaAvVSzBHYoZGfCJR/RaKz71wMWTkTOrf9uqUutmJa/xnLxEH9
         WbiRaDwvuNaEpct/OGSpkEuvURDNUXmDHj29CZMjc0M7VjWlVWiSbAFV6j/+RQgEsSaw
         87rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784007590; x=1784612390;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=k2lHS08yiSSbdpwwu4OaOpdnqnXLqyVO0+OVfh2Ctyo=;
        b=gWdkyKffYn0NJDC/ScXckRa6yD0+rIFEkTuQGLEe7Mv9hWhKEnF5GOC5bYvLKu1Xmm
         nV/GbebWPwGpS8a05ZiveiE+jgaXmjvkng4SXNBsyDOSsxuk/xxqSCfODaRtCrRfL/LK
         HDqkbJtFsVqG0JGpr2heeZ69MQaS6KptHIVe/IeytK8dnkndmfDI6T+/dQFf7KY1fSH0
         FKEc7VE384YmQZRHqQVlvTboniH2/yyJs0HOexjJg9wozn7K8OYu10xqdWabZGLMm6xK
         lFc6TBXrnchQ9T2ec8c5PAC2les3n4oLIQiMqoUrLrh14szsyRKWOwsPUK7mcuhmHABF
         Fr2g==
X-Gm-Message-State: AOJu0YzlySvsdKkqc090By/DWb7QOluZnw9nqnBdzYrSfIhJh8D6fa2m
	8bvIAhjWVPzwZeGrLxI2vn+x9bTOvPJ5cyBxaFPfJ5U/7CVPNK691Nw2bXIuMA==
X-Gm-Gg: AfdE7cklNuJpNNPj73wKrZFm/b2PdbVaEw0BzNY3EojPcHwppQbcDYlCttjQkZ4X0NW
	ajICspoCcvjTDSGv8odE+tPJ9eg7ZUlT5RgUJfHRM8FIGNDHEaegpQeNnaMGL/fNYPc/8V2DDiJ
	Ci9TM3uiwqYJIU419xSCoXytDNtBgqZPJOJIlvTp92Lc0cs9aUWGc+iHsxUJiM19jjCM+t4DOdo
	aBdS32HuRkrb+sJOn8u6Pv11/ajaR79023U7m1+RU1ydnH/lAb4tu7rZMplZ5Rl1Dk3EDWeROyJ
	EvhrXuYq+n0uLPe9eutmUF+p6/ca+QWHaAjw+DG/nzNYtF1lL+2JJwOZzC/XIyVK+k9eIgqCLD7
	Fs1vuIm0oI1BobMYntJXHZm2xLGWhR5l/e/z1EDYKBolLkizA0WxtwILdHD1YyDc5GdOaHap/Y1
	waS1q2ZreAv5g+AI6IW/6LiQ7Uutw+tWuNBygt3h4Py7TWfnc4ChDGnAJR0xinHGUJsSCOyiMz2
	TSg
X-Received: by 2002:a05:6a21:320b:b0:3c0:9c1a:8939 with SMTP id adf61e73a8af0-3c34d8b7157mr3038230637.65.1784007589978;
        Mon, 13 Jul 2026 22:39:49 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:e15f:5d5f:580b:f2e9])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b9a67c217sm18127165c88.8.2026.07.13.22.39.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 22:39:49 -0700 (PDT)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date: Mon, 13 Jul 2026 22:39:38 -0700
Subject: [PATCH v2 2/3] Input: samsung-keypad - keep interrupt disabled
 while closed
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260713-samsung-kp-irq-v2-2-acc84b6daf9a@gmail.com>
References: <20260713-samsung-kp-irq-v2-0-acc84b6daf9a@gmail.com>
In-Reply-To: <20260713-samsung-kp-irq-v2-0-acc84b6daf9a@gmail.com>
To: linux-input@vger.kernel.org
Cc: Krzysztof Kozlowski <krzk@kernel.org>, linux-kernel@vger.kernel.org
X-Mailer: b4 0.16-dev-b242f

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
index a578f429d100..a51f0f639e9e 100644
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
+		if (!input_device_enabled(keypad->input_dev))
+			writel(~0x0, keypad->base + SAMSUNG_KEYIFSTSCLR);
 	}
 
 	clk_disable(keypad->clk);

-- 
2.55.0.795.g602f6c329a-goog

