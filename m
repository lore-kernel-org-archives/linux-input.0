From: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
Subject: [PATCH] input: wm97xx: adapt parameters to tosa touchscreen.
Date: Fri, 24 Oct 2014 21:18:06 +0400
Message-ID: <1414171086-18330-1-git-send-email-dbaryshkov@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wg0-f41.google.com ([74.125.82.41]:44527 "EHLO
	mail-wg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756653AbaJXRSR (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 24 Oct 2014 13:18:17 -0400
Received: by mail-wg0-f41.google.com with SMTP id b13so1581315wgh.24
        for <linux-input@vger.kernel.org>; Fri, 24 Oct 2014 10:18:16 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: patches@opensource.wolfsonmicro.com, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lrg@slimlogic.co.uk>, Dmitry Eremin-Solenikov <dmitry_eremin@mentor.com>

From: Dmitry Eremin-Solenikov <dmitry_eremin@mentor.com>

Sharp SL-6000 (tosa) touchscreen needs wider limits to properly map all
points on the screen. Expand ranges in abs_x and abs_y arrays according
to the touchscreen area.

Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
---
 drivers/input/touchscreen/wm97xx-core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/input/touchscreen/wm97xx-core.c b/drivers/input/touchscreen/wm97xx-core.c
index d0ef91f..b1ae779 100644
--- a/drivers/input/touchscreen/wm97xx-core.c
+++ b/drivers/input/touchscreen/wm97xx-core.c
@@ -70,11 +70,11 @@
  * Documentation/input/input-programming.txt for more details.
  */
 
-static int abs_x[3] = {350, 3900, 5};
+static int abs_x[3] = {150, 4000, 5};
 module_param_array(abs_x, int, NULL, 0);
 MODULE_PARM_DESC(abs_x, "Touchscreen absolute X min, max, fuzz");
 
-static int abs_y[3] = {320, 3750, 40};
+static int abs_y[3] = {200, 4000, 40};
 module_param_array(abs_y, int, NULL, 0);
 MODULE_PARM_DESC(abs_y, "Touchscreen absolute Y min, max, fuzz");
 
-- 
2.1.1

