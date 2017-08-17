From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: [PATCH 26/30] Input: touchit213: constify serio_device_id
Date: Thu, 17 Aug 2017 17:08:27 +0530
Message-ID: <1502969911-25408-27-git-send-email-arvind.yadav.cs@gmail.com>
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
 drivers/input/touchscreen/touchit213.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/touchscreen/touchit213.c b/drivers/input/touchscreen/touchit213.c
index c27cf8f..98a1669 100644
--- a/drivers/input/touchscreen/touchit213.c
+++ b/drivers/input/touchscreen/touchit213.c
@@ -192,7 +192,7 @@ static int touchit213_connect(struct serio *serio, struct serio_driver *drv)
  * The serio driver structure.
  */
 
-static struct serio_device_id touchit213_serio_ids[] = {
+static const struct serio_device_id touchit213_serio_ids[] = {
 	{
 		.type	= SERIO_RS232,
 		.proto	= SERIO_TOUCHIT213,
-- 
2.7.4
