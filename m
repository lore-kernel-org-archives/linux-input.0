From: Benoit Parrot <bparrot@ti.com>
Subject: [Patch 1/1] Input: edt-ft5x06 - disable irq handling during suspend
Date: Fri, 21 Jun 2019 13:51:24 -0500
Message-ID: <20190621185124.28966-1-bparrot@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Henrik Rydberg <rydberg@bitmath.org>, Marco Felsch <m.felsch@pengutronix.de>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Benoit Parrot <bparrot@ti.com>
List-Id: linux-input@vger.kernel.org

As a wakeup source when the system is in suspend there is little point
trying to access a register across the i2c bus as it is probably still
inactive. We need to prevent the irq handler from being called during
suspend.

Without this modification upon wakeup you would see the following kernel
error:

[ 118.733717] PM: Wakeup source GPIO0
[ 118.751933] edt_ft5x06 1-0038: Unable to fetch data, error: -13

Signed-off-by: Benoit Parrot <bparrot@ti.com>
---
 drivers/input/touchscreen/edt-ft5x06.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/input/touchscreen/edt-ft5x06.c b/drivers/input/touchscreen/edt-ft5x06.c
index c639ebce914c..c885bfe783a4 100644
--- a/drivers/input/touchscreen/edt-ft5x06.c
+++ b/drivers/input/touchscreen/edt-ft5x06.c
@@ -1200,8 +1200,10 @@ static int __maybe_unused edt_ft5x06_ts_suspend(struct device *dev)
 {
 	struct i2c_client *client = to_i2c_client(dev);
 
-	if (device_may_wakeup(dev))
+	if (device_may_wakeup(dev)) {
 		enable_irq_wake(client->irq);
+		disable_irq(client->irq);
+	}
 
 	return 0;
 }
@@ -1210,8 +1212,10 @@ static int __maybe_unused edt_ft5x06_ts_resume(struct device *dev)
 {
 	struct i2c_client *client = to_i2c_client(dev);
 
-	if (device_may_wakeup(dev))
+	if (device_may_wakeup(dev)) {
 		disable_irq_wake(client->irq);
+		enable_irq(client->irq);
+	}
 
 	return 0;
 }
-- 
2.17.1
