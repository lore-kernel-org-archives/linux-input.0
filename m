From: Huang Weiyi <weiyi.huang@gmail.com>
Subject: remove duplicated include
Date: Thu, 08 May 2008 22:16:07 +0800
Message-ID: <20080508221348.8965.WEIYI.HUANG@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.176]:54138 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752741AbYEHOQI (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 8 May 2008 10:16:08 -0400
Received: by wa-out-1112.google.com with SMTP id j37so1153467waf.23
        for <linux-input@vger.kernel.org>; Thu, 08 May 2008 07:16:07 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com, dtor@mail.ru
Cc: linux-input@vger.kernel.org

Removed duplicated include file <linux/module.h>.

Signed-off-by: Huang Weiyi <weiyi.huang@gmail.com>

--- a/drivers/input/misc/apanel.c       2008-05-08 22:09:04.000000000 +0800
+++ b/drivers/input/misc/apanel.c       2008-05-08 22:09:16.000000000 +0800
@@ -20,7 +20,6 @@
 #include <linux/module.h>
 #include <linux/ioport.h>
 #include <linux/io.h>
-#include <linux/module.h>
 #include <linux/input-polldev.h>
 #include <linux/i2c.h>
 #include <linux/workqueue.h>


