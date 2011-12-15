From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH 3/3] input: mpu3050: Ensure we enable interrupts
Date: Thu, 15 Dec 2011 22:18:59 +0000
Message-ID: <20111215221857.8657.57262.stgit@bob.linux.org.uk>
References: <20111215221732.8657.63987.stgit@bob.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:58665 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759422Ab1LOWU2 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 15 Dec 2011 17:20:28 -0500
In-Reply-To: <20111215221732.8657.63987.stgit@bob.linux.org.uk>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org

From: Heikki Krogerus <heikki.krogerus@linux.intel.com>

This also changes the devname parameter delivered to
request_threaded_irq() from "mpu_int" to "mpu3050".

Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Alan Cox <alan@linux.intel.com>
---

 drivers/input/misc/mpu3050.c |   10 +++++++++-
 1 files changed, 9 insertions(+), 1 deletions(-)


diff --git a/drivers/input/misc/mpu3050.c b/drivers/input/misc/mpu3050.c
index 89c7160..cf42c78 100644
--- a/drivers/input/misc/mpu3050.c
+++ b/drivers/input/misc/mpu3050.c
@@ -437,12 +437,20 @@ static int __devinit mpu3050_probe(struct i2c_client *client,
 		error = request_threaded_irq(client->irq,
 				NULL, mpu3050_interrupt_thread,
 				IRQF_TRIGGER_RISING,
-				"mpu_int", sensor);
+				"mpu3050", sensor);
 		if (error) {
 			dev_err(&client->dev, "can't get IRQ %d, error %d\n",
 					client->irq, error);
 			goto err_pm_set_suspended;
 		}
+
+		/* Enable interrupts */
+		i2c_smbus_write_byte_data(sensor->client, MPU3050_INT_CFG,
+					MPU3050_LATCH_INT_EN
+					| MPU3050_RAW_RDY_EN
+					| MPU3050_MPU_RDY_EN);
+		if (ret < 0)
+			goto err_free_irq;
 	} else {
 		error = mpu3050_create_polled_idev(sensor);
 		if (error) {

