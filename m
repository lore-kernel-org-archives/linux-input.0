From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: [PATCH] input: psmouse: constify attribute_group structures.
Date: Wed,  5 Jul 2017 16:31:45 +0530
Message-ID: <76743bb6b9b654259c6d40deec4515395be85478.1499252427.git.arvind.yadav.cs@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pg0-f68.google.com ([74.125.83.68]:36532 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751696AbdGELCD (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Wed, 5 Jul 2017 07:02:03 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com, benjamin.tissoires@redhat.com
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

attribute_groups are not supposed to change at runtime. All functions
working with attribute_groups provided by <linux/sysfs.h> work with const
attribute_group. So mark the non-const structs as const.

File size before:
   text	   data	    bss	    dec	    hex	filename
  12850	    740	     12	  13602	   3522	drivers/input/mouse/psmouse-base.o

File size After adding 'const':
   text	   data	    bss	    dec	    hex	filename
  12914	    676	     12	  13602	   3522	drivers/input/mouse/psmouse-base.o

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 drivers/input/mouse/psmouse-base.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/mouse/psmouse-base.c b/drivers/input/mouse/psmouse-base.c
index f73b47b..6a5649e 100644
--- a/drivers/input/mouse/psmouse-base.c
+++ b/drivers/input/mouse/psmouse-base.c
@@ -101,7 +101,7 @@
 	NULL
 };
 
-static struct attribute_group psmouse_attribute_group = {
+static const struct attribute_group psmouse_attribute_group = {
 	.attrs	= psmouse_attributes,
 };
 
-- 
1.9.1

