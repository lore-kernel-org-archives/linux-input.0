From: Corentin Labbe <clabbe.montjoie@gmail.com>
Subject: [PATCH] Input: joydev: remove unused linux/miscdevice.h include
Date: Thu, 15 Dec 2016 19:12:13 +0100
Message-ID: <20161215181213.27732-1-clabbe.montjoie@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wj0-f195.google.com ([209.85.210.195]:34614 "EHLO
        mail-wj0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753464AbcLOSO0 (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Thu, 15 Dec 2016 13:14:26 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Corentin Labbe <clabbe.montjoie@gmail.com>

This patch remove the inclusion of linux/miscdevice.h for joydev
since it does not use miscdevice.

Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>
---
 drivers/input/joydev.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/input/joydev.c b/drivers/input/joydev.c
index f3135ae..abd18f3 100644
--- a/drivers/input/joydev.c
+++ b/drivers/input/joydev.c
@@ -22,7 +22,6 @@
 #include <linux/sched.h>
 #include <linux/slab.h>
 #include <linux/mm.h>
-#include <linux/miscdevice.h>
 #include <linux/module.h>
 #include <linux/poll.h>
 #include <linux/init.h>
-- 
2.10.2

