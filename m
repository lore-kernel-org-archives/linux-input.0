Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A190322A1F
	for <linux-input@vger.kernel.org>; Sun, 26 Jul 2026 13:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785072225; cv=none; b=idJya52M9fsIHDCHDBqTt+q9LQN4jixkuArxNVNuiWJcjUzch0e+GhgfBsrbUH+Y7tLgJKhMT1P0WaOrSCsICp484v7NTnzWDHXEU4+mreAzzWBIvXRvq/4K2WNisc0OsZCVwdBchoZWvMjf1VV8Es03NWRvqijxzq7+fT52swo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785072225; c=relaxed/simple;
	bh=ZYCXZa832Q6+DX+1LMeq2DwpEVIMYkP7nWsmX6nB5kg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hRrZ3zCGFsxZSdJyg69K6SP7P6BkYN+gbAFITKmmA2xiGAJJ6XzGhaZKCKaNlc+6hxrhil+jKV4YBMNJ2+miHsqkZj3j+9H8tQb759sw/Lx7BZ1XGO7yj2SActG5vxZpk4R8bJqOY3NlCgNb1e9VYMxIKs6EnG5rV6NJ1OkGueU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jGGJR4Il; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jGGJR4Il"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2cab973140bso25765335ad.3
        for <linux-input@vger.kernel.org>; Sun, 26 Jul 2026 06:23:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785072222; x=1785677022; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eSUJuYigHm58yvQUKh2r6LkQh9E+UHdZ5mCBDAJC6J0=;
        b=jGGJR4IlxkYR/L7L3ZbLQhB6XZNdZdCPYtC8XBfxu4WxPU04AZGNWXpcyCgrDa39C+
         4o/j2V3pYZK1fwOHGBDjfUDeFYIqBYQd2eS1ZbAoYGcJ3xG6xUNdqUAyonO+epO+Or36
         z3LHdw75BkG4KiZ8TVXeKzfvQ9Ljwnp+6Wysaya1pQmm89F3Lr/lZTrDKUN256jGsx9Q
         8f0+/Em/HpFl/MPGJ/fSkzyGKU57JaA+MaQtQ7pk1D3kOTPQE6ZkP6ERKHAt25gacvln
         SjcrrXHzbWomF+QedBeN10QCZx/jFErH8OlM0W055YvPIrYL8krkVPI7B3lJbfsBOctK
         4NVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785072222; x=1785677022;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=eSUJuYigHm58yvQUKh2r6LkQh9E+UHdZ5mCBDAJC6J0=;
        b=dNSDRJxeS48j0FfY7wdUDpa0j0+zkT3hRbrGJUoLI1Ri4bD6BrgF0wcVbgHg5R3sg4
         Y/ikBTdgnc9M/hYgNirMuwcr+6pYvaAd4rN986P92bGiV4Gsf00MkDW9Nte8L+Rf+Q80
         5+a+4tST0OPj/J9IaRVdZd/j8GHoTA6/nlouSGvMYUcXIJZByX0925CswD0h9GtGM7zj
         sivo8AlWHUfen6kuOV0M0uPx7E6D/+pUQAKyAL+KHpCp35S9eZHh4XqvsEQJxKjsoMcJ
         SMiOgJ98YlRZpNzOxh+k2UqxCD+tkjPxEQ4NwdP9KPkLsSe1KSUnL21jlzhMLt0+X0Qn
         IiJA==
X-Gm-Message-State: AOJu0Yyrx8nJTZjONSki4/ML/qJ1xg8w7c7Z77ULSAf7F6ElBAymCpNY
	0JaqrvIJ+Qq822ZGEOXvBxZgtBeWRW3MqwJhgvmecf3MkKfOwfH6qAyqGXvbnli6
X-Gm-Gg: AR+sD12K3XIMZnbCkoJEnbyPkRIBd0vDADWZGSn+b0oZqsr0xOBiXPSzBncLNQRga+F
	5q4x2V5Y3orbupkdeMWhEcuk9U3N4QUTqsROI2L9Wdj1YSeStKpbmOnkswsxey/CiaBtFukvpGI
	63V+5AEP2SP75bmWE2wIH6ZKDWkkletBkGqu5wk5ZbMBm0iRwCbkjjZ+fbUUtmYlQU3LcKXlgEX
	+R1HGywc803iTR+VGHaeLy8BHP6KHQSSiYWQyXkrkJd62qsZEHm0zf9V3iFqOpiVOAxMsuFzJUZ
	tRqeELcL/5qQ9BZi/sn8WEH4jZJQU32Fc1mQTqd+/8pODji8RsHGAiXgmjmxFZGQYNoptqSMH+q
	H5IIBc+sPh/ZRgM4N15j08doG9azVLFoTH+ssSFRA+Gv7F4xluHCutj+U7F+QOOF/Cr9SifDbpj
	D4icqsg19K5XBM+sfEpmd6cnae
X-Received: by 2002:a17:902:e5d2:b0:2cf:bf32:ba6c with SMTP id d9443c01a7336-2cfde85ec52mr50270285ad.26.1785072222048;
        Sun, 26 Jul 2026 06:23:42 -0700 (PDT)
Received: from Linux.bbrouter ([115.96.217.226])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-314bc419e3asm20784436eec.11.2026.07.26.06.23.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jul 2026 06:23:40 -0700 (PDT)
From: Ishaan Dandekar <ishaan.dandekar@gmail.com>
To: linux-input@vger.kernel.org,
	linux-usb@vger.kernel.org
Cc: gregkh@linuxfoundation.org,
	nikhilsolanke5@gmail.com,
	Ishaan Dandekar <ishaan.dandekar@gmail.com>
Subject: [PATCH 3/3] Input: xpad - add support for generic clone X-Input gamepads
Date: Sun, 26 Jul 2026 18:50:40 +0530
Message-Id: <20260726132039.28330-4-ishaan.dandekar@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260726132039.28330-1-ishaan.dandekar@gmail.com>
References: <20260726132039.28330-1-ishaan.dandekar@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This device exposes a vendor-specific Xbox 360 interface (0283:0001) but was previously ignored by the driver, causing it to fall back to a generic hid interface. Adding its ID to xpad_device and xpad_table allows it to initialize correctly as an X-Input gamepad.

Signed-off-by: Ishaan Dandekar <ishaan.dandekar@gmail.com>
---
 drivers/input/joystick/xpad.c | 2 ++
 drivers/usb/core/quirks.c     | 2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
index feb8f368f..c0a15db03 100644
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
+	{ USB_DEVICE(0x0283, 0x0001) }, /* Generic X-Input Gamepad */
 	XPAD_XBOX360_VENDOR(0x0351),		/* CRKD Controllers */
 	XPAD_XBOX360_VENDOR(0x03eb),		/* Wooting Keyboards (Legacy) */
 	XPAD_XBOX360_VENDOR(0x03f0),		/* HP HyperX Xbox 360 controllers */
diff --git a/drivers/usb/core/quirks.c b/drivers/usb/core/quirks.c
index 97b1cdf0e..b5b577f0b 100644
--- a/drivers/usb/core/quirks.c
+++ b/drivers/usb/core/quirks.c
@@ -592,7 +592,7 @@ static const struct usb_device_id usb_quirk_list[] = {
 	{ USB_DEVICE(0x2386, 0x3119), .driver_info = USB_QUIRK_NO_LPM },
 
 	{ USB_DEVICE(0x2386, 0x350e), .driver_info = USB_QUIRK_NO_LPM },
-	
+
 	/* ShanWan Wireless Gamepad */
 	{ USB_DEVICE(0x2563, 0x0575), .driver_info = USB_QUIRK_WINDOWS_CONFIG_REQ_SIZE },
 
-- 
2.34.1

