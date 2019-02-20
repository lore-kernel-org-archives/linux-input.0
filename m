From: Aaron Ma <aaron.ma@canonical.com>
Subject: [PATCH 1/2] Input: synaptics-rmi4 - clear irqs before set irqs
Date: Wed, 20 Feb 2019 17:41:59 +0100
Message-ID: <20190220164200.31044-1-aaron.ma@canonical.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Cheiny@synaptics.com, aduggan@synaptics.com, benjamin.tissoires@redhat.com, aaron.ma@canonical.com
List-Id: linux-input@vger.kernel.org

rmi4 got spam data after S3 resume on some ThinkPads.
Then TrackPoint lost when be detected by psmouse.
Clear irqs status before set irqs will make TrackPoint back.

BugLink: https://bugs.launchpad.net/bugs/1791427
Cc: <stable@vger.kernel.org>
Signed-off-by: Aaron Ma <aaron.ma@canonical.com>
---
 drivers/input/rmi4/rmi_driver.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/input/rmi4/rmi_driver.c b/drivers/input/rmi4/rmi_driver.c
index fc3ab93b7aea..20631b272f43 100644
--- a/drivers/input/rmi4/rmi_driver.c
+++ b/drivers/input/rmi4/rmi_driver.c
@@ -374,6 +374,17 @@ static int rmi_driver_set_irq_bits(struct rmi_device *rmi_dev,
 	struct device *dev = &rmi_dev->dev;
 
 	mutex_lock(&data->irq_mutex);
+
+	/* Dummy read in order to clear irqs */
+	error = rmi_read_block(rmi_dev,
+			data->f01_container->fd.data_base_addr + 1,
+			data->irq_status, data->num_of_irq_regs);
+	if (error < 0) {
+		dev_err(dev, "%s: Failed to read interrupt status!",
+							__func__);
+		goto error_unlock;
+	}
+
 	bitmap_or(data->new_irq_mask,
 		  data->current_irq_mask, mask, data->irq_count);
 
-- 
2.17.1
