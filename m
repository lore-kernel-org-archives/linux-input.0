From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: [PATCH] input: elants_i2c: constify attribute_group structures.
Date: Wed,  5 Jul 2017 17:08:02 +0530
Message-ID: <cafea55e0251880fc28742e389055985a35c201c.1499254632.git.arvind.yadav.cs@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f195.google.com ([209.85.192.195]:35116 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751772AbdGELiU (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Wed, 5 Jul 2017 07:38:20 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com, linux@roeck-us.net
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

attribute_groups are not supposed to change at runtime. All functions
working with attribute_groups provided by <linux/sysfs.h> work with const
attribute_group. So mark the non-const structs as const.

File size before:
   text	   data	    bss	    dec	    hex	filename
   9448	   1008	      0	  10456	   28d8	drivers/input/touchscreen/elants_i2c.o

File size After adding 'const':
   text	   data	    bss	    dec	    hex	filename
   9496	    944	      0	  10440	   28c8	drivers/input/touchscreen/elants_i2c.o

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 drivers/input/touchscreen/elants_i2c.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/touchscreen/elants_i2c.c b/drivers/input/touchscreen/elants_i2c.c
index 872750e..0f4cda7 100644
--- a/drivers/input/touchscreen/elants_i2c.c
+++ b/drivers/input/touchscreen/elants_i2c.c
@@ -1066,7 +1066,7 @@ static ssize_t elants_version_attribute_show(struct device *dev,
 	NULL
 };
 
-static struct attribute_group elants_attribute_group = {
+static const struct attribute_group elants_attribute_group = {
 	.attrs = elants_attributes,
 };
 
-- 
1.9.1

