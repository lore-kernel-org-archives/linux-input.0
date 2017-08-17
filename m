From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: [PATCH 30/30] Input: wacom_w8001: constify serio_device_id
Date: Thu, 17 Aug 2017 17:08:31 +0530
Message-ID: <1502969911-25408-31-git-send-email-arvind.yadav.cs@gmail.com>
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
 drivers/input/touchscreen/wacom_w8001.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/touchscreen/wacom_w8001.c b/drivers/input/touchscreen/wacom_w8001.c
index 85e9572..3715d1e 100644
--- a/drivers/input/touchscreen/wacom_w8001.c
+++ b/drivers/input/touchscreen/wacom_w8001.c
@@ -681,7 +681,7 @@ static int w8001_connect(struct serio *serio, struct serio_driver *drv)
 	return err;
 }
 
-static struct serio_device_id w8001_serio_ids[] = {
+static const struct serio_device_id w8001_serio_ids[] = {
 	{
 		.type	= SERIO_RS232,
 		.proto	= SERIO_W8001,
-- 
2.7.4
