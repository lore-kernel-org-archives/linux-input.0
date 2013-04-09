From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH v2 2/2] ARM: shmobile: Armadillo800EVA: Move st1232 reset
 pin handling
Date: Tue, 9 Apr 2013 17:26:44 +0900
Message-ID: <20130409082644.GD18478@verge.net.au>
References: <1365425547-10391-1-git-send-email-hechtb+renesas@gmail.com>
 <1365425547-10391-2-git-send-email-hechtb+renesas@gmail.com>
 <1534841.hHClRQAXMk@avalon>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1534841.hHClRQAXMk@avalon>
Sender: linux-sh-owner@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Bastian Hecht <hechtb@gmail.com>, linux-sh@vger.kernel.org, linux-input@vger.kernel.org, Tony SIM <chinyeow.sim.xt@renesas.com>, Magnus Damm <magnus.damm@gmail.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
List-Id: linux-input@vger.kernel.org

On Mon, Apr 08, 2013 at 04:17:22PM +0200, Laurent Pinchart wrote:
> Hi Bastian,
> 
> Thanks for the patch.
> 
> On Monday 08 April 2013 14:52:27 Bastian Hecht wrote:
> > We no longer need to set up the reset pin for the st1232 in the board
> > code, but can pass the GPIO number via the platform data to the driver.
> > This results in a cleaner grouping of the device setup.
> > 
> > Signed-off-by: Bastian Hecht <hechtb+renesas@gmail.com>
> 
> Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

Thanks.

I have queued this up in the boards-armadillo800eva branch.

There were some conflicts when I applied the code which
I fixed manually. Bastian, can you please check that the
following is correct? If it is not please send an incremental patch.


>From 14e0f336a45cdb9150aab5731c2b5b74f4dc3588 Mon Sep 17 00:00:00 2001
From: Bastian Hecht <hechtb@gmail.com>
Date: Mon, 8 Apr 2013 12:52:27 +0000
Subject: [PATCH] ARM: shmobile: Armadillo800EVA: Move st1232 reset pin
 handling

We no longer need to set up the reset pin for the st1232 in the board
code, but can pass the GPIO number via the platform data to the driver.
This results in a cleaner grouping of the device setup.

Signed-off-by: Bastian Hecht <hechtb+renesas@gmail.com>
Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/board-armadillo800eva.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-shmobile/board-armadillo800eva.c b/arch/arm/mach-shmobile/board-armadillo800eva.c
index f322a18..60fca5d 100644
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
@@ -968,10 +969,14 @@ static struct platform_device i2c_gpio_device = {
 };
 
 /* I2C */
+static struct st1232_pdata st1232_i2c0_pdata = {
+	.reset_gpio = 166,
+};
 static struct i2c_board_info i2c0_devices[] = {
 	{
 		I2C_BOARD_INFO("st1232-ts", 0x55),
 		.irq = evt2irq(0x0340),
+		.platform_data = &st1232_i2c0_pdata,
 	},
 	{
 		I2C_BOARD_INFO("wm8978", 0x1a),
@@ -1092,7 +1097,6 @@ static void __init eva_init(void)
 
 	/* Touchscreen */
 	gpio_request(GPIO_FN_IRQ10,	NULL); /* TP_INT */
-	gpio_request_one(166, GPIOF_OUT_INIT_HIGH, NULL); /* TP_RST_B */
 
 	/* GETHER */
 	gpio_request(GPIO_FN_ET_CRS,		NULL);
-- 
1.7.10.4

