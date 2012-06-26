From: Daniel Kurtz <djkurtz@chromium.org>
Subject: [PATCH 04/21 v5] Input: atmel_mxt_ts - warn if sysfs could not be created
Date: Tue, 26 Jun 2012 14:56:52 +0800
Message-ID: <1340693829-18665-5-git-send-email-djkurtz@chromium.org>
References: <1340693829-18665-1-git-send-email-djkurtz@chromium.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yx0-f202.google.com ([209.85.213.202]:60466 "EHLO
	mail-yx0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755535Ab2FZG5S (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 26 Jun 2012 02:57:18 -0400
Received: by yenl3 with SMTP id l3so543775yen.1
        for <linux-input@vger.kernel.org>; Mon, 25 Jun 2012 23:57:18 -0700 (PDT)
In-Reply-To: <1340693829-18665-1-git-send-email-djkurtz@chromium.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Henrik Rydberg <rydberg@euromail.se>, Joonyoung Shim <jy0922.shim@samsung.com>, Nick Dyer <nick.dyer@itdev.co.uk>, linux-input@vger.kernel.org
Cc: Iiro Valkonen <iiro.valkonen@atmel.com>, Benson Leung <bleung@chromium.org>, Yufeng Shen <miletus@chromium.org>, Olof Johansson <olofj@chromium.org>, linux-kernel@vger.kernel.org, Daniel Kurtz <djkurtz@chromium.org>

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

