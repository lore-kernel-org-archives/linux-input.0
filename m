From: Masanari Iida <standby24x7@gmail.com>
Subject: [PATCH] Input: touchscreen: Fix a typo in Kconfig
Date: Fri, 20 Apr 2018 03:45:14 +0900
Message-ID: <20180419184514.9668-1-standby24x7@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, dmitry.torokhov@gmail.com, trivial@kernel.org, linux-input@vger.kernel.org
Cc: Masanari Iida <standby24x7@gmail.com>
List-Id: linux-input@vger.kernel.org

This patch fix a spelling typo found in Kconfig.

Signed-off-by: Masanari Iida <standby24x7@gmail.com>
---
 drivers/input/touchscreen/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/touchscreen/Kconfig b/drivers/input/touchscreen/Kconfig
index 4f15496fec8b..3e613afa10b4 100644
--- a/drivers/input/touchscreen/Kconfig
+++ b/drivers/input/touchscreen/Kconfig
@@ -362,7 +362,7 @@ config TOUCHSCREEN_HIDEEP
 
 	  If unsure, say N.
 
-	  To compile this driver as a moudle, choose M here : the
+	  To compile this driver as a module, choose M here : the
 	  module will be called hideep_ts.
 
 config TOUCHSCREEN_ILI210X
-- 
2.17.0.140.g0b0cc9f86731
