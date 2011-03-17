From: Iiro Valkonen <iiro.valkonen@atmel.com>
Subject: [PATCH 1/2] Input: atmel_mxt_ts - Increase the wait times for backup
 and reset
Date: Thu, 17 Mar 2011 16:42:23 +0200
Message-ID: <4D821DCF.6090403@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from newsmtp5.atmel.com ([204.2.163.5]:64970 "EHLO
	sjogate2.atmel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752955Ab1CQOpB (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 17 Mar 2011 10:45:01 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org

Increase the sleep times after backup and reset, so that we can be sure they have been completed even when the mXT cycle time is set to maximum value (254ms).

Signed-off-by: Iiro Valkonen <iiro.valkonen@atmel.com>
---
 drivers/input/touchscreen/atmel_mxt_ts.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c b/drivers/input/touchscreen/atmel_mxt_ts.c
index 4012436..f8cd478 100644
--- a/drivers/input/touchscreen/atmel_mxt_ts.c
+++ b/drivers/input/touchscreen/atmel_mxt_ts.c
@@ -169,8 +169,8 @@
 /* Define for MXT_GEN_COMMAND */
 #define MXT_BOOT_VALUE		0xa5
 #define MXT_BACKUP_VALUE	0x55
-#define MXT_BACKUP_TIME		25	/* msec */
-#define MXT_RESET_TIME		65	/* msec */
+#define MXT_BACKUP_TIME		270	/* msec */
+#define MXT_RESET_TIME		350	/* msec */
 
 #define MXT_FWRESET_TIME	175	/* msec */
 
-- 
1.7.0.4
