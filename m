From: Aniroop Mathur <aniroop.mathur@gmail.com>
Subject: [PATCH] Input: Initialize input_no by -1
Date: Tue, 25 Nov 2014 21:38:35 +0530
Message-ID: <1416931715-2902-1-git-send-email-aniroop.mathur@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pd0-f177.google.com ([209.85.192.177]:53865 "EHLO
	mail-pd0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750935AbaKYQIm (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 25 Nov 2014 11:08:42 -0500
Received: by mail-pd0-f177.google.com with SMTP id ft15so830125pdb.8
        for <linux-input@vger.kernel.org>; Tue, 25 Nov 2014 08:08:42 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
Cc: aniroop.mathur@gmail.com

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

