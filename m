From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: [PATCH] input: yealink: Constify attribute_group structures.
Date: Wed,  5 Jul 2017 16:11:11 +0530
Message-ID: <36c5479a9df7ac0ef16cfd5556c96f894d1a927a.1499251200.git.arvind.yadav.cs@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pg0-f68.google.com ([74.125.83.68]:35952 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752472AbdGEKl3 (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Wed, 5 Jul 2017 06:41:29 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com, Henk.Vergonet@gmail.com
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, usbb2k-api-dev@nongnu.org

attribute_groups are not supposed to change at runtime. All functions
working with attribute_groups provided by <linux/sysfs.h> work with const
attribute_group. So mark the non-const structs as const.

File size before:
   text	   data	    bss	    dec	    hex	filename
   6039	    944	      0	   6983	   1b47	drivers/input/misc/yealink.o

File size After adding 'const':
   text	   data	    bss	    dec	    hex	filename
   6103	    880	      0	   6983	   1b47	drivers/input/misc/yealink.o

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 drivers/input/misc/yealink.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/misc/yealink.c b/drivers/input/misc/yealink.c
index 6e7ff95..a1e0ff5 100644
--- a/drivers/input/misc/yealink.c
+++ b/drivers/input/misc/yealink.c
@@ -798,7 +798,7 @@ static ssize_t store_ringtone(struct device *dev,
 	NULL
 };
 
-static struct attribute_group yld_attr_group = {
+static const struct attribute_group yld_attr_group = {
 	.attrs = yld_attributes
 };
 
-- 
1.9.1

