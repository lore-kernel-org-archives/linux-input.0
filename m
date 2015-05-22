From: Haibo Chen <haibo.chen@freescale.com>
Subject: [PATCH] Input: ads7846 - correct the value get from SPI
Date: Fri, 22 May 2015 15:02:16 +0800
Message-ID: <1432278136-32457-1-git-send-email-haibo.chen@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-bn1on0145.outbound.protection.outlook.com ([157.56.110.145]:23712
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751456AbbEVHOJ (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 22 May 2015 03:14:09 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: jg1.han@samsung.com, pramod.gurav@smartplayin.com, linux-input@vger.kernel.org, haibo.chen@freescale.com

According to the touch controller SPEC, SPI return a 16 bit value,
only 12 bits are valid, they are bit[14-3].

The value of MISO and MOSI can be configed when SPI in idle mode.
Currently this touch driver consider the SPI bus set the MOSI and
MISO in low level when SPI bus in idle mode. So the bit[15] of the
value get from SPI bus is always 0. But when SPI bus congfig the
MOSI and MISO in high level when SPI in idle mode, the bit[15] of
the value get from SPI is always 1, if not mask this bit[15], we may
get the wrong value.

This patch mask the invalid bit, and make sure to return the correct
value nomatter how SPI bus configed.

Signed-off-by: Haibo Chen <haibo.chen@freescale.com>
---
 drivers/input/touchscreen/ads7846.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/touchscreen/ads7846.c b/drivers/input/touchscreen/ads7846.c
index e4eb8a6..91b335f 100644
--- a/drivers/input/touchscreen/ads7846.c
+++ b/drivers/input/touchscreen/ads7846.c
@@ -678,7 +678,7 @@ static int ads7846_get_value(struct ads7846 *ts, struct spi_message *m)
 		 * adjust:  on-wire is a must-ignore bit, a BE12 value, then
 		 * padding; built from two 8 bit values written msb-first.
 		 */
-		return be16_to_cpup((__be16 *)t->rx_buf) >> 3;
+		return (be16_to_cpup((__be16 *)t->rx_buf) & 0x7ff8) >> 3;
 	}
 }
 
-- 
1.9.1

