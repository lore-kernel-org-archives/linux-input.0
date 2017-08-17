From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: [PATCH 02/30] Input: magellan: constify serio_device_id
Date: Thu, 17 Aug 2017 17:08:03 +0530
Message-ID: <1502969911-25408-3-git-send-email-arvind.yadav.cs@gmail.com>
References: <1502969911-25408-1-git-send-email-arvind.yadav.cs@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pg0-f67.google.com ([74.125.83.67]:36608 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751844AbdHQLjY (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Thu, 17 Aug 2017 07:39:24 -0400
In-Reply-To: <1502969911-25408-1-git-send-email-arvind.yadav.cs@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

serio_device_id are not supposed to change at runtime. All functions
working with serio_device_id provided by <linux/serio.h> work with
const serio_device_id. So mark the non-const structs as const.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 drivers/input/joystick/magellan.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/joystick/magellan.c b/drivers/input/joystick/magellan.c
index c5358ba..a9d0e3e 100644
--- a/drivers/input/joystick/magellan.c
+++ b/drivers/input/joystick/magellan.c
@@ -198,7 +198,7 @@ static int magellan_connect(struct serio *serio, struct serio_driver *drv)
  * The serio driver structure.
  */
 
-static struct serio_device_id magellan_serio_ids[] = {
+static const struct serio_device_id magellan_serio_ids[] = {
 	{
 		.type	= SERIO_RS232,
 		.proto	= SERIO_MAGELLAN,
-- 
2.7.4

