From: "Geyslan G. Bem" <geyslan@gmail.com>
Subject: [PATCH v2] drivers: input: mouse: Remove useless casting in cypress_ps2.c
Date: Wed, 16 Oct 2013 19:31:15 -0300
Message-ID: <1381962675-26876-1-git-send-email-geyslan@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ve0-f175.google.com ([209.85.128.175]:49222 "EHLO
	mail-ve0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754088Ab3JPWgV (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 16 Oct 2013 18:36:21 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: dudl@cypress.com, kamal@canonical.com, mario_limonciello@dell.com, git@status.e4ward.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-br@googlegroups.com, "Geyslan G. Bem" <geyslan@gmail.com>

Get rid of unnecessary (void *) casting in 'cypress_init' function.

Signed-off-by: Geyslan G. Bem <geyslan@gmail.com>
---
 drivers/input/mouse/cypress_ps2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/mouse/cypress_ps2.c b/drivers/input/mouse/cypress_ps2.c
index f51765f..b87d7ba 100644
--- a/drivers/input/mouse/cypress_ps2.c
+++ b/drivers/input/mouse/cypress_ps2.c
@@ -680,7 +680,7 @@ int cypress_init(struct psmouse *psmouse)
 	struct cytp_data *cytp;
 
 	cytp = (struct cytp_data *)kzalloc(sizeof(struct cytp_data), GFP_KERNEL);
-	psmouse->private = (void *)cytp;
+	psmouse->private = cytp;
 	if (cytp == NULL)
 		return -ENOMEM;
 
-- 
1.8.4

