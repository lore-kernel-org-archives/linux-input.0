From: Marcus Folkesson <marcus.folkesson@gmail.com>
Subject: [PATCH] input: misc: make USB drivers depend on USB
Date: Wed, 17 Jan 2018 22:33:05 +0100
Message-ID: <20180117213305.965-1-marcus.folkesson@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-lf0-f65.google.com ([209.85.215.65]:43314 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752446AbeAQVdU (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Wed, 17 Jan 2018 16:33:20 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Damien Riegel <damien.riegel@savoirfairelinux.com>, Marcus Folkesson <marcus.folkesson@gmail.com>, Joseph Chen <chenjh@rock-chips.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

A driver should not enable an entire subsystem.

Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
---
 drivers/input/misc/Kconfig | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/drivers/input/misc/Kconfig b/drivers/input/misc/Kconfig
index 9f082a388388..dd04da910bc9 100644
--- a/drivers/input/misc/Kconfig
+++ b/drivers/input/misc/Kconfig
@@ -354,8 +354,7 @@ config INPUT_ATLAS_BTNS
 
 config INPUT_ATI_REMOTE2
 	tristate "ATI / Philips USB RF remote control"
-	depends on USB_ARCH_HAS_HCD
-	select USB
+	depends on USB
 	help
 	  Say Y here if you want to use an ATI or Philips USB RF remote control.
 	  These are RF remotes with USB receivers.
@@ -369,8 +368,7 @@ config INPUT_ATI_REMOTE2
 
 config INPUT_KEYSPAN_REMOTE
 	tristate "Keyspan DMR USB remote control"
-	depends on USB_ARCH_HAS_HCD
-	select USB
+	depends on USB
 	help
 	  Say Y here if you want to use a Keyspan DMR USB remote control.
 	  Currently only the UIA-11 type of receiver has been tested.  The tag
@@ -401,8 +399,7 @@ config INPUT_KXTJ9_POLLED_MODE
 
 config INPUT_POWERMATE
 	tristate "Griffin PowerMate and Contour Jog support"
-	depends on USB_ARCH_HAS_HCD
-	select USB
+	depends on USB
 	help
 	  Say Y here if you want to use Griffin PowerMate or Contour Jog devices.
 	  These are aluminum dials which can measure clockwise and anticlockwise
@@ -417,8 +414,7 @@ config INPUT_POWERMATE
 
 config INPUT_YEALINK
 	tristate "Yealink usb-p1k voip phone"
-	depends on USB_ARCH_HAS_HCD
-	select USB
+	depends on USB
 	help
 	  Say Y here if you want to enable keyboard and LCD functions of the
 	  Yealink usb-p1k usb phones. The audio part is enabled by the generic
@@ -432,8 +428,7 @@ config INPUT_YEALINK
 
 config INPUT_CM109
 	tristate "C-Media CM109 USB I/O Controller"
-	depends on USB_ARCH_HAS_HCD
-	select USB
+	depends on USB
 	help
 	  Say Y here if you want to enable keyboard and buzzer functions of the
 	  C-Media CM109 usb phones. The audio part is enabled by the generic
-- 
2.15.1

