From: Andi Shyti <andi@etezian.org>
Subject: [PATCH 02/12] Input: ad7879 - use managed devm_device_add_group
Date: Sat, 30 Sep 2017 05:38:29 +0900
Message-ID: <20170929203839.7010-3-andi@etezian.org>
References: <20170929203839.7010-1-andi@etezian.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from 16.mo6.mail-out.ovh.net ([87.98.139.208]:39543 "EHLO
        16.mo6.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752548AbdI2U5m (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Fri, 29 Sep 2017 16:57:42 -0400
Received: from player761.ha.ovh.net (b9.ovh.net [213.186.33.59])
        by mo6.mail-out.ovh.net (Postfix) with ESMTP id EE556112846
        for <linux-input@vger.kernel.org>; Fri, 29 Sep 2017 22:39:27 +0200 (CEST)
In-Reply-To: <20170929203839.7010-1-andi@etezian.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Andi Shyti <andi@etezian.org>, Andi Shyti <andi.shyti@samsung.com>, Michael Hennerich <michael.hennerich@analog.com>

Commit 57b8ff070f98 ("driver core: add devm_device_add_group()
and friends") has added the the managed version for creating
sysfs group files.

Use devm_device_add_group instead of sysfs_create_group and
remove the action that cleans the sysfs file when exiting the
driver.

CC: Michael Hennerich <michael.hennerich@analog.com>
Signed-off-by: Andi Shyti <andi@etezian.org>
---
 drivers/input/touchscreen/ad7879.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/drivers/input/touchscreen/ad7879.c b/drivers/input/touchscreen/ad7879.c
index 196028c45210..7d74a0ae2c94 100644
--- a/drivers/input/touchscreen/ad7879.c
+++ b/drivers/input/touchscreen/ad7879.c
@@ -524,13 +524,6 @@ static int ad7879_parse_dt(struct device *dev, struct ad7879 *ts)
 	return 0;
 }
 
-static void ad7879_cleanup_sysfs(void *_ts)
-{
-	struct ad7879 *ts = _ts;
-
-	sysfs_remove_group(&ts->dev->kobj, &ad7879_attr_group);
-}
-
 int ad7879_probe(struct device *dev, struct regmap *regmap,
 		 int irq, u16 bustype, u8 devid)
 {
@@ -658,11 +651,7 @@ int ad7879_probe(struct device *dev, struct regmap *regmap,
 
 	__ad7879_disable(ts);
 
-	err = sysfs_create_group(&dev->kobj, &ad7879_attr_group);
-	if (err)
-		return err;
-
-	err = devm_add_action_or_reset(dev, ad7879_cleanup_sysfs, ts);
+	err = devm_device_add_group(dev, &ad7879_attr_group);
 	if (err)
 		return err;
 
-- 
2.14.2

