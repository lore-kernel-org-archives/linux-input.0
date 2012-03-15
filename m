From: Philipp Zabel <pzabel@gmx.de>
Subject: [PATCH] Input: navpoint: add clk_prepare/clk_unprepare calls
Date: Thu, 15 Mar 2012 19:09:38 +0100
Message-ID: <1331834978.14662.1.camel@flow>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailout-de.gmx.net ([213.165.64.22]:53707 "HELO
	mailout-de.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1754499Ab2COSJl (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 15 Mar 2012 14:09:41 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Paul Parsons <lost.distance@yahoo.com>

This patch adds clk_prepare/clk_unprepare calls to the navpoint
driver by using the helper functions clk_prepare_enable and
clk_disable_unprepare.

Signed-off-by: Philipp Zabel <philipp.zabel@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Paul Parsons <lost.distance@yahoo.com>
---
 drivers/input/mouse/navpoint.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/input/mouse/navpoint.c b/drivers/input/mouse/navpoint.c
index 253ec18..cb0d3b1 100644
--- a/drivers/input/mouse/navpoint.c
+++ b/drivers/input/mouse/navpoint.c
@@ -225,7 +225,7 @@ static int navpoint_suspend(struct device *dev)
 
 	pxa_ssp_write_reg(ssp, SSCR0, 0);
 
-	clk_disable(ssp->clk);
+	clk_disable_unprepare(ssp->clk);
 
 	return 0;
 }
@@ -236,7 +236,7 @@ static int navpoint_resume(struct device *dev)
 	struct ssp_device *ssp = drv_data->ssp;
 	int timeout;
 
-	clk_enable(ssp->clk);
+	clk_prepare_enable(ssp->clk);
 
 	pxa_ssp_write_reg(ssp, SSCR1, sscr1);
 	pxa_ssp_write_reg(ssp, SSSR, sssr);
-- 
1.7.9.1


