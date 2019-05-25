From: YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] Input: synaptics-rmi4 - Remove set but not used variable 'sensor_flags'
Date: Sat, 25 May 2019 22:11:19 +0800
Message-ID: <20190525141119.11852-1-yuehaibing@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: dmitry.torokhov@gmail.com, cheiny@synaptics.com, nick@shmanahar.org
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, YueHaibing <yuehaibing@huawei.com>
List-Id: linux-input@vger.kernel.org

Fixes gcc '-Wunused-but-set-variable' warning:

drivers/input/rmi4/rmi_f12.c: In function rmi_f12_read_sensor_tuning:
drivers/input/rmi4/rmi_f12.c:76:6: warning: variable sensor_flags set but not used [-Wunused-but-set-variable]

It's not used since introduction in
commit b43d2c1e9353 ("Input: synaptics-rmi4 - add support for F12")

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/input/rmi4/rmi_f12.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/input/rmi4/rmi_f12.c b/drivers/input/rmi4/rmi_f12.c
index 5c7f48915779..72b5498e1a9f 100644
--- a/drivers/input/rmi4/rmi_f12.c
+++ b/drivers/input/rmi4/rmi_f12.c
@@ -73,7 +73,6 @@ static int rmi_f12_read_sensor_tuning(struct f12_data *f12)
 	int pitch_y = 0;
 	int rx_receivers = 0;
 	int tx_receivers = 0;
-	int sensor_flags = 0;
 
 	item = rmi_get_register_desc_item(&f12->control_reg_desc, 8);
 	if (!item) {
@@ -129,10 +128,8 @@ static int rmi_f12_read_sensor_tuning(struct f12_data *f12)
 		offset += 2;
 	}
 
-	if (rmi_register_desc_has_subpacket(item, 4)) {
-		sensor_flags = buf[offset];
+	if (rmi_register_desc_has_subpacket(item, 4))
 		offset += 1;
-	}
 
 	sensor->x_mm = (pitch_x * rx_receivers) >> 12;
 	sensor->y_mm = (pitch_y * tx_receivers) >> 12;
-- 
2.17.1
