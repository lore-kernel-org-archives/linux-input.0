From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: [PATCH] input: ims-pcu: Constify attribute_group structures.
Date: Wed,  5 Jul 2017 16:04:54 +0530
Message-ID: <4d578e7696c17e4ae288707c723fbfb7a48e4ccb.1499250830.git.arvind.yadav.cs@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f194.google.com ([209.85.192.194]:36044 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752345AbdGEKfM (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Wed, 5 Jul 2017 06:35:12 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

attribute_groups are not supposed to change at runtime. All functions
working with attribute_groups provided by <linux/sysfs.h> work with const
attribute_group. So mark the non-const structs as const.

File size before:
   text	   data	    bss	    dec	    hex	filename
  13547	   1600	      0	  15147	   3b2b	drivers/input/misc/ims-pcu.o

File size After adding 'const':
   text	   data	    bss	    dec	    hex	filename
  13675	   1472	      0	  15147	   3b2b	drivers/input/misc/ims-pcu.o

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 drivers/input/misc/ims-pcu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/input/misc/ims-pcu.c b/drivers/input/misc/ims-pcu.c
index f4e8fbe..6bf82ea 100644
--- a/drivers/input/misc/ims-pcu.c
+++ b/drivers/input/misc/ims-pcu.c
@@ -1261,7 +1261,7 @@ static umode_t ims_pcu_is_attr_visible(struct kobject *kobj,
 	return mode;
 }
 
-static struct attribute_group ims_pcu_attr_group = {
+static const struct attribute_group ims_pcu_attr_group = {
 	.is_visible	= ims_pcu_is_attr_visible,
 	.attrs		= ims_pcu_attrs,
 };
@@ -1480,7 +1480,7 @@ struct ims_pcu_ofn_bit_attribute ims_pcu_ofn_attr_##_field = {		\
 	NULL
 };
 
-static struct attribute_group ims_pcu_ofn_attr_group = {
+static const struct attribute_group ims_pcu_ofn_attr_group = {
 	.name	= "ofn",
 	.attrs	= ims_pcu_ofn_attrs,
 };
-- 
1.9.1

