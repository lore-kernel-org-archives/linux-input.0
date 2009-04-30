From: Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH] input: remove driver_data direct access of struct device
Date: Thu, 30 Apr 2009 15:17:30 -0700
Message-ID: <20090430221730.GA18512@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from kroah.org ([198.145.64.141]:55435 "EHLO coco.kroah.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751306AbZD3W3d (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 30 Apr 2009 18:29:33 -0400
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, Greg KH <greg@kroah.com>

From: Greg Kroah-Hartman <gregkh@suse.de>

In the near future, the driver core is going to not allow direct access
to the driver_data pointer in struct device.  Instead, the functions
dev_get_drvdata() and dev_set_drvdata() should be used.  These functions
have been around since the beginning, so are backwards compatible with
all older kernel versions.

Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 drivers/input/touchscreen/wm97xx-core.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/input/touchscreen/wm97xx-core.c
+++ b/drivers/input/touchscreen/wm97xx-core.c
@@ -569,7 +569,7 @@ static int wm97xx_probe(struct device *d
 	mutex_init(&wm->codec_mutex);
 
 	wm->dev = dev;
-	dev->driver_data = wm;
+	dev_set_drvdata(dev, wm);
 	wm->ac97 = to_ac97_t(dev);
 
 	/* check that we have a supported codec */
