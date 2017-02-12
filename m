From: Nick Dyer <nick@shmanahar.org>
Subject: [PATCH] Input: synaptics-rmi4 - use dev_driver_string when registering interrupt
Date: Sun, 12 Feb 2017 23:11:28 +0000
Message-ID: <1486941088-3730-1-git-send-email-nick@shmanahar.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from avasout05.plus.net ([84.93.230.250]:52881 "EHLO
        avasout05.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751000AbdBLXLm (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Sun, 12 Feb 2017 18:11:42 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Andrew Duggan <aduggan@synaptics.com>, Christopher Heiny <cheiny@synaptics.com>, linux-input@vger.kernel.org, Chris Healy <cphealy@gmail.com>, Nick Dyer <nick@shmanahar.org>

When IRQ handling was moved to rmi_driver in 3aeed5b the naming of the
interrupt changed from "rmi4_i2c" to "2-0020" (or similar). This patch restores
the previous behaviour and makes the interrupt easier to identify in
/proc/interrupts.

Signed-off-by: Nick Dyer <nick@shmanahar.org>
---
 drivers/input/rmi4/rmi_driver.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/rmi4/rmi_driver.c b/drivers/input/rmi4/rmi_driver.c
index 23d705b..e3a6c7c 100644
--- a/drivers/input/rmi4/rmi_driver.c
+++ b/drivers/input/rmi4/rmi_driver.c
@@ -252,7 +252,7 @@ static int rmi_irq_init(struct rmi_device *rmi_dev)
 
 	ret = devm_request_threaded_irq(&rmi_dev->dev, pdata->irq, NULL,
 					rmi_irq_fn, irq_flags | IRQF_ONESHOT,
-					dev_name(rmi_dev->xport->dev),
+					dev_driver_string(rmi_dev->xport->dev),
 					rmi_dev);
 	if (ret < 0) {
 		dev_err(&rmi_dev->dev, "Failed to register interrupt %d\n",
-- 
2.7.4

