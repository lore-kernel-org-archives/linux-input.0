From: Andrew Duggan <aduggan@synaptics.com>
Subject: [PATCH 04/26] Input: synaptics-rmi4 - prevent oopses when irq arrives while the device is not bound
Date: Thu, 5 Nov 2015 15:34:04 -0800
Message-ID: <1446766466-30043-5-git-send-email-aduggan@synaptics.com>
References: <1446766466-30043-1-git-send-email-aduggan@synaptics.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1446766466-30043-1-git-send-email-aduggan@synaptics.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Benjamin Tissoires <benjamin.tissoires@gmail.com>, Christopher Heiny <cheiny@synaptics.com>, Stephen Chandler Paul <cpaul@redhat.com>
List-Id: linux-input@vger.kernel.org

From: Benjamin Tissoires <benjamin.tissoires@redhat.com>

If the device has been registered but is not populated, we should not
process any incoming interrupt.
Make sure the pointers we are following are valid.

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Tested-by: Andrew Duggan <aduggan@synaptics.com>
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
2.1.4
