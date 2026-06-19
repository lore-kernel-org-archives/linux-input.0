Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACFAF383C93
	for <linux-input@vger.kernel.org>; Fri, 19 Jun 2026 12:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781871555; cv=none; b=cSjJXc5TxHMw75h16iF/KEcy7bXBhTqeMUk3O5IlDdT7RBo4O7AP0vDNdfjMZBIRBRGIGD9xrwLqOlqs8vlGUB+X6ykZSE6b6g5KHc3vC5oMNV4pkCiXzzPmljDuTAzeNhWAHRoMcaWxlr3Bate2n5vlZbBRRa60FOMSMa84k1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781871555; c=relaxed/simple;
	bh=XvnmUbZUJwsA6QiWBe3gl09y6a9I9S+FYDVVJz8JRKY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Cv9JKHkBw8+tqVEjj6MebrxMJ6BSHTUKxB0+L1F8CR5iNNV8caqCBDyqQc0CuM7p3WHV3G36donvFCUHHf6HA9W110mplDCtIHhNF9OoRKU9eXi+ZAWx2ccN4vJ9EqTqXJUyddHKJwp+zchw04HQeWACEEq/67DmJXa8UUhJd7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=azeron.eu; spf=pass smtp.mailfrom=azeron.eu; dkim=pass (2048-bit key) header.d=azeron.eu header.i=@azeron.eu header.b=ZjTWaM4Y; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=azeron.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=azeron.eu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=azeron.eu header.i=@azeron.eu header.b="ZjTWaM4Y"
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5ad4f39064bso1828666e87.3
        for <linux-input@vger.kernel.org>; Fri, 19 Jun 2026 05:19:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=azeron.eu; s=google; t=1781871546; x=1782476346; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Qzmp1/Ngbo4C0QUT9uBl951hQgWvV4bW2P3lG6Z1bjo=;
        b=ZjTWaM4YC2c5zG60wvY6xuBVa9o0YOaTs6OfbzbY5b1qJKLM4c/LTFKcZPAp/CWQ7T
         32eHCIziMxR0tVWY5EWntepta2lokPasK/E/lB/fqzY/VugE5hcQjIhINeB/XviO2j1W
         hPNzKu2jPDweMAQJVZcMtn1jwizq835OB+Jk3kL54B1V+UHigEc7ndfgLIuZ7laBlUsU
         Qm/jemBMs0dKcMwx3/rsCSLVCt3CAM5r/nSZxelWD4xgwXh2UesnlNc9uMKQAhaL6nJP
         65j+j2xla1nVQ1vEdAeWW8JsA22qeIT+K7sXZ973YTjLuiPimZ7O0Vy6nztEoJWtEv3A
         P/Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781871546; x=1782476346;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qzmp1/Ngbo4C0QUT9uBl951hQgWvV4bW2P3lG6Z1bjo=;
        b=XuDm0C+ijjevFSm5YVj/q62ubyfTuvx43mFYDtx/j+DOVVbLnD40s+DlChC8YeoX3G
         tazVmTCt4QHiWpsDGgnwJFlTfttXEKXKsJyL//RHJsOnpiSpJdr+2vjHjRbwvrE9aB+R
         k8cy4kOWjxIGRc4xwnW/H/QByUuIDVed5Xb1oILsFiQJxJIlRluCPiLZGWUXxWFidBJh
         G+HZ2k/b/yw0oMdxnvmf2WQ5cygTKIRLROMuowv9CtdmzsBQPB73iaPstV6SyPW6iYnH
         bC/POoykXnNnaeOgUzLBeR1qWPB4S0AzTlzyEghOamY6SvZJLtzwym00pDhO/xl6P5Wk
         J5oA==
X-Gm-Message-State: AOJu0Yzx9hRFOdov5w5GnPUuKgz9MHmcMZLTQIZ0SeBPNubLraXW5K0G
	3tvide/bsAROZ31r0KPcWhhSEvCmhwMywstU8mHe65DjpW/aD7KJHBgIwFYsqecXAX2NVLM0cT2
	W9q69ZI4=
X-Gm-Gg: AfdE7cnq4sg+vfLbmbG8HmOGr1XVgqzN3P3VBuAfhJ5V/9gLDiygxFtiVoH6CMUC9ON
	nFJarKSklGy42WiZR4apJCk8xY56+eCDHOsPifyyS3MAxydPXJQ4D/vCDjdzqpxkRCRnbVJwCzt
	Z6m++KoaiqdLdgBdCgp5kPCcls1A6zmrGybwnl+9gzTl9ZpgUsVl6V+QrJp1UyFUjvpwKywmH6R
	1VliPObbrt5Hxfd5bVV7h04zoZegezKmBrr8Ms67/rLeBonUdIy8OhuxOmS3iQZY1cC11h/1XQp
	0ARdYVijCdKsyYbp5x06yH2WJUilGVIP0BNphj3VVh3jyd7jEk8DlhuaOKLXG4vhY9btTjedDtk
	QrLXtdFLeLNM7RukqMpNFW3K3Rx+qWz0ZO2zgb5j6rosNoX4fKAkPRv6Y1FJ8bYSLtXpBDZ4SKd
	z4YtKvAtwEq+pZYoGUNsx56SNNlwHoSnpeAIaT98hU
X-Received: by 2002:a05:6512:6404:b0:5aa:6b70:325b with SMTP id 2adb3069b0e04-5ad576d31a7mr812075e87.7.1781871545399;
        Fri, 19 Jun 2026 05:19:05 -0700 (PDT)
Received: from PC-077.localdomain ([94.140.104.242])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5ad574925c4sm557207e87.58.2026.06.19.05.19.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jun 2026 05:19:05 -0700 (PDT)
From: Roberts Kursitis <roberts.kursitis@azeron.eu>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Roberts Kursitis <roberts.kursitis@azeron.eu>
Subject: [PATCH] Input: xpad - add support for Azeron devices
Date: Fri, 19 Jun 2026 15:19:01 +0300
Message-ID: <20260619121901.17926-1-roberts.kursitis@azeron.eu>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add USB Vendor and Product IDs for the Azeron devices (Cyro,
Cyborg, Classic/Compact, Cyro Lefty, Cyborg II and Keyzen).

These devices share a firmware XInput implementation and
expose the standard xbox 360 interface signature. Note that
0x16d0 is a shared vendor block (MCS Electronics / pid.codes
allocations), but is bound here as the XPAD_XBOX360_VENDOR
macro only binds interfaces presenting the strict xbox 360
signature.

Note: Devices may reject the LED magic-packet with -EPIPE.

Signed-off-by: Roberts Kursitis <roberts.kursitis@azeron.eu>
---
 drivers/input/joystick/xpad.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
index feb8f368f..82019cbe2 100644
--- a/drivers/input/joystick/xpad.c
+++ b/drivers/input/joystick/xpad.c
@@ -292,6 +292,14 @@ static const struct xpad_device {
 	{ 0x1689, 0xfd00, "Razer Onza Tournament Edition", 0, XTYPE_XBOX360 },
 	{ 0x1689, 0xfd01, "Razer Onza Classic Edition", 0, XTYPE_XBOX360 },
 	{ 0x1689, 0xfe00, "Razer Sabertooth", 0, XTYPE_XBOX360 },
+	{ 0x162e, 0xbeef, "Joytech Neo-Se Take2", 0, XTYPE_XBOX360 },
+	{ 0x16d0, 0x1103, "Azeron Cyro", 0, XTYPE_XBOX360 },
+	{ 0x16d0, 0x113c, "Azeron Cyborg", 0, XTYPE_XBOX360 },
+	{ 0x16d0, 0x1192, "Azeron Classic/Compact", 0, XTYPE_XBOX360 },
+	{ 0x16d0, 0x1212, "Azeron Cyro Lefty", 0, XTYPE_XBOX360 },
+	{ 0x16d0, 0x12f7, "Azeron Cyborg II", 0, XTYPE_XBOX360 },
+	{ 0x16d0, 0x13ea, "Azeron Keyzen", 0, XTYPE_XBOX360 },
+	{ 0x1689, 0xfd00, "Razer Onza Tournament Edition", 0, XTYPE_XBOX360 },
 	{ 0x17ef, 0x6182, "Lenovo Legion Controller for Windows", 0, XTYPE_XBOX360 },
 	{ 0x1949, 0x041a, "Amazon Game Controller", 0, XTYPE_XBOX360 },
 	{ 0x1a86, 0xe310, "Legion Go S", 0, XTYPE_XBOX360 },
@@ -533,6 +541,7 @@ static const struct usb_device_id xpad_table[] = {
 	XPAD_XBOX360_VENDOR(0x15e4),		/* Numark Xbox 360 controllers */
 	XPAD_XBOX360_VENDOR(0x162e),		/* Joytech Xbox 360 controllers */
 	XPAD_XBOX360_VENDOR(0x1689),		/* Razer Onza */
+	XPAD_XBOX360_VENDOR(0x16d0),		/* Azeron controllers */
 	XPAD_XBOX360_VENDOR(0x17ef),		/* Lenovo */
 	XPAD_XBOX360_VENDOR(0x1949),		/* Amazon controllers */
 	XPAD_XBOX360_VENDOR(0x1a86),		/* Nanjing Qinheng Microelectronics (WCH) */
-- 
2.43.0

