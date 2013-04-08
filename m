From: Bastian Hecht <hechtb@gmail.com>
Subject: [PATCH v2 2/2] ARM: shmobile: Armadillo800EVA: Move st1232 reset pin handling
Date: Mon,  8 Apr 2013 14:52:27 +0200
Message-ID: <1365425547-10391-2-git-send-email-hechtb+renesas@gmail.com>
References: <1365425547-10391-1-git-send-email-hechtb+renesas@gmail.com>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1365425547-10391-1-git-send-email-hechtb+renesas@gmail.com>
Sender: linux-sh-owner@vger.kernel.org
To: linux-sh@vger.kernel.org, linux-input@vger.kernel.org
Cc: Tony SIM <chinyeow.sim.xt@renesas.com>, Laurent Pichart <laurent.pinchart@ideasonboard.com>, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
List-Id: linux-input@vger.kernel.org

We no longer need to set up the reset pin for the st1232 in the board
code, but can pass the GPIO number via the platform data to the driver.
This results in a cleaner grouping of the device setup.

Signed-off-by: Bastian Hecht <hechtb+renesas@gmail.com>
---
v2:
reset_pin changed to reset_gpio

 arch/arm/mach-shmobile/board-armadillo800eva.c |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-shmobile/board-armadillo800eva.c b/arch/arm/mach-shmobile/board-armadillo800eva.c
index bf4c3d2..d1c1ff4 100644
--- a/arch/arm/mach-shmobile/board-armadillo800eva.c
+++ b/arch/arm/mach-shmobile/board-armadillo800eva.c
@@ -24,6 +24,7 @@
 #include <linux/err.h>
 #include <linux/kernel.h>
 #include <linux/input.h>
+#include <linux/input/st1232_pdata.h>
 #include <linux/irq.h>
 #include <linux/platform_device.h>
 #include <linux/gpio.h>
@@ -997,10 +998,15 @@ static struct platform_device i2c_gpio_device = {
 };
 
 /* I2C */
+static struct st1232_pdata st1232_i2c0_pdata = {
+	.reset_gpio = 166,
+};
+
 static struct i2c_board_info i2c0_devices[] = {
 	{
 		I2C_BOARD_INFO("st1232-ts", 0x55),
 		.irq = irq_pin(10),
+		.platform_data = &st1232_i2c0_pdata,
 	},
 	{
 		I2C_BOARD_INFO("wm8978", 0x1a),
@@ -1120,7 +1126,6 @@ static void __init eva_init(void)
 
 	/* Touchscreen */
 	gpio_request(GPIO_FN_IRQ10,	NULL); /* TP_INT */
-	gpio_request_one(166, GPIOF_OUT_INIT_HIGH, NULL); /* TP_RST_B */
 
 	/* GETHER */
 	gpio_request(GPIO_FN_ET_CRS,		NULL);
-- 
1.7.9.5

