From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: [PATCH 10/30] Input: hil_kbd: constify serio_device_id
Date: Thu, 17 Aug 2017 17:08:11 +0530
Message-ID: <1502969911-25408-11-git-send-email-arvind.yadav.cs@gmail.com>
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
 drivers/input/keyboard/hil_kbd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/keyboard/hil_kbd.c b/drivers/input/keyboard/hil_kbd.c
index 5b152f2..bb29a7c 100644
--- a/drivers/input/keyboard/hil_kbd.c
+++ b/drivers/input/keyboard/hil_kbd.c
@@ -559,7 +559,7 @@ static int hil_dev_connect(struct serio *serio, struct serio_driver *drv)
 	return error;
 }
 
-static struct serio_device_id hil_dev_ids[] = {
+static const struct serio_device_id hil_dev_ids[] = {
 	{
 		.type = SERIO_HIL_MLC,
 		.proto = SERIO_HIL,
-- 
2.7.4
