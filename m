From: Matthias Kaehlcke <matthias.list@kaehlcke.net>
Subject: [PATCH] cyttsp: Fix swap of mfg_stat and mfg_cmd registers
Date: Tue, 4 Jun 2013 23:19:30 +0200
Message-ID: <20130604211930.GF3618@raspi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:58676 "EHLO
	relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751272Ab3FDVTf (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 4 Jun 2013 17:19:35 -0400
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Javier Martinez Canillas <javier@dowhile0.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Kevin McNeely <kev@cypress.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

The command and status register in the driver were swapped with
respect to the order specified in the datasheet (CY8CTMA140).
Confirmed with Cypress that the order in the datasheet is correct.

Signed-off-by: Matthias Kaehlcke <matthias@kaehlcke.net>
---
 drivers/input/touchscreen/cyttsp_core.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/touchscreen/cyttsp_core.h b/drivers/input/touchscreen/cyttsp_core.h
index 1aa3c69..f1ebde3 100644
--- a/drivers/input/touchscreen/cyttsp_core.h
+++ b/drivers/input/touchscreen/cyttsp_core.h
@@ -67,8 +67,8 @@ struct cyttsp_xydata {
 /* TTSP System Information interface definition */
 struct cyttsp_sysinfo_data {
 	u8 hst_mode;
-	u8 mfg_cmd;
 	u8 mfg_stat;
+	u8 mfg_cmd;
 	u8 cid[3];
 	u8 tt_undef1;
 	u8 uid[8];
-- 
1.7.10.4

