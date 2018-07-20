From: Nick Dyer <nick@shmanahar.org>
Subject: [PATCH v1 04/10] Input: atmel_mxt_ts - remove unnecessary debug on ENOMEM
Date: Fri, 20 Jul 2018 22:51:16 +0100
Message-ID: <20180720215122.23558-4-nick@shmanahar.org>
References: <20180720215122.23558-1-nick@shmanahar.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180720215122.23558-1-nick@shmanahar.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, Chris Healy <cphealy@gmail.com>, Nikita Yushchenko <nikita.yoush@cogentembedded.com>, Lucas Stach <l.stach@pengutronix.de>, Nick Dyer <nick.dyer@itdev.co.uk>
List-Id: linux-input@vger.kernel.org

From: Nick Dyer <nick.dyer@itdev.co.uk>

Signed-off-by: Nick Dyer <nick.dyer@itdev.co.uk>
---
 drivers/input/touchscreen/atmel_mxt_ts.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c b/drivers/input/touchscreen/atmel_mxt_ts.c
index dcafb812ee7e..92661aa910ae 100644
--- a/drivers/input/touchscreen/atmel_mxt_ts.c
+++ b/drivers/input/touchscreen/atmel_mxt_ts.c
@@ -1520,10 +1520,8 @@ static int mxt_update_cfg(struct mxt_data *data, const struct firmware *cfg)
 			MXT_INFO_CHECKSUM_SIZE;
 	config_mem_size = data->mem_size - cfg_start_ofs;
 	config_mem = kzalloc(config_mem_size, GFP_KERNEL);
-	if (!config_mem) {
-		dev_err(dev, "Failed to allocate memory\n");
+	if (!config_mem)
 		return -ENOMEM;
-	}
 
 	ret = mxt_prepare_cfg_mem(data, cfg, data_pos, cfg_start_ofs,
 				  config_mem, config_mem_size);
@@ -1982,10 +1980,8 @@ static int mxt_initialize_input_device(struct mxt_data *data)
 
 	/* Register input device */
 	input_dev = input_allocate_device();
-	if (!input_dev) {
-		dev_err(dev, "Failed to allocate memory\n");
+	if (!input_dev)
 		return -ENOMEM;
-	}
 
 	input_dev->name = "Atmel maXTouch Touchscreen";
 	input_dev->phys = data->phys;
-- 
2.17.1
