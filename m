From: Joe Perches <joe@perches.com>
Subject: [PATCH] remove unused #defines
	to_dev,to_handler,to_handle,to_handle_h
Date: Wed, 23 Apr 2008 20:50:31 -0700
Message-ID: <1209009031.8636.201.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from 136-022.dsl.labridge.com ([206.117.136.22]:3641 "EHLO
	mail.perches.com" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S1753599AbYDXDu6 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 23 Apr 2008 23:50:58 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org

Originally sent to LKML, but you should have received this too.

-------------

Remove unused to_dev, to_handler, to_handle from include/linux/input.h
Move to_handle_h from include/linux/input.h to drivers/char/keyboard.c
Remove unused to_dev from drivers/base/driver.c

Signed-off-by: Joe Perches <joe@perches.com>

 drivers/base/driver.c   |    3 ---
 drivers/char/keyboard.c |    2 ++
 include/linux/input.h   |    5 -----
 3 files changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/base/driver.c b/drivers/base/driver.c
index 9a6537f..2611ae8 100644
--- a/drivers/base/driver.c
+++ b/drivers/base/driver.c
@@ -16,9 +16,6 @@
 #include <linux/string.h>
 #include "base.h"
 
-#define to_dev(node) container_of(node, struct device, driver_list)
-
-
 static struct device *next_device(struct klist_iter *i)
 {
 	struct klist_node *n = klist_next(i);
diff --git a/drivers/char/keyboard.c b/drivers/char/keyboard.c
index 9769bf8..0ad7397 100644
--- a/drivers/char/keyboard.c
+++ b/drivers/char/keyboard.c
@@ -45,6 +45,8 @@
 
 extern void ctrl_alt_del(void);
 
+#define to_handle_h(n) container_of(n, struct input_handle, h_node)
+
 /*
  * Exported functions/variables
  */
diff --git a/include/linux/input.h b/include/linux/input.h
index cae2c35..4349ba6 100644
--- a/include/linux/input.h
+++ b/include/linux/input.h
@@ -1217,11 +1217,6 @@ struct input_handle {
 	struct list_head	h_node;
 };
 
-#define to_dev(n) container_of(n, struct input_dev, node)
-#define to_handler(n) container_of(n, struct input_handler, node)
-#define to_handle(n) container_of(n, struct input_handle, d_node)
-#define to_handle_h(n) container_of(n, struct input_handle, h_node)
-
 struct input_dev *input_allocate_device(void);
 void input_free_device(struct input_dev *dev);
 


