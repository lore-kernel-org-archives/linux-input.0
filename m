From: Joonyoung Shim <jy0922.shim@samsung.com>
Subject: [PATCH] Input: wm97xx - use EBUSY instead of EINVAL
Date: Wed, 03 Jun 2009 14:45:15 +0900
Message-ID: <4A260DEB.2040306@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:33870 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750806AbZFCFpc (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 3 Jun 2009 01:45:32 -0400
Received: from epmmp1 (mailout4.samsung.com [203.254.224.34])
 by mailout1.samsung.com
 (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
 with ESMTP id <0KKN0036UENF8S@mailout1.samsung.com> for
 linux-input@vger.kernel.org; Wed, 03 Jun 2009 14:45:15 +0900 (KST)
Received: from TNRNDGASPAPP1.tn.corp.samsungelectronics.net ([165.213.149.150])
 by mmp1.samsung.com (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
 with ESMTPA id <0KKN000JSENF5Q@mmp1.samsung.com> for
 linux-input@vger.kernel.org; Wed, 03 Jun 2009 14:45:15 +0900 (KST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: dmitry.torokhov@gmail.com, broonie@opensource.wolfsonmicro.com

If request_irq() fails, we have to return -EBUSY instead of -EINVAL.

Signed-off-by: Joonyoung Shim <jy0922.shim@samsung.com>
---
 drivers/input/touchscreen/wm97xx-core.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/input/touchscreen/wm97xx-core.c b/drivers/input/touchscreen/wm97xx-core.c
index 2957d48..06cc8cf 100644
--- a/drivers/input/touchscreen/wm97xx-core.c
+++ b/drivers/input/touchscreen/wm97xx-core.c
@@ -375,7 +375,7 @@ static int wm97xx_init_pen_irq(struct wm97xx *wm)
 		dev_err(wm->dev,
 			"Failed to register pen down interrupt, polling");
 		wm->pen_irq = 0;
-		return -EINVAL;
+		return -EBUSY;
 	}
 
 	/* Configure GPIO as interrupt source on WM971x */
-- 
1.6.0.4
