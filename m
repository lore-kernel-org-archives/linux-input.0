Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16588349CFF
	for <linux-input@vger.kernel.org>; Tue, 14 Jul 2026 05:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784007596; cv=none; b=BrGEKkfQh2IfIWz+pLHqQnbz6UuyT/tMU0uBe44oDTZm+P6lbdYygKoK+k/kZXZFzS7JrmG/e4XmOBM6QpJEPhRXIbvMY8IW/7cjwMmV7zo7aOKMuScrgfeAFwK3jnIYZPD4byRAgC5kMa0BSZjaYKdRlpBh5KedUJUZCbJXhLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784007596; c=relaxed/simple;
	bh=O+zpxtco1vGs4iQLGtpBVCp8TNbvWelI5pjKpHMtF7U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=a+85Ge4dcgFZWOTDWHMNEGWMDfU0htLZ1+SFci+n7aixlCzOpXx/JUpLXsjP5t5scfWPIVAyEQ5ThJ/v0lVpKF0Qr93nY9UV88pY6wiy1ruTeNj1bbTesOhArKkx0MFWQw/pxF1stud8GVvxFdGYmmqkqfuETBiDE7HpeGQ757c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NqWvptyD; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NqWvptyD"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-38e1a9d9105so238385a91.1
        for <linux-input@vger.kernel.org>; Mon, 13 Jul 2026 22:39:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784007589; x=1784612389; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6vLs2pnpyfUpM4296TeOwGpRPQVn2UEDthdemoKxSj8=;
        b=NqWvptyD7Oa+f48RRfC4Hoex2LU+fTylCSYa5xZmTKL80O3P+R2W32n4/eekjYJ3NX
         fhPwi7LVAt5yVUpLyZ3B9Vif/FrMtl1MpXu4kQUZZvokONFDUKGpHYJgZW4LKkIo5/oh
         Eqi2uyhF0sE55kizG7v5xA8uFWPlWxLWYUuoTGxbi3E2DAnZEfvef5V0xEs95BSL+7M2
         SR59mQ+rECU8wS1FFKToodyDyWRe7ufjGSI+fYyCve5THkUPDGg/mouTjF0hGnCa/grd
         gTkMqWW/DOY2armDF5d9plrXw8PF1Tuh4f1z/QtHPGO4W3Bx4UqxgUdnoyGoYfVfSY/d
         uYpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784007589; x=1784612389;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6vLs2pnpyfUpM4296TeOwGpRPQVn2UEDthdemoKxSj8=;
        b=bAzV7oU9BaRw/Z+Mah7FM7Z69CwXxFVegJ+cPXsmpp3tG9lEuITv6eZLFpZ3EQDeX+
         2mpwtdYHDecKlqT+S0RMH4Xnlsau1uL4BOX3WfPjGsNddTF8RRHQ+W3+5Hpa4kD7c04a
         1McYI9e7qdwyCK0U+puC7PoFU5QRXXC+HoYCGz6c8f48CD8uAcxjDZM04C9cQl7ab52m
         ZaFmdPIkz6ItOoUUpNkrDXBqZsKUhs0N5a8rG+nrh6q4lWy/45b1sggJH7njdxT6MOnn
         G4IhKLNcd1Ez4fxdgvIux7gT0rcib7ALz44HI6oXOLP73u53FSblEAvsp6Hc/AEyYddw
         OmCQ==
X-Gm-Message-State: AOJu0YxQnYg6tnu/rPNWlSTjrItbBxKqBPriORz6fyO30I1dgUtuLqmS
	Nt9N4xu+iE7m8qpWihRx2SN1V5nAW2iu2XrL+kDcXtxnzV/DwT/rACaIHX9M+Q==
X-Gm-Gg: AfdE7clUJJmVFRfJY9VAC2nBXKDq5jsFVi/AvFqRoE3+m08/DynFT76WCnOc8/PAeVQ
	RA3b627Va++YU7wcxhDUyil8PzRSExBtFCJKqFLo7QnnGx9bXFONh+dkwNTmiM9WT2vnicvUyOi
	khXjs86VM1OLbxEzCa2GK1bscYrmw0AG71B5YlFA0bKYgSwmi3Znypa/Sa7GIGnV/sreN/KkiC2
	mS98OPgm/vHBRyzfzELPhpHGACbWztWeuDJ8gLuESYx9TwtG7a1qWW1bXD4w8rZPZAejKGs7EcB
	ro/XAZLbv51wQHyyLhNP/N70REQvJ4C3MZzjZ33vIpr1vbWvWKRKPEhAxJ5Ptuml9RsUzLhaMQh
	2Sw76tZ9+h8VqGfLfoqvVTh65IGcAy7eUENOvb+805Jfm1IVymp9CH1yJ++83VlfMj3hL22cIzL
	+MNF7Dv2L2g2v3CkBnUCBTEm+c5NaO1QSPeuDHhq9/ijb1PD3NOr4PtS7PcCGDL5Ouzfi34FCFv
	mWgtLKPH8zV6aA=
X-Received: by 2002:a05:6a21:151b:b0:3bf:6c04:a812 with SMTP id adf61e73a8af0-3c110b2d86emr12502322637.51.1784007588911;
        Mon, 13 Jul 2026 22:39:48 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:e15f:5d5f:580b:f2e9])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b9a67c217sm18127165c88.8.2026.07.13.22.39.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 22:39:48 -0700 (PDT)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date: Mon, 13 Jul 2026 22:39:37 -0700
Subject: [PATCH v2 1/3] Input: samsung-keypad - clean up wakeup
 configuration logic
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260713-samsung-kp-irq-v2-1-acc84b6daf9a@gmail.com>
References: <20260713-samsung-kp-irq-v2-0-acc84b6daf9a@gmail.com>
In-Reply-To: <20260713-samsung-kp-irq-v2-0-acc84b6daf9a@gmail.com>
To: linux-input@vger.kernel.org
Cc: Krzysztof Kozlowski <krzk@kernel.org>, linux-kernel@vger.kernel.org
X-Mailer: b4 0.16-dev-b242f

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

