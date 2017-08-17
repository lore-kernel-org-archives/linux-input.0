From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: [PATCH 28/30] Input: touchwin: constify serio_device_id
Date: Thu, 17 Aug 2017 17:08:29 +0530
Message-ID: <1502969911-25408-29-git-send-email-arvind.yadav.cs@gmail.com>
References: <1502969911-25408-1-git-send-email-arvind.yadav.cs@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pg0-f67.google.com ([74.125.83.67]:38524 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752787AbdHQLkO (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Thu, 17 Aug 2017 07:40:14 -0400
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
 drivers/input/touchscreen/touchwin.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/touchscreen/touchwin.c b/drivers/input/touchscreen/touchwin.c
index ba90f44..2ba6b4c 100644
--- a/drivers/input/touchscreen/touchwin.c
+++ b/drivers/input/touchscreen/touchwin.c
@@ -159,7 +159,7 @@ static int tw_connect(struct serio *serio, struct serio_driver *drv)
  * The serio driver structure.
  */
 
-static struct serio_device_id tw_serio_ids[] = {
+static const struct serio_device_id tw_serio_ids[] = {
 	{
 		.type	= SERIO_RS232,
 		.proto	= SERIO_TOUCHWIN,
-- 
2.7.4

