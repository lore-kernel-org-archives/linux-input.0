From: Daniel Kurtz <djkurtz@chromium.org>
Subject: [PATCH 10/10] Input: atmel_mxt_ts - increase FWRESET_TIME
Date: Fri,  1 Feb 2013 16:11:52 +0800
Message-ID: <1359706312-24642-11-git-send-email-djkurtz@chromium.org>
References: <1359706312-24642-1-git-send-email-djkurtz@chromium.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1359706312-24642-1-git-send-email-djkurtz@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Henrik Rydberg <rydberg@euromail.se>, Benson Leung <bleung@chromium.org>, Yufeng Shen <miletus@chromium.org>, Nick Dyer <nick.dyer@itdev.co.uk>
Cc: Joonyoung Shim <jy0922.shim@samsung.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, olofj@chromium.org
List-Id: linux-input@vger.kernel.org

From: Benson Leung <bleung@chromium.org>

175ms is not enough time to update the firmware. Set to
500ms.

Signed-off-by: Benson Leung <bleung@chromium.org>
---
 drivers/input/touchscreen/atmel_mxt_ts.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c b/drivers/input/touchscreen/atmel_mxt_ts.c
index ef867d3..0cf9ff1 100644
--- a/drivers/input/touchscreen/atmel_mxt_ts.c
+++ b/drivers/input/touchscreen/atmel_mxt_ts.c
@@ -180,7 +180,7 @@
 #define MXT_BACKUP_TIME		25	/* msec */
 #define MXT_RESET_TIME		65	/* msec */
 
-#define MXT_FWRESET_TIME	175	/* msec */
+#define MXT_FWRESET_TIME	500	/* msec */
 
 /* Command to unlock bootloader */
 #define MXT_UNLOCK_CMD_MSB	0xaa
-- 
1.8.1
