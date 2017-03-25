From: Nick Dyer <nick@shmanahar.org>
Subject: [PATCH 1/3] Input: synaptics-rmi4 - use dev_driver_string when registering interrupt
Date: Sat, 25 Mar 2017 00:58:58 +0000
Message-ID: <1490403540-31425-2-git-send-email-nick@shmanahar.org>
References: <1490403540-31425-1-git-send-email-nick@shmanahar.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from avasout06.plus.net ([212.159.14.18]:54883 "EHLO
        avasout06.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754414AbdCYBGt (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Fri, 24 Mar 2017 21:06:49 -0400
In-Reply-To: <1490403540-31425-1-git-send-email-nick@shmanahar.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Andrew Duggan <aduggan@synaptics.com>, Christopher Heiny <cheiny@synaptics.com>, linux-input@vger.kernel.org, Chris Healy <cphealy@gmail.com>, Lucas Stach <l.stach@pengutronix.de>, Nick Dyer <nick@shmanahar.org>

When IRQ handling was moved to rmi_driver in 3aeed5b the naming of the
interrupt changed from "rmi4_i2c" to "2-0020" (or similar). This patch restores
the previous behaviour and makes the interrupt easier to identify in
/proc/interrupts.

Signed-off-by: Nick Dyer <nick@shmanahar.org>
---
 drivers/input/rmi4/rmi_driver.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/rmi4/rmi_driver.c b/drivers/input/rmi4/rmi_driver.c
index d64fc92..5b7350f 100644
--- a/drivers/input/rmi4/rmi_driver.c
+++ b/drivers/input/rmi4/rmi_driver.c
@@ -251,7 +251,7 @@ static int rmi_irq_init(struct rmi_device *rmi_dev)
 
 	ret = devm_request_threaded_irq(&rmi_dev->dev, pdata->irq, NULL,
 					rmi_irq_fn, irq_flags | IRQF_ONESHOT,
-					dev_name(rmi_dev->xport->dev),
+					dev_driver_string(rmi_dev->xport->dev),
 					rmi_dev);
 	if (ret < 0) {
 		dev_err(&rmi_dev->dev, "Failed to register interrupt %d\n",
-- 
2.7.4

