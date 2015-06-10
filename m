From: Fabian Frederick <fabf@skynet.be>
Subject: [PATCH 1/1 linux-next] Input: cyttsp4 - use swap() in cyttsp4_get_touch()
Date: Wed, 10 Jun 2015 18:31:43 +0200
Message-ID: <1433953903-23653-1-git-send-email-fabf@skynet.be>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailrelay110.isp.belgacom.be ([195.238.20.137]:6993 "EHLO
	mailrelay110.isp.belgacom.be" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933901AbbFJQbw (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 10 Jun 2015 12:31:52 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Julia Lawall <Julia.Lawall@lip6.fr>, Fabian Frederick <fabf@skynet.be>, Ferruh Yigit <fery@cypress.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org

Use kernel.h macro definition.

Thanks to Julia Lawall for Coccinelle scripting support.

Signed-off-by: Fabian Frederick <fabf@skynet.be>
---
 drivers/input/touchscreen/cyttsp4_core.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/input/touchscreen/cyttsp4_core.c b/drivers/input/touchscreen/cyttsp4_core.c
index 568a3d3..5ed3105 100644
--- a/drivers/input/touchscreen/cyttsp4_core.c
+++ b/drivers/input/touchscreen/cyttsp4_core.c
@@ -775,7 +775,6 @@ static void cyttsp4_get_touch(struct cyttsp4_mt_data *md,
 	struct device *dev = &md->input->dev;
 	struct cyttsp4_sysinfo *si = md->si;
 	enum cyttsp4_tch_abs abs;
-	int tmp;
 	bool flipped;
 
 	for (abs = CY_TCH_X; abs < CY_TCH_NUM_ABS; abs++) {
@@ -790,9 +789,7 @@ static void cyttsp4_get_touch(struct cyttsp4_mt_data *md,
 	}
 
 	if (md->pdata->flags & CY_FLAG_FLIP) {
-		tmp = touch->abs[CY_TCH_X];
-		touch->abs[CY_TCH_X] = touch->abs[CY_TCH_Y];
-		touch->abs[CY_TCH_Y] = tmp;
+		swap(touch->abs[CY_TCH_X], touch->abs[CY_TCH_Y]);
 		flipped = true;
 	} else
 		flipped = false;
-- 
2.4.2

