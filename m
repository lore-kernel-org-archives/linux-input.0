From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: [PATCH] input: constify attribute_group structures.
Date: Wed,  5 Jul 2017 15:45:25 +0530
Message-ID: <aa330ec69c70699ed3ed0b84f93c4b62518732dc.1499249046.git.arvind.yadav.cs@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f196.google.com ([209.85.192.196]:33308 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751772AbdGEKPp (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Wed, 5 Jul 2017 06:15:45 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

attribute_groups are not supposed to change at runtime. All functions
working with attribute_groups provided by <linux/sysfs.h> work with const
attribute_group. So mark the non-const structs as const.

File size before:
   text	   data	    bss	    dec	    hex	filename
  17755	   1312	     16	  19083	   4a8b	drivers/input/input.o

File size After adding 'const':
   text	   data	    bss	    dec	    hex	filename
  17947	   1120	     16	  19083	   4a8b	drivers/input/input.o

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 drivers/input/input.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/input/input.c b/drivers/input/input.c
index 067d648..4b5fa22 100644
--- a/drivers/input/input.c
+++ b/drivers/input/input.c
@@ -1398,7 +1398,7 @@ static ssize_t input_dev_show_properties(struct device *dev,
 	NULL
 };
 
-static struct attribute_group input_dev_attr_group = {
+static const struct attribute_group input_dev_attr_group = {
 	.attrs	= input_dev_attrs,
 };
 
@@ -1425,7 +1425,7 @@ static DEVICE_ATTR(name, S_IRUGO, input_dev_show_id_##name, NULL)
 	NULL
 };
 
-static struct attribute_group input_dev_id_attr_group = {
+static const struct attribute_group input_dev_id_attr_group = {
 	.name	= "id",
 	.attrs	= input_dev_id_attrs,
 };
@@ -1495,7 +1495,7 @@ static DEVICE_ATTR(bm, S_IRUGO, input_dev_show_cap_##bm, NULL)
 	NULL
 };
 
-static struct attribute_group input_dev_caps_attr_group = {
+static const struct attribute_group input_dev_caps_attr_group = {
 	.name	= "capabilities",
 	.attrs	= input_dev_caps_attrs,
 };
-- 
1.9.1

