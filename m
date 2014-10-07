From: Pramod Gurav <pramod.gurav@smartplayin.com>
Subject: [PATCH] Input: adp5588-keys: cancel workqueue in failure path
Date: Tue,  7 Oct 2014 13:00:49 +0530
Message-ID: <1412667049-6128-1-git-send-email-pramod.gurav@smartplayin.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp112.ord1c.emailsrvr.com ([108.166.43.112]:40488 "EHLO
	smtp112.ord1c.emailsrvr.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751214AbaJGH1S (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 7 Oct 2014 03:27:18 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Pramod Gurav <pramod.gurav@smartplayin.com>, Michael Hennerich <michael.hennerich@analog.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org

This change introduces a label to call cancel_delayed_work_sync in
failure path.

Cc: Michael Hennerich <michael.hennerich@analog.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org
Signed-off-by: Pramod Gurav <pramod.gurav@smartplayin.com>
---
 drivers/input/keyboard/adp5588-keys.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/input/keyboard/adp5588-keys.c b/drivers/input/keyboard/adp5588-keys.c
index 5ef7fcf..b494062 100644
--- a/drivers/input/keyboard/adp5588-keys.c
+++ b/drivers/input/keyboard/adp5588-keys.c
@@ -559,7 +559,7 @@ static int adp5588_probe(struct i2c_client *client,
 	error = input_register_device(input);
 	if (error) {
 		dev_err(&client->dev, "unable to register input device\n");
-		goto err_free_mem;
+		goto err_delayed_work;
 	}
 
 	error = request_irq(client->irq, adp5588_irq,
@@ -592,6 +592,8 @@ static int adp5588_probe(struct i2c_client *client,
  err_unreg_dev:
 	input_unregister_device(input);
 	input = NULL;
+ err_delayed_work:
+	cancel_delayed_work_sync(&kpad->work);
  err_free_mem:
 	input_free_device(input);
 	kfree(kpad);
-- 
1.7.9.5

