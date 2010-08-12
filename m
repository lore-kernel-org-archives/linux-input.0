From: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
Subject: [PATCH 3/4] atkbd: support binding to ps2mult devices
Date: Thu, 12 Aug 2010 13:31:52 +0400
Message-ID: <1281605513-11586-4-git-send-email-dbaryshkov@gmail.com>
References: <1281605513-11586-1-git-send-email-dbaryshkov@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:62580 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751869Ab0HLJcM (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 12 Aug 2010 05:32:12 -0400
Received: by mail-ww0-f44.google.com with SMTP id 40so1297310wwj.1
        for <linux-input@vger.kernel.org>; Thu, 12 Aug 2010 02:32:11 -0700 (PDT)
In-Reply-To: <1281605513-11586-1-git-send-email-dbaryshkov@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
---
 drivers/input/keyboard/atkbd.c |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/drivers/input/keyboard/atkbd.c b/drivers/input/keyboard/atkbd.c
index d358ef8..156fe54 100644
--- a/drivers/input/keyboard/atkbd.c
+++ b/drivers/input/keyboard/atkbd.c
@@ -1113,6 +1113,7 @@ static int atkbd_connect(struct serio *serio, struct serio_driver *drv)
 		/* Fall through */
 
 	case SERIO_8042:
+	case SERIO_PS2MULT_T:
 		if (serio->write)
 			atkbd->write = true;
 		break;
@@ -1240,6 +1241,12 @@ static struct serio_device_id atkbd_serio_ids[] = {
 		.id	= SERIO_ANY,
 		.extra	= SERIO_ANY,
 	},
+	{
+		.type	= SERIO_PS2MULT_T,
+		.proto	= SERIO_ANY,
+		.id	= SERIO_ANY,
+		.extra	= SERIO_ANY,
+	},
 	{ 0 }
 };
 
-- 
1.7.1

