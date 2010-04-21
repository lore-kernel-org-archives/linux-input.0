From: Cory Fields <FOSS@AtlasTechnologiesInc.com>
Subject: [PATCH] hid: Remove annoying non-error printk
Date: Wed, 21 Apr 2010 17:08:24 -0400
Message-ID: <1271884104-31884-1-git-send-email-FOSS@AtlasTechnologiesInc.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-input@vger.kernel.org, jkosina@suse.cz
List-Id: linux-input@vger.kernel.org

This is the only line printed on my "quiet" boot and seems completely
unnecessary.

Signed-off-by: Cory Fields <FOSS@AtlasTechnologiesInc.com>
---
 drivers/hid/hid-wacom.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/drivers/hid/hid-wacom.c b/drivers/hid/hid-wacom.c
index f7700cf..f947d83 100644
--- a/drivers/hid/hid-wacom.c
+++ b/drivers/hid/hid-wacom.c
@@ -277,7 +277,6 @@ static int __init wacom_init(void)
 	ret = hid_register_driver(&wacom_driver);
 	if (ret)
 		printk(KERN_ERR "can't register wacom driver\n");
-	printk(KERN_ERR "wacom driver registered\n");
 	return ret;
 }
 
-- 
1.7.0
