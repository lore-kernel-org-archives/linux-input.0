Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71B0234EEEA
	for <linux-input@vger.kernel.org>; Tue, 14 Jul 2026 05:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784007592; cv=none; b=tgKxkQ84A1smijxl1z5J8X5XbAb0mLWttIHwDHEqoPQpU3if96Pig9SshBHhcx90HA7tzgf68aNWTscpEI7ahJP8XXeSQvipwa7XcF3wWc69DOXfDcSP2Zp2YnQzFNWbqLtgtTj1Rx1R1xZIimDH07jxzp4hll6kU3nxAesZi04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784007592; c=relaxed/simple;
	bh=LQOFsdwDlQXXzpZCv7JgpDdfcSBRXwiumQeq+1mKp/U=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=poV+7Jg34auU1mHXTash2CBAHGd/fib8+4ERy0GIrzQew+8aHESv/A1KizXrZq0shpwVDX2rx9+u9F1N8B5qGnLYxEaz3vm6DFNTq6PUGWQKoH5B6CixGMexg0gUtmZecsu2e8onkcT+HqtPadpnU1pz1szjZUC+8lsR8wP13Zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HsfV31YQ; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HsfV31YQ"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-383adaa461fso439796a91.3
        for <linux-input@vger.kernel.org>; Mon, 13 Jul 2026 22:39:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784007588; x=1784612388; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=/VMNZy+CKGa0XMS2CCxjnKsK7OPmXHnUQ2wlt6Z3JiM=;
        b=HsfV31YQyqLm8zlDJ+kN2MrF17j5g0unzL36DIkP1ALe8vXSpU3gRUso9o06qTL3NX
         PEEk+3hj3LdHHA8nuTT7SgHFCSpunhn/ZECLyPWoXkNk12STQwPcVp7gy6IKU7wHRdfq
         IU1V5r5hxr5jKWon+XMHkBFpB2orP0lp/vNIjtI0OZT2TEfo+bwT8GrcLBzEqAYhML/z
         DA7Nqutz5fpO0J2sa3Vei+vI0sqmCgi2T6SHo0cl5pKVOFQ4ZHingzzja3V3O+6SmolC
         ztPlOb12sIUOSuWSHE2O7Mfq/B3vjjirAzd+iCqp/1nCLD+Cr7ycOjcHPlIjWQFOiEIO
         yxJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784007588; x=1784612388;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=/VMNZy+CKGa0XMS2CCxjnKsK7OPmXHnUQ2wlt6Z3JiM=;
        b=C3RPvHaFKSeDxOuNvrQLRg1GJO/QnNGo97z2oGQ+MtsApYyR/LN79jIXY6yfgxfwLg
         Pn3dEbg31VsXUnFdYs4dLtqqFzuY/+ORh0t0/o/eAYs+axN6p7vmiXS0thLuUPp9Ts8R
         97l+pP5yw+JaV/3HRBax1YKChZzXQrxmVdWfDy31M723Ej9DPGDC5WR4tg1HlZIzf+r6
         B4j1+kyRn01tinMAN4ZHA1UOVuJ5potCP9la1lmWIq+B1z/R1B4j9avwsIvjb6MpFrRK
         VLwvv09OB7EtjElWxeg8FaSWF3DxbmK3SM4kw1u/EAMeW1IQrPbEfzzETPocEK1KwE9O
         AarA==
X-Gm-Message-State: AOJu0YzAPpBn8Kz2C5JNncbD6AoyF404fBKmHnVUXJmAtXRWM+aE9q+b
	RqaJJ9jLv0zJ0R17RXLmiMdtKeyItnxkvwOKg7aRDUV+Yu0Gd6pegAmJvzbLbw==
X-Gm-Gg: AfdE7ckEE/FToRE0iVjtDCAE94IHsKRcmXwybaupq6+Xhu6fUWxrHMs9VWRV3d019nB
	eg9IRcXqbAIbxsXzAE/yEzM+9DIHDKf7ZRax/uqde4B3aP2Lzus8OKhWXN7HrHnnEn0Xf4KhiXg
	BKN+a1PrWR/4Yf6++hfEp2MbuSOq+gVWkUqzEPpIAJRU4VqUsYE2kcsDBenqGN/UHC7OLs3IcfF
	aYuihMPcWp1dgk15y30SDNC1tRTn9RgEojrHu1id1ApnIG7guP0Z/DxN9HBsNaLCCQtKe9nRGCw
	nhor7BQqBQuB4RPhYrcdPDssGRJq7lM8zF2frSNYe4BmfUgVVXgXKYmZ9mT+eGa7IqXW2qWdZcx
	+IOmKq2UvjJA4vY4K1w+XtELS7+98/uC4O1VthLWpOWqbZo/6uIH8uo58WMgWfahrR9x0T+fuh1
	MJxvpef90BdB3TXbr+bFR7z+wWR6DVv14MnR/FcEP0uGBPhRJQexHqE0BSyfaBSrgs9Xg6eyIGe
	/94Acx0gkPS29k=
X-Received: by 2002:a05:6a20:7d9f:b0:3a2:7ef4:81df with SMTP id adf61e73a8af0-3c11063e3f0mr14317365637.26.1784007587771;
        Mon, 13 Jul 2026 22:39:47 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:e15f:5d5f:580b:f2e9])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b9a67c217sm18127165c88.8.2026.07.13.22.39.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 22:39:47 -0700 (PDT)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH v2 0/3] Input: samsung-keypad - interrupt and PM fixes
Date: Mon, 13 Jul 2026 22:39:36 -0700
Message-Id: <20260713-samsung-kp-irq-v2-0-acc84b6daf9a@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJjLVWoC/02Myw6CMBBFf4XM2iGlPARX/odxUaDAqKU4LURD+
 HeLbtzdk9xzVnCaSTs4RSuwXsiRHQPIQwTNoMZeI7WBQQpZiGOSolPGzWOP9wmJn9hWtSxy2Ym
 6LCFIE+uOXt/g5fpjN9c33fi9sj86tgb9wFr9hzOR5KmoYhlWUWWYYGvI8zv2lu19sMu5N4oec
 WMNbNsHwWhh3LcAAAA=
X-Change-ID: 20260713-samsung-kp-irq-d9b2652f0b88
To: linux-input@vger.kernel.org
Cc: Krzysztof Kozlowski <krzk@kernel.org>, linux-kernel@vger.kernel.org
X-Mailer: b4 0.16-dev-b242f

This series improves the Samsung keypad driver's interrupt handling
and power management.

Changes in v2:
- Fix incorrect clearing of keypad status register during system resume
  which caused wakeup key events to be discarded. We now only clear it
  if the device is closed.
- We do not expect runtime suspend/resume to fail in this driver, and
  power domains are not expected to interfere, so no additional PM
  error handling is introduced.

Link to v1:
https://lore.kernel.org/r/20260714015309.2140694-1-dmitry.torokhov@gmail.com

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
Dmitry Torokhov (3):
      Input: samsung-keypad - clean up wakeup configuration logic
      Input: samsung-keypad - keep interrupt disabled while closed
      Input: samsung-keypad - use pm_runtime_active guard

 drivers/input/keyboard/samsung-keypad.c | 39 ++++++++++++++-------------------
 1 file changed, 17 insertions(+), 22 deletions(-)
---
base-commit: 49362394dad7df66c274c867a271394c10ca2bb8
change-id: 20260713-samsung-kp-irq-d9b2652f0b88

Thanks.

-- 
Dmitry

