From: Huang Weiyi <weiyi.huang@gmail.com>
Subject: Input: remove unused #include <version.h>
Date: Sat, 23 Aug 2008 13:56:18 +0800
Message-ID: <20080823132007.127D.WEIYI.HUANG@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ti-out-0910.google.com ([209.85.142.190]:59891 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753669AbYHWF4U (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 23 Aug 2008 01:56:20 -0400
Received: by ti-out-0910.google.com with SMTP id b6so452807tic.23
        for <linux-input@vger.kernel.org>; Fri, 22 Aug 2008 22:56:19 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com, dtor@mail.ru
Cc: linux-input@vger.kernel.org

The driver(s) below do not use LINUX_VERSION_CODE nor KERNEL_VERSION.
  drivers/input/keyboard/bf54x-keys.c
  drivers/input/touchscreen/mainstone-wm97xx.c

This patch removes the said #include <version.h>.

Signed-off-by: Huang Weiyi <weiyi.huang@gmail.com>

diff --git a/drivers/input/keyboard/bf54x-keys.c b/drivers/input/keyboard/bf54x-keys.c
index 54ed8e2..6f227d3 100644
--- a/drivers/input/keyboard/bf54x-keys.c
+++ b/drivers/input/keyboard/bf54x-keys.c
@@ -29,7 +29,6 @@
  */

 #include <linux/module.h>
-#include <linux/version.h>

 #include <linux/init.h>
 #include <linux/fs.h>
diff --git a/drivers/input/touchscreen/mainstone-wm97xx.c b/drivers/input/touchscreen/mainstone-wm97xx.c
index 283f93a..37a555f 100644
--- a/drivers/input/touchscreen/mainstone-wm97xx.c
+++ b/drivers/input/touchscreen/mainstone-wm97xx.c
@@ -25,7 +25,6 @@

 #include <linux/module.h>
 #include <linux/moduleparam.h>
-#include <linux/version.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/delay.h>

