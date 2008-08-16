From: Huang Weiyi <weiyi.huang@gmail.com>
Subject: [TOUCHSCREEN] removed unused #include <version.h>
Date: Sun, 17 Aug 2008 07:50:39 +0800
Message-ID: <20080817064554.160C.WEIYI.HUANG@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ti-out-0910.google.com ([209.85.142.187]:14173 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752184AbYHPXuw (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 16 Aug 2008 19:50:52 -0400
Received: by ti-out-0910.google.com with SMTP id b6so623856tic.23
        for <linux-input@vger.kernel.org>; Sat, 16 Aug 2008 16:50:50 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: broonie@opensource.wolfsonmicro.com, liam.girdwood@wolfsonmicro.com
Cc: linux-input@vger.kernel.org

The drivers below do not use LINUX_VERSION_CODE nor KERNEL_VERSION.
  drivers/input/touchscreen/wm9705.c
  drivers/input/touchscreen/wm9712.c
  drivers/input/touchscreen/wm9713.c
  drivers/input/touchscreen/wm97xx-core.c

This patch removes the said #include <version.h>.

Signed-off-by: Huang Weiyi <weiyi.huang@gmail.com>

diff --git a/drivers/input/touchscreen/wm9705.c b/drivers/input/touchscreen/wm9705.c
index 978e1a1..372efbc 100644
--- a/drivers/input/touchscreen/wm9705.c
+++ b/drivers/input/touchscreen/wm9705.c
@@ -17,7 +17,6 @@
 
 #include <linux/module.h>
 #include <linux/moduleparam.h>
-#include <linux/version.h>
 #include <linux/kernel.h>
 #include <linux/input.h>
 #include <linux/delay.h>
diff --git a/drivers/input/touchscreen/wm9712.c b/drivers/input/touchscreen/wm9712.c
index 4c5d85a..c8bb1e7 100644
--- a/drivers/input/touchscreen/wm9712.c
+++ b/drivers/input/touchscreen/wm9712.c
@@ -17,7 +17,6 @@
 
 #include <linux/module.h>
 #include <linux/moduleparam.h>
-#include <linux/version.h>
 #include <linux/kernel.h>
 #include <linux/input.h>
 #include <linux/delay.h>
diff --git a/drivers/input/touchscreen/wm9713.c b/drivers/input/touchscreen/wm9713.c
index 8384587..781ee83 100644
--- a/drivers/input/touchscreen/wm9713.c
+++ b/drivers/input/touchscreen/wm9713.c
@@ -17,7 +17,6 @@
 
 #include <linux/module.h>
 #include <linux/moduleparam.h>
-#include <linux/version.h>
 #include <linux/kernel.h>
 #include <linux/input.h>
 #include <linux/delay.h>
diff --git a/drivers/input/touchscreen/wm97xx-core.c b/drivers/input/touchscreen/wm97xx-core.c
index cdc24ad..d589ab0 100644
--- a/drivers/input/touchscreen/wm97xx-core.c
+++ b/drivers/input/touchscreen/wm97xx-core.c
@@ -37,7 +37,6 @@
 
 #include <linux/module.h>
 #include <linux/moduleparam.h>
-#include <linux/version.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/delay.h>

