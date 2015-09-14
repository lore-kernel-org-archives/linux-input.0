From: Fabio Estevam <fabio.estevam@freescale.com>
Subject: [PATCH v2 4/4] Input: imx6ul_tsc - Fix controller name
Date: Mon, 14 Sep 2015 14:00:03 -0300
Message-ID: <1442250003-4040-4-git-send-email-fabio.estevam@freescale.com>
References: <1442250003-4040-1-git-send-email-fabio.estevam@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-by2on0108.outbound.protection.outlook.com ([207.46.100.108]:10464
	"EHLO na01-by2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753972AbbINRAU (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 14 Sep 2015 13:00:20 -0400
In-Reply-To: <1442250003-4040-1-git-send-email-fabio.estevam@freescale.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: haibo.chen@freescale.com, linux-input@vger.kernel.org, Fabio Estevam <fabio.estevam@freescale.com>

We should better write "Touchscreen".

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
Changes since v1:
- Pass 'imx6ul_tsc' in the Subject

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

