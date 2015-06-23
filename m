From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH 04/11] Input: synaptics-rmi4 - prevent oopses when irq arrives while the device is not bound
Date: Tue, 23 Jun 2015 15:17:23 -0400
Message-ID: <1435087050-11444-5-git-send-email-benjamin.tissoires@redhat.com>
References: <1435087050-11444-1-git-send-email-benjamin.tissoires@redhat.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:60431 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933010AbbFWTRl (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 23 Jun 2015 15:17:41 -0400
In-Reply-To: <1435087050-11444-1-git-send-email-benjamin.tissoires@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Andrew Duggan <aduggan@synaptics.com>, Christopher Heiny <cheiny@synaptics.com>, Allie Xiong <axiong@synaptics.com>
Cc: Stephen Chandler Paul <cpaul@redhat.com>, benjamin.tissoires@gmail.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Benjamin Tissoires <benjamin.tissoires@redhat.com>

If the device has been registered but is not populated, we should not
process any incoming interrupt.
Make sure the pointers we are following are valid.

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---
 drivers/input/rmi4/rmi_driver.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/input/rmi4/rmi_driver.c b/drivers/input/rmi4/rmi_driver.c
index 2fdc7e8..fe5f2f9 100644
--- a/drivers/input/rmi4/rmi_driver.c
+++ b/drivers/input/rmi4/rmi_driver.c
@@ -279,6 +279,9 @@ int rmi_process_interrupt_requests(struct rmi_device *rmi_dev)
 	struct rmi_function *entry;
 	int error;
 
+	if (!data || !data->f01_container || !data->irq_status)
+		return 0;
+
 	error = rmi_read_block(rmi_dev,
 				data->f01_container->fd.data_base_addr + 1,
 				data->irq_status, data->num_of_irq_regs);
-- 
2.4.3

