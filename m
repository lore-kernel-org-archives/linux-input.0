From: Shine Liu <shinel@foxmail.com>
Subject: [PATCH] input/touchscreen: add S3C24XX SoC touchscreen input driver
Date: Mon, 19 Oct 2009 18:54:21 +0800
Message-ID: <1255949661.2060.29.camel@shinel>
Reply-To: shinel@foxmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-input@vger.kernel.org, dtor@mail.ru, dmitry.torokhov@gmail.com
Cc: linux-arm-kernel@lists.infradead.org
List-Id: linux-input@vger.kernel.org


This touchscreen driver is for touchscreen controller on Samsung
S3C2410/S3C2440 SoC chip. S3C2410/S3C2440 has the on chip touchscreen
controller based on it's analog to digital converter(8-channel analog
inputs, touchscreen uses 4 of them). This driver uses the exsiting S3C
ADC driver to make the touchscreen controller of S3C2410/S3C2440 work
well together with other ADC devices connected to the S3C24XX SoC chip.

The patch is created against kernel 2.6.32-rc4 and tested with S3C2440
SoC and Samsung LTE430WQ-F0C touchscreen.


Signed-off-by: Shine Liu <liuxian@redflag-linux.com>
Signed-off-by: Shine Liu <shinel@foxmail.com>
--------------------------------------------------------

--- a/drivers/input/touchscreen/Makefile	2009-10-12 05:43:56.000000000 +0800
+++ b/drivers/input/touchscreen/Makefile	2009-10-13 20:35:02.000000000 +0800
@@ -10,6 +10,7 @@
 obj-$(CONFIG_TOUCHSCREEN_AD7879)	+= ad7879.o
 obj-$(CONFIG_TOUCHSCREEN_ADS7846)	+= ads7846.o
 obj-$(CONFIG_TOUCHSCREEN_ATMEL_TSADCC)	+= atmel_tsadcc.o
+obj-$(CONFIG_TOUCHSCREEN_S3C24XX_TSADCC)       += s3c24xx_tsadcc.o
 obj-$(CONFIG_TOUCHSCREEN_BITSY)		+= h3600_ts_input.o
 obj-$(CONFIG_TOUCHSCREEN_CORGI)		+= corgi_ts.o
 obj-$(CONFIG_TOUCHSCREEN_GUNZE)		+= gunze.o
--- a/drivers/input/touchscreen/Kconfig	2009-10-12 05:43:56.000000000 +0800
+++ b/drivers/input/touchscreen/Kconfig	2009-10-13 20:37:51.000000000 +0800
@@ -307,6 +307,19 @@
 	  To compile this driver as a module, choose M here: the
 	  module will be called atmel_tsadcc.
 
+config TOUCHSCREEN_S3C24XX_TSADCC
+	tristate "Samsung S3C24XX touchscreen input driver"
+	depends on ARCH_S3C2410 && S3C24XX_ADC && INPUT && INPUT_TOUCHSCREEN
+	select SERIO
+	help
+	  Say Y here if you have a touchscreen connected to the ADC Controller
+	  on your s3c2410/s3c2440 SoC.
+
+	  If unsure, say N.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called s3c24xx_tsadcc.
+
 config TOUCHSCREEN_UCB1400
 	tristate "Philips UCB1400 touchscreen"
 	depends on AC97_BUS
--- /dev/null	2009-10-09 10:57:12.360986601 +0800
+++ b/drivers/input/touchscreen/s3c24xx_tsadcc.c	2009-10-19 17:16:57.000000000 +0800
@@ -0,0 +1,432 @@
+/*
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
+ *
+ * Part of the code come from openmoko project.
+ *
+ * Shine Liu <shinel@foxmail.com>
+ */
+
+#include <linux/errno.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/slab.h>
+#include <linux/input.h>
+#include <linux/init.h>
+#include <linux/serio.h>
+#include <linux/timer.h>
+#include <linux/delay.h>
+#include <linux/platform_device.h>
+#include <linux/clk.h>
+#include <linux/io.h>
+#include <asm/irq.h>
+
+#include <mach/gpio.h>
+#include <mach/regs-gpio.h>
+#include <mach/hardware.h>
+#include <plat/regs-adc.h>
+#include <plat/adc.h>
+
+
+MODULE_AUTHOR("Shine Liu <shinel@foxmail.com>");
+MODULE_DESCRIPTION("Samsung s3c24xx touchscreen driver");
+MODULE_LICENSE("GPL");
+
+
+#define S3C24XX_TS_VERSION	0x0101
+
+#define TSC_SLEEP (S3C2410_ADCTSC_PULL_UP_DISABLE | \
+	S3C2410_ADCTSC_XY_PST(0))
+
+#define WAIT4INT(x)	(((x)<<8) | \
+	S3C2410_ADCTSC_YM_SEN | \
+	S3C2410_ADCTSC_YP_SEN | \
+	S3C2410_ADCTSC_XP_SEN | \
+	S3C2410_ADCTSC_XY_PST(3))
+
+#define AUTO_XY	(S3C2410_ADCTSC_PULL_UP_DISABLE | \
+	S3C2410_ADCTSC_AUTO_PST | \
+	S3C2410_ADCTSC_XY_PST(0))
+
+#define TS_STATE_STANDBY 0 /* initial state */
+#define TS_STATE_PRESSED 1
+#define TS_STATE_RELEASE_PENDING 2 /* wait to confirm the up event */
+#define TS_STATE_RELEASE 3
+
+#define TIME_RELEASE_PENDING (HZ / 20) /* about 50ms */
+#define TIME_NEXT_CONV ((HZ < 51)? 1 : HZ / 50) /* about 20ms */
+
+static char *s3c24xx_ts_name = "Samsung s3c24xx TouchScreen";
+static void __iomem *base_addr;
+
+
+/*
+ * Per-touchscreen data.
+ */
+
+struct s3c24xx_ts {
+	struct input_dev *dev;
+	struct s3c_adc_client *adc_client;
+	unsigned char is_down;
+	unsigned char state;
+	unsigned adc_selected;
+	unsigned int delay;	/* register value for delay */
+	unsigned int presc;	/* register value for prescaler */
+};
+
+static struct s3c24xx_ts ts;
+
+
+/*
+ * Low level functions to config registers.
+ */
+static inline void s3c24xx_ts_connect(void)
+{
+	s3c2410_gpio_cfgpin(S3C2410_GPG(12), S3C2410_GPG12_XMON);
+	s3c2410_gpio_cfgpin(S3C2410_GPG(13), S3C2410_GPG13_nXPON);
+	s3c2410_gpio_cfgpin(S3C2410_GPG(14), S3C2410_GPG14_YMON);
+	s3c2410_gpio_cfgpin(S3C2410_GPG(15), S3C2410_GPG15_nYPON);
+}
+
+static void s3c24xx_ts_start_adc_conversion(void)
+{
+	pr_debug("start_adc_conv ADCTSC: 0x%x", 
+		readl(base_addr + S3C2410_ADCTSC));
+	writel(AUTO_XY, base_addr + S3C2410_ADCTSC);
+	pr_debug(" ---> 0x%x", 
+		readl(base_addr + S3C2410_ADCTSC));
+	s3c_adc_start(ts.adc_client, 0, 1);
+	pr_debug(" ---> 0x%x\n", 
+		readl(base_addr + S3C2410_ADCTSC));
+}
+
+
+/*
+ * Event handling
+ */
+
+enum ts_input_event {IE_UP = 0, IE_DOWN};
+
+static void ts_input_report(int event, int coords[])
+{
+
+	if (event == IE_DOWN) {
+		input_report_abs(ts.dev, ABS_X, coords[0]);
+		input_report_abs(ts.dev, ABS_Y, coords[1]);
+		input_report_key(ts.dev, BTN_TOUCH, 1);
+		input_report_abs(ts.dev, ABS_PRESSURE, 1);
+
+		pr_debug("down (X:%03d, Y:%03d)\n", coords[0], coords[1]);
+	} else {
+		input_report_key(ts.dev, BTN_TOUCH, 0);
+		input_report_abs(ts.dev, ABS_PRESSURE, 0);
+		pr_debug("up\n");
+	}
+
+	input_sync(ts.dev);
+}
+
+
+/*
+ * Timer to process the UP event or to report the postion of DRAG
+ */
+
+static void ts_drag_pull_timer_f(unsigned long data);
+static struct timer_list ts_drag_pull_timer = 
+	TIMER_INITIALIZER(ts_drag_pull_timer_f, 0, 0);
+
+static void ts_drag_pull_timer_f(unsigned long data)
+{
+	unsigned long flags;
+	/* delay reporting the UP event to avoid jitter */
+	static unsigned release_pending_counter = 0;
+	pr_debug("Timer called: is_down[%d] status[%d]\n", ts.is_down, ts.state);
+
+	local_irq_save(flags);
+	if(ts.state == TS_STATE_RELEASE_PENDING) {
+		if(release_pending_counter++ < 1) {
+			/* jitter avoidance window: delay TIME_RELEASE_PENDING jfs */
+			mod_timer(&ts_drag_pull_timer, jiffies + TIME_RELEASE_PENDING);
+		} else {
+			/* no down event occurd during last delay */
+			release_pending_counter = 0;
+			ts_input_report(IE_UP, NULL);
+			ts.state = TS_STATE_RELEASE;
+			writel(WAIT4INT(0), base_addr + S3C2410_ADCTSC);
+		}
+		local_irq_restore(flags);
+		return;
+	}
+
+	/* ts.is_down should be true here */
+	s3c24xx_ts_start_adc_conversion();
+	local_irq_restore(flags);
+}
+
+
+/*
+ * ISR for the IRQ_TS
+ */
+
+static irqreturn_t stylus_updown(int irq, void *dev_id)
+{
+	unsigned long data0;
+	unsigned long data1;
+	unsigned long adctsc;
+	int event_type;		/* 1 for down, 0 for up */
+
+	/* 
+	 * According to s3c2440 manual chap16: After Touch Screen 
+	 * Controller generates INT_TC, XY_PST must be set to [00]
+	 */
+	adctsc = readl(base_addr + S3C2410_ADCTSC);
+	writel(adctsc & ~(S3C2410_ADCTSC_XY_PST(3)), base_addr + S3C2410_ADCTSC);
+	data0 = readl(base_addr + S3C2410_ADCDAT0);
+	data1 = readl(base_addr + S3C2410_ADCDAT1);
+	event_type = (!(data0 & S3C2410_ADCDAT0_UPDOWN)) &&
+					    (!(data1 & S3C2410_ADCDAT0_UPDOWN));
+	pr_debug("event_type: %d, DATA0 0x%lx, DATA1 0x%lx, ADCTSC 0x%lx, "
+		"ADCUPDN 0x%x\n", event_type, data0, data1,
+		adctsc, readl(base_addr + 0x14));
+
+	/* ignore sequential same event */
+	if(ts.is_down == event_type) {
+		pr_debug("###Ignore same event: %d\n", event_type);
+		/* restore XY_PST */
+		writel(adctsc, base_addr + S3C2410_ADCTSC);
+		return IRQ_HANDLED;
+	}
+
+	ts.is_down = event_type;
+	if (ts.is_down) {
+		s3c24xx_ts_start_adc_conversion();
+	} else {
+		ts.state = TS_STATE_RELEASE_PENDING;
+		/*
+		 * Delay to report the up event for a while to avoid jitter.
+		 * This state will be checked after (0, TIME_NEXT_CONV)
+		 * jiffies depended on when the interrupt occured.
+		 */
+	}
+
+	return IRQ_HANDLED;
+}
+
+/* 
+ * Called in ISR of IRQ_ADC
+ */
+
+static void stylus_adc_action(struct s3c_adc_client *client,
+		unsigned p0, unsigned p1, unsigned *conv_left)
+{
+	int buf[2];
+	unsigned long flags;
+
+	local_irq_save(flags);
+	/* 
+	 * IRQ_TS may rise just in the time window between AUTO_XY mode
+	 * set and this pointer */
+	if(ts.state == TS_STATE_RELEASE_PENDING)
+	{
+		local_irq_restore(flags);
+		return;
+	}
+
+	/* Grab the ADC results. */
+	buf[0] = p0;
+	buf[1] = p1;
+
+	ts_input_report(IE_DOWN, buf);
+	pr_debug("[adc_selected: %d] ADCTSC: 0x%x", 
+		ts.adc_selected, readl(base_addr + S3C2410_ADCTSC));
+
+	writel(WAIT4INT(1), base_addr + S3C2410_ADCTSC);
+	printk(" ---> 0x%x\n", 
+		readl(base_addr + S3C2410_ADCTSC));
+
+	ts.state = TS_STATE_PRESSED;
+	mod_timer(&ts_drag_pull_timer, jiffies + TIME_NEXT_CONV);
+	local_irq_restore(flags);
+}
+
+
+/* 
+ * callback function for s3c-adc
+ */
+
+void adc_selected_f(struct s3c_adc_client *client, unsigned selected)
+{
+	ts.adc_selected = selected;
+}
+
+
+/*
+ * The functions for inserting/removing us as a module.
+ */
+
+static int __init s3c24xx_ts_probe(struct platform_device *pdev)
+{
+	int rc;
+	struct input_dev *input_dev;
+	int ret = 0;
+
+	dev_info(&pdev->dev, "Starting\n");
+	pr_debug("Entering s3c24xx_ts_probe\n");
+
+	base_addr = ioremap(S3C2410_PA_ADC, 0x20);
+	if (base_addr == NULL) {
+		dev_err(&pdev->dev, "Failed to remap register block\n");
+		ret = -ENOMEM;
+		goto fail0;
+	}
+
+	/* Configure GPIOs */
+	s3c24xx_ts_connect();
+
+	writel(WAIT4INT(0), base_addr + S3C2410_ADCTSC);
+
+	/* Initialise input stuff */
+	memset(&ts, 0, sizeof(struct s3c24xx_ts));
+	ts.adc_client =
+		s3c_adc_register(pdev, adc_selected_f, stylus_adc_action, 1);
+	if (!ts.adc_client) {
+			dev_err(&pdev->dev,
+					"Unable to register s3c24xx_ts as s3c_adc client\n");
+			ret = -EIO;
+			goto fail1;
+	}
+
+	/* save prescale EN and VAL in the S3C2410_ADCCON register */
+	ts.presc = readl(base_addr + S3C2410_ADCCON);
+	/* save value of S3C2410_ADCDLY register */
+	ts.delay = readl(base_addr + S3C2410_ADCDLY);
+	pr_debug("platform data: ADCCON=%08x ADCDLY=%08x\n", ts.presc, ts.delay);
+
+	input_dev = input_allocate_device();
+	if (!input_dev) {
+		dev_err(&pdev->dev, "Unable to allocate the input device\n");
+		ret = -ENOMEM;
+		goto fail2;
+	}
+
+	ts.dev = input_dev;
+	ts.dev->evbit[0] = BIT_MASK(EV_SYN) | BIT_MASK(EV_KEY) | BIT_MASK(EV_ABS);
+	ts.dev->keybit[BIT_WORD(BTN_TOUCH)] = BIT_MASK(BTN_TOUCH);
+	input_set_abs_params(ts.dev, ABS_X, 0, 0x3FF, 0, 0);
+	input_set_abs_params(ts.dev, ABS_Y, 0, 0x3FF, 0, 0);
+	input_set_abs_params(ts.dev, ABS_PRESSURE, 0, 1, 0, 0);
+
+	ts.dev->name = s3c24xx_ts_name;
+	ts.dev->id.bustype = BUS_RS232;
+	ts.dev->id.vendor = 0xBAAD;
+	ts.dev->id.product = 0xBEEF;
+	ts.dev->id.version = S3C24XX_TS_VERSION;
+	ts.state = TS_STATE_STANDBY;
+
+	/* Get IRQ */
+	if (request_irq(IRQ_TC, stylus_updown, IRQF_SAMPLE_RANDOM,
+			"s3c24xx_ts_action", ts.dev)) {
+		dev_err(&pdev->dev, "Could not allocate ts IRQ_TC !\n");
+		ret = -EIO;
+		goto fail3;
+	}
+
+	dev_info(&pdev->dev, "Successfully loaded\n");
+
+	/* All went ok, so register to the input system */
+	rc = input_register_device(ts.dev);
+	if (rc) {
+		ret = -EIO;
+		goto fail4;
+	}
+	return 0;
+
+fail4:
+	disable_irq(IRQ_TC);
+	free_irq(IRQ_TC, ts.dev);
+fail3:
+	input_free_device(ts.dev);
+fail2:	
+	s3c_adc_release(ts.adc_client);
+fail1:
+	iounmap(base_addr);
+fail0:
+	return ret;
+}
+
+static int s3c24xx_ts_remove(struct platform_device *pdev)
+{
+	disable_irq(IRQ_TC);
+	free_irq(IRQ_TC, ts.dev);
+	input_unregister_device(ts.dev);
+	input_free_device(ts.dev);
+	s3c_adc_release(ts.adc_client);
+	iounmap(base_addr);
+	return 0;
+}
+
+#ifdef CONFIG_PM
+static int s3c24xx_ts_suspend(struct platform_device *pdev, pm_message_t state)
+{
+	disable_irq(IRQ_TC);
+	ts.presc = readl(base_addr + S3C2410_ADCCON);
+	ts.delay = readl(base_addr + S3C2410_ADCDLY);
+
+	writel(TSC_SLEEP, base_addr + S3C2410_ADCTSC);
+	writel(ts.presc | S3C2410_ADCCON_STDBM, base_addr + S3C2410_ADCCON);
+	return 0;
+}
+
+static int s3c24xx_ts_resume(struct platform_device *pdev)
+{
+	/* Restore registers */
+	writel(ts.presc, base_addr + S3C2410_ADCCON);
+	writel(ts.delay, base_addr + S3C2410_ADCDLY);
+	writel(WAIT4INT(0), base_addr + S3C2410_ADCTSC);
+	enable_irq(IRQ_TC);
+	return 0;
+}
+
+#else
+#define s3c24xx_ts_suspend NULL
+#define s3c24xx_ts_resume  NULL
+#endif
+
+static struct platform_driver s3c24xx_ts_driver = {
+	.driver		= {
+		.name	= "s3c24xx-ts",
+		.owner	= THIS_MODULE,
+	},
+	.probe		= s3c24xx_ts_probe,
+	.remove		= s3c24xx_ts_remove,
+	.suspend 	= s3c24xx_ts_suspend,
+	.resume		= s3c24xx_ts_resume,
+};
+
+static int __init s3c24xx_ts_init(void)
+{
+	int rc;
+
+	rc = platform_driver_register(&s3c24xx_ts_driver);
+	return rc;
+}
+
+static void __exit s3c24xx_ts_exit(void)
+{
+	platform_driver_unregister(&s3c24xx_ts_driver);
+}
+
+module_init(s3c24xx_ts_init);
+module_exit(s3c24xx_ts_exit);
+
