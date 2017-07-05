From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: [PATCH] input: synaptics-rmi4: constify attribute_group structures.
Date: Wed,  5 Jul 2017 15:54:00 +0530
Message-ID: <83ad64e25236b6ecba3666c21f74f2fe196a0a39.1499250094.git.arvind.yadav.cs@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f196.google.com ([209.85.192.196]:36402 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751696AbdGEKY2 (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Wed, 5 Jul 2017 06:24:28 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com, benjamin.tissoires@redhat.com
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

attribute_groups are not supposed to change at runtime. All functions
working with attribute_groups provided by <linux/sysfs.h> work with const
attribute_group. So mark the non-const structs as const.

File size before:
   text	   data	    bss	    dec	    hex	filename
   5287	    448	      0	   5735	   1667	drivers/input/rmi4/rmi_f34.o

File size After adding 'const':
   text	   data	    bss	    dec	    hex	filename
   5339	    384	      0	   5723	   165b	drivers/input/rmi4/rmi_f34.o

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 drivers/input/rmi4/rmi_f34.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/rmi4/rmi_f34.c b/drivers/input/rmi4/rmi_f34.c
index b8ee78e..4cfe970 100644
--- a/drivers/input/rmi4/rmi_f34.c
+++ b/drivers/input/rmi4/rmi_f34.c
@@ -516,7 +516,7 @@ static DEVICE_ATTR(update_fw_status, 0444,
 	NULL
 };
 
-static struct attribute_group rmi_firmware_attr_group = {
+static const struct attribute_group rmi_firmware_attr_group = {
 	.attrs = rmi_firmware_attrs,
 };
 
-- 
1.9.1

