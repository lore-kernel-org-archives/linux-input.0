From: Andrew Duggan <aduggan@synaptics.com>
Subject: [PATCH v3 6/8] Input: synaptics-rmi4: Remove unneeded variable
Date: Wed, 13 Jul 2016 23:09:39 -0700
Message-ID: <1468476579-8184-1-git-send-email-aduggan@synaptics.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-input-owner@vger.kernel.org>
Received: from us-mx1.synaptics.com ([192.147.44.131]:59648 "EHLO
	us-mx1.synaptics.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751335AbcGNGJs (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 14 Jul 2016 02:09:48 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Andrew Duggan <aduggan@synaptics.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Vincent Huang <vincent.huang@tw.synaptics.com>, Nick Dyer <nick@shmanahar.org>, Chris Healy <cphealy@gmail.com>

Remove the data_base_addr_offset variable in rmi_f11_attention(). The
f11 data is read as a single block so there is no need to store an offset
to the data address.

Signed-off-by: Andrew Duggan <aduggan@synaptics.com>
Reviewed-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Reviewed-by: Nick Dyer <nick@shmanahar.org>
---
This is the same as the v1 version.

 drivers/input/rmi4/rmi_f11.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/input/rmi4/rmi_f11.c b/drivers/input/rmi4/rmi_f11.c
index e691432..688e604 100644
--- a/drivers/input/rmi4/rmi_f11.c
+++ b/drivers/input/rmi4/rmi_f11.c
@@ -1265,7 +1265,6 @@ static int rmi_f11_attention(struct rmi_function *fn, unsigned long *irq_bits)
 	struct rmi_driver_data *drvdata = dev_get_drvdata(&rmi_dev->dev);
 	struct f11_data *f11 = dev_get_drvdata(&fn->dev);
 	u16 data_base_addr = fn->fd.data_base_addr;
-	u16 data_base_addr_offset = 0;
 	int error;
 
 	if (rmi_dev->xport->attn_data) {
@@ -1275,8 +1274,7 @@ static int rmi_f11_attention(struct rmi_function *fn, unsigned long *irq_bits)
 		rmi_dev->xport->attn_size -= f11->sensor.attn_size;
 	} else {
 		error = rmi_read_block(rmi_dev,
-				data_base_addr + data_base_addr_offset,
-				f11->sensor.data_pkt,
+				data_base_addr, f11->sensor.data_pkt,
 				f11->sensor.pkt_size);
 		if (error < 0)
 			return error;
@@ -1284,7 +1282,6 @@ static int rmi_f11_attention(struct rmi_function *fn, unsigned long *irq_bits)
 
 	rmi_f11_finger_handler(f11, &f11->sensor, irq_bits,
 				drvdata->num_of_irq_regs);
-	data_base_addr_offset += f11->sensor.pkt_size;
 
 	return 0;
 }
-- 
2.5.0

