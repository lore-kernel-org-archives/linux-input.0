Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71ED6281525;
	Thu,  9 Apr 2026 16:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775752383; cv=none; b=p0ulW+gp0U5Kywjfm/4CzrvJy2YzPhGZDk6XA3QlHZakP/tRTPcjAGofRXgWY7vW9553jMYRvCjjeMWEz8DQbhBAVVJJa0Oj2VpiZAhQTkqzJ7nlGfOMOSyOC1GEAtlWblKjOCZjWzNc9DGzJXnvU0Dil7GoGtBJgPVI/PfHu8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775752383; c=relaxed/simple;
	bh=f/U9xTEyQ+Lv5PCj8E9vxswlvyRMXqx84duuzz+tUHQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Q3+S7DnY9uDm2pU9REwz21OMZANRLJDlxg1LaPfSz0LYJu/dJMjfma77SrBC4LLBChag4GMyv2BExOKx6DDJE30yGrb386Anda7ZiqCH9wY3kIyKsy3JMEmLx2eV0jSKjz0BEWtLAzDUc52nhxpe3LX5yzh89tmc1h8YDw8m6bM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=dUrxrzM6; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="dUrxrzM6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1775752379;
	bh=f/U9xTEyQ+Lv5PCj8E9vxswlvyRMXqx84duuzz+tUHQ=;
	h=From:Date:Subject:To:Cc:From;
	b=dUrxrzM6v1UOBov0zVjcyEzLwYUrumlXFx6fUs3EKa/oeLyy+a5j+xN92v84QhL6F
	 CV9ZCKySFVVZMjv6f/IlX3joyZWaEahVFwjpQx1BFbuR2j1jsV/78OmiLo3946HyVy
	 aqRLOF4lB17/fn/h/v69KRvNqGwKDiowV0zOwr+g=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Thu, 09 Apr 2026 18:32:53 +0200
Subject: [PATCH] HID: drop 'default !EXPERT' from HID_PICOLCD symbols
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260409-hid-picolcd-v1-1-bed3388da78c@weissschuh.net>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMTQ5AMBBA4avIrDUp8ZO6ilgwHToi2rSIRNxds
 fwW710QyDMFaJILPB0c2K4RWZoAmn6dSLCOhlzmlSykEoa1cIx2QS2yodI19VjWqoRYOE8jn9+
 t7X6HfZgJt3cB9/0ASJ/tzm8AAAA=
X-Change-ID: 20260409-hid-picolcd-1b6d7eac5795
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775752378; l=2186;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=f/U9xTEyQ+Lv5PCj8E9vxswlvyRMXqx84duuzz+tUHQ=;
 b=XxSh81EvJbt1FWgXBswvgr2e3rJEb8lGWnOMu2NRliWe9V6HqDGgVEtSHvyD++GnSda1uU/1c
 FoWXBgdTEy9CnOx0h+McXX9CNDKATdA0JaxuFGhByB9RM6y3DaaZGs/
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

The 'EXPERT' configuration is meant to make advanced kconfig options
configurable. It is not meant to actively change these options.
In the case of the HID_PICOLCD suboptions the intention seems to be that
normal users always expect these options to be enabled for the driver.

So 'EXPERT' is enabled, these options should stay enabled and not
automatically and suddenly become disabled. Switch them to 'default y'
to match the intention of a normal user. EXPERT users then can disable
them if needed.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 drivers/hid/Kconfig | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
index c1d9f7c6a5f2..1ef4fe3debf2 100644
--- a/drivers/hid/Kconfig
+++ b/drivers/hid/Kconfig
@@ -938,7 +938,7 @@ config HID_PICOLCD
 
 config HID_PICOLCD_FB
 	bool "Framebuffer support" if EXPERT
-	default !EXPERT
+	default y
 	depends on HID_PICOLCD
 	depends on HID_PICOLCD=FB || FB=y
 	select FB_SYSMEM_HELPERS_DEFERRED
@@ -948,7 +948,7 @@ config HID_PICOLCD_FB
 
 config HID_PICOLCD_BACKLIGHT
 	bool "Backlight control" if EXPERT
-	default !EXPERT
+	default y
 	depends on HID_PICOLCD
 	depends on HID_PICOLCD=BACKLIGHT_CLASS_DEVICE || BACKLIGHT_CLASS_DEVICE=y
 	help
@@ -957,7 +957,7 @@ config HID_PICOLCD_BACKLIGHT
 
 config HID_PICOLCD_LCD
 	bool "Contrast control" if EXPERT
-	default !EXPERT
+	default y
 	depends on HID_PICOLCD
 	depends on HID_PICOLCD=LCD_CLASS_DEVICE || LCD_CLASS_DEVICE=y
 	help
@@ -965,7 +965,7 @@ config HID_PICOLCD_LCD
 
 config HID_PICOLCD_LEDS
 	bool "GPO via leds class" if EXPERT
-	default !EXPERT
+	default y
 	depends on HID_PICOLCD
 	depends on HID_PICOLCD=LEDS_CLASS || LEDS_CLASS=y
 	help
@@ -973,7 +973,7 @@ config HID_PICOLCD_LEDS
 
 config HID_PICOLCD_CIR
 	bool "CIR via RC class" if EXPERT
-	default !EXPERT
+	default y
 	depends on HID_PICOLCD
 	depends on HID_PICOLCD=RC_CORE || RC_CORE=y
 	help

---
base-commit: 7f87a5ea75f011d2c9bc8ac0167e5e2d1adb1594
change-id: 20260409-hid-picolcd-1b6d7eac5795

Best regards,
--  
Thomas Weißschuh <linux@weissschuh.net>

