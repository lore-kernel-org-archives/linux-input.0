From: YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH] Input: applespi - Fix build error
Date: Mon, 29 Jul 2019 11:14:55 +0800
Message-ID: <20190729031455.59400-1-yuehaibing@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: ronald@innovation.ch, dmitry.torokhov@gmail.com, nikolas@gnu.org
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, YueHaibing <yuehaibing@huawei.com>
List-Id: linux-input@vger.kernel.org

If CONFIG_KEYBOARD_APPLESPI=y but CONFIG_LEDS_CLASS=m
building fails:

drivers/input/keyboard/applespi.o: In function `applespi_probe':
applespi.c:(.text+0x1fcd): undefined reference to `devm_led_classdev_register_ext'

Wrap it in LEDS_CLASS macro to fix this.

Reported-by: Hulk Robot <hulkci@huawei.com>
Fixes: 038b1a05eae6 ("Input: add Apple SPI keyboard and trackpad driver")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/input/keyboard/applespi.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/input/keyboard/applespi.c b/drivers/input/keyboard/applespi.c
index acf34a5..9c50b09 100644
--- a/drivers/input/keyboard/applespi.c
+++ b/drivers/input/keyboard/applespi.c
@@ -1790,11 +1790,13 @@ static int applespi_probe(struct spi_device *spi)
 	applespi->backlight_info.default_trigger = "kbd-backlight";
 	applespi->backlight_info.brightness_set  = applespi_set_bl_level;
 
+#ifdef CONFIG_LEDS_CLASS
 	sts = devm_led_classdev_register(&spi->dev, &applespi->backlight_info);
 	if (sts)
 		dev_warn(&applespi->spi->dev,
 			 "Unable to register keyboard backlight class dev (%d)\n",
 			 sts);
+#endif
 
 	/* set up debugfs entries for touchpad dimensions logging */
 	applespi->debugfs_root = debugfs_create_dir("applespi", NULL);
-- 
2.7.4
