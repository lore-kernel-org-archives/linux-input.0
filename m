From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: [PATCH] input: ads7846: constify attribute_group structures.
Date: Wed,  5 Jul 2017 17:11:22 +0530
Message-ID: <45e77f7a38336caf2d91814f4926c35b94577109.1499254838.git.arvind.yadav.cs@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pg0-f65.google.com ([74.125.83.65]:33320 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750909AbdGELlk (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Wed, 5 Jul 2017 07:41:40 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com, linux@roeck-us.net
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

attribute_groups are not supposed to change at runtime. All functions
working with attribute_groups provided by <linux/sysfs.h> work with const
attribute_group. So mark the non-const structs as const.

File size before:
   text	   data	    bss	    dec	    hex	filename
   9086	    624	      0	   9710	   25ee	drivers/input/touchscreen/ads7846.o

File size After adding 'const':
   text	   data	    bss	    dec	    hex	filename
   9198	    496	      0	   9694	   25de	drivers/input/touchscreen/ads7846.o

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 drivers/input/touchscreen/ads7846.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/input/touchscreen/ads7846.c b/drivers/input/touchscreen/ads7846.c
index 735a0be..a2f45ae 100644
--- a/drivers/input/touchscreen/ads7846.c
+++ b/drivers/input/touchscreen/ads7846.c
@@ -499,7 +499,7 @@ static umode_t ads7846_is_visible(struct kobject *kobj, struct attribute *attr,
 	NULL,
 };
 
-static struct attribute_group ads7846_attr_group = {
+static const struct attribute_group ads7846_attr_group = {
 	.attrs = ads7846_attributes,
 	.is_visible = ads7846_is_visible,
 };
@@ -599,7 +599,7 @@ static ssize_t ads7846_disable_store(struct device *dev,
 	NULL,
 };
 
-static struct attribute_group ads784x_attr_group = {
+static const struct attribute_group ads784x_attr_group = {
 	.attrs = ads784x_attributes,
 };
 
-- 
1.9.1

