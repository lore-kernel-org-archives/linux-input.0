From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: [PATCH 23/30] Input: inexio: constify serio_device_id
Date: Thu, 17 Aug 2017 17:08:24 +0530
Message-ID: <1502969911-25408-24-git-send-email-arvind.yadav.cs@gmail.com>
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
 drivers/input/touchscreen/inexio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/touchscreen/inexio.c b/drivers/input/touchscreen/inexio.c
index adb80b6..b9bc562 100644
--- a/drivers/input/touchscreen/inexio.c
+++ b/drivers/input/touchscreen/inexio.c
@@ -165,7 +165,7 @@ static int inexio_connect(struct serio *serio, struct serio_driver *drv)
  * The serio driver structure.
  */
 
-static struct serio_device_id inexio_serio_ids[] = {
+static const struct serio_device_id inexio_serio_ids[] = {
 	{
 		.type	= SERIO_RS232,
 		.proto	= SERIO_INEXIO,
-- 
2.7.4
