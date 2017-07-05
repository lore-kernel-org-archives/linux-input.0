From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: [PATCH] input: raydium_i2c_ts: constify attribute_group structures.
Date: Wed,  5 Jul 2017 17:04:04 +0530
Message-ID: <d3542b756e145b079bd76cbba3705ab8bd524ace.1499254387.git.arvind.yadav.cs@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f193.google.com ([209.85.192.193]:36162 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750909AbdGELe0 (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Wed, 5 Jul 2017 07:34:26 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com, linux@roeck-us.net
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

attribute_groups are not supposed to change at runtime. All functions
working with attribute_groups provided by <linux/sysfs.h> work with const
attribute_group. So mark the non-const structs as const.

File size before:
   text	   data	    bss	    dec	    hex	filename
   7801	    560	      0	   8361	   20a9	drivers/input/touchscreen/raydium_i2c_ts.o

File size After adding 'const':
   text	   data	    bss	    dec	    hex	filename
   7849	    496	      0	   8345	   2099	drivers/input/touchscreen/raydium_i2c_ts.o

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 drivers/input/touchscreen/raydium_i2c_ts.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/touchscreen/raydium_i2c_ts.c b/drivers/input/touchscreen/raydium_i2c_ts.c
index 1252e49..4f1d3fd 100644
--- a/drivers/input/touchscreen/raydium_i2c_ts.c
+++ b/drivers/input/touchscreen/raydium_i2c_ts.c
@@ -939,7 +939,7 @@ static ssize_t raydium_i2c_calibrate_store(struct device *dev,
 	NULL
 };
 
-static struct attribute_group raydium_i2c_attribute_group = {
+static const struct attribute_group raydium_i2c_attribute_group = {
 	.attrs = raydium_i2c_attributes,
 };
 
-- 
1.9.1

