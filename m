From: Aniroop Mathur <aniroop.mathur@gmail.com>
Subject: [PATCH] Input: Initialize input_no by -1
Date: Sat, 22 Nov 2014 00:18:39 +0530
Message-ID: <CADYu30-dyHvidn6z6NW0w8hEwFd6Nctf8_5Yb5LKU4MFKvwLHw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-la0-f46.google.com ([209.85.215.46]:58681 "EHLO
	mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750807AbaKUSsl (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 21 Nov 2014 13:48:41 -0500
Received: by mail-la0-f46.google.com with SMTP id gd6so4836657lab.33
        for <linux-input@vger.kernel.org>; Fri, 21 Nov 2014 10:48:39 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

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
-       static atomic_t input_no = ATOMIC_INIT(0);
+       static atomic_t input_no = ATOMIC_INIT(-1);
        struct input_dev *dev;

        dev = kzalloc(sizeof(struct input_dev), GFP_KERNEL);
@@ -1789,7 +1789,7 @@ struct input_dev *input_allocate_device(void)
                INIT_LIST_HEAD(&dev->node);

                dev_set_name(&dev->dev, "input%ld",
-                            (unsigned long) atomic_inc_return(&input_no) - 1);
+                            (unsigned long) atomic_inc_return(&input_no));

                __module_get(THIS_MODULE);
        }
-- 
1.9.1
