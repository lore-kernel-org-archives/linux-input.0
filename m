From: Rostislav Lisovy <lisovy@gmail.com>
Subject: [PATCH 2/2] input: edt-ft5x06: Perform register read from the very beginning (reg 0x0)
Date: Tue, 21 Apr 2015 13:19:53 +0200
Message-ID: <1429615193-16794-2-git-send-email-lisovy@jablotron.cz>
References: <1429615193-16794-1-git-send-email-lisovy@jablotron.cz>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wg0-f48.google.com ([74.125.82.48]:32951 "EHLO
	mail-wg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751773AbbDULUM (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 21 Apr 2015 07:20:12 -0400
In-Reply-To: <1429615193-16794-1-git-send-email-lisovy@jablotron.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Simon Budig <simon.budig@kernelconcepts.de>, Daniel Wagener <daniel.wagener@kernelconcepts.de>, =?UTF-8?q?Lothar=20Wa=C3=9Fmann?= <LW@KARO-electronics.de>, lisovy@jablotron.cz

When the touch controller detects a touch event, it raises
an interrupt. The driver then reads the touch controller
registers in its ISR. When register readout is started with the
register 0x02, some devices (tested with the register-compatible
FT5316) return 'garbage' (on single touch, "number of touchpoints"
is 5, all the other registers are either 0xFF, 0x0F or 0x00)
and since the device thinks the interrupt event was not handled
properly (by proper register read), the interrupt is being invoked
cca 60--70 times.

By starting the register read with the register 0x00 (X and Y
coordinated are at the offset 3), valid data are read and the
interrupt event is properly handled.

Signed-off-by: Rostislav Lisovy <lisovy@jablotron.cz>
---
 drivers/input/touchscreen/edt-ft5x06.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/input/touchscreen/edt-ft5x06.c b/drivers/input/touchscreen/edt-ft5x06.c
index c938d4b..72bd74c 100644
--- a/drivers/input/touchscreen/edt-ft5x06.c
+++ b/drivers/input/touchscreen/edt-ft5x06.c
@@ -187,10 +187,10 @@ static irqreturn_t edt_ft5x06_ts_isr(int irq, void *dev_id)
 		break;
 
 	case M09:
-		cmd = 0x02;
-		offset = 1;
+		cmd = 0x00;
+		offset = 3;
 		tplen = 6;
-		datalen = 29;
+		datalen = 31;
 		break;
 
 	default:
-- 
2.1.0

