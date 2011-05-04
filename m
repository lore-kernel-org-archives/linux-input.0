From: Ville Syrjala <syrjala@sci.fi>
Subject: [PATCH] ati_remote2: Return the error code from sysfs channel_mask store
Date: Thu,  5 May 2011 00:46:28 +0300
Message-ID: <1304545588-22990-1-git-send-email-syrjala@sci.fi>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from filtteri1.pp.htv.fi ([213.243.153.184]:47074 "EHLO
	filtteri1.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754199Ab1EDVqm (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 4 May 2011 17:46:42 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, Ville Syrjala <syrjala@sci.fi>

If the channel_mask setup fails when configuring it through sysfs,
return the error code to the caller instead of claiming success.

Signed-off-by: Ville Syrjala <syrjala@sci.fi>
---
 drivers/input/misc/ati_remote2.c |    9 ++++++---
 1 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/input/misc/ati_remote2.c b/drivers/input/misc/ati_remote2.c
index 0b0e9be..3877bfc 100644
--- a/drivers/input/misc/ati_remote2.c
+++ b/drivers/input/misc/ati_remote2.c
@@ -737,14 +737,17 @@ static ssize_t ati_remote2_store_channel_mask(struct device *dev,
 
 	mutex_lock(&ati_remote2_mutex);
 
-	if (mask != ar2->channel_mask && !ati_remote2_setup(ar2, mask))
-		ar2->channel_mask = mask;
+	if (mask != ar2->channel_mask) {
+		r = ati_remote2_setup(ar2, mask);
+		if (!r)
+			ar2->channel_mask = mask;
+	}
 
 	mutex_unlock(&ati_remote2_mutex);
 
 	usb_autopm_put_interface(ar2->intf[0]);
 
-	return count;
+	return r ? r : count;
 }
 
 static ssize_t ati_remote2_show_mode_mask(struct device *dev,
-- 
1.7.3.4

