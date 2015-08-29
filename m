From: Luis de Bethencourt <luis@debethencourt.com>
Subject: [PATCH v2 5/6] input: egalax_ts: Fix module autoload for OF platform
 driver
Date: Sat, 29 Aug 2015 12:48:57 +0200
Message-ID: <20150829104857.GA20914@goodgumbo.baconseed.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wi0-f170.google.com ([209.85.212.170]:38203 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753043AbbH2Ks7 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 29 Aug 2015 06:48:59 -0400
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jingoo Han <jg1.han@samsung.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Javier Martinez Canillas <javier@osg.samsung.com>

This platform driver has a OF device ID table but the OF module
alias information is not created so module autoloading won't work.

Signed-off-by: Luis de Bethencourt <luis@debethencourt.com>
---
 drivers/input/touchscreen/egalax_ts.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/input/touchscreen/egalax_ts.c b/drivers/input/touchscreen/egalax_ts.c
index 4c56299..7229858 100644
--- a/drivers/input/touchscreen/egalax_ts.c
+++ b/drivers/input/touchscreen/egalax_ts.c
@@ -264,6 +264,7 @@ static const struct of_device_id egalax_ts_dt_ids[] = {
 	{ .compatible = "eeti,egalax_ts" },
 	{ /* sentinel */ }
 };
+MODULE_DEVICE_TABLE(of, egalax_ts_dt_ids);
 
 static struct i2c_driver egalax_ts_driver = {
 	.driver = {
-- 
2.4.6

