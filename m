From: Nick Dyer <nick@shmanahar.org>
Subject: [PATCH v4 2/7] Input: synaptics-rmi4 - add a couple of debug lines
Date: Wed, 19 Oct 2016 00:26:03 +0100
Message-ID: <1476833168-12880-2-git-send-email-nick@shmanahar.org>
References: <1476833168-12880-1-git-send-email-nick@shmanahar.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from avasout06.plus.net ([212.159.14.18]:46731 "EHLO
        avasout06.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756156AbcJRX0P (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Tue, 18 Oct 2016 19:26:15 -0400
In-Reply-To: <1476833168-12880-1-git-send-email-nick@shmanahar.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Andrew Duggan <aduggan@synaptics.com>
Cc: Chris Healy <cphealy@gmail.com>, Henrik Rydberg <rydberg@bitmath.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Linus Walleij <linus.walleij@linaro.org>, Bjorn Andersson <bjorn.andersson@linaro.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Nick Dyer <nick@shmanahar.org>

Signed-off-by: Nick Dyer <nick@shmanahar.org>
---
 drivers/input/rmi4/rmi_bus.c    | 3 +++
 drivers/input/rmi4/rmi_driver.c | 1 +
 2 files changed, 4 insertions(+)

diff --git a/drivers/input/rmi4/rmi_bus.c b/drivers/input/rmi4/rmi_bus.c
index ef8c747..3c6a1b5 100644
--- a/drivers/input/rmi4/rmi_bus.c
+++ b/drivers/input/rmi4/rmi_bus.c
@@ -230,6 +230,9 @@ int rmi_register_function(struct rmi_function *fn)
 
 void rmi_unregister_function(struct rmi_function *fn)
 {
+	rmi_dbg(RMI_DEBUG_CORE, &fn->dev, "Unregistering F%02X.\n",
+			fn->fd.function_number);
+
 	device_del(&fn->dev);
 	of_node_put(fn->dev.of_node);
 	put_device(&fn->dev);
diff --git a/drivers/input/rmi4/rmi_driver.c b/drivers/input/rmi4/rmi_driver.c
index 63c9e22..adb3ee8 100644
--- a/drivers/input/rmi4/rmi_driver.c
+++ b/drivers/input/rmi4/rmi_driver.c
@@ -722,6 +722,7 @@ static int rmi_initial_reset(struct rmi_device *rmi_dev,
 			return RMI_SCAN_DONE;
 		}
 
+		rmi_dbg(RMI_DEBUG_CORE, &rmi_dev->dev, "Sending reset\n");
 		error = rmi_write_block(rmi_dev, cmd_addr, &cmd_buf, 1);
 		if (error) {
 			dev_err(&rmi_dev->dev,
-- 
2.7.4

