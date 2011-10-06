From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 4/9] Input: serio_raw - use bool for boolean data
Date: Wed,  5 Oct 2011 22:08:11 -0700
Message-ID: <1317877696-7719-4-git-send-email-dmitry.torokhov@gmail.com>
References: <1317877696-7719-1-git-send-email-dmitry.torokhov@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pz0-f42.google.com ([209.85.210.42]:40708 "EHLO
	mail-pz0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752839Ab1JFFIY (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 6 Oct 2011 01:08:24 -0400
Received: by pzk1 with SMTP id 1so5956160pzk.1
        for <linux-input@vger.kernel.org>; Wed, 05 Oct 2011 22:08:24 -0700 (PDT)
In-Reply-To: <1317877696-7719-1-git-send-email-dmitry.torokhov@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Thomas Tuttle <ttuttle@chromium.org>

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---
 drivers/input/serio/serio_raw.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/input/serio/serio_raw.c b/drivers/input/serio/serio_raw.c
index 77ce3a6..a5afc7c 100644
--- a/drivers/input/serio/serio_raw.c
+++ b/drivers/input/serio/serio_raw.c
@@ -139,9 +139,9 @@ static int serio_raw_release(struct inode *inode, struct file *file)
 	return 0;
 }
 
-static int serio_raw_fetch_byte(struct serio_raw *serio_raw, char *c)
+static bool serio_raw_fetch_byte(struct serio_raw *serio_raw, char *c)
 {
-	int empty;
+	bool empty;
 
 	serio_pause_rx(serio_raw->serio);
 
@@ -394,7 +394,7 @@ static struct serio_driver serio_raw_drv = {
 	.connect	= serio_raw_connect,
 	.reconnect	= serio_raw_reconnect,
 	.disconnect	= serio_raw_disconnect,
-	.manual_bind	= 1,
+	.manual_bind	= true,
 };
 
 static int __init serio_raw_init(void)
-- 
1.7.6.4

