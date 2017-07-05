From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: [PATCH] input: aiptek: constify attribute_group structures.
Date: Wed,  5 Jul 2017 15:29:23 +0530
Message-ID: <4233d44c46760d064233b0d38372c62d2ac92161.1499247975.git.arvind.yadav.cs@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f196.google.com ([209.85.192.196]:35063 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751672AbdGEJ7l (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Wed, 5 Jul 2017 05:59:41 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

attribute_groups are not supposed to change at runtime. All functions
working with attribute_groups provided by <linux/sysfs.h> work with const
attribute_group. So mark the non-const structs as const.

File size before:
   text	   data	    bss	    dec	    hex	filename
   9941	   1560	      0	  11501	   2ced	drivers/input/tablet/aiptek.o

File size After adding 'const':
   text	   data	    bss	    dec	    hex	filename
  10005	   1496	      0	  11501	   2ced	drivers/input/tablet/aiptek.o

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 drivers/input/tablet/aiptek.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/tablet/aiptek.c b/drivers/input/tablet/aiptek.c
index d67547b..0b55e1f 100644
--- a/drivers/input/tablet/aiptek.c
+++ b/drivers/input/tablet/aiptek.c
@@ -1676,7 +1676,7 @@ static ssize_t show_firmwareCode(struct device *dev, struct device_attribute *at
 	NULL
 };
 
-static struct attribute_group aiptek_attribute_group = {
+static const struct attribute_group aiptek_attribute_group = {
 	.attrs	= aiptek_attributes,
 };
 
-- 
1.9.1

