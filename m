From: Shine Liu <shinel@foxmail.com>
Subject: [PATCH v2] input/touchscreen: add S3C24XX SoC touchscreen input
 driver
Date: Tue, 20 Oct 2009 20:16:37 +0800
Message-ID: <1256040997.1600.61.camel@shinel>
References: <1255949661.2060.29.camel@shinel>
	 <20091020013837.GA24370@core.coreip.homeip.net>
Reply-To: shinel@foxmail.com
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtpbg94.qq.com ([119.147.10.253]:53576 "HELO smtpbg94.qq.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751947AbZJTMRb (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 20 Oct 2009 08:17:31 -0400
In-Reply-To: <20091020013837.GA24370@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi Dmitry,

On Mon, 2009-10-19 at 18:38 -0700, Dmitry Torokhov wrote:

> 
> Still, below some comments so that the next iteration of the driver does
> not have the same faults ;)

Thank you for your carefully review. I have removed the unnecessary code
according your comment. And I also removed some redundant head files in
the include section. The error handling in s3c24xx_ts_probe was also
improved. 

I'm very glad to hear any further comment on this patch.

Best Regards,

Shine Liu



Signed-off-by: Shine Liu <liuxian@redflag-linux.com>
-----------------------------------------------------


--- a/drivers/input/touchscreen/Kconfig	2009-10-12 05:43:56.000000000 +0800
+++ b/drivers/input/touchscreen/Kconfig	2009-10-20 10:11:17.000000000 +0800
@@ -307,6 +307,18 @@
 	  To compile this driver as a module, choose M here: the
 	  module will be called atmel_tsadcc.
 
+config TOUCHSCREEN_S3C24XX_TSADCC
+	tristate "Samsung S3C24XX touchscreen input driver"
+	depends on ARCH_S3C2410 && S3C24XX_ADC && INPUT && INPUT_TOUCHSCREEN
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
--- drivers/input/touchscreen/Makefile	2009-10-12 05:43:56.000000000 +0800
+++ drivers/input/touchscreen/Makefile	2009-10-13 20:35:02.000000000 +0800
@@ -10,6 +10,7 @@
 obj-$(CONFIG_TOUCHSCREEN_AD7879)	+= ad7879.o
 obj-$(CONFIG_TOUCHSCREEN_ADS7846)	+= ads7846.o
 obj-$(CONFIG_TOUCHSCREEN_ATMEL_TSADCC)	+= atmel_tsadcc.o
+obj-$(CONFIG_TOUCHSCREEN_S3C24XX_TSADCC)       += s3c24xx_tsadcc.o
 obj-$(CONFIG_TOUCHSCREEN_BITSY)		+= h3600_ts_input.o
 obj-$(CONFIG_TOUCHSCREEN_CORGI)		+= corgi_ts.o
 obj-$(CONFIG_TOUCHSCREEN_GUNZE)		+= gunze.o
--- /dev/null	2009-10-09 10:57:12.360986601 +0800
+++ b/drivers/input/touchscreen/s3c24xx_tsadcc.c	2009-10-20 18:54:13.000000000 +0800
@@ -0,0 +1,440 @@
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
+ * Part of the code comes from the openmoko project.
+ *
+ * Shine Liu <shinel@foxmail.com>
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/input.h>
+#include <linux/timer.h>
+#include <linux/platform_device.h>
+#include <linux/io.h>
+#include <linux/interrupt.h>
+
+#include <mach/regs-gpio.h>
+#include <mach/gpio.h>
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
+#define TIME_NEXT_CONV ((HZ < 50)? 1 : HZ / 50) /* about 20ms */
+
+static char *s3c24xx_ts_name = "Samsung s3c24xx TouchScreen";
+
+static void ts_drag_pull_timer_f(unsigned long data);
+
+
+/*
+ * Per-touchscreen data.
+ */
+
+struct s3c24xx_ts {
+	struct input_dev *input;
+	struct platform_device *pdev;
+	struct s3c_adc_client *adc_client;
+	void __iomem *base_addr;
+	struct timer_list drag_pull_timer;
+
+	unsigned char is_down;
+	unsigned char state;
+	unsigned adc_selected;
+	unsigned int delay;	/* register value for delay */
+	unsigned int presc;	/* register value for prescaler */
+};
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
+static void s3c24xx_ts_start_adc_conversion(struct s3c24xx_ts *ts)
+{
+	dev_dbg(&ts->pdev->dev, "start_adc_conv ADCTSC: 0x%x", 
+		readl(ts->base_addr + S3C2410_ADCTSC));
+	writel(AUTO_XY, ts->base_addr + S3C2410_ADCTSC);
+	dev_dbg(&ts->pdev->dev, " ---> 0x%x", 
+		readl(ts->base_addr + S3C2410_ADCTSC));
+	s3c_adc_start(ts->adc_client, 0, 1);
+	dev_dbg(&ts->pdev->dev, " ---> 0x%x\n", 
+		readl(ts->base_addr + S3C2410_ADCTSC));
+}
+
+
+/*
+ * Event handling
+ */
+
+enum ts_input_event {IE_UP = 0, IE_DOWN};
+
+static void ts_input_report(struct s3c24xx_ts *ts, int event, int coords[])
+{
+	if (event == IE_DOWN) {
+		input_report_abs(ts->input, ABS_X, coords[0]);
+		input_report_abs(ts->input, ABS_Y, coords[1]);
+		input_report_key(ts->input, BTN_TOUCH, 1);
+		dev_dbg(&ts->pdev->dev, "down (X:%03d, Y:%03d)\n", 
+			coords[0], coords[1]);
+	} else {
+		input_report_key(ts->input, BTN_TOUCH, 0);
+		dev_dbg(&ts->pdev->dev, "up\n");
+	}
+
+	input_sync(ts->input);
+}
+
+
+/*
+ * Timer to process the UP event or to report the postion of DRAG
+ */
+
+static void ts_drag_pull_timer_f(unsigned long data)
+{
+	struct s3c24xx_ts *ts = (struct s3c24xx_ts *)data;
+
+	/* delay reporting the UP event to avoid jitter */
+	static unsigned release_pending_counter = 0;
+	dev_dbg(&ts->pdev->dev, "Timer called: is_down[%d] status[%d]\n", 
+		ts->is_down, ts->state);
+
+	if(ts->state == TS_STATE_RELEASE_PENDING) {
+		if(release_pending_counter++ < 1) {
+			/* jitter avoidance: delay TIME_RELEASE_PENDING jfs */
+			mod_timer(&ts->drag_pull_timer, 
+				jiffies + TIME_RELEASE_PENDING);
+		} else {
+			/* no down event occurd during last delay */
+			release_pending_counter = 0;
+			ts_input_report(ts, IE_UP, NULL);
+			ts->state = TS_STATE_RELEASE;
+			writel(WAIT4INT(0), ts->base_addr + S3C2410_ADCTSC);
+		}
+		return;
+	}
+
+	/* ts->is_down should be true here */
+	s3c24xx_ts_start_adc_conversion(ts);
+}
+
+
+/*
+ * ISR for the IRQ_TS
+ */
+
+static irqreturn_t stylus_updown(int irq, void *dev)
+{
+	unsigned long data0;
+	unsigned long data1;
+	unsigned long adctsc;
+	int event_type;		/* 1 for down, 0 for up */
+
+	struct s3c24xx_ts *ts = dev;
+
+	/* 
+	 * According to s3c2440 manual chap16: After Touch Screen 
+	 * Controller generates INT_TC, XY_PST must be set to [00]
+	 */
+	adctsc = readl(ts->base_addr + S3C2410_ADCTSC);
+	writel(adctsc & ~(S3C2410_ADCTSC_XY_PST(3)), 
+		ts->base_addr + S3C2410_ADCTSC);
+	data0 = readl(ts->base_addr + S3C2410_ADCDAT0);
+	data1 = readl(ts->base_addr + S3C2410_ADCDAT1);
+	event_type = (!(data0 & S3C2410_ADCDAT0_UPDOWN)) &&
+					    (!(data1 & S3C2410_ADCDAT0_UPDOWN));
+	dev_dbg(&ts->pdev->dev, "event_type: %d, DATA0 0x%lx, DATA1 0x%lx,"
+		"ADCTSC 0x%lx, ADCUPDN 0x%x\n", event_type, 
+		data0, data1, adctsc, readl(ts->base_addr + 0x14));
+
+	/* ignore sequential the same UP/DOWN event */
+	if(ts->is_down == event_type) {
+		dev_dbg(&ts->pdev->dev, "### Ignore the same UP/DOWN event: %d\n", 
+			event_type);
+		/* restore XY_PST */
+		writel(adctsc, ts->base_addr + S3C2410_ADCTSC);
+		return IRQ_HANDLED;
+	}
+
+	ts->is_down = event_type;
+	if (ts->is_down) {
+		s3c24xx_ts_start_adc_conversion(ts);
+	} else {
+		ts->state = TS_STATE_RELEASE_PENDING;
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
+
+/* 
+ * Called in ISR of IRQ_ADC
+ */
+
+static void stylus_adc_action(struct s3c_adc_client *client,
+		unsigned p0, unsigned p1, unsigned *conv_left)
+{
+	int buf[2];
+	struct s3c24xx_ts *ts = 
+		platform_get_drvdata(*(struct platform_device **)client);
+
+	/* 
+	 * IRQ_TS may rise just in the time window between AUTO_XY mode
+	 * set and this pointer */
+	if(ts->state == TS_STATE_RELEASE_PENDING)
+		return;
+
+	/* Grab the ADC results. */
+	buf[0] = p0;
+	buf[1] = p1;
+
+	ts_input_report(ts, IE_DOWN, buf);
+	dev_dbg(&ts->pdev->dev, "[adc_selected: %d] ADCTSC: 0x%x", 
+		ts->adc_selected, readl(ts->base_addr + S3C2410_ADCTSC));
+
+	writel(WAIT4INT(1), ts->base_addr + S3C2410_ADCTSC);
+	dev_dbg(&ts->pdev->dev ," ---> 0x%x\n",  
+		readl(ts->base_addr + S3C2410_ADCTSC));
+
+	ts->state = TS_STATE_PRESSED;
+	mod_timer(&ts->drag_pull_timer, jiffies + TIME_NEXT_CONV);
+}
+
+
+/* 
+ * callback function for s3c-adc
+ */
+
+void adc_selected_f(struct s3c_adc_client *client, unsigned selected)
+{
+	struct s3c24xx_ts *ts = 
+		platform_get_drvdata(*(struct platform_device **)client);
+
+	ts->adc_selected = selected;
+}
+
+
+/*
+ * The functions for inserting/removing us as a module.
+ */
+
+static int __devinit s3c24xx_ts_probe(struct platform_device *pdev)
+{
+	struct input_dev *input_dev;
+	struct s3c24xx_ts *ts;
+	int err = -ENOMEM;
+	struct timer_list timer_tmp = 
+		TIMER_INITIALIZER(ts_drag_pull_timer_f, 0, 0);
+
+	dev_info(&pdev->dev, "Starting\n");
+	dev_dbg(&pdev->dev, "Entering s3c24xx_ts_probe\n");
+
+	/* Configure GPIOs */
+	s3c24xx_ts_connect();
+
+	/* Initialise input stuff */
+	ts = kzalloc(sizeof(struct s3c24xx_ts), GFP_KERNEL);
+	if (ts == NULL) {
+		dev_err(&pdev->dev, "failed to allocate s3c24xx_ts\n");
+		return -ENOMEM;
+	}
+
+	ts->pdev = pdev;
+	memcpy(&ts->drag_pull_timer, &timer_tmp, sizeof(struct timer_list));
+	ts->drag_pull_timer.data = (unsigned long)ts;
+
+	ts->base_addr = ioremap(S3C2410_PA_ADC, 0x20);
+	if (ts->base_addr == NULL) {
+		dev_err(&pdev->dev, "Failed to remap register block\n");
+		err = -ENXIO;
+		goto err_out_kfree;
+	}
+	ts->presc = readl(ts->base_addr + S3C2410_ADCCON);
+	ts->delay = readl(ts->base_addr + S3C2410_ADCDLY);
+	dev_dbg(&pdev->dev, "platform data: ADCCON=%08x ADCDLY=%08x\n", 
+		ts->presc, ts->delay);
+	writel(WAIT4INT(0), ts->base_addr + S3C2410_ADCTSC);
+
+	ts->adc_client =
+		s3c_adc_register(pdev, adc_selected_f, stylus_adc_action, 1);
+	if (IS_ERR(ts->adc_client)) {
+			dev_err(&pdev->dev,
+					"Unable to register s3c24xx_ts as s3c_adc client\n");
+			err = PTR_ERR(ts->adc_client);
+			goto err_out_iounmap;
+	}
+
+	input_dev = input_allocate_device();
+	if (!input_dev) {
+		dev_err(&pdev->dev, "Unable to allocate the input device\n");
+		err = -ENOMEM;
+		goto err_out_adc_release;
+	}
+	ts->input = input_dev;
+
+	ts->input->evbit[0] = BIT_MASK(EV_SYN) | BIT_MASK(EV_KEY) | BIT_MASK(EV_ABS);
+	ts->input->keybit[BIT_WORD(BTN_TOUCH)] = BIT_MASK(BTN_TOUCH);
+	input_set_abs_params(ts->input, ABS_X, 0, 0x3FF, 0, 0);
+	input_set_abs_params(ts->input, ABS_Y, 0, 0x3FF, 0, 0);
+
+	ts->input->name = s3c24xx_ts_name;
+	ts->input->id.vendor = 0xBAAD;
+	ts->input->id.product = 0xF00D;
+	ts->input->id.version = S3C24XX_TS_VERSION;
+	ts->state = TS_STATE_STANDBY;
+
+	/* Get IRQ */
+	err = request_irq(IRQ_TC, stylus_updown, IRQF_SAMPLE_RANDOM,
+			"s3c24xx_ts_action", ts);
+	if (err < 0) {
+		dev_err(&pdev->dev, "Could not allocate ts IRQ_TC\n");
+		goto err_out_free_dev;
+	}
+
+	/* All went ok, so register to the input system */
+	err = input_register_device(ts->input);
+	if (err < 0) {
+		dev_err(&pdev->dev, "Unable to register to the input system\n");
+		goto err_out_free_irq;
+	}
+	platform_set_drvdata(pdev, ts);
+	return 0;
+
+err_out_free_irq:
+	free_irq(IRQ_TC, ts);
+err_out_free_dev:
+	input_free_device(ts->input);
+err_out_adc_release:	
+	s3c_adc_release(ts->adc_client);
+err_out_iounmap:
+	iounmap(ts->base_addr);
+err_out_kfree:
+	kfree(ts);
+	return err;
+}
+
+static int __devexit s3c24xx_ts_remove(struct platform_device *pdev)
+{
+	struct s3c24xx_ts *ts = platform_get_drvdata(pdev);
+
+	free_irq(IRQ_TC, ts);
+	input_unregister_device(ts->input);
+	s3c_adc_release(ts->adc_client);
+	iounmap(ts->base_addr);
+	kfree(ts);
+	return 0;
+}
+
+#ifdef CONFIG_PM
+static int s3c24xx_ts_pm_suspend(struct device *dev)
+{
+	struct s3c24xx_ts *ts = dev_get_drvdata(dev);
+
+	disable_irq(IRQ_TC);
+	/* save prescale EN and VAL in the S3C2410_ADCCON register */
+	ts->presc = readl(ts->base_addr + S3C2410_ADCCON);
+	/* save value of S3C2410_ADCDLY register */
+	ts->delay = readl(ts->base_addr + S3C2410_ADCDLY);
+
+
+	writel(TSC_SLEEP, ts->base_addr + S3C2410_ADCTSC);
+	writel(ts->presc | S3C2410_ADCCON_STDBM, ts->base_addr + S3C2410_ADCCON);
+	return 0;
+}
+
+static int s3c24xx_ts_pm_resume(struct device *dev)
+{
+	struct s3c24xx_ts *ts = dev_get_drvdata(dev);
+
+	/* Restore registers */
+	writel(ts->presc, ts->base_addr + S3C2410_ADCCON);
+	writel(ts->delay, ts->base_addr + S3C2410_ADCDLY);
+	writel(WAIT4INT(0), ts->base_addr + S3C2410_ADCTSC);
+	enable_irq(IRQ_TC);
+	return 0;
+}
+
+static struct dev_pm_ops s3c24xx_ts_pm_ops = {
+        .suspend        = s3c24xx_ts_pm_suspend,
+        .resume         = s3c24xx_ts_pm_resume,
+};
+
+#else
+#define s3c24xx_ts_pm_ops NULL
+#endif
+
+
+
+static struct platform_driver s3c24xx_ts_driver = {
+	.probe		= s3c24xx_ts_probe,
+	.remove		= __devexit_p(s3c24xx_ts_remove),
+	.driver 	= {
+		.name	= "s3c24xx-ts",
+		.owner	= THIS_MODULE,
+		.pm 	= s3c24xx_ts_pm_ops,
+	},
+};
+
+static int __init s3c24xx_ts_init(void)
+{
+	return platform_driver_register(&s3c24xx_ts_driver);
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



