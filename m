From: Oreste Salerno <oreste.salerno@tomtom.com>
Subject: [PATCH v5 2/4] Input: cyttsp - check return value of input_mt_init_slots
Date: Thu, 21 Jan 2016 23:21:30 +0100
Message-ID: <c6915f2eed9c09d520eb14f15ac0145b248ece66.1453414661.git.oreste.salerno@tomtom.com>
References: <cover.1453414661.git.oreste.salerno@tomtom.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail3.tomtom.com ([85.90.76.132]:51281 "EHLO mail3.tomtom.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751103AbcAUWVl (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 21 Jan 2016 17:21:41 -0500
In-Reply-To: <cover.1453414661.git.oreste.salerno@tomtom.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-input@vger.kernel.org, fery@cypress.com, dmitry.torokhov@gmail.com, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, devicetree@vger.kernel.org, oreste.salerno@tomtom.com

Signed-off-by: Oreste Salerno <oreste.salerno@tomtom.com>
---
 drivers/input/touchscreen/cyttsp_core.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/input/touchscreen/cyttsp_core.c b/drivers/input/touchscreen/cyttsp_core.c
index e6437f2..c269a19 100644
--- a/drivers/input/touchscreen/cyttsp_core.c
+++ b/drivers/input/touchscreen/cyttsp_core.c
@@ -594,7 +594,11 @@ struct cyttsp *cyttsp_probe(const struct cyttsp_bus_ops *bus_ops,
 	input_set_abs_params(input_dev, ABS_MT_TOUCH_MAJOR,
 			     0, CY_MAXZ, 0, 0);
 
-	input_mt_init_slots(input_dev, CY_MAX_ID, 0);
+	error = input_mt_init_slots(input_dev, CY_MAX_ID, 0);
+	if (error) {
+		dev_err(dev, "Unable to init MT slots.\n");
+		return ERR_PTR(error);
+	}
 
 	error = devm_request_threaded_irq(dev, ts->irq, NULL, cyttsp_irq,
 					  IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
-- 
1.9.1

