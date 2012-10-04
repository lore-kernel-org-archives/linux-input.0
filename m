From: Andreas Pretzsch <apr@cn-eng.de>
Subject: [PATCH] Input: imx_keypad - only set enabled columns to open-drain
Date: Thu,  4 Oct 2012 23:57:26 +0200
Message-ID: <1349387846-29640-1-git-send-email-apr@cn-eng.de>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.mars-solutions.de ([213.239.212.107]:25314 "EHLO
	mail.mars-solutions.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752450Ab2JDWDF (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 4 Oct 2012 18:03:05 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Fabio Estevam <fabio.estevam@freescale.com>
Cc: Alberto Panizzo <maramaopercheseimorto@gmail.com>, Michael Grzeschik <m.grzeschik@pengutronix.de>, linux-input@vger.kernel.org

In imx_keypad_inhibit(), all 8 columns were set to open-drain, in
contrast to the rest of the driver, where only the enabled columns
are modified/used.
Contrary to the normal expectation, this also affects column I/Os not
even mapped via IOMUX to the KPP hardware module but used as a GPIO.
Therefore only init enabled columns to open-drain and leave all others
with their default reset value of 0, i.e. totem-pole.

Signed-off-by: Andreas Pretzsch <apr@cn-eng.de>
---

Patch is against mainline 3.6.0.
Testing platform was a customer specific i.MX31 board with a 8x1 matrix,
without any power-management.

Before inclusion in mainline, the patch should be reviewed and tested on
other i.MX boards with different keypad matrix setup and esp. other cores.
Therefore all recently active committers as well as the original author
of the driver are addressed as To/Cc, with a request for review and test.

Beside that, there is some kind of regression due to this fix, as unused
columns are no longer (erroneously) implicit set to open-drain.
Last, on the i.MX31 columns 0..3 are exclusive KPP signals, so the fix
could be limited to columns 4..7, albeit I see no real use in that.

 drivers/input/keyboard/imx_keypad.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/input/keyboard/imx_keypad.c b/drivers/input/keyboard/imx_keypad.c
index cdc2526..6650927 100644
--- a/drivers/input/keyboard/imx_keypad.c
+++ b/drivers/input/keyboard/imx_keypad.c
@@ -362,7 +362,8 @@ static void imx_keypad_inhibit(struct imx_keypad *keypad)
 	writew(reg_val, keypad->mmio_base + KPSR);
 
 	/* Colums as open drain and disable all rows */
-	writew(0xff00, keypad->mmio_base + KPCR);
+	reg_val = ((keypad->cols_en_mask & 0xff) << 8) | 0x00;
+	writew(reg_val, keypad->mmio_base + KPCR);
 }
 
 static void imx_keypad_close(struct input_dev *dev)
-- 
1.7.10.4

