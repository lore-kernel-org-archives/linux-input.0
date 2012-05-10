From: Sasha Levin <levinsasha928@gmail.com>
Subject: [PATCH] TWL6040: fix build error
Date: Thu, 10 May 2012 20:44:33 +0200
Message-ID: <1336675473-24774-1-git-send-email-levinsasha928@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:54183 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760754Ab2EJSnb (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 10 May 2012 14:43:31 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com, peter.ujfalusi@ti.com, broonie@opensource.wolfsonicro.com
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Sasha Levin <levinsasha928@gmail.com>

Fixes build error due to missing of_property_read_u32.

Signed-off-by: Sasha Levin <levinsasha928@gmail.com>
---
 drivers/input/misc/twl6040-vibra.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/input/misc/twl6040-vibra.c b/drivers/input/misc/twl6040-vibra.c
index bb134ce..97447ee 100644
--- a/drivers/input/misc/twl6040-vibra.c
+++ b/drivers/input/misc/twl6040-vibra.c
@@ -27,6 +27,7 @@
  */
 #include <linux/module.h>
 #include <linux/platform_device.h>
+#include <linux/of.h>
 #include <linux/of_device.h>
 #include <linux/workqueue.h>
 #include <linux/input.h>
-- 
1.7.8.5

