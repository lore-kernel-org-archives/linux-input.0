From: Evan Green <evgreen@chromium.org>
Subject: [PATCH v2] Input: atmel_mxt_ts - Disable IRQ across suspend
Date: Tue, 24 Sep 2019 14:52:38 -0700
Message-ID: <20190924215238.184750-1-evgreen@chromium.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Nick Dyer <nick@shmanahar.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Jongpil Jung <jongpil19.jung@samsung.com>, Furquan Shaikh <furquan@chromium.org>, Rajat Jain <rajatja@chromium.org>, Evan Green <evgreen@chromium.org>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Across suspend and resume, we are seeing error messages like the following:

atmel_mxt_ts i2c-PRP0001:00: __mxt_read_reg: i2c transfer failed (-121)
atmel_mxt_ts i2c-PRP0001:00: Failed to read T44 and T5 (-121)

This occurs because the driver leaves its IRQ enabled. Upon resume, there
is an IRQ pending, but the interrupt is serviced before both the driver and
the underlying I2C bus have been resumed. This causes EREMOTEIO errors.

Disable the IRQ in suspend, and re-enable it on resume. If there are cases
where the driver enters suspend with interrupts disabled, that's a bug we
should fix separately.

Signed-off-by: Evan Green <evgreen@chromium.org>
---

Changes in v2:
 - Enable and disable unconditionally (Dmitry)

 drivers/input/touchscreen/atmel_mxt_ts.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c b/drivers/input/touchscreen/atmel_mxt_ts.c
index 24c4b691b1c9..a58092488679 100644
--- a/drivers/input/touchscreen/atmel_mxt_ts.c
+++ b/drivers/input/touchscreen/atmel_mxt_ts.c
@@ -3155,6 +3155,7 @@ static int __maybe_unused mxt_suspend(struct device *dev)
 		mxt_stop(data);
 
 	mutex_unlock(&input_dev->mutex);
+	disable_irq(data->irq);
 
 	return 0;
 }
@@ -3174,6 +3175,7 @@ static int __maybe_unused mxt_resume(struct device *dev)
 		mxt_start(data);
 
 	mutex_unlock(&input_dev->mutex);
+	enable_irq(data->irq);
 
 	return 0;
 }
-- 
2.21.0
