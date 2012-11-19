From: Bill Pemberton <wfp5p@virginia.edu>
Subject: [PATCH 003/493] Input: serio - remove CONFIG_HOTPLUG ifdefs
Date: Mon, 19 Nov 2012 13:19:12 -0500
Message-ID: <1353349642-3677-3-git-send-email-wfp5p@virginia.edu>
References: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from viridian.itc.Virginia.EDU ([128.143.12.139]:41682 "EHLO
	viridian.itc.virginia.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754051Ab2KSSiQ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 19 Nov 2012 13:38:16 -0500
In-Reply-To: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org

Remove conditional code based on CONFIG_HOTPLUG being false.  It's
always on now in preparation of it going away as an option.

Signed-off-by: Bill Pemberton <wfp5p@virginia.edu>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com> 
Cc: linux-input@vger.kernel.org 
---
 drivers/input/serio/serio.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/drivers/input/serio/serio.c b/drivers/input/serio/serio.c
index d0f7533..25fc597 100644
--- a/drivers/input/serio/serio.c
+++ b/drivers/input/serio/serio.c
@@ -891,8 +891,6 @@ static int serio_bus_match(struct device *dev, struct device_driver *drv)
 	return serio_match_port(serio_drv->id_table, serio);
 }
 
-#ifdef CONFIG_HOTPLUG
-
 #define SERIO_ADD_UEVENT_VAR(fmt, val...)				\
 	do {								\
 		int err = add_uevent_var(env, fmt, val);		\
@@ -920,15 +918,6 @@ static int serio_uevent(struct device *dev, struct kobj_uevent_env *env)
 }
 #undef SERIO_ADD_UEVENT_VAR
 
-#else
-
-static int serio_uevent(struct device *dev, struct kobj_uevent_env *env)
-{
-	return -ENODEV;
-}
-
-#endif /* CONFIG_HOTPLUG */
-
 #ifdef CONFIG_PM
 static int serio_suspend(struct device *dev)
 {
-- 
1.8.0

