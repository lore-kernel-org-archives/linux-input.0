From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH] input: touchscreen: use of_property_read_bool()
Date: Mon,  7 Sep 2015 15:01:54 +0800
Message-ID: <1441609314-4859-1-git-send-email-shawn.lin@rock-chips.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.133]:60628 "EHLO
	lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751676AbbIGHEG (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 7 Sep 2015 03:04:06 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Shawn Lin <shawn.lin@rock-chips.com>

Use more compact of_property_read_bool() calls instead of the
of_find_property() calls.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

 drivers/input/touchscreen/mms114.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/input/touchscreen/mms114.c b/drivers/input/touchscreen/mms114.c
index 7cce876..66df77b 100644
--- a/drivers/input/touchscreen/mms114.c
+++ b/drivers/input/touchscreen/mms114.c
@@ -406,9 +406,9 @@ static struct mms114_platform_data *mms114_parse_dt(struct device *dev)
 	of_property_read_u32(np, "moving-threshold",
 				&pdata->moving_threshold);
 
-	if (of_find_property(np, "x-invert", NULL))
+	if (of_property_read_bool(np, "x-invert"))
 		pdata->x_invert = true;
-	if (of_find_property(np, "y-invert", NULL))
+	if (of_property_read_bool(np, "y-invert"))
 		pdata->y_invert = true;
 
 	return pdata;
-- 
2.3.7


