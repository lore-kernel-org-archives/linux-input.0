From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: [PATCH 16/30] Input: serio: constify serio_device_id
Date: Thu, 17 Aug 2017 17:08:17 +0530
Message-ID: <1502969911-25408-17-git-send-email-arvind.yadav.cs@gmail.com>
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
 drivers/input/serio/serio_raw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/serio/serio_raw.c b/drivers/input/serio/serio_raw.c
index 71ef5d6..516f9fe 100644
--- a/drivers/input/serio/serio_raw.c
+++ b/drivers/input/serio/serio_raw.c
@@ -410,7 +410,7 @@ static void serio_raw_disconnect(struct serio *serio)
 	serio_set_drvdata(serio, NULL);
 }
 
-static struct serio_device_id serio_raw_serio_ids[] = {
+static const struct serio_device_id serio_raw_serio_ids[] = {
 	{
 		.type	= SERIO_8042,
 		.proto	= SERIO_ANY,
-- 
2.7.4
