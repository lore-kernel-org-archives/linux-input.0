From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH 06/11] Input: synaptics-rmi4 - add a reset callback
Date: Tue, 23 Jun 2015 15:17:25 -0400
Message-ID: <1435087050-11444-7-git-send-email-benjamin.tissoires@redhat.com>
References: <1435087050-11444-1-git-send-email-benjamin.tissoires@redhat.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:34590 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933124AbbFWTRn (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 23 Jun 2015 15:17:43 -0400
In-Reply-To: <1435087050-11444-1-git-send-email-benjamin.tissoires@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Andrew Duggan <aduggan@synaptics.com>, Christopher Heiny <cheiny@synaptics.com>, Allie Xiong <axiong@synaptics.com>
Cc: Stephen Chandler Paul <cpaul@redhat.com>, benjamin.tissoires@gmail.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Benjamin Tissoires <benjamin.tissoires@redhat.com>

When a device is physically reset, the transport layer may need to reset
its state too and also do extra work to make the device accessible on the
bus.

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---
 drivers/input/rmi4/rmi_bus.h    | 1 +
 drivers/input/rmi4/rmi_driver.c | 8 ++++++++
 2 files changed, 9 insertions(+)

diff --git a/drivers/input/rmi4/rmi_bus.h b/drivers/input/rmi4/rmi_bus.h
index d4cfc85..41d6c3d 100644
--- a/drivers/input/rmi4/rmi_bus.h
+++ b/drivers/input/rmi4/rmi_bus.h
@@ -197,6 +197,7 @@ struct rmi_transport_ops {
 
 	int (*enable_device) (struct rmi_transport_dev *xport);
 	void (*disable_device) (struct rmi_transport_dev *xport);
+	int (*reset)(struct rmi_transport_dev *xport, u16 reset_addr);
 };
 
 /**
diff --git a/drivers/input/rmi4/rmi_driver.c b/drivers/input/rmi4/rmi_driver.c
index 264bc62..81e7c55 100644
--- a/drivers/input/rmi4/rmi_driver.c
+++ b/drivers/input/rmi4/rmi_driver.c
@@ -611,6 +611,14 @@ static int rmi_initial_reset(struct rmi_device *rmi_dev,
 		const struct rmi_device_platform_data *pdata =
 				rmi_get_platform_data(rmi_dev);
 
+		if (rmi_dev->xport->ops->reset) {
+			if (rmi_dev->xport->ops->reset(rmi_dev->xport,
+						       cmd_addr))
+				return error;
+
+			return RMI_SCAN_DONE;
+		}
+
 		error = rmi_write_block(rmi_dev, cmd_addr, &cmd_buf, 1);
 		if (error) {
 			dev_err(&rmi_dev->dev,
-- 
2.4.3

