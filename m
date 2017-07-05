From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: [PATCH] input: serio: constify attribute_group structures.
Date: Wed,  5 Jul 2017 15:12:53 +0530
Message-ID: <4448ab728b41d7e7648777cd90bcd3096da711bf.1499247619.git.arvind.yadav.cs@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pg0-f66.google.com ([74.125.83.66]:34971 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751626AbdGEJnM (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Wed, 5 Jul 2017 05:43:12 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com, benjamin.tissoires@redhat.com
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

attribute_groups are not supposed to change at runtime. All functions
working with attribute_groups provided by <linux/sysfs.h> work with const
attribute_group. So mark the non-const structs as const.

File size before:
   text	   data	    bss	    dec	    hex	filename
   6862	   1008	      4	   7874	   1ec2	drivers/input/serio/serio.o

File size After adding 'const':
   text	   data	    bss	    dec	    hex	filename
   6990	    880	      4	   7874	   1ec2	drivers/input/serio/serio.o

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 drivers/input/serio/serio.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/input/serio/serio.c b/drivers/input/serio/serio.c
index 30d6230..24a90c8 100644
--- a/drivers/input/serio/serio.c
+++ b/drivers/input/serio/serio.c
@@ -469,7 +469,7 @@ static ssize_t firmware_id_show(struct device *dev, struct device_attribute *att
 	NULL
 };
 
-static struct attribute_group serio_id_attr_group = {
+static const struct attribute_group serio_id_attr_group = {
 	.name	= "id",
 	.attrs	= serio_device_id_attrs,
 };
@@ -489,7 +489,7 @@ static ssize_t firmware_id_show(struct device *dev, struct device_attribute *att
 	NULL
 };
 
-static struct attribute_group serio_device_attr_group = {
+static const struct attribute_group serio_device_attr_group = {
 	.attrs	= serio_device_attrs,
 };
 
-- 
1.9.1

