From: Dan Carpenter <error27@gmail.com>
Subject: [patch 2/2] Input: kxtj9: fix locking typo in kxtj9_set_poll()
Date: Wed, 20 Jul 2011 08:31:08 +0300
Message-ID: <20110720053108.GE6445@shale.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:59964 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751215Ab1GTFc7 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 20 Jul 2011 01:32:59 -0400
Received: by mail-ww0-f44.google.com with SMTP id 5so4845198wwe.1
        for <linux-input@vger.kernel.org>; Tue, 19 Jul 2011 22:32:58 -0700 (PDT)
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Chris Hudson <chudson@kionix.com>
Cc: Dmitry Torokhov <dtor@mail.ru>, linux-input@vger.kernel.org

According to the comments we want to call mutex_lock() here instead
of mutex_unlock().  That makes more sense.

Signed-off-by: Dan Carpenter <error27@gmail.com>

diff --git a/drivers/input/misc/kxtj9.c b/drivers/input/misc/kxtj9.c
index 6c96dc3..c456f63 100644
--- a/drivers/input/misc/kxtj9.c
+++ b/drivers/input/misc/kxtj9.c
@@ -362,7 +362,7 @@ static ssize_t kxtj9_set_poll(struct device *dev, struct device_attribute *attr,
 		return error;
 
 	/* Lock the device to prevent races with open/close (and itself) */
-	mutex_unlock(&input_dev->mutex);
+	mutex_lock(&input_dev->mutex);
 
 	disable_irq(client->irq);
 
