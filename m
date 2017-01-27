From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] Input: synaptics-rmi4 - Fix reversed tests
Date: Fri, 27 Jan 2017 13:11:15 +0100
Message-ID: <20170127121115.19427-1-christophe.jaillet@wanadoo.fr>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: dmitry.torokhov@gmail.com, benjamin.tissoires@redhat.com, aduggan@synaptics.com, nick@shmanahar.org, yamada.masahiro@socionext.com
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org, Christophe JAILLET <christophe.jaillet@wanadoo.fr>
List-Id: linux-input@vger.kernel.org

These tests looks reversed.
A warning should be displayed if an error is returned, not on success.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/input/rmi4/rmi_driver.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/input/rmi4/rmi_driver.c b/drivers/input/rmi4/rmi_driver.c
index 11447ab1055c..bf5c36e229ba 100644
--- a/drivers/input/rmi4/rmi_driver.c
+++ b/drivers/input/rmi4/rmi_driver.c
@@ -901,7 +901,7 @@ void rmi_enable_irq(struct rmi_device *rmi_dev, bool clear_wake)
 	data->enabled = true;
 	if (clear_wake && device_may_wakeup(rmi_dev->xport->dev)) {
 		retval = disable_irq_wake(irq);
-		if (!retval)
+		if (retval)
 			dev_warn(&rmi_dev->dev,
 				 "Failed to disable irq for wake: %d\n",
 				 retval);
@@ -936,7 +936,7 @@ void rmi_disable_irq(struct rmi_device *rmi_dev, bool enable_wake)
 	disable_irq(irq);
 	if (enable_wake && device_may_wakeup(rmi_dev->xport->dev)) {
 		retval = enable_irq_wake(irq);
-		if (!retval)
+		if (retval)
 			dev_warn(&rmi_dev->dev,
 				 "Failed to enable irq for wake: %d\n",
 				 retval);
-- 
2.9.3
