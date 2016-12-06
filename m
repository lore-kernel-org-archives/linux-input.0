From: Marcos Paulo de Souza <marcos.souza.org@gmail.com>
Subject: [PATCH 1/2] Input: i8042 - Add warn when a command can't write its parameter
Date: Tue,  6 Dec 2016 21:44:54 -0200
Message-ID: <20161206234531.4320-1-marcos.souza.org@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Cc: Marcos Paulo de Souza <marcos.souza.org@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

This can happen in cases like bug #102951[1], so add a proper warn as done
in wait_read.

[1] https://bugzilla.kernel.org/show_bug.cgi?id=102951

Signed-off-by: Marcos Paulo de Souza <marcos.souza.org@gmail.com>
---
 drivers/input/serio/i8042.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/input/serio/i8042.c b/drivers/input/serio/i8042.c
index 89abfdb..1c70747 100644
--- a/drivers/input/serio/i8042.c
+++ b/drivers/input/serio/i8042.c
@@ -312,8 +312,10 @@ static int __i8042_command(unsigned char *param, int command)
 
 	for (i = 0; i < ((command >> 12) & 0xf); i++) {
 		error = i8042_wait_write();
-		if (error)
+		if (error) {
+			pr_warn("Can't write i8042 parameter, wait_write timed out\n");
 			return error;
+		}
 		dbg("%02x -> i8042 (parameter)\n", param[i]);
 		i8042_write_data(param[i]);
 	}
-- 
2.9.3
