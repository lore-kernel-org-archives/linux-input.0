Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1A753176EE
	for <linux-input@vger.kernel.org>; Mon, 27 Jul 2026 12:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785156391; cv=none; b=QK4aWab3q4a3w9Q07sINHqthuG/dipYeJl95DxdGKqLWTWGXTsm4Bu5tk31LtcQaPYQUwnqW/m9lUihA+411aNsbB2DD3vmtPANnjjwxWhwGMvYiNmQyW1W0JgKRUimzMulzhxoKcaBVMexXzx0XBHEN5SVO4f5+DmXOsZX4wek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785156391; c=relaxed/simple;
	bh=VDDjkmzjU6n0G54i9rZl6mDjWJS+nAzi/UNqjMG7jqs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hKcbytjWGipSplxnVcdjJVPScerfVqg3q6zHF8Uhp3I2pl/tI1xrQii9SsLrSHWXll1vmAPG6rnPn7tpgZQaba0A0bV3Kt7EMsNnazvOZs7XKcvwgGFdyrgenX2XHSFVetBnPi26RaVlagb8i1TV6M/ITtxRQ4VAdnn4dtc8bPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ACEHA29H; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ACEHA29H"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-38dfe910e9dso2376700a91.3
        for <linux-input@vger.kernel.org>; Mon, 27 Jul 2026 05:46:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785156389; x=1785761189; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=UBNUvjGcjm+xj3uAGQhgxGlKo+bmrY/qvFo6MzrXzyw=;
        b=ACEHA29Hl4L6gEPkbgJ8gjVQUyx9MN5Ak7tb+fOECh7hHOPYJptBdzAkN4i0NP/7pJ
         LH8tY/UBnYUStRiHgUiG+ekubN6XWRQr2oUw7w6IPYiuRSndSRjUd7WurvSxcL1dgwJ6
         2MaN0m0VXGzaykFv0CU2MlhbgVjfrP6Ws7IdI+uvRnrezU0tBG3KAdXQ+kX41mFESRcS
         mzElpjPxKDKoXuTURRLCO0oZ1b6fFLXj7gt3WA+yH4meaejwbcweBvCYqjPDDA5Uch5Y
         ZUCfz8VC3WekEjMgmJXnRFADMr9KaB4UN7my8Kyb0YuAiH81iH6nRtwo7Yux5f8FuStG
         2LYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785156389; x=1785761189;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UBNUvjGcjm+xj3uAGQhgxGlKo+bmrY/qvFo6MzrXzyw=;
        b=GKc3k+M3eQ7zTAhc2MHw0We/icPYMPDyG3Z9rqRB3Q2mPTReawKD2139/L+niUyzV3
         piF/eR2jwLap9ksr/4UzyPr405RLeoD3v67+1f2GGlsokFGzmT4CSXpZo5CsvW4tWl7H
         /lu/O/pnctujGsGaINhe7uTnVw0hI8ukeOk3rUGti1sGsFmctzU6W98LEQgUBK4RFLCZ
         D4JkRTTMkScRY5Ri33US+fbQqrwUvNiZ2o75DD/x/WO6yL8t4qtMQX4bIGXyTsGokro3
         7mE1/Ljm4SrcLP5eLKDmAo7dW+9XdGlDQU6oW1AA2dAaxZ+1jZIS2SbychLCLOe4Isxp
         57pg==
X-Gm-Message-State: AOJu0YxvD6hpRPD+aQMuoGkwIxk9Z9dcNf0mKOPSkGqbWIQ1Eq0viahl
	Y7r7/v/rEPl++qV9JV7Wn85McCvVZvoGo/Qg4CL2F40DX71I3qWWbkkNj3WLMVXHZqU=
X-Gm-Gg: AR+sD11GGqpq1h044Ew1QnzKrFd08mXP4GAKhg2dSRp9eVGyw5DdvLCuH9qwtbTY97o
	XQAFyh1XkPBmgysXWchQYwFYCsAFM1T1EFh/6tJglEJ5+HWftGlfwSmTbxHC6eWNoOPD7Ra9FLO
	5o7nMnWwBcoOkQHUVuh1qs0VXZCofoqS5J1ElHbWbfii3DE+WLVvp1+ZxNpSmWIB7M/Z7r3kQIA
	pM+YA7+GMWpnFr6+vlGuKKzuYYlfRFOI9W2rqEcVqVITbSwtO7GyRtNeLKpkHNFBPZidjEVv30D
	BGAN6QA33w9jPHVg2RA81pl3PVn0oICWiYBUzyvgBp/fO/OlClmfGggc+eFzUJGWuluRFi46XMl
	X5LkssPOHwyk3bxmORgFKCDJGixJrKYS8U5cZ6wguZGl1Dk4owzjt+PjUA6+ZgTXA9t3zF5xvKV
	Y6QjpHNngcJHFmNCvLBy273Hmo
X-Received: by 2002:a17:90a:c88f:b0:38e:c7b0:84ad with SMTP id 98e67ed59e1d1-38f603392aamr650243a91.0.1785156389137;
        Mon, 27 Jul 2026 05:46:29 -0700 (PDT)
Received: from Linux.bbrouter ([115.96.218.218])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13d6ba579c3sm25613776c88.8.2026.07.27.05.46.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 05:46:28 -0700 (PDT)
From: Ishaan Dandekar <ishaan.dandekar@gmail.com>
To: linux-input@vger.kernel.org
Cc: dmitry.torokhov@gmail.com,
	gregkh@linuxfoundation.org,
	Ishaan Dandekar <ishaan.dandekar@gmail.com>
Subject: [PATCH v3] Input: xpad - add support for generic clone X-Input gamepads
Date: Mon, 27 Jul 2026 18:13:07 +0530
Message-Id: <20260727124307.11155-1-ishaan.dandekar@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This device exposes a vendor-specific Xbox 360 interface (0283:0001)
but was previously ignored by the driver, causing it to fall back to
a generic hid interface. Adding its ID to xpad_device and xpad_table
allows it to initialize correctly as an X-Input gamepad.

Signed-off-by: Ishaan Dandekar <ishaan.dandekar@gmail.com>
---
Changes in v3:
- Swapped USB_DEVICE() macro for XPAD_XBOX360_VENDOR().
- Fixed comment alignment.

Changes in v2:
- Wrapped commit message at 72 columns.
- Separated from the USB series to target the input subsystem directly.

 drivers/input/joystick/xpad.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
index feb8f368f..1e5eb601e 100644
--- a/drivers/input/joystick/xpad.c
+++ b/drivers/input/joystick/xpad.c
@@ -99,6 +99,7 @@ static const struct xpad_device {
 } xpad_device[] = {
 	/* Please keep this list sorted by vendor and product ID. */
 	{ 0x0079, 0x18d4, "GPD Win 2 X-Box Controller", 0, XTYPE_XBOX360 },
+	{ 0x0283, 0x0001, "Generic X-Input Gamepad", 0, XTYPE_XBOX360 },
 	{ 0x0351, 0x1000, "CRKD LP Blueberry Burst Pro Edition (Xbox)", 0, XTYPE_XBOX360 },
 	{ 0x0351, 0x2000, "CRKD LP Black Tribal Edition (Xbox) ", 0, XTYPE_XBOX360 },
 	{ 0x03eb, 0xff01, "Wooting One (Legacy)", 0, XTYPE_XBOX360 },
@@ -496,6 +497,7 @@ static const struct usb_device_id xpad_table[] = {
 	 */
 	{ USB_INTERFACE_INFO('X', 'B', 0) },	/* Xbox USB-IF not-approved class */
 	XPAD_XBOX360_VENDOR(0x0079),		/* GPD Win 2 controller */
+	XPAD_XBOX360_VENDOR(0x0283),		/* Generic X-Input Gamepad */
 	XPAD_XBOX360_VENDOR(0x0351),		/* CRKD Controllers */
 	XPAD_XBOX360_VENDOR(0x03eb),		/* Wooting Keyboards (Legacy) */
 	XPAD_XBOX360_VENDOR(0x03f0),		/* HP HyperX Xbox 360 controllers */
-- 
2.34.1

