From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: [PATCH 09/30] Input: iatkbd: constify serio_device_id
Date: Thu, 17 Aug 2017 17:08:10 +0530
Message-ID: <1502969911-25408-10-git-send-email-arvind.yadav.cs@gmail.com>
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
 drivers/input/keyboard/atkbd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/keyboard/atkbd.c b/drivers/input/keyboard/atkbd.c
index ec876b5..7e75835 100644
--- a/drivers/input/keyboard/atkbd.c
+++ b/drivers/input/keyboard/atkbd.c
@@ -1270,7 +1270,7 @@ static int atkbd_reconnect(struct serio *serio)
 	return retval;
 }
 
-static struct serio_device_id atkbd_serio_ids[] = {
+static const struct serio_device_id atkbd_serio_ids[] = {
 	{
 		.type	= SERIO_8042,
 		.proto	= SERIO_ANY,
-- 
2.7.4
