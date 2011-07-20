From: Dan Carpenter <error27@gmail.com>
Subject: [patch 1/2] input: kxtj9: fix bug in probe()
Date: Wed, 20 Jul 2011 08:30:41 +0300
Message-ID: <20110720053041.GD6445@shale.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:63970 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750777Ab1GTFcd (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 20 Jul 2011 01:32:33 -0400
Received: by wyg8 with SMTP id 8so3233484wyg.19
        for <linux-input@vger.kernel.org>; Tue, 19 Jul 2011 22:32:32 -0700 (PDT)
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Chris Hudson <chudson@kionix.com>
Cc: Dmitry Torokhov <dtor@mail.ru>, linux-input@vger.kernel.org

We are testing the wrong variable here.  I believe tj9->input_dev
is always NULL at this point, so probe() will fail.

Signed-off-by: Dan Carpenter <error27@gmail.com>
---
Compile tested.

diff --git a/drivers/input/misc/kxtj9.c b/drivers/input/misc/kxtj9.c
index a416f7f..6c96dc3 100644
--- a/drivers/input/misc/kxtj9.c
+++ b/drivers/input/misc/kxtj9.c
@@ -301,7 +301,7 @@ static int __devinit kxtj9_setup_input_device(struct kxtj9_data *tj9)
 	int err;
 
 	input_dev = input_allocate_device();
-	if (!tj9->input_dev) {
+	if (!input_dev) {
 		dev_err(&tj9->client->dev, "input device allocate failed\n");
 		return -ENOMEM;
 	}
