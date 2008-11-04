From: Jaya Kumar <jayakumar.lkml@gmail.com>
Subject: [RFC 2.6.27 5/5] Add support for E-Ink Broadsheet controller and AM300 kit
Date: Tue,  4 Nov 2008 08:55:13 +0800
Message-ID: <12257601541179-git-send-email-jayakumar.lkml@gmail.com>
References: <12257601131298-git-send-email-jayakumar.lkml@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.238]:54998 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753128AbYKDA4E (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 3 Nov 2008 19:56:04 -0500
Received: by rv-out-0506.google.com with SMTP id k40so2922566rvb.1
        for <linux-input@vger.kernel.org>; Mon, 03 Nov 2008 16:56:04 -0800 (PST)
In-Reply-To: <12257601131298-git-send-email-jayakumar.lkml@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: linux-fbdev-devel@lists.sourceforge.net, linux-input@vger.kernel.org, Jaya Kumar <jayakumar.lkml@gmail.com>

This patch adds support for the E-Ink Broadsheet display controller and the
AM300 gumstix kit.

Signed-off-by: Jaya Kumar <jayakumar.lkml@gmail.com>
---
 arch/arm/mach-pxa/Kconfig    |    4 +
 arch/arm/mach-pxa/Makefile   |    1 +
 arch/arm/mach-pxa/am300epd.c |  337 +++++++++++++++++++++++++
 drivers/video/Kconfig        |   14 +
 drivers/video/Makefile       |    3 +-
 drivers/video/broadsheetfb.c |  570 ++++++++++++++++++++++++++++++++++++++++++
 include/video/broadsheetfb.h |   63 +++++
 7 files changed, 991 insertions(+), 1 deletions(-)
 create mode 100644 arch/arm/mach-pxa/am300epd.c
 create mode 100644 drivers/video/broadsheetfb.c
 create mode 100644 include/video/broadsheetfb.h

diff --git a/arch/arm/mach-pxa/Kconfig b/arch/arm/mach-pxa/Kconfig
index f27f6b3..5bdd4e9 100644
--- a/arch/arm/mach-pxa/Kconfig
+++ b/arch/arm/mach-pxa/Kconfig
@@ -339,6 +339,10 @@ config MACH_AM200EPD
 	depends on MACH_GUMSTIX_F
 	bool "Enable AM200EPD board support"
 
+config MACH_AM300EPD
+	depends on MACH_GUMSTIX_F
+	bool "Enable AM300EPD board support"
+
 config PXA_EZX
 	bool "Motorola EZX Platform"
 	select PXA27x
diff --git a/arch/arm/mach-pxa/Makefile b/arch/arm/mach-pxa/Makefile
index d31c997..5ea970b 100644
--- a/arch/arm/mach-pxa/Makefile
+++ b/arch/arm/mach-pxa/Makefile
@@ -28,6 +28,7 @@ obj-$(CONFIG_CPU_PXA930)	+= pxa930.o
 # Specific board support
 obj-$(CONFIG_ARCH_GUMSTIX)	+= gumstix.o
 obj-$(CONFIG_MACH_AM200EPD)	+= am200epd.o
+obj-$(CONFIG_MACH_AM300EPD)	+= am300epd.o
 obj-$(CONFIG_ARCH_LUBBOCK)	+= lubbock.o
 obj-$(CONFIG_MACH_LOGICPD_PXA270) += lpd270.o
 obj-$(CONFIG_MACH_MAINSTONE)	+= mainstone.o
diff --git a/arch/arm/mach-pxa/am300epd.c b/arch/arm/mach-pxa/am300epd.c
new file mode 100644
index 0000000..bb81564
--- /dev/null
+++ b/arch/arm/mach-pxa/am300epd.c
@@ -0,0 +1,337 @@
+/*
+ * am300epd.c -- Platform device for AM300 EPD kit
+ *
+ * Copyright (C) 2008, Jaya Kumar
+ *
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License. See the file COPYING in the main directory of this archive for
+ * more details.
+ *
+ * This work was made possible by help and equipment support from E-Ink
+ * Corporation. http://support.eink.com/community
+ *
+ * This driver is written to be used with the Broadsheet display controller.
+ * on the AM300 EPD prototype kit/development kit with an E-Ink 800x600
+ * Vizplex EPD on a Gumstix board using the Broadsheet interface board.
+ *
+ */
+
+#define DEBUG 1
+
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/errno.h>
+#include <linux/string.h>
+#include <linux/delay.h>
+#include <linux/interrupt.h>
+#include <linux/fb.h>
+#include <linux/init.h>
+#include <linux/platform_device.h>
+#include <linux/irq.h>
+#include <linux/gpio.h>
+
+#include <mach/gumstix.h>
+#include <mach/mfp-pxa25x.h>
+#include <mach/pxafb.h>
+
+#include "generic.h"
+
+#include <video/broadsheetfb.h>
+
+static unsigned int panel_type = 6;
+static struct platform_device *am300_device;
+static struct broadsheet_board am300_board;
+
+static unsigned long am300_pin_config[] __initdata = {
+	GPIO16_GPIO,
+	GPIO17_GPIO,
+	GPIO32_GPIO,
+	GPIO48_GPIO,
+	GPIO49_GPIO,
+	GPIO51_GPIO,
+	GPIO74_GPIO,
+	GPIO75_GPIO,
+	GPIO76_GPIO,
+	GPIO77_GPIO,
+
+	/* this is the 16-bit hdb bus 58-73 */
+	GPIO58_GPIO,
+	GPIO59_GPIO,
+	GPIO60_GPIO,
+	GPIO61_GPIO,
+
+	GPIO62_GPIO,
+	GPIO63_GPIO,
+	GPIO64_GPIO,
+	GPIO65_GPIO,
+
+	GPIO66_GPIO,
+	GPIO67_GPIO,
+	GPIO68_GPIO,
+	GPIO69_GPIO,
+
+	GPIO70_GPIO,
+	GPIO71_GPIO,
+	GPIO72_GPIO,
+	GPIO73_GPIO,
+};
+
+/* register offsets for gpio control */
+#define PWR_GPIO_PIN 16
+#define CFG_GPIO_PIN 17
+#define RDY_GPIO_PIN 32
+#define DC_GPIO_PIN 48
+#define RST_GPIO_PIN 49
+#define LED_GPIO_PIN 51
+#define RD_GPIO_PIN 74
+#define WR_GPIO_PIN 75
+#define CS_GPIO_PIN 76
+#define IRQ_GPIO_PIN 77
+
+/* hdb bus */
+#define DB0_GPIO_PIN 58
+#define DB15_GPIO_PIN 73
+
+static int gpios[] = { PWR_GPIO_PIN, CFG_GPIO_PIN, RDY_GPIO_PIN, DC_GPIO_PIN,
+			RST_GPIO_PIN, RD_GPIO_PIN, WR_GPIO_PIN, CS_GPIO_PIN,
+			IRQ_GPIO_PIN, LED_GPIO_PIN };
+static char *gpio_names[] = { "PWR", "CFG", "RDY", "DC", "RST", "RD", "WR",
+				"CS", "IRQ", "LED" };
+
+static int am300_wait_for_rdy(struct broadsheetfb_par *par)
+{
+	unsigned long flags;
+	DEFINE_WAIT(wait);
+
+	spin_lock_irqsave(par->lock, flags);
+	while (!gpio_get_value(RDY_GPIO_PIN)) {
+		prepare_to_wait(&par->waitq, &wait, TASK_INTERRUPTIBLE);
+
+		spin_unlock_irqrestore(par->lock, flags);
+		schedule();
+		spin_lock_irqsave(par->lock, flags);
+	}
+	finish_wait(&par->waitq, &wait);
+
+	spin_unlock_irqrestore(par->lock, flags);
+	return 0;
+
+}
+
+static int am300_init_gpio_regs(struct broadsheetfb_par *par)
+{
+	int i;
+	int err;
+	char dbname[8];
+
+	for (i = 0; i < ARRAY_SIZE(gpios); i++) {
+		err = gpio_request(gpios[i], gpio_names[i]);
+		if (err) {
+			dev_err(&am300_device->dev, "failed requesting "
+				"gpio %s, err=%d\n", gpio_names[i], err);
+			goto err_req_gpio;
+		}
+	}
+
+	/* we also need to take care of the hdb bus */
+	for (i = DB0_GPIO_PIN; i <= DB15_GPIO_PIN; i++) {
+		sprintf(dbname, "DB%d", i);
+		err = gpio_request(i, dbname);
+		if (err) {
+			dev_err(&am300_device->dev, "failed requesting "
+				"gpio %d, err=%d\n", i, err);
+			while (i >= DB0_GPIO_PIN)
+				gpio_free(i--);
+			i = ARRAY_SIZE(gpios) - 1;
+			goto err_req_gpio;
+		}
+	}
+
+	/* setup the outputs and init values */
+	gpio_direction_output(PWR_GPIO_PIN, 0);
+	gpio_direction_output(CFG_GPIO_PIN, 1);
+	gpio_direction_output(DC_GPIO_PIN, 0);
+	gpio_direction_output(RD_GPIO_PIN, 1);
+	gpio_direction_output(WR_GPIO_PIN, 1);
+	gpio_direction_output(CS_GPIO_PIN, 1);
+	gpio_direction_output(RST_GPIO_PIN, 0);
+
+	/* setup the inputs */
+	gpio_direction_input(RDY_GPIO_PIN);
+	gpio_direction_input(IRQ_GPIO_PIN);
+
+	/* start the hdb bus as an input */
+	for (i = DB0_GPIO_PIN; i <= DB15_GPIO_PIN; i++)
+		gpio_direction_output(i, 0);
+
+	/* go into command mode */
+	gpio_set_value(CFG_GPIO_PIN, 1);
+	gpio_set_value(RST_GPIO_PIN, 0);
+	mdelay(10);
+	gpio_set_value(RST_GPIO_PIN, 1);
+	mdelay(10);
+	am300_wait_for_rdy(par);
+
+	return 0;
+
+err_req_gpio:
+	while (i > 0)
+		gpio_free(gpios[i--]);
+
+	return err;
+}
+
+static int am300_init_board(struct broadsheetfb_par *par)
+{
+	int ret;
+
+	/* setup pins */
+	ret = am300_init_gpio_regs(par);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static void am300_cleanup(struct broadsheetfb_par *par)
+{
+	int i;
+
+	free_irq(IRQ_GPIO(RDY_GPIO_PIN), par);
+
+	for (i = 0; i < ARRAY_SIZE(gpios); i++)
+		gpio_free(gpios[i]);
+
+	for (i = DB0_GPIO_PIN; i <= DB15_GPIO_PIN; i++)
+		gpio_free(i);
+
+}
+
+static u16 am300_get_hdb(struct broadsheetfb_par *par)
+{
+	u16 res = 0;
+	int i;
+
+	for (i = 0; i <= (DB15_GPIO_PIN - DB0_GPIO_PIN) ; i++)
+		res |= (gpio_get_value(DB0_GPIO_PIN + i)) ? (1 << i) : 0;
+
+	return res;
+}
+
+static void am300_set_hdb(struct broadsheetfb_par *par, u16 data)
+{
+	int i;
+
+	for (i = 0; i <= (DB15_GPIO_PIN - DB0_GPIO_PIN) ; i++)
+		gpio_set_value(DB0_GPIO_PIN + i, (data >> i) & 0x01);
+}
+
+
+static void am300_set_ctl(struct broadsheetfb_par *par, unsigned char bit,
+				u8 state)
+{
+	switch (bit) {
+	case BS_CS:
+		gpio_set_value(CS_GPIO_PIN, state);
+		break;
+	case BS_DC:
+		gpio_set_value(DC_GPIO_PIN, state);
+		break;
+	case BS_WR:
+		gpio_set_value(WR_GPIO_PIN, state);
+		break;
+	}
+}
+
+static int am300_get_panel_type(void)
+{
+	return panel_type;
+}
+
+static irqreturn_t am300_handle_irq(int irq, void *dev_id)
+{
+	unsigned long flags;
+	struct broadsheetfb_par *par = dev_id;
+
+	spin_lock_irqsave(par->lock, flags);
+	wake_up_interruptible(&par->waitq);
+	spin_unlock_irqrestore(par->lock, flags);
+	return IRQ_HANDLED;
+}
+
+static int am300_setup_irq(struct fb_info *info)
+{
+	int ret;
+	struct broadsheetfb_par *par = info->par;
+
+	spin_lock_init(&par->lock);
+
+	ret = request_irq(IRQ_GPIO(RDY_GPIO_PIN), am300_handle_irq,
+				IRQF_DISABLED|IRQF_TRIGGER_RISING,
+				"AM300", par);
+	if (ret)
+		dev_err(&am300_device->dev, "request_irq failed: %d\n", ret);
+
+	return ret;
+}
+
+static int am300_wait_event(struct broadsheetfb_par *par)
+{
+	return wait_event_timeout(par->waitq, gpio_get_value(RDY_GPIO_PIN), HZ);
+}
+
+static int am300_wait_event_intr(struct broadsheetfb_par *par)
+{
+	return wait_event_interruptible_timeout(par->waitq,
+					gpio_get_value(RDY_GPIO_PIN), HZ);
+}
+
+static struct broadsheet_board am300_board = {
+	.owner			= THIS_MODULE,
+	.init			= am300_init_board,
+	.cleanup		= am300_cleanup,
+	.set_hdb		= am300_set_hdb,
+	.get_hdb		= am300_get_hdb,
+	.set_ctl		= am300_set_ctl,
+	.wait_for_rdy		= am300_wait_for_rdy,
+	.get_panel_type		= am300_get_panel_type,
+	.setup_irq		= am300_setup_irq,
+	.wait_event		= am300_wait_event,
+	.wait_event_intr	= am300_wait_event_intr,
+};
+
+static int __init am300_init(void)
+{
+	int ret;
+
+	pxa2xx_mfp_config(ARRAY_AND_SIZE(am300_pin_config));
+
+	/* request our platform independent driver */
+	request_module("broadsheetfb");
+
+	am300_device = platform_device_alloc("broadsheetfb", -1);
+	if (!am300_device)
+		return -ENOMEM;
+
+	/* the am300_board that will be seen by broadsheetfb is a copy */
+	platform_device_add_data(am300_device, &am300_board,
+					sizeof(am300_board));
+
+	ret = platform_device_add(am300_device);
+
+	if (ret) {
+		platform_device_put(am300_device);
+		return ret;
+	}
+
+	return 0;
+}
+
+module_param(panel_type, uint, 0);
+MODULE_PARM_DESC(panel_type, "Select the panel type: 6, 8, 97");
+
+module_init(am300_init);
+
+MODULE_DESCRIPTION("board driver for am300 epd kit");
+MODULE_AUTHOR("Jaya Kumar");
+MODULE_LICENSE("GPL");
diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
index 0f13448..db49aa4 100644
--- a/drivers/video/Kconfig
+++ b/drivers/video/Kconfig
@@ -2083,6 +2083,20 @@ config FB_METRONOME
 	  controller. The pre-release name for this device was 8track
 	  and could also have been called by some vendors as PVI-nnnn.
 
+config FB_BROADSHEET
+	tristate "E-Ink Broadsheet/Epson S1D13521 controller support"
+	depends on FB
+	select FB_SYS_FILLRECT
+	select FB_SYS_COPYAREA
+	select FB_SYS_IMAGEBLIT
+	select FB_SYS_FOPS
+	select FB_DEFERRED_IO
+	help
+	  This driver implements support for the E-Ink Broadsheet
+	  controller. The release name for this device was Epson S1D13521
+	  and could also have been called by other names when coupled with
+	  a bridge adapter.
+
 source "drivers/video/omap/Kconfig"
 
 source "drivers/video/backlight/Kconfig"
diff --git a/drivers/video/Makefile b/drivers/video/Makefile
index 248bddc..05efefa 100644
--- a/drivers/video/Makefile
+++ b/drivers/video/Makefile
@@ -105,7 +105,8 @@ obj-$(CONFIG_FB_PMAG_AA)	  += pmag-aa-fb.o
 obj-$(CONFIG_FB_PMAG_BA)	  += pmag-ba-fb.o
 obj-$(CONFIG_FB_PMAGB_B)	  += pmagb-b-fb.o
 obj-$(CONFIG_FB_MAXINE)		  += maxinefb.o
-obj-$(CONFIG_FB_METRONOME)        += metronomefb.o
+obj-$(CONFIG_FB_METRONOME)	  += metronomefb.o
+obj-$(CONFIG_FB_BROADSHEET)	  += broadsheetfb.o
 obj-$(CONFIG_FB_S1D13XXX)	  += s1d13xxxfb.o
 obj-$(CONFIG_FB_SH7760)		  += sh7760fb.o
 obj-$(CONFIG_FB_IMX)              += imxfb.o
diff --git a/drivers/video/broadsheetfb.c b/drivers/video/broadsheetfb.c
new file mode 100644
index 0000000..00e800a
--- /dev/null
+++ b/drivers/video/broadsheetfb.c
@@ -0,0 +1,570 @@
+/*
+ * broadsheetfb.c -- FB driver for E-Ink Broadsheet controller
+ *
+ * Copyright (C) 2008, Jaya Kumar
+ *
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License. See the file COPYING in the main directory of this archive for
+ * more details.
+ *
+ * Layout is based on skeletonfb.c by James Simmons and Geert Uytterhoeven.
+ *
+ * This driver is written to be used with the Broadsheet display controller.
+ *
+ * It is intended to be architecture independent. A board specific driver
+ * must be used to perform all the physical IO interactions.
+ *
+ */
+#define DEBUG 1
+
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/errno.h>
+#include <linux/string.h>
+#include <linux/mm.h>
+#include <linux/slab.h>
+#include <linux/vmalloc.h>
+#include <linux/delay.h>
+#include <linux/interrupt.h>
+#include <linux/fb.h>
+#include <linux/init.h>
+#include <linux/platform_device.h>
+#include <linux/list.h>
+#include <linux/uaccess.h>
+
+#include <video/broadsheetfb.h>
+
+/* Display specific information */
+#define DPY_W 800
+#define DPY_H 600
+
+static struct fb_fix_screeninfo broadsheetfb_fix __devinitdata = {
+	.id =		"broadsheetfb",
+	.type =		FB_TYPE_PACKED_PIXELS,
+	.visual =	FB_VISUAL_STATIC_PSEUDOCOLOR,
+	.xpanstep =	0,
+	.ypanstep =	0,
+	.ywrapstep =	0,
+	.line_length =	DPY_W,
+	.accel =	FB_ACCEL_NONE,
+};
+
+static struct fb_var_screeninfo broadsheetfb_var __devinitdata = {
+	.xres		= DPY_W,
+	.yres		= DPY_H,
+	.xres_virtual	= DPY_W,
+	.yres_virtual	= DPY_H,
+	.bits_per_pixel	= 8,
+	.grayscale	= 1,
+	.nonstd		= 1,
+	.red =		{ 0, 4, 0 },
+	.green =	{ 0, 4, 0 },
+	.blue =		{ 0, 4, 0 },
+	.transp =	{ 0, 0, 0 },
+};
+
+/* main broadsheetfb functions */
+static void broadsheet_issue_data(struct broadsheetfb_par *par, u16 data)
+{
+	par->board->set_ctl(par, BS_WR, 0);
+	par->board->set_hdb(par, data);
+	par->board->set_ctl(par, BS_WR, 1);
+}
+
+static void broadsheet_issue_cmd(struct broadsheetfb_par *par, u16 data)
+{
+	par->board->set_ctl(par, BS_DC, 0);
+	broadsheet_issue_data(par, data);
+}
+
+static void broadsheet_send_command(struct broadsheetfb_par *par, u16 data)
+{
+	par->board->wait_for_rdy(par);
+
+	par->board->set_ctl(par, BS_CS, 0);
+	broadsheet_issue_cmd(par, data);
+	par->board->set_ctl(par, BS_DC, 1);
+	par->board->set_ctl(par, BS_CS, 1);
+}
+
+static void broadsheet_send_cmdargs(struct broadsheetfb_par *par, u16 cmd,
+					int argc, u16 *argv)
+{
+	int i;
+
+	par->board->wait_for_rdy(par);
+
+	par->board->set_ctl(par, BS_CS, 0);
+	broadsheet_issue_cmd(par, cmd);
+	par->board->set_ctl(par, BS_DC, 1);
+
+	for (i = 0; i < argc; i++)
+		broadsheet_issue_data(par, argv[i]);
+	par->board->set_ctl(par, BS_CS, 1);
+}
+
+static void broadsheet_burst_write(struct broadsheetfb_par *par, int size,
+					u16 *data)
+{
+	int i;
+	u16 tmp;
+
+	par->board->set_ctl(par, BS_CS, 0);
+	par->board->set_ctl(par, BS_DC, 1);
+
+	for (i = 0; i < size; i++) {
+		par->board->set_ctl(par, BS_WR, 0);
+		tmp = (data[i] & 0x0F) << 4;
+		tmp |= (data[i] & 0x0F00) << 4;
+		par->board->set_hdb(par, tmp);
+		par->board->set_ctl(par, BS_WR, 1);
+	}
+
+	par->board->set_ctl(par, BS_CS, 1);
+}
+
+static u16 broadsheet_get_data(struct broadsheetfb_par *par)
+{
+	u16 res;
+	/* wait for ready to go hi. (lo is busy) */
+	par->board->wait_for_rdy(par);
+
+	/* cs lo, dc lo for cmd, we lo for each data, db as usual */
+	par->board->set_ctl(par, BS_DC, 1);
+	par->board->set_ctl(par, BS_CS, 0);
+	par->board->set_ctl(par, BS_WR, 0);
+
+	res = par->board->get_hdb(par);
+
+	/* strobe wr */
+	par->board->set_ctl(par, BS_WR, 1);
+	par->board->set_ctl(par, BS_CS, 1);
+
+	return res;
+}
+
+static void broadsheet_write_reg(struct broadsheetfb_par *par, u16 reg,
+					u16 data)
+{
+	/* wait for ready to go hi. (lo is busy) */
+	par->board->wait_for_rdy(par);
+
+	/* cs lo, dc lo for cmd, we lo for each data, db as usual */
+	par->board->set_ctl(par, BS_CS, 0);
+
+	broadsheet_issue_cmd(par, BS_CMD_WR_REG);
+
+	par->board->set_ctl(par, BS_DC, 1);
+
+	broadsheet_issue_data(par, reg);
+	broadsheet_issue_data(par, data);
+
+	par->board->set_ctl(par, BS_CS, 1);
+}
+
+static u16 broadsheet_read_reg(struct broadsheetfb_par *par, u16 reg)
+{
+	broadsheet_send_command(par, reg);
+	mdelay(100);
+	return broadsheet_get_data(par);
+}
+
+static void __devinit broadsheet_init_display(struct broadsheetfb_par *par)
+{
+	u16 args[5];
+
+	args[0] = DPY_W;
+	args[1] = DPY_H;
+	args[2] = (100 | (1 << 8) | (1 << 9)); /* sdcfg */
+	args[3] = 2; /* gdrv cfg */
+	args[4] = (4 | (1 << 7)); /* lut index format */
+	broadsheet_send_cmdargs(par, BS_CMD_INIT_DSPE_CFG, 5, args);
+
+	/* did the controller really set it? */
+	broadsheet_send_cmdargs(par, BS_CMD_INIT_DSPE_CFG, 5, args);
+
+	args[0] = 4; /* fsync len */
+	args[1] = (10 << 8) | 4; /* fend/fbegin len */
+	args[2] = 10; /* line sync len */
+	args[3] = (100 << 8) | 4; /* line end/begin len */
+	args[4] = 6; /* pixel clock cfg */
+	broadsheet_send_cmdargs(par, BS_CMD_INIT_DSPE_TMG, 5, args);
+
+	/* setup waveform */
+	args[0] = 0x886;
+	args[1] = 0;
+	broadsheet_send_cmdargs(par, BS_CMD_RD_WFM_INFO, 2, args);
+
+	broadsheet_send_command(par, BS_CMD_UPD_GDRV_CLR);
+
+	broadsheet_send_command(par, BS_CMD_WAIT_DSPE_TRG);
+
+	broadsheet_write_reg(par, 0x330, 0x84);
+
+	broadsheet_send_command(par, BS_CMD_WAIT_DSPE_TRG);
+
+	args[0] = (0x3 << 4);
+	broadsheet_send_cmdargs(par, BS_CMD_LD_IMG, 1, args);
+
+	args[0] = 0x154;
+	broadsheet_send_cmdargs(par, BS_CMD_WR_REG, 1, args);
+
+	broadsheet_burst_write(par, DPY_W*DPY_H/2,
+				(u16 *) par->info->screen_base);
+
+	broadsheet_send_command(par, BS_CMD_LD_IMG_END);
+
+	args[0] = 0x4300;
+	broadsheet_send_cmdargs(par, BS_CMD_UPD_FULL, 1, args);
+
+	broadsheet_send_command(par, BS_CMD_WAIT_DSPE_TRG);
+
+	broadsheet_send_command(par, BS_CMD_WAIT_DSPE_FREND);
+
+	par->board->wait_for_rdy(par);
+}
+
+static void __devinit broadsheet_init(struct broadsheetfb_par *par)
+{
+	broadsheet_send_command(par, BS_CMD_INIT_SYS_RUN);
+	/* the controller needs a second */
+	mdelay(1000);
+	broadsheet_init_display(par);
+}
+
+static void broadsheetfb_dpy_update_pages(struct broadsheetfb_par *par,
+						u16 y1, u16 y2)
+{
+	u16 args[5];
+	unsigned char *buf = (unsigned char __force *)par->info->screen_base;
+
+	/* y1 must be a multiple of 4 so drop the lower bits */
+	y1 &= 0xFFFC;
+	/* y2 must be a multiple of 4 , but - 1 so up the lower bits */
+	y2 |= 0x0003;
+
+	args[0] = 0x3 << 4;
+	args[1] = 0;
+	args[2] = y1;
+	args[3] = cpu_to_le16(par->info->var.xres);
+	args[4] = y2;
+	broadsheet_send_cmdargs(par, BS_CMD_LD_IMG_AREA, 5, args);
+
+	args[0] = 0x154;
+	broadsheet_send_cmdargs(par, BS_CMD_WR_REG, 1, args);
+
+	buf += y1 * par->info->var.xres;
+	broadsheet_burst_write(par, ((1 + y2 - y1) * par->info->var.xres)/2,
+				(u16 *) buf);
+
+	broadsheet_send_command(par, BS_CMD_LD_IMG_END);
+
+	args[0] = 0x4300;
+	broadsheet_send_cmdargs(par, BS_CMD_UPD_FULL, 1, args);
+
+	broadsheet_send_command(par, BS_CMD_WAIT_DSPE_TRG);
+
+	broadsheet_send_command(par, BS_CMD_WAIT_DSPE_FREND);
+
+	par->board->wait_for_rdy(par);
+
+}
+
+static void broadsheetfb_dpy_update(struct broadsheetfb_par *par)
+{
+	u16 args[5];
+
+	args[0] = 0x3 << 4;
+	broadsheet_send_cmdargs(par, BS_CMD_LD_IMG, 1, args);
+
+	args[0] = 0x154;
+	broadsheet_send_cmdargs(par, BS_CMD_WR_REG, 1, args);
+	broadsheet_burst_write(par, DPY_W*DPY_H/2,
+				(u16 *) par->info->screen_base);
+
+	broadsheet_send_command(par, BS_CMD_LD_IMG_END);
+
+	args[0] = 0x4300;
+	broadsheet_send_cmdargs(par, BS_CMD_UPD_FULL, 1, args);
+
+	broadsheet_send_command(par, BS_CMD_WAIT_DSPE_TRG);
+
+	broadsheet_send_command(par, BS_CMD_WAIT_DSPE_FREND);
+
+	par->board->wait_for_rdy(par);
+
+}
+
+/* this is called back from the deferred io workqueue */
+static void broadsheetfb_dpy_deferred_io(struct fb_info *info,
+				struct list_head *pagelist)
+{
+	u16 y1 = 0, h = 0;
+	int prev_index = -1;
+	struct page *cur;
+	struct fb_deferred_io *fbdefio = info->fbdefio;
+	int h_inc;
+	u16 yres = info->var.yres;
+	u16 xres = info->var.xres;
+
+	/* height increment is fixed per page */
+	h_inc = DIV_ROUND_UP(PAGE_SIZE , xres);
+
+	/* walk the written page list and swizzle the data */
+	list_for_each_entry(cur, &fbdefio->pagelist, lru) {
+		if (prev_index < 0) {
+			/* just starting so assign first page */
+			y1 = (cur->index << PAGE_SHIFT) / xres;
+			h = h_inc;
+		} else if ((prev_index + 1) == cur->index) {
+			/* this page is consecutive so increase our height */
+			h += h_inc;
+		} else {
+			/* page not consecutive, issue previous update first */
+			broadsheetfb_dpy_update_pages(info->par, y1, y1 + h);
+			/* start over with our non consecutive page */
+			y1 = (cur->index << PAGE_SHIFT) / xres;
+			h = h_inc;
+		}
+		prev_index = cur->index;
+	}
+
+	/* if we still have any pages to update we do so now */
+	if (h >= yres) {
+		/* its a full screen update, just do it */
+		broadsheetfb_dpy_update(info->par);
+	} else {
+		broadsheetfb_dpy_update_pages(info->par, y1,
+						min((u16) (y1 + h), yres));
+	}
+}
+
+static void broadsheetfb_fillrect(struct fb_info *info,
+				   const struct fb_fillrect *rect)
+{
+	struct broadsheetfb_par *par = info->par;
+
+	sys_fillrect(info, rect);
+
+	broadsheetfb_dpy_update(par);
+}
+
+static void broadsheetfb_copyarea(struct fb_info *info,
+				   const struct fb_copyarea *area)
+{
+	struct broadsheetfb_par *par = info->par;
+
+	sys_copyarea(info, area);
+
+	broadsheetfb_dpy_update(par);
+}
+
+static void broadsheetfb_imageblit(struct fb_info *info,
+				const struct fb_image *image)
+{
+	struct broadsheetfb_par *par = info->par;
+
+	sys_imageblit(info, image);
+
+	broadsheetfb_dpy_update(par);
+}
+
+/*
+ * this is the slow path from userspace. they can seek and write to
+ * the fb. it's inefficient to do anything less than a full screen draw
+ */
+static ssize_t broadsheetfb_write(struct fb_info *info, const char __user *buf,
+				size_t count, loff_t *ppos)
+{
+	struct broadsheetfb_par *par = info->par;
+	unsigned long p = *ppos;
+	void *dst;
+	int err = 0;
+	unsigned long total_size;
+
+	if (info->state != FBINFO_STATE_RUNNING)
+		return -EPERM;
+
+	total_size = info->fix.smem_len;
+
+	if (p > total_size)
+		return -EFBIG;
+
+	if (count > total_size) {
+		err = -EFBIG;
+		count = total_size;
+	}
+
+	if (count + p > total_size) {
+		if (!err)
+			err = -ENOSPC;
+
+		count = total_size - p;
+	}
+
+	dst = (void __force *) (info->screen_base + p);
+
+	if (copy_from_user(dst, buf, count))
+		err = -EFAULT;
+
+	if  (!err)
+		*ppos += count;
+
+	broadsheetfb_dpy_update(par);
+
+	return (err) ? err : count;
+}
+
+static struct fb_ops broadsheetfb_ops = {
+	.owner		= THIS_MODULE,
+	.fb_read        = fb_sys_read,
+	.fb_write	= broadsheetfb_write,
+	.fb_fillrect	= broadsheetfb_fillrect,
+	.fb_copyarea	= broadsheetfb_copyarea,
+	.fb_imageblit	= broadsheetfb_imageblit,
+};
+
+static struct fb_deferred_io broadsheetfb_defio = {
+	.delay		= HZ/4,
+	.deferred_io	= broadsheetfb_dpy_deferred_io,
+};
+
+static int __devinit broadsheetfb_probe(struct platform_device *dev)
+{
+	struct fb_info *info;
+	struct broadsheet_board *board;
+	int retval = -ENOMEM;
+	int videomemorysize;
+	unsigned char *videomemory;
+	struct broadsheetfb_par *par;
+	int i;
+
+	/* pick up board specific routines */
+	board = dev->dev.platform_data;
+	if (!board)
+		return -EINVAL;
+
+	/* try to count device specific driver, if can't, platform recalls */
+	if (!try_module_get(board->owner))
+		return -ENODEV;
+
+	info = framebuffer_alloc(sizeof(struct broadsheetfb_par), &dev->dev);
+	if (!info)
+		goto err;
+
+	videomemorysize = (DPY_W*DPY_H);
+	videomemory = vmalloc(videomemorysize);
+	if (!videomemory)
+		goto err_fb_rel;
+
+	memset(videomemory, 0, videomemorysize);
+
+	info->screen_base = (char __force __iomem *)videomemory;
+	info->fbops = &broadsheetfb_ops;
+
+	info->var = broadsheetfb_var;
+	info->fix = broadsheetfb_fix;
+	info->fix.smem_len = videomemorysize;
+	par = info->par;
+	par->info = info;
+	par->board = board;
+	par->write_reg = broadsheet_write_reg;
+	par->read_reg = broadsheet_read_reg;
+	init_waitqueue_head(&par->waitq);
+
+	info->flags = FBINFO_FLAG_DEFAULT;
+
+	info->fbdefio = &broadsheetfb_defio;
+	fb_deferred_io_init(info);
+
+	retval = fb_alloc_cmap(&info->cmap, 16, 0);
+	if (retval < 0) {
+		dev_err(&dev->dev, "Failed to allocate colormap\n");
+		goto err_vfree;
+	}
+
+	/* set cmap */
+	for (i = 0; i < 16; i++)
+		info->cmap.red[i] = (((2*i)+1)*(0xFFFF))/32;
+	memcpy(info->cmap.green, info->cmap.red, sizeof(u16)*16);
+	memcpy(info->cmap.blue, info->cmap.red, sizeof(u16)*16);
+
+	retval = par->board->setup_irq(info);
+	if (retval < 0)
+		goto err_cmap;
+
+	/* this inits the dpy */
+	retval = board->init(par);
+	if (retval < 0)
+		goto err_free_irq;
+
+	broadsheet_init(par);
+
+	retval = register_framebuffer(info);
+	if (retval < 0)
+		goto err_free_irq;
+	platform_set_drvdata(dev, info);
+
+	printk(KERN_INFO
+	       "fb%d: Broadsheet frame buffer, using %dK of video memory\n",
+	       info->node, videomemorysize >> 10);
+
+
+	return 0;
+
+err_free_irq:
+	board->cleanup(par);
+err_cmap:
+	fb_dealloc_cmap(&info->cmap);
+err_vfree:
+	vfree(videomemory);
+err_fb_rel:
+	framebuffer_release(info);
+err:
+	module_put(board->owner);
+	return retval;
+
+}
+
+static int __devexit broadsheetfb_remove(struct platform_device *dev)
+{
+	struct fb_info *info = platform_get_drvdata(dev);
+
+	if (info) {
+		struct broadsheetfb_par *par = info->par;
+		unregister_framebuffer(info);
+		fb_deferred_io_cleanup(info);
+		par->board->cleanup(par);
+		fb_dealloc_cmap(&info->cmap);
+		vfree((void __force *)info->screen_base);
+		module_put(par->board->owner);
+		framebuffer_release(info);
+	}
+	return 0;
+}
+
+static struct platform_driver broadsheetfb_driver = {
+	.probe	= broadsheetfb_probe,
+	.remove = broadsheetfb_remove,
+	.driver	= {
+		.owner	= THIS_MODULE,
+		.name	= "broadsheetfb",
+	},
+};
+
+static int __init broadsheetfb_init(void)
+{
+	return platform_driver_register(&broadsheetfb_driver);
+}
+
+static void __exit broadsheetfb_exit(void)
+{
+	platform_driver_unregister(&broadsheetfb_driver);
+}
+
+module_init(broadsheetfb_init);
+module_exit(broadsheetfb_exit);
+
+MODULE_DESCRIPTION("fbdev driver for Broadsheet controller");
+MODULE_AUTHOR("Jaya Kumar");
+MODULE_LICENSE("GPL");
diff --git a/include/video/broadsheetfb.h b/include/video/broadsheetfb.h
new file mode 100644
index 0000000..f233537
--- /dev/null
+++ b/include/video/broadsheetfb.h
@@ -0,0 +1,63 @@
+/*
+ * broadsheetfb.h - definitions for the broadsheet framebuffer driver
+ *
+ * Copyright (C) 2008 by Jaya Kumar
+ *
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License. See the file COPYING in the main directory of this archive for
+ * more details.
+ *
+ */
+
+#ifndef _LINUX_BROADSHEETFB_H_
+#define _LINUX_BROADSHEETFB_H_
+
+/* Broadsheet command defines */
+#define BS_CMD_INIT_SYS_RUN	0x06
+#define BS_CMD_INIT_DSPE_CFG	0x09
+#define BS_CMD_INIT_DSPE_TMG	0x0A
+#define BS_CMD_INIT_ROTMODE	0x0B
+#define BS_CMD_RD_REG		0x10
+#define BS_CMD_WR_REG		0x11
+#define BS_CMD_LD_IMG		0x20
+#define BS_CMD_LD_IMG_AREA	0x22
+#define BS_CMD_LD_IMG_END	0x23
+#define BS_CMD_WAIT_DSPE_TRG	0x28
+#define BS_CMD_WAIT_DSPE_FREND	0x29
+#define BS_CMD_RD_WFM_INFO	0x30
+#define BS_CMD_UPD_INIT		0x32
+#define BS_CMD_UPD_FULL		0x33
+#define BS_CMD_UPD_GDRV_CLR	0x37
+
+/* Broadsheet pin interface specific defines */
+#define BS_CS	0x01
+#define BS_DC 	0x02
+#define BS_WR 	0x03
+
+/* struct used by broadsheet. board specific stuff comes from *board */
+struct broadsheetfb_par {
+	struct fb_info *info;
+	struct broadsheet_board *board;
+	void (*write_reg)(struct broadsheetfb_par *, u16 reg, u16 val);
+	u16 (*read_reg)(struct broadsheetfb_par *, u16 reg);
+	wait_queue_head_t waitq;
+	spinlock_t lock;
+};
+
+/* board specific routines */
+struct broadsheet_board {
+	struct module *owner;
+	int (*init)(struct broadsheetfb_par *);
+	int (*wait_for_rdy)(struct broadsheetfb_par *);
+	int (*wait_for_rdy_lo)(struct broadsheetfb_par *);
+	void (*set_ctl)(struct broadsheetfb_par *, unsigned char, u8);
+	void (*set_hdb)(struct broadsheetfb_par *, u16);
+	u16 (*get_hdb)(struct broadsheetfb_par *);
+	void (*cleanup)(struct broadsheetfb_par *);
+	int (*get_panel_type)(void);
+	int (*setup_irq)(struct fb_info *);
+	int (*wait_event)(struct broadsheetfb_par *);
+	int (*wait_event_intr)(struct broadsheetfb_par *);
+};
+
+#endif
-- 
1.5.2.3

