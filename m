From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: [PATCH 11/30] Input: lkkbd: constify serio_device_id
Date: Thu, 17 Aug 2017 17:08:12 +0530
Message-ID: <1502969911-25408-12-git-send-email-arvind.yadav.cs@gmail.com>
References: <1502969911-25408-1-git-send-email-arvind.yadav.cs@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1502969911-25408-1-git-send-email-arvind.yadav.cs@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

serio_device_id are not supposed to change at runtime. All functions
working with serio_device_id provided by <linux/serio.h> work with
const serio_device_id. So mark the non-const structs as const.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 drivers/input/keyboard/lkkbd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/keyboard/lkkbd.c b/drivers/input/keyboard/lkkbd.c
index 9fcd9f1..471d538 100644
--- a/drivers/input/keyboard/lkkbd.c
+++ b/drivers/input/keyboard/lkkbd.c
@@ -707,7 +707,7 @@ static void lkkbd_disconnect(struct serio *serio)
 	kfree(lk);
 }
 
-static struct serio_device_id lkkbd_serio_ids[] = {
+static const struct serio_device_id lkkbd_serio_ids[] = {
 	{
 		.type	= SERIO_RS232,
 		.proto	= SERIO_LKKBD,
-- 
2.7.4
