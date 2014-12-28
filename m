From: Aniroop Mathur <aniroop.mathur@gmail.com>
Subject: [PATCH] Input: Avoid kernel panic during device unregistration
Date: Sun, 28 Dec 2014 23:42:05 +0530
Message-ID: <1419790325-4004-1-git-send-email-aniroop.mathur@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pd0-f169.google.com ([209.85.192.169]:54853 "EHLO
	mail-pd0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751733AbaL1SMH (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 28 Dec 2014 13:12:07 -0500
Received: by mail-pd0-f169.google.com with SMTP id z10so15890815pdj.0
        for <linux-input@vger.kernel.org>; Sun, 28 Dec 2014 10:12:05 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com, dtor@mail.ru, linux-input@vger.kernel.org
Cc: aniroop.mathur@gmail.com, a.mathur@samsung.com

This patch adds null check before actually unregistering the input device
to avoid null pointer exception which leads to kernel panic.

So now, input device drivers won't have to worry about or add null case
condition before calling input_unregister_device() in shutdown and
remove functions.

Signed-off-by: Aniroop Mathur <a.mathur@samsung.com>
---
 drivers/input/input.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/input/input.c b/drivers/input/input.c
index 01fe49e..575219d 100644
--- a/drivers/input/input.c
+++ b/drivers/input/input.c
@@ -2170,6 +2170,9 @@ EXPORT_SYMBOL(input_register_device);
  */
 void input_unregister_device(struct input_dev *dev)
 {
+	if (!dev)
+		return;
+
 	if (dev->devres_managed) {
 		WARN_ON(devres_destroy(dev->dev.parent,
 					devm_input_device_unregister,
-- 
1.9.1

