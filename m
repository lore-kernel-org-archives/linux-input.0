From: Jiada Wang <jiada_wang@mentor.com>
Subject: [PATCH v1 58/63] Input: atmel_mxt_ts: Remove sysfs attributes during driver detach
Date: Fri, 16 Aug 2019 17:38:25 +0900
Message-ID: <20190816083830.19553-4-jiada_wang@mentor.com>
References: <20190816083830.19553-1-jiada_wang@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190816083830.19553-1-jiada_wang@mentor.com>
Sender: linux-kernel-owner@vger.kernel.org
To: nick@shmanahar.org, dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, jiada_wang@mentor.com, george_davis@mentor.com
List-Id: linux-input@vger.kernel.org

From: Sanjeev Chugh <Sanjeev_Chugh@mentor.com>

This change prevents a scenario when sysfs attributes for Atmel touch
controller driver are being accessed by userland while touch driver
module unloading has already begun. At present, sysfs attribute files
are created at device probe but they are not removed while driver is
being detached.

This change will prevent calls to generic driver layer when the sysfs
driver attributes files are already deleted. Therefore, kernel will not
attempt to invoke driver routines for showing the sysfs atrributes.

Signed-off-by: Sanjeev Chugh <Sanjeev_Chugh@mentor.com>
Signed-off-by: George G. Davis <george_davis@mentor.com>
Signed-off-by: Jiada Wang <jiada_wang@mentor.com>
---
 drivers/input/touchscreen/atmel_mxt_ts.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c b/drivers/input/touchscreen/atmel_mxt_ts.c
index 234e3031ba42..431c2c54eab0 100644
--- a/drivers/input/touchscreen/atmel_mxt_ts.c
+++ b/drivers/input/touchscreen/atmel_mxt_ts.c
@@ -2255,10 +2255,12 @@ static int mxt_update_cfg(struct mxt_data *data, const struct firmware *fw)
 static void mxt_free_input_device(struct mxt_data *data)
 {
 	if (data->input_dev) {
-		struct input_dev *dev = data->input_dev;
+		struct input_dev *input_dev = data->input_dev;
 
 		data->input_dev = NULL;
-		input_unregister_device(dev);
+		sysfs_remove_group(&input_dev->dev.kobj,
+				   &data->gpio_attrs);
+		input_unregister_device(input_dev);
 	}
 }
 
-- 
2.19.2
