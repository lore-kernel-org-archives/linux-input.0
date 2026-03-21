Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFBD01DE3DB;
	Sat, 21 Mar 2026 13:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774098950; cv=none; b=sUQ/quMXLPAzZzPBafjvbGCNXpVjj0EsiNi1yWXOtofjK4g4n+5EVOeJ50MIK7XH19qdYvyrq41nLpGOnACTiKXfFZOXIN2HgQ+zsYEs552mI3tBybtZ2sf7TsE43FXj1r+/yWh71wuV+8UAjSCpY4eavdGW4KX5DGj8druu7qQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774098950; c=relaxed/simple;
	bh=v7vo608Xn8vb6rZ3iS2Wj0Z2ZYx3mX8gI12Uyx7v45g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=TY76iXdU93L+c32lJY5j0w47Ku1R7QVl/P9A9aRn3SNby+SCUI+5hMNz/3n3IytY4cfaxpQOCFmg4v+Vm6YJIavqWHrx6TcPP6YDxmUrOQoh6ZzdBZXNR9Ovdd6BGvohGikT3vPhwmULkRHBf9yLoALgxXo8oRtTmjnC+VDk5ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=REAuo9uC; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="REAuo9uC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1774098945;
	bh=v7vo608Xn8vb6rZ3iS2Wj0Z2ZYx3mX8gI12Uyx7v45g=;
	h=From:Date:Subject:To:Cc:From;
	b=REAuo9uCuP6bJWjG/bevFhWOtF/UaAmlJaX0XQ/XAqk4HL+3XHDsPF6SigK7TSSPD
	 thPKnqaynI0ULv1/Udg0h9i55FM8AZO8XYnQUuJ+OxCxJ2znNPZ3mKk4ZoBDbEpW3F
	 OSHH12VV4No+oeCjNQC4LWsJAsnYUXQQ2ZtkO1B8=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Sat, 21 Mar 2026 14:15:45 +0100
Subject: [PATCH] HID: drop 'default !EXPERT' from tristate symbols
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260321-hid-expert-v1-1-4a6d81b4f3ac@weissschuh.net>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDYyND3YzMFN3UioLUohJdC/O05DQzA0sjY4NEJaCGgqLUtMwKsGHRsbW
 1AIthYp9cAAAA
X-Change-ID: 20260321-hid-expert-87fcf609230a
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774098945; l=3214;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=v7vo608Xn8vb6rZ3iS2Wj0Z2ZYx3mX8gI12Uyx7v45g=;
 b=vwSOmWBl9mpKPYEV9Hn5mRqyhTs2EtvzuhvmYf7cwnsN9dC32PE88brTTHc0gCUjUJuHpQc+t
 02Wcvid1wevAnupitkr23Y4iZ11YOn8v76fB0MDVKdO7oi+kPPZ9oz1
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

There is no reason to build random drivers for obscure hardware into the
core kernel by default.

The usages of 'default !EXPERT' for the HID_PICOLCD suboptions are kept,
as these make some sense, although they probably should use 'default y'.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 drivers/hid/Kconfig | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
index 10c12d8e6557..7b1d8d81bd65 100644
--- a/drivers/hid/Kconfig
+++ b/drivers/hid/Kconfig
@@ -107,7 +107,6 @@ menu "Special HID drivers"
 
 config HID_A4TECH
 	tristate "A4TECH mice"
-	default !EXPERT
 	help
 	Support for some A4TECH mice with two scroll wheels.
 
@@ -140,7 +139,6 @@ config HID_APPLE
 	tristate "Apple {i,Power,Mac}Books"
 	depends on LEDS_CLASS
 	depends on NEW_LEDS
-	default !EXPERT
 	help
 	Support for some Apple devices which less or more break
 	HID specification.
@@ -209,7 +207,6 @@ config HID_AUREAL
 
 config HID_BELKIN
 	tristate "Belkin Flip KVM and Wireless keyboard"
-	default !EXPERT
 	help
 	Support for Belkin Flip KVM and Wireless keyboard.
 
@@ -237,14 +234,12 @@ config HID_BIGBEN_FF
 
 config HID_CHERRY
 	tristate "Cherry Cymotion keyboard"
-	default !EXPERT
 	help
 	Support for Cherry Cymotion keyboard.
 
 config HID_CHICONY
 	tristate "Chicony devices"
 	depends on USB_HID
-	default !EXPERT
 	help
 	Support for Chicony Tactical pad and special keys on Chicony keyboards.
 
@@ -322,7 +317,6 @@ config HID_CREATIVE_SB0540
 
 config HID_CYPRESS
 	tristate "Cypress mouse and barcode readers"
-	default !EXPERT
 	help
 	Support for cypress mouse and barcode readers.
 
@@ -388,7 +382,6 @@ config HID_EVISION
 
 config HID_EZKEY
 	tristate "Ezkey BTC 8193 keyboard"
-	default !EXPERT
 	help
 	Support for Ezkey BTC 8193 keyboard.
 
@@ -564,7 +557,6 @@ config HID_ICADE
 
 config HID_ITE
 	tristate "ITE devices"
-	default !EXPERT
 	help
 	Support for ITE devices not fully compliant with HID standard.
 
@@ -585,7 +577,6 @@ config HID_TWINHAN
 
 config HID_KENSINGTON
 	tristate "Kensington Slimblade Trackball"
-	default !EXPERT
 	help
 	Support for Kensington Slimblade Trackball.
 
@@ -666,7 +657,6 @@ config HID_LOGITECH
 	depends on USB_HID
 	depends on LEDS_CLASS
 	depends on LEDS_CLASS_MULTICOLOR
-	default !EXPERT
 	help
 	Support for Logitech devices that are not fully compliant with HID standard.
 
@@ -781,20 +771,17 @@ config HID_MEGAWORLD_FF
 
 config HID_REDRAGON
 	tristate "Redragon keyboards"
-	default !EXPERT
 	help
     Support for Redragon keyboards that need fix-ups to work properly.
 
 config HID_MICROSOFT
 	tristate "Microsoft non-fully HID-compliant devices"
-	default !EXPERT
 	select INPUT_FF_MEMLESS
 	help
 	Support for Microsoft devices that are not fully compliant with HID standard.
 
 config HID_MONTEREY
 	tristate "Monterey Genius KB29E keyboard"
-	default !EXPERT
 	help
 	Support for Monterey Genius KB29E.
 

---
base-commit: 2bbe306cc6f970474cb2ad7d5332220e81119bbd
change-id: 20260321-hid-expert-87fcf609230a

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>

