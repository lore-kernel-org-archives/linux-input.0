From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: [PATCH 15/30] Input: xtkbd: constify serio_device_id
Date: Thu, 17 Aug 2017 17:08:16 +0530
Message-ID: <1502969911-25408-16-git-send-email-arvind.yadav.cs@gmail.com>
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
 drivers/input/keyboard/xtkbd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/keyboard/xtkbd.c b/drivers/input/keyboard/xtkbd.c
index 7c2325b..8f64b9d 100644
--- a/drivers/input/keyboard/xtkbd.c
+++ b/drivers/input/keyboard/xtkbd.c
@@ -145,7 +145,7 @@ static void xtkbd_disconnect(struct serio *serio)
 	kfree(xtkbd);
 }
 
-static struct serio_device_id xtkbd_serio_ids[] = {
+static const struct serio_device_id xtkbd_serio_ids[] = {
 	{
 		.type	= SERIO_XT,
 		.proto	= SERIO_ANY,
-- 
2.7.4
