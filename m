From: Fabian Frederick <fabf@skynet.be>
Subject: [PATCH 1/1] drivers/hid/hid-picolcd_debugfs.c: remove unnecessary NULL test before debugfs_remove
Date: Sat, 28 Jun 2014 15:35:03 +0200
Message-ID: <1403962503-8507-1-git-send-email-fabf@skynet.be>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: bonbons@linux-vserver.org, Fabian Frederick <fabf@skynet.be>, Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Fix checkpatch warning:
WARNING: debugfs_remove(NULL) is safe this check is probably not required

Cc: Jiri Kosina <jkosina@suse.cz>
Cc: linux-input@vger.kernel.org
Signed-off-by: Fabian Frederick <fabf@skynet.be>
---
 drivers/hid/hid-picolcd_debugfs.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/hid/hid-picolcd_debugfs.c b/drivers/hid/hid-picolcd_debugfs.c
index 024cdf3..3c13af6 100644
--- a/drivers/hid/hid-picolcd_debugfs.c
+++ b/drivers/hid/hid-picolcd_debugfs.c
@@ -883,16 +883,13 @@ void picolcd_exit_devfs(struct picolcd_data *data)
 
 	dent = data->debug_reset;
 	data->debug_reset = NULL;
-	if (dent)
-		debugfs_remove(dent);
+	debugfs_remove(dent);
 	dent = data->debug_eeprom;
 	data->debug_eeprom = NULL;
-	if (dent)
-		debugfs_remove(dent);
+	debugfs_remove(dent);
 	dent = data->debug_flash;
 	data->debug_flash = NULL;
-	if (dent)
-		debugfs_remove(dent);
+	debugfs_remove(dent);
 	mutex_destroy(&data->mutex_flash);
 }
 
-- 
1.8.4.5
