From: Marcos Paulo de Souza <marcos.souza.org@gmail.com>
Subject: [PATCH 2/2] Input: i8042 - change dbg to pr_warn when returning errors
Date: Tue,  6 Dec 2016 21:44:55 -0200
Message-ID: <20161206234531.4320-2-marcos.souza.org@gmail.com>
References: <20161206234531.4320-1-marcos.souza.org@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20161206234531.4320-1-marcos.souza.org@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Cc: Marcos Paulo de Souza <marcos.souza.org@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Signed-off-by: Marcos Paulo de Souza <marcos.souza.org@gmail.com>
---
 drivers/input/serio/i8042.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/input/serio/i8042.c b/drivers/input/serio/i8042.c
index 1c70747..bc54ce5 100644
--- a/drivers/input/serio/i8042.c
+++ b/drivers/input/serio/i8042.c
@@ -323,13 +323,13 @@ static int __i8042_command(unsigned char *param, int command)
 	for (i = 0; i < ((command >> 8) & 0xf); i++) {
 		error = i8042_wait_read();
 		if (error) {
-			dbg("     -- i8042 (timeout)\n");
+			pr_warn("     -- i8042 (timeout)\n");
 			return error;
 		}
 
 		if (command == I8042_CMD_AUX_LOOP &&
 		    !(i8042_read_status() & I8042_STR_AUXDATA)) {
-			dbg("     -- i8042 (auxerr)\n");
+			pr_warn("     -- i8042 (auxerr)\n");
 			return -1;
 		}
 
-- 
2.9.3
