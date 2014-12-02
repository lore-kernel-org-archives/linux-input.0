From: Aniroop Mathur <aniroop.mathur@gmail.com>
Subject: [PATCH] Input : Initialize input_no by -1
Date: Tue,  2 Dec 2014 22:15:29 +0530
Message-ID: <1417538729-2751-1-git-send-email-aniroop.mathur@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pd0-f173.google.com ([209.85.192.173]:45629 "EHLO
	mail-pd0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753928AbaLBQpo (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 2 Dec 2014 11:45:44 -0500
Received: by mail-pd0-f173.google.com with SMTP id ft15so13441194pdb.18
        for <linux-input@vger.kernel.org>; Tue, 02 Dec 2014 08:45:43 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com, dtor@mail.ru, linux-input@vger.kernel.org
Cc: aniroop.mathur@gmail.com, a.mathur@samsung.com

This patch initializes input_no by -1 in order to avoid extra subtraction
operation performed everytime for allocation of an input device.

Signed-off-by: Aniroop Mathur <aniroop.mathur@gmail.com>
---
 drivers/input/input.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/input/input.c b/drivers/input/input.c
index 29ca0bb..01fe49e 100644
--- a/drivers/input/input.c
+++ b/drivers/input/input.c
@@ -1774,7 +1774,7 @@ EXPORT_SYMBOL_GPL(input_class);
  */
 struct input_dev *input_allocate_device(void)
 {
-	static atomic_t input_no = ATOMIC_INIT(0);
+	static atomic_t input_no = ATOMIC_INIT(-1);
 	struct input_dev *dev;
 
 	dev = kzalloc(sizeof(struct input_dev), GFP_KERNEL);
@@ -1789,7 +1789,7 @@ struct input_dev *input_allocate_device(void)
 		INIT_LIST_HEAD(&dev->node);
 
 		dev_set_name(&dev->dev, "input%ld",
-			     (unsigned long) atomic_inc_return(&input_no) - 1);
+			     (unsigned long) atomic_inc_return(&input_no));
 
 		__module_get(THIS_MODULE);
 	}
-- 
1.9.1

