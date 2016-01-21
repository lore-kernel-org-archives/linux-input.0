From: Oreste Salerno <oreste.salerno@tomtom.com>
Subject: [PATCH v4 2/4] Input: cyttsp - check return value of input_mt_init_slots
Date: Thu, 21 Jan 2016 20:21:14 +0100
Message-ID: <d2d63491f1fe7fc63940f97810dcf40b10906b35.1453403916.git.oreste.salerno@tomtom.com>
References: <cover.1453403916.git.oreste.salerno@tomtom.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail3.tomtom.com ([85.90.76.132]:34439 "EHLO mail3.tomtom.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752537AbcAUTVY (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 21 Jan 2016 14:21:24 -0500
In-Reply-To: <cover.1453403916.git.oreste.salerno@tomtom.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-input@vger.kernel.org, fery@cypress.com, dmitry.torokhov@gmail.com, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, devicetree@vger.kernel.org, oreste.salerno@tomtom.com

Signed-off-by: Oreste Salerno <oreste.salerno@tomtom.com>
---
 drivers/input/touchscreen/cyttsp_core.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/input/touchscreen/cyttsp_core.c b/drivers/input/touchscreen/cyttsp_core.c
index 3c2ee84..10379bc 100644
--- a/drivers/input/touchscreen/cyttsp_core.c
+++ b/drivers/input/touchscreen/cyttsp_core.c
@@ -584,7 +584,11 @@ struct cyttsp *cyttsp_probe(const struct cyttsp_bus_ops *bus_ops,
 	input_set_abs_params(input_dev, ABS_MT_TOUCH_MAJOR,
 			     0, CY_MAXZ, 0, 0);
 
-	input_mt_init_slots(input_dev, CY_MAX_ID, 0);
+	error = input_mt_init_slots(input_dev, CY_MAX_ID, 0);
+	if (error) {
+		dev_err(dev, "Unable to init MT slots.\n");
+		goto err_platform_exit;
+	}
 
 	error = devm_request_threaded_irq(dev, ts->irq, NULL, cyttsp_irq,
 					  IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
-- 
1.9.1

