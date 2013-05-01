From: Heiko Abraham <abrahamh@web.de>
Subject: [PATCH 1/1] Input: egalax_ts - ABS_MT_POSITION_Y not reported well
Date: Wed,  1 May 2013 12:45:17 -0700
Message-ID: <1367437517-14193-1-git-send-email-abrahamh@web.de>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mout.web.de ([212.227.17.11]:57865 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756186Ab3EATpl (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 1 May 2013 15:45:41 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, Heiko Abraham <abrahamh@web.de>

The egalax_ts touchscreen modul not report ABS_MT_POSITION_Y proper.
As result it may be, that upper software levels only receive x coordinates well.

Signed-off-by: Heiko Abraham <abrahamh@web.de>
---
 drivers/input/touchscreen/egalax_ts.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/input/touchscreen/egalax_ts.c b/drivers/input/touchscreen/egalax_ts.c
index 17c9097..39f3df8 100644
--- a/drivers/input/touchscreen/egalax_ts.c
+++ b/drivers/input/touchscreen/egalax_ts.c
@@ -216,7 +216,7 @@ static int egalax_ts_probe(struct i2c_client *client,
 	input_set_abs_params(input_dev,
 			     ABS_MT_POSITION_X, 0, EGALAX_MAX_X, 0, 0);
 	input_set_abs_params(input_dev,
-			     ABS_MT_POSITION_X, 0, EGALAX_MAX_Y, 0, 0);
+			     ABS_MT_POSITION_Y, 0, EGALAX_MAX_Y, 0, 0);
 	input_mt_init_slots(input_dev, MAX_SUPPORT_POINTS, 0);
 
 	input_set_drvdata(input_dev, ts);
-- 
1.7.0.4

