From: Daniel Kurtz <djkurtz@chromium.org>
Subject: [PATCH 04/23 v6] Input: atmel_mxt_ts - warn if sysfs could not be created
Date: Thu, 28 Jun 2012 21:08:05 +0800
Message-ID: <1340888904-15620-5-git-send-email-djkurtz@chromium.org>
References: <1340888904-15620-1-git-send-email-djkurtz@chromium.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-lb0-f202.google.com ([209.85.217.202]:38708 "EHLO
	mail-lb0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754215Ab2F1NIa (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 28 Jun 2012 09:08:30 -0400
Received: by lbbgp10 with SMTP id gp10so137873lbb.1
        for <linux-input@vger.kernel.org>; Thu, 28 Jun 2012 06:08:28 -0700 (PDT)
In-Reply-To: <1340888904-15620-1-git-send-email-djkurtz@chromium.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Henrik Rydberg <rydberg@euromail.se>, Joonyoung Shim <jy0922.shim@samsung.com>, Nick Dyer <nick.dyer@itdev.co.uk>, Yufeng Shen <miletus@chromium.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Olof Johansson <olof@lixom.net>, Benson Leung <bleung@chromium.org>, Daniel Kurtz <djkurtz@chromium.org>

If sysfs entry creation fails, the driver is still usable, so don't
just abort probe.  Just warn and continue.

Signed-off-by: Daniel Kurtz <djkurtz@chromium.org>
---
 drivers/input/touchscreen/atmel_mxt_ts.c |    5 +----
 1 files changed, 1 insertions(+), 4 deletions(-)

diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c b/drivers/input/touchscreen/atmel_mxt_ts.c
index 926209c..c72f595 100644
--- a/drivers/input/touchscreen/atmel_mxt_ts.c
+++ b/drivers/input/touchscreen/atmel_mxt_ts.c
@@ -1172,13 +1172,10 @@ static int __devinit mxt_probe(struct i2c_client *client,
 
 	error = sysfs_create_group(&client->dev.kobj, &mxt_attr_group);
 	if (error)
-		goto err_unregister_device;
+		dev_warn(&client->dev, "error creating sysfs entries.\n");
 
 	return 0;
 
-err_unregister_device:
-	input_unregister_device(input_dev);
-	input_dev = NULL;
 err_free_irq:
 	free_irq(client->irq, data);
 err_free_object:
-- 
1.7.7.3

