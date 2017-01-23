From: Bhumika Goyal <bhumirks@gmail.com>
Subject: [PATCH] input: constify device_type structures
Date: Tue, 24 Jan 2017 00:31:07 +0530
Message-ID: <1485198067-14284-1-git-send-email-bhumirks@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f193.google.com ([209.85.192.193]:33489 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751102AbdAWTBT (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Mon, 23 Jan 2017 14:01:19 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: julia.lawall@lip6.fr, dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Bhumika Goyal <bhumirks@gmail.com>

Declare device_type structures as const as they are only stored in the
type field of a device structure. This field is of type const, so add
const to declaration of device_type structures.

File size before:
   text	   data	    bss	    dec	    hex	filename
  17184	   1344	     80	  18608	   48b0	drivers/input/input.o

File size after:
   text	   data	    bss	    dec	    hex	filename
  17248	   1280	     80	  18608	   48b0	drivers/input/input.o

File size before:
   text	   data	    bss	    dec	    hex	filename
   2355	    384	      8	   2747	    abb	drivers/input/rmi4/rmi_bus.o

File size after:
   text	   data	    bss	    dec	    hex	filename
   2483	    264	      8	   2755	    ac3	drivers/input/rmi4/rmi_bus.o

Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>
---
 drivers/input/input.c        | 2 +-
 drivers/input/rmi4/rmi_bus.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/input/input.c b/drivers/input/input.c
index d95c34e..6a75bb0 100644
--- a/drivers/input/input.c
+++ b/drivers/input/input.c
@@ -1749,7 +1749,7 @@ static int input_dev_poweroff(struct device *dev)
 };
 #endif /* CONFIG_PM */
 
-static struct device_type input_dev_type = {
+static const struct device_type input_dev_type = {
 	.groups		= input_dev_attr_groups,
 	.release	= input_dev_release,
 	.uevent		= input_dev_uevent,
diff --git a/drivers/input/rmi4/rmi_bus.c b/drivers/input/rmi4/rmi_bus.c
index 1c40d94..213e318 100644
--- a/drivers/input/rmi4/rmi_bus.c
+++ b/drivers/input/rmi4/rmi_bus.c
@@ -55,7 +55,7 @@ static void rmi_release_device(struct device *dev)
 	kfree(rmi_dev);
 }
 
-static struct device_type rmi_device_type = {
+static const struct device_type rmi_device_type = {
 	.name		= "rmi4_sensor",
 	.release	= rmi_release_device,
 };
@@ -134,7 +134,7 @@ static void rmi_release_function(struct device *dev)
 	kfree(fn);
 }
 
-static struct device_type rmi_function_type = {
+static const struct device_type rmi_function_type = {
 	.name		= "rmi4_function",
 	.release	= rmi_release_function,
 };
-- 
1.9.1

