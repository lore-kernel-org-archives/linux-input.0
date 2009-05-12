From: akpm@linux-foundation.org
Subject: [patch 9/9] serios: async shutdown
Date: Tue, 12 May 2009 13:43:11 -0700
Message-ID: <200905122102.n4CL2RUY006919@imap1.linux-foundation.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:35993 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752302AbZELVHT (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 12 May 2009 17:07:19 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dtor@mail.ru
Cc: linux-input@vger.kernel.org, akpm@linux-foundation.org, shaohua.li@intel.com, arjan@infradead.org

From: Shaohua Li <shaohua.li@intel.com>

serio shutdown is quite slow. It sometimes will take 0.2s for each port.

Signed-off-by: Shaohua Li <shaohua.li@intel.com>
Cc: Arjan van de Ven <arjan@infradead.org>
Cc: Dmitry Torokhov <dtor@mail.ru>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/input/serio/serio.c |    9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff -puN drivers/input/serio/serio.c~serios-async-shutdown drivers/input/serio/serio.c
--- a/drivers/input/serio/serio.c~serios-async-shutdown
+++ a/drivers/input/serio/serio.c
@@ -36,6 +36,7 @@
 #include <linux/kthread.h>
 #include <linux/mutex.h>
 #include <linux/freezer.h>
+#include <linux/async.h>
 
 MODULE_AUTHOR("Vojtech Pavlik <vojtech@ucw.cz>");
 MODULE_DESCRIPTION("Serio abstraction core");
@@ -792,11 +793,17 @@ static void serio_cleanup(struct serio *
 	mutex_unlock(&serio->drv_mutex);
 }
 
+static void serio_async_shutdown(void *data, async_cookie_t cookie)
+{
+	struct serio *serio = data;
+	serio_cleanup(serio);
+}
+
 static void serio_shutdown(struct device *dev)
 {
 	struct serio *serio = to_serio_port(dev);
 
-	serio_cleanup(serio);
+	async_schedule(serio_async_shutdown, serio);
 }
 
 static void serio_attach_driver(struct serio_driver *drv)
_
