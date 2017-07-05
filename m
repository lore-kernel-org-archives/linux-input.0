From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: [PATCH] input: elantech: constify attribute_group structures.
Date: Wed,  5 Jul 2017 16:27:00 +0530
Message-ID: <52e088c00d018502a9b6b7107486611602591a12.1499252216.git.arvind.yadav.cs@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f195.google.com ([209.85.192.195]:34426 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751804AbdGEK5S (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Wed, 5 Jul 2017 06:57:18 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com, benjamin.tissoires@redhat.com, linux@roeck-us.net
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

attribute_groups are not supposed to change at runtime. All functions
working with attribute_groups provided by <linux/sysfs.h> work with const
attribute_group. So mark the non-const structs as const.

File size before:
   text	   data	    bss	    dec	    hex	filename
  16815	   1424	      0	  18239	   473f	drivers/input/mouse/elantech.o

File size After adding 'const':
   text	   data	    bss	    dec	    hex	filename
  16879	   1360	      0	  18239	   473f	drivers/input/mouse/elantech.o

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 drivers/input/mouse/elantech.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/mouse/elantech.c b/drivers/input/mouse/elantech.c
index e73d968..b6fd752 100644
--- a/drivers/input/mouse/elantech.c
+++ b/drivers/input/mouse/elantech.c
@@ -1375,7 +1375,7 @@ static ssize_t elantech_set_int_attr(struct psmouse *psmouse,
 	NULL
 };
 
-static struct attribute_group elantech_attr_group = {
+static const struct attribute_group elantech_attr_group = {
 	.attrs = elantech_attrs,
 };
 
-- 
1.9.1

