From: Christopher Heiny <cheiny@synaptics.com>
Subject: [PATCH v1.01] input synaptics-rmi4: rmi_driver.c storage fix
Date: Wed, 5 Mar 2014 17:11:48 -0800
Message-ID: <1394068308-6284-1-git-send-email-cheiny@synaptics.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-input-owner@vger.kernel.org>
Received: from us-mx2.synaptics.com ([192.147.44.131]:46854 "EHLO
	us-mx2.synaptics.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755378AbaCFBL4 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 5 Mar 2014 20:11:56 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Linux Input <linux-input@vger.kernel.org>, Christopher Heiny <cheiny@synaptics.com>, Andrew Duggan <aduggan@synaptics.com>, Vincent Huang <vincent.huang@tw.synaptics.com>, Vivian Ly <vly@synaptics.com>, Daniel Rosenberg <daniel.rosenberg@synaptics.com>, Linus Walleij <linus.walleij@linaro.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, David Herrmann <dh.herrmann@gmail.com>, Jiri Kosina <jkosina@suse.cz>

Do not use kfree() on storage allocated with devm_kzalloc(),
eliminating kernel panics on device removal.

I'm not sure how this eluded all the patching that's been going on over
the past few weeks, but somehow it did.  v1.01 - fix brain hiccup in
the commit message.

Reported-by: Courtney Cavin <courtney.cavin@sonymobile.com>
Reported-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reported-by: Andrew Duggan <aduggan@synaptics.com>
Signed-off-by: Christopher Heiny <cheiny@synaptics.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Linux Walleij <linus.walleij@linaro.org>
Cc: David Herrmann <dh.herrmann@gmail.com>
Cc: Jiri Kosina <jkosina@suse.cz>

---

 drivers/input/rmi4/rmi_driver.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/input/rmi4/rmi_driver.c b/drivers/input/rmi4/rmi_driver.c
index 4406a7f..3552ffb 100644
--- a/drivers/input/rmi4/rmi_driver.c
+++ b/drivers/input/rmi4/rmi_driver.c
@@ -743,7 +743,6 @@ static int rmi_driver_remove(struct device *dev)
 		gpio_free(pdata->attn_gpio);
 
 	kfree(data->irq_status);
-	kfree(data);
 
 	return 0;
 }
@@ -942,7 +941,6 @@ err_destroy_functions:
 err_free_mem:
 	if (data->gpio_held)
 		gpio_free(pdata->attn_gpio);
-	kfree(data);
 	return retval < 0 ? retval : 0;
 }
 
