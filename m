From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: [PATCH] input: synaptics-rmi4: Constify attribute_group structures.
Date: Wed,  5 Jul 2017 16:00:30 +0530
Message-ID: <910bd7f4f3001b8c1b3ad7d40eb6619c091b2b29.1499250565.git.arvind.yadav.cs@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pg0-f65.google.com ([74.125.83.65]:33791 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751626AbdGEKat (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Wed, 5 Jul 2017 06:30:49 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com, benjamin.tissoires@redhat.com
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

attribute_groups are not supposed to change at runtime. All functions
working with attribute_groups provided by <linux/sysfs.h> work with const
attribute_group. So mark the non-const structs as const.

File size before:
   text	   data	    bss	    dec	    hex	filename
   4777	    480	      0	   5257	   1489	drivers/input/rmi4/rmi_f01.o

File size After adding 'const':
   text	   data	    bss	    dec	    hex	filename
   4817	    416	      0	   5233	   1471	drivers/input/rmi4/rmi_f01.o

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 drivers/input/rmi4/rmi_f01.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/rmi4/rmi_f01.c b/drivers/input/rmi4/rmi_f01.c
index 7f7e917..aa1aabf 100644
--- a/drivers/input/rmi4/rmi_f01.c
+++ b/drivers/input/rmi4/rmi_f01.c
@@ -334,7 +334,7 @@ static ssize_t rmi_driver_package_id_show(struct device *dev,
 	NULL
 };
 
-static struct attribute_group rmi_f01_attr_group = {
+static const struct attribute_group rmi_f01_attr_group = {
 	.attrs = rmi_f01_attrs,
 };
 
-- 
1.9.1

