From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 3/4] Input-gameport: Add the macro "pr_fmt" for module
 "joydump"
Date: Sat, 24 Sep 2016 15:48:54 +0200
Message-ID: <3345f7c1-b823-a819-aabf-5b4990068075@users.sourceforge.net>
References: <d8da8333-d83a-ca61-b887-7fd7528c63a4@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mout.web.de ([212.227.17.12]:58355 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1758262AbcIXNtE (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Sat, 24 Sep 2016 09:49:04 -0400
In-Reply-To: <d8da8333-d83a-ca61-b887-7fd7528c63a4@users.sourceforge.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org, Julia Lawall <julia.lawall@lip6.fr>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sat, 24 Sep 2016 14:30:44 +0200

Add a definition for the macro "pr_fmt" so that its information can be used
for consistent message output.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/input/joystick/joydump.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/input/joystick/joydump.c b/drivers/input/joystick/joydump.c
index f9f6cbe..a38f10e 100644
--- a/drivers/input/joystick/joydump.c
+++ b/drivers/input/joystick/joydump.c
@@ -27,6 +27,8 @@
  * Vojtech Pavlik, Simunkova 1594, Prague 8, 182 00 Czech Republic
  */
 
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
 #include <linux/module.h>
 #include <linux/gameport.h>
 #include <linux/kernel.h>
-- 
2.10.0

