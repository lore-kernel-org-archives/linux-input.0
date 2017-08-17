From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: [PATCH 01/30] Input: iforce: constify serio_device_id
Date: Thu, 17 Aug 2017 17:08:02 +0530
Message-ID: <1502969911-25408-2-git-send-email-arvind.yadav.cs@gmail.com>
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
 drivers/input/joystick/iforce/iforce-serio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/joystick/iforce/iforce-serio.c b/drivers/input/joystick/iforce/iforce-serio.c
index 46d5041..154e827 100644
--- a/drivers/input/joystick/iforce/iforce-serio.c
+++ b/drivers/input/joystick/iforce/iforce-serio.c
@@ -164,7 +164,7 @@ static void iforce_serio_disconnect(struct serio *serio)
 	kfree(iforce);
 }
 
-static struct serio_device_id iforce_serio_ids[] = {
+static const struct serio_device_id iforce_serio_ids[] = {
 	{
 		.type	= SERIO_RS232,
 		.proto	= SERIO_IFORCE,
-- 
2.7.4
