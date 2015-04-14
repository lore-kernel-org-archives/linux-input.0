From: Oliver Neukum <oneukum@suse.de>
Subject: [PATCH] ff-core: use new debug macros
Date: Tue, 14 Apr 2015 14:06:10 +0200
Message-ID: <1429013170-15053-1-git-send-email-oneukum@suse.de>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:34121 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753532AbbDNMG5 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 14 Apr 2015 08:06:57 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: jkosina@suse.cz, linux-usb@vger.kernel.org, linux-input@vger.kernel.org
Cc: Oliver Neukum <oneukum@suse.de>

Replace old pr_* with dev_* debugging macros

Signed-off-by: Oliver Neukum <oneukum@suse.de>
---
 drivers/input/ff-core.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/input/ff-core.c b/drivers/input/ff-core.c
index f50f6dd..b81c88c 100644
--- a/drivers/input/ff-core.c
+++ b/drivers/input/ff-core.c
@@ -23,8 +23,6 @@
 
 /* #define DEBUG */
 
-#define pr_fmt(fmt) KBUILD_BASENAME ": " fmt
-
 #include <linux/input.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
@@ -116,7 +114,7 @@ int input_ff_upload(struct input_dev *dev, struct ff_effect *effect,
 
 	if (effect->type < FF_EFFECT_MIN || effect->type > FF_EFFECT_MAX ||
 	    !test_bit(effect->type, dev->ffbit)) {
-		pr_debug("invalid or not supported effect type in upload\n");
+		dev_dbg(&dev->dev, "invalid or not supported effect type in upload\n");
 		return -EINVAL;
 	}
 
@@ -124,7 +122,7 @@ int input_ff_upload(struct input_dev *dev, struct ff_effect *effect,
 	    (effect->u.periodic.waveform < FF_WAVEFORM_MIN ||
 	     effect->u.periodic.waveform > FF_WAVEFORM_MAX ||
 	     !test_bit(effect->u.periodic.waveform, dev->ffbit))) {
-		pr_debug("invalid or not supported wave form in upload\n");
+		dev_dbg(&dev->dev, "invalid or not supported wave form in upload\n");
 		return -EINVAL;
 	}
 
@@ -246,7 +244,7 @@ static int flush_effects(struct input_dev *dev, struct file *file)
 	struct ff_device *ff = dev->ff;
 	int i;
 
-	pr_debug("flushing now\n");
+	dev_dbg(&dev->dev, "flushing now\n");
 
 	mutex_lock(&ff->mutex);
 
@@ -316,7 +314,7 @@ int input_ff_create(struct input_dev *dev, unsigned int max_effects)
 	int i;
 
 	if (!max_effects) {
-		pr_err("cannot allocate device without any effects\n");
+		dev_err(&dev->dev, "cannot allocate device without any effects\n");
 		return -EINVAL;
 	}
 
-- 
2.1.4

