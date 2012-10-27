From: Roland Stigge <stigge@antcom.de>
Subject: [PATCH] Input: select INPUT_MATRIXKMAP for lpc32xx-keys
Date: Sat, 27 Oct 2012 09:40:48 +0200
Message-ID: <1351323648-18645-1-git-send-email-stigge@antcom.de>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.work-microwave.de ([62.245.205.51]:51532 "EHLO
	work-microwave.de" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752994Ab2J0Hk7 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 27 Oct 2012 03:40:59 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, grant.likely@secretlab.ca
Cc: Roland Stigge <stigge@antcom.de>

This patch adds a "select" dependency of KEYBOARD_LPC32XX on INPUT_MATRIXKMAP,
as the other drivers are doing in this regard. This fixes the following compile
error if KEYBOARD_LPC32XX is enabled but INPUT_MATRIXKMAP is not:

drivers/input/keyboard/lpc32xx-keys.c:230: undefined reference to
`matrix_keypad_build_keymap'

Signed-off-by: Roland Stigge <stigge@antcom.de>

---
 drivers/input/keyboard/Kconfig |    1 +
 1 file changed, 1 insertion(+)

--- linux-2.6.orig/drivers/input/keyboard/Kconfig
+++ linux-2.6/drivers/input/keyboard/Kconfig
@@ -335,6 +335,7 @@ config KEYBOARD_LOCOMO
 config KEYBOARD_LPC32XX
 	tristate "LPC32XX matrix key scanner support"
 	depends on ARCH_LPC32XX && OF
+	select INPUT_MATRIXKMAP
 	help
 	  Say Y here if you want to use NXP LPC32XX SoC key scanner interface,
 	  connected to a key matrix.
