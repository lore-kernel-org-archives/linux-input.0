From: Fabio Estevam <fabio.estevam@freescale.com>
Subject: [PATCH 4/4] Input: touchscreen - Fix controller name
Date: Mon, 14 Sep 2015 13:53:20 -0300
Message-ID: <1442249600-666-4-git-send-email-fabio.estevam@freescale.com>
References: <1442249600-666-1-git-send-email-fabio.estevam@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-bl2on0111.outbound.protection.outlook.com ([65.55.169.111]:24293
	"EHLO na01-bl2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753296AbbINQxe (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 14 Sep 2015 12:53:34 -0400
In-Reply-To: <1442249600-666-1-git-send-email-fabio.estevam@freescale.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: haibo.chen@freescale.com, linux-input@vger.kernel.org, Fabio Estevam <fabio.estevam@freescale.com>

We should better write "Touchscreen".

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 drivers/input/touchscreen/imx6ul_tsc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/touchscreen/imx6ul_tsc.c b/drivers/input/touchscreen/imx6ul_tsc.c
index 67c73f2..8275267 100644
--- a/drivers/input/touchscreen/imx6ul_tsc.c
+++ b/drivers/input/touchscreen/imx6ul_tsc.c
@@ -355,7 +355,7 @@ static int imx6ul_tsc_probe(struct platform_device *pdev)
 	if (!input_dev)
 		return -ENOMEM;
 
-	input_dev->name = "iMX6UL TouchScreen Controller";
+	input_dev->name = "iMX6UL Touchscreen Controller";
 	input_dev->id.bustype = BUS_HOST;
 
 	input_dev->open = imx6ul_tsc_open;
-- 
1.9.1

