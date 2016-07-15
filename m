From: Peter Chen <peter.chen@nxp.com>
Subject: [PATCH 1/1] input: touchscreen: ts4800-ts: add missing of_node_put after calling of_parse_phandle
Date: Fri, 15 Jul 2016 17:32:05 +0800
Message-ID: <1468575125-24920-1-git-send-email-peter.chen@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-by2nam01on0052.outbound.protection.outlook.com ([104.47.34.52]:1060
	"EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751811AbcGOKN5 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 15 Jul 2016 06:13:57 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: Peter Chen <peter.chen@nxp.com>, linux-input@vger.kernel.org, Rob Herring <robh@kernel.org>, Damien Riegel <damien.riegel@savoirfairelinux.com>

of_node_put needs to be called when the device node which is got
from of_parse_phandle has finished using.

Cc: linux-input@vger.kernel.org
Cc: Rob Herring <robh@kernel.org>
Cc: Damien Riegel <damien.riegel@savoirfairelinux.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Peter Chen <peter.chen@nxp.com>
---
 drivers/input/touchscreen/ts4800-ts.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/input/touchscreen/ts4800-ts.c b/drivers/input/touchscreen/ts4800-ts.c
index 3c3dd78..8f27ad8 100644
--- a/drivers/input/touchscreen/ts4800-ts.c
+++ b/drivers/input/touchscreen/ts4800-ts.c
@@ -135,6 +135,7 @@ static int ts4800_parse_dt(struct platform_device *pdev,
 	ts->bit = BIT(bit);
 
 	ts->regmap = syscon_node_to_regmap(syscon_np);
+	of_node_put(syscon_np);
 	if (IS_ERR(ts->regmap)) {
 		dev_err(dev, "cannot get parent's regmap\n");
 		return PTR_ERR(ts->regmap);
-- 
1.9.1

