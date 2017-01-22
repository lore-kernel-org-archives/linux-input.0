From: Marcos Paulo de Souza <marcos.souza.org@gmail.com>
Subject: [PATCH -v2] Input: i8042: Add dbg msg when a command can't write its parameter
Date: Sun, 22 Jan 2017 15:55:19 -0200
Message-ID: <20170122175557.29008-1-marcos.souza.org@gmail.com>
References: <20161206234531.4320-1-marcos.souza.org@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qt0-f193.google.com ([209.85.216.193]:32918 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751047AbdAVR4O (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Sun, 22 Jan 2017 12:56:14 -0500
In-Reply-To: <20161206234531.4320-1-marcos.souza.org@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
Cc: Marcos Paulo de Souza <marcos.souza.org@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

This can happen in cases like bug #102951[1], so add a proper debug msg
as done in wait_read. Also, change wait_read debug message to differ from
wait_write.

[1] https://bugzilla.kernel.org/show_bug.cgi?id=102951

Signed-off-by: Marcos Paulo de Souza <marcos.souza.org@gmail.com>
---
Changes from v1:
 * use dbg instead of pr_warn

 drivers/input/serio/i8042.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/input/serio/i8042.c b/drivers/input/serio/i8042.c
index 62685a7..cba6831 100644
--- a/drivers/input/serio/i8042.c
+++ b/drivers/input/serio/i8042.c
@@ -312,8 +312,10 @@ static int __i8042_command(unsigned char *param, int command)
 
 	for (i = 0; i < ((command >> 12) & 0xf); i++) {
 		error = i8042_wait_write();
-		if (error)
+		if (error) {
+			dbg("     -- i8042 (timeout wait_write)\n");
 			return error;
+		}
 		dbg("%02x -> i8042 (parameter)\n", param[i]);
 		i8042_write_data(param[i]);
 	}
@@ -321,7 +323,7 @@ static int __i8042_command(unsigned char *param, int command)
 	for (i = 0; i < ((command >> 8) & 0xf); i++) {
 		error = i8042_wait_read();
 		if (error) {
-			dbg("     -- i8042 (timeout)\n");
+			dbg("     -- i8042 (timeout wait_read)\n");
 			return error;
 		}
 
-- 
2.9.3

