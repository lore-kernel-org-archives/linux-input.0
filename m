From: Nicolas Iooss <nicolas.iooss_linux@m4x.org>
Subject: [PATCH] input: elan_i2c - fix typo in include header guard
Date: Thu, 19 Mar 2015 21:10:31 +0800
Message-ID: <1426770631-29665-1-git-send-email-nicolas.iooss_linux@m4x.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: dusonlin@emc.com.tw, dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Nicolas Iooss <nicolas.iooss_linux@m4x.org>
List-Id: linux-input@vger.kernel.org

Signed-off-by: Nicolas Iooss <nicolas.iooss_linux@m4x.org>
Fixes: 6696777c6506 ("Input: add driver for Elan I2C/SMbus touchpad")
---
 drivers/input/mouse/elan_i2c.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/mouse/elan_i2c.h b/drivers/input/mouse/elan_i2c.h
index e100c1b31597..9b2dc015f20c 100644
--- a/drivers/input/mouse/elan_i2c.h
+++ b/drivers/input/mouse/elan_i2c.h
@@ -17,7 +17,7 @@
  */
 
 #ifndef _ELAN_I2C_H
-#define _ELAN_i2C_H
+#define _ELAN_I2C_H
 
 #include <linux/types.h>
 
-- 
2.3.3
