From: Huang Weiyi <weiyi.huang@gmail.com>
Subject: drivers/input/serio/hp_sdc.c: Removed duplicated include
Date: Fri, 25 Jul 2008 23:30:20 +0800
Message-ID: <20080725231334.9146.WEIYI.HUANG@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ti-out-0910.google.com ([209.85.142.189]:61458 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752033AbYGYPaX (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 25 Jul 2008 11:30:23 -0400
Received: by ti-out-0910.google.com with SMTP id b6so1795622tic.23
        for <linux-input@vger.kernel.org>; Fri, 25 Jul 2008 08:30:22 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com, dtor@mail.ru
Cc: linux-input@vger.kernel.org

Removed duplicated include file <linux/semaphore.h> in 
drivers/input/serio/hp_sdc.c.

Signed-off-by: Huang Weiyi <weiyi.huang@gmail.com>

diff --git a/drivers/input/serio/hp_sdc.c b/drivers/input/serio/hp_sdc.c
index aad664d..0d39597 100644
--- a/drivers/input/serio/hp_sdc.c
+++ b/drivers/input/serio/hp_sdc.c
@@ -70,7 +70,6 @@
 #include <linux/semaphore.h>
 #include <linux/slab.h>
 #include <linux/hil.h>
-#include <linux/semaphore.h>
 #include <asm/io.h>
 #include <asm/system.h>


