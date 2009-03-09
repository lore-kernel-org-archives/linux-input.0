From: "Hennerich, Michael" <Michael.Hennerich@analog.com>
Subject: RE: [patch 03/22] input: AD7879 Touchscreen driver
Date: Mon, 9 Mar 2009 15:50:40 -0000
Message-ID: <8A42379416420646B9BFAC9682273B6D094E3A2B@limkexm3.ad.analog.com>
References: <200903041958.n24Jws9R028400@imap1.linux-foundation.org> <8A42379416420646B9BFAC9682273B6D09407D59@limkexm3.ad.analog.com> <20090306100510.GC24864@dtor-d630.eng.vmware.com> <8A42379416420646B9BFAC9682273B6D09407E53@limkexm3.ad.analog.com> <20090308072450.GB7102@dtor-d630.eng.vmware.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_001_01C9A0CE.CD158371"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from nwd2mail11.analog.com ([137.71.25.57]:53840 "EHLO
	nwd2mail11.analog.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753841AbZCIPur (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 9 Mar 2009 11:50:47 -0400
Content-class: urn:content-classes:message
In-Reply-To: <20090308072450.GB7102@dtor-d630.eng.vmware.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: akpm@linux-foundation.org, linux-input@vger.kernel.org, cooloney@kernel.org, randy.dunlap@oracle.com

This is a multi-part message in MIME format.

------_=_NextPart_001_01C9A0CE.CD158371
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi Dmitry,

>I see, it is indeed much better. I have same comment about mutual
>exclusion between enable and disable as with 7877 driver. Could you
>please try the patch below and let me know if I broke the driver or
>not? ;)

Thanks for your efforts.
The driver still works. Please apply the patch below, on top of your
patch.
It fixes a build error and a typo. (ad7879_setup referenced before
defined)=20

Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>

Best regards,
Michael

--- drivers/input/touchscreen/ad7879_dtor.c     2009-03-09
16:13:06.000000000 +0100

+++ drivers/input/touchscreen/ad7879.c  2009-03-09 16:14:20.000000000
+0100

@@ -234,6 +234,31 @@ static irqreturn_t ad7879_irq(int irq, v

        return IRQ_HANDLED;

 }

=20

+static void ad7879_setup(struct ad7879 *ts)

+{

+       ts->cmd_crtl3 =3D AD7879_YPLUS_BIT |

+                       AD7879_XPLUS_BIT |

+                       AD7879_Z2_BIT |

+                       AD7879_Z1_BIT |

+                       AD7879_TEMPMASK_BIT |

+                       AD7879_AUXVBATMASK_BIT |

+                       AD7879_GPIOALERTMASK_BIT;

+

+       ts->cmd_crtl2 =3D AD7879_PM(AD7879_PM_DYN) | AD7879_DFR |

+                       AD7879_AVG(ts->averaging) |

+                       AD7879_MFS(ts->median) |

+                       AD7879_FCD(ts->first_conversion_delay) |

+                       ts->gpio_init;

+

+       ts->cmd_crtl1 =3D AD7879_MODE_INT | AD7879_MODE_SEQ1 |

+                       AD7879_ACQ(ts->acquisition_time) |

+                       AD7879_TMR(ts->pen_down_acc_interval);

+

+       ad7879_write(ts->bus, AD7879_REG_CTRL2, ts->cmd_crtl2);

+       ad7879_write(ts->bus, AD7879_REG_CTRL3, ts->cmd_crtl3);

+       ad7879_write(ts->bus, AD7879_REG_CTRL1, ts->cmd_crtl1);

+}

+

 static void ad7879_disable(struct ad7879 *ts)

 {

        mutex_lock(&ts->mutex);

@@ -341,31 +366,6 @@ static const struct attribute_group ad78

        .attrs =3D ad7879_attributes,

 };

=20

-static void ad7879_setup(struct ad7879 *ts)

-{

-       ts->cmd_crtl3 =3D AD7879_YPLUS_BIT |

-                       AD7879_XPLUS_BIT |

-                       AD7879_Z2_BIT |

-                       AD7879_Z1_BIT |

-                       AD7879_TEMPMASK_BIT |

-                       AD7879_AUXVBATMASK_BIT |

-                       AD7879_GPIOALERTMASK_BIT;

-

-       ts->cmd_crtl2 =3D AD7879_PM(AD7879_PM_DYN) | AD7879_DFR |

-                       AD7879_AVG(ts->averaging) |

-                       AD7879_MFS(ts->median) |

-                       AD7879_FCD(ts->first_conversion_delay) |

-                       ts->gpio_init;

-

-       ts->cmd_crtl1 =3D AD7879_MODE_INT | AD7879_MODE_SEQ1 |

-                       AD7879_ACQ(ts->acquisition_time) |

-                       AD7879_TMR(ts->pen_down_acc_interval);
-
-       ad7879_write(ts->bus, AD7879_REG_CTRL2, ts->cmd_crtl2);
-       ad7879_write(ts->bus, AD7879_REG_CTRL3, ts->cmd_crtl3);
-       ad7879_write(ts->bus, AD7879_REG_CTRL1, ts->cmd_crtl1);
-}
-
 static int __devinit ad7879_construct(bus_device *bus, struct ad7879
*ts)
 {
        struct input_dev *input_dev;
@@ -746,11 +746,11 @@ static int __devexit ad7879_remove(struc
        return 0;
 }

-static const struct i2c_device_id ad7979_id[] =3D {
+static const struct i2c_device_id ad7879_id[] =3D {
        { "ad7879", 0 },
        { }
 };
-MODULE_DEVICE_TABLE(i2c, ad7979_id);
+MODULE_DEVICE_TABLE(i2c, ad7879_id);

 static struct i2c_driver ad7879_driver =3D {
        .driver =3D {
@@ -761,7 +761,7 @@ static struct i2c_driver ad7879_driver =3D
        .remove         =3D __devexit_p(ad7879_remove),
        .suspend        =3D ad7879_suspend,
        .resume         =3D ad7879_resume,
-       .id_table       =3D ad7979_id,
+       .id_table       =3D ad7879_id,
 };

 static int __init ad7879_init(void)

>-----Original Message-----
>From: Dmitry Torokhov [mailto:dmitry.torokhov@gmail.com]
>Sent: Sunday, March 08, 2009 8:25 AM
>To: Hennerich, Michael
>Cc: akpm@linux-foundation.org; linux-input@vger.kernel.org;
>cooloney@kernel.org; randy.dunlap@oracle.com
>Subject: Re: [patch 03/22] input: AD7879 Touchscreen driver
>
>On Fri, Mar 06, 2009 at 10:07:36AM -0000, Hennerich, Michael wrote:
>>
>>
>> >From: Dmitry Torokhov [mailto:dmitry.torokhov@gmail.com]
>> >
>> >Hi Michael,
>> >
>> >On Fri, Mar 06, 2009 at 09:48:17AM -0000, Hennerich, Michael wrote:
>> >>
>> >> Hi Dmitry,
>> >>
>> >> Is there a schedule when this and my other patch get merged
mainline?
>> >>
>> >> [patch 01/22] input/touchscreen driver: add support AD7877
>> touchscreen
>> >> driver
>> >>
>> >> Do you have any concerns or is there something that should be done
>> >> differently?
>> >
>> >I have some concerns with regard to locking in the driver. I had a
>> >preliminary patch but I need to look at it again.
>> >
>> >--
>> >Dmitry
>>
>> Hi Dmitry,
>>
>> I reworked the locking, it's now done differently.
>>
>
>I see, it is indeed much better. I have same comment about mutual
>exclusion between enable and disable as with 7877 driver. Could you
>please try the patch below and let me know if I broke the driver or
>not? ;)
>
>Thanks!
>
>--
>Dmitry
>
>Input: ad7879 fixups
>
>Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
>---
>
> drivers/input/touchscreen/ad7879.c |  193
+++++++++++++++++---------------
>----
> 1 files changed, 89 insertions(+), 104 deletions(-)
>
>
>diff --git a/drivers/input/touchscreen/ad7879.c
>b/drivers/input/touchscreen/ad7879.c
>index 19287af..30b0159 100644
>--- a/drivers/input/touchscreen/ad7879.c
>+++ b/drivers/input/touchscreen/ad7879.c
>@@ -1,7 +1,5 @@
> /*
>- * File:        drivers/input/touchscreen/ad7879.c
>- *
>- *		Copyright (C) 2008 Michael Hennerich, Analog Devices
Inc.
>+ * Copyright (C) 2008 Michael Hennerich, Analog Devices Inc.
>  *
>  * Description:	AD7879 based touchscreen, and GPIO driver
(I2C/SPI
>Interface)
>  *
>@@ -35,7 +33,7 @@
>  *	Copyright (C) 2004 Texas Instruments
>  *	Copyright (C) 2005 Dirk Behme
>  *  - ad7877.c
>- * 	Copyright (C) 2006-2008 Analog Devices Inc.
>+ *	Copyright (C) 2006-2008 Analog Devices Inc.
>  */
>
> #include <linux/device.h>
>@@ -70,11 +68,11 @@
> /* Control REG 1 */
> #define AD7879_TMR(x)			((x & 0xFF) << 0)
> #define AD7879_ACQ(x)			((x & 0x3) << 8)
>-#define AD7879_MODE_NOC  		(0 << 10)	/* Do not
convert */
>-#define AD7879_MODE_SCC  		(1 << 10)	/* Single
channel
>conversion */
>-#define AD7879_MODE_SEQ0 		(2 << 10)	/* Sequence 0 in
Slave Mode
>*/
>-#define AD7879_MODE_SEQ1 		(3 << 10)	/* Sequence 1 in
Master
>Mode */
>-#define AD7879_MODE_INT 		(1 << 15)	/* PENIRQ
disabled INT
>enabled */
>+#define AD7879_MODE_NOC			(0 << 10)	/* Do
not convert */
>+#define AD7879_MODE_SCC			(1 << 10)	/*
Single channel
>conversion */
>+#define AD7879_MODE_SEQ0		(2 << 10)	/* Sequence 0 in
Slave Mode
>*/
>+#define AD7879_MODE_SEQ1		(3 << 10)	/* Sequence 1 in
Master
>Mode */
>+#define AD7879_MODE_INT			(1 << 15)	/*
PENIRQ disabled
>INT enabled */
>
> /* Control REG 2 */
> #define AD7879_FCD(x)			((x & 0x3) << 0)
>@@ -129,18 +127,20 @@ typedef struct i2c_client	bus_device;
> #endif
>
> struct ad7879 {
>-	bus_device 		*bus;
>+	bus_device		*bus;
> 	struct input_dev	*input;
> 	struct work_struct	work;
> 	struct timer_list	timer;
>-	spinlock_t		lock;
>+
>+	struct mutex		mutex;
>+	unsigned		disabled:1;	/* P: mutex */
>
> #if defined(CONFIG_TOUCHSCREEN_AD7879_SPI) ||
>defined(CONFIG_TOUCHSCREEN_AD7879_SPI_MODULE)
> 	struct spi_message	msg;
> 	struct spi_transfer	xfer[AD7879_NR_SENSE + 1];
> 	u16			cmd;
> #endif
>-	u16 			conversion_data[AD7879_NR_SENSE];
>+	u16			conversion_data[AD7879_NR_SENSE];
> 	char			phys[32];
> 	u8			first_conversion_delay;
> 	u8			acquisition_time;
>@@ -153,7 +153,6 @@ struct ad7879 {
> 	u16			cmd_crtl1;
> 	u16			cmd_crtl2;
> 	u16			cmd_crtl3;
>-	unsigned		disabled:1;	/* P: lock */
> 	unsigned		gpio:1;
> };
>
>@@ -163,9 +162,9 @@ static void ad7879_collect(struct ad7879 *);
>
> static void ad7879_report(struct ad7879 *ts)
> {
>-	struct input_dev	*input_dev =3D ts->input;
>-	unsigned		Rt;
>-	u16			x, y, z1, z2;
>+	struct input_dev *input_dev =3D ts->input;
>+	unsigned Rt;
>+	u16 x, y, z1, z2;
>
> 	x =3D ts->conversion_data[AD7879_SEQ_XPOS] & MAX_12BIT;
> 	y =3D ts->conversion_data[AD7879_SEQ_YPOS] & MAX_12BIT;
>@@ -187,10 +186,7 @@ static void ad7879_report(struct ad7879 *ts)
> 		Rt =3D (z2 - z1) * x * ts->x_plate_ohms;
> 		Rt /=3D z1;
> 		Rt =3D (Rt + 2047) >> 12;
>-	} else
>-		Rt =3D 0;
>
>-	if (Rt) {
> 		input_report_abs(input_dev, ABS_X, x);
> 		input_report_abs(input_dev, ABS_Y, y);
> 		input_report_abs(input_dev, ABS_PRESSURE, Rt);
>@@ -218,7 +214,7 @@ static void ad7879_ts_event_release(struct ad7879
*ts)
>
> static void ad7879_timer(unsigned long handle)
> {
>-	struct ad7879	*ts =3D (void *)handle;
>+	struct ad7879 *ts =3D (void *)handle;
>
> 	ad7879_ts_event_release(ts);
> }
>@@ -240,40 +236,36 @@ static irqreturn_t ad7879_irq(int irq, void
*handle)
>
> static void ad7879_disable(struct ad7879 *ts)
> {
>-	unsigned long flags;
>+	mutex_lock(&ts->mutex);
>
>-	spin_lock_irqsave(&ts->lock, flags);
>-	if (ts->disabled) {
>-		spin_unlock_irqrestore(&ts->lock, flags);
>-		return;
>-	}
>+	if (!ts->disabled) {
>
>-	ts->disabled =3D 1;
>-	disable_irq(ts->bus->irq);
>-	spin_unlock_irqrestore(&ts->lock, flags);
>+		ts->disabled =3D 1;
>+		disable_irq(ts->bus->irq);
>
>-	cancel_work_sync(&ts->work);
>+		cancel_work_sync(&ts->work);
>
>-	if (del_timer_sync(&ts->timer))
>-		ad7879_ts_event_release(ts);
>+		if (del_timer_sync(&ts->timer))
>+			ad7879_ts_event_release(ts);
>
>-	/* we know the chip's in lowpower mode since we always
>-	 * leave it that way after every request
>-	 */
>+		ad7879_write(ts->bus, AD7879_REG_CTRL2,
>+			     AD7879_PM(AD7879_PM_SHUTDOWN));
>+	}
>+
>+	mutex_unlock(&ts->mutex);
> }
>
> static void ad7879_enable(struct ad7879 *ts)
> {
>-	unsigned long flags;
>+	mutex_lock(&ts->mutex);
>
>-	spin_lock_irqsave(&ts->lock, flags);
> 	if (ts->disabled) {
>-		spin_unlock_irqrestore(&ts->lock, flags);
>-		return;
>+		ad7879_setup(ts);
>+		ts->disabled =3D 0;
>+		enable_irq(ts->bus->irq);
> 	}
>-	ts->disabled =3D 0;
>-	enable_irq(ts->bus->irq);
>-	spin_unlock_irqrestore(&ts->lock, flags);
>+
>+	mutex_unlock(&ts->mutex);
> }
>
> static ssize_t ad7879_disable_show(struct device *dev,
>@@ -290,12 +282,11 @@ static ssize_t ad7879_disable_store(struct device
>*dev,
> {
> 	struct ad7879 *ts =3D dev_get_drvdata(dev);
> 	unsigned long val;
>-	int ret;
>-
>-	ret =3D strict_strtoul(buf, 10, &val);
>+	int error;
>
>-	if (ret)
>-		return ret;
>+	error =3D strict_strtoul(buf, 10, &val);
>+	if (error)
>+		return error;
>
> 	if (val)
> 		ad7879_disable(ts);
>@@ -321,22 +312,21 @@ static ssize_t ad7879_gpio_store(struct device
*dev,
> {
> 	struct ad7879 *ts =3D dev_get_drvdata(dev);
> 	unsigned long val;
>-	int ret;
>+	int error;
>
>-	ret =3D strict_strtoul(buf, 10, &val);
>-	if (ret)
>-		return ret;
>+	error =3D strict_strtoul(buf, 10, &val);
>+	if (error)
>+		return error;
>
>+	mutex_lock(&ts->mutex);
> 	ts->gpio =3D !!val;
>+	error =3D ad7879_write(ts->bus, AD7879_REG_CTRL2,
>+			   ts->gpio ?
>+				ts->cmd_crtl2 & ~AD7879_GPIO_DATA :
>+				ts->cmd_crtl2 | AD7879_GPIO_DATA);
>+	mutex_unlock(&ts->mutex);
>
>-	ret =3D ad7879_write(ts->bus, AD7879_REG_CTRL2,
>-			ts->gpio ? ts->cmd_crtl2 & ~AD7879_GPIO_DATA
>-			: ts->cmd_crtl2 | AD7879_GPIO_DATA);
>-
>-	if (ret)
>-		return ret;
>-
>-	return count;
>+	return error ? : count;
> }
>
> static DEVICE_ATTR(gpio, 0664, ad7879_gpio_show, ad7879_gpio_store);
>@@ -351,7 +341,7 @@ static const struct attribute_group
ad7879_attr_group =3D
>{
> 	.attrs =3D ad7879_attributes,
> };
>
>-static void ad7879_setup(bus_device *bus, struct ad7879 *ts)
>+static void ad7879_setup(struct ad7879 *ts)
> {
> 	ts->cmd_crtl3 =3D AD7879_YPLUS_BIT |
> 			AD7879_XPLUS_BIT |
>@@ -371,9 +361,9 @@ static void ad7879_setup(bus_device *bus, struct
ad7879
>*ts)
> 			AD7879_ACQ(ts->acquisition_time) |
> 			AD7879_TMR(ts->pen_down_acc_interval);
>
>-	ad7879_write(bus, AD7879_REG_CTRL2, ts->cmd_crtl2);
>-	ad7879_write(bus, AD7879_REG_CTRL3, ts->cmd_crtl3);
>-	ad7879_write(bus, AD7879_REG_CTRL1, ts->cmd_crtl1);
>+	ad7879_write(ts->bus, AD7879_REG_CTRL2, ts->cmd_crtl2);
>+	ad7879_write(ts->bus, AD7879_REG_CTRL3, ts->cmd_crtl3);
>+	ad7879_write(ts->bus, AD7879_REG_CTRL1, ts->cmd_crtl1);
> }
>
> static int __devinit ad7879_construct(bus_device *bus, struct ad7879
*ts)
>@@ -401,7 +391,7 @@ static int __devinit ad7879_construct(bus_device
*bus,
>struct ad7879 *ts)
>
> 	setup_timer(&ts->timer, ad7879_timer, (unsigned long) ts);
> 	INIT_WORK(&ts->work, ad7879_work);
>-	spin_lock_init(&ts->lock);
>+	mutex_init(&ts->mutex);
>
> 	ts->x_plate_ohms =3D pdata->x_plate_ohms ? : 400;
> 	ts->pressure_max =3D pdata->pressure_max ? : ~0;
>@@ -418,7 +408,7 @@ static int __devinit ad7879_construct(bus_device
*bus,
>struct ad7879 *ts)
> 	else
> 		ts->gpio_init =3D AD7879_GPIO_EN | AD7879_GPIODIR;
>
>-	snprintf(ts->phys, sizeof(ts->phys), "%s/inputX", dev_name(&bus-
>>dev));
>+	snprintf(ts->phys, sizeof(ts->phys), "%s/input0", dev_name(&bus-
>>dev));
>
> 	input_dev->name =3D "AD7879 Touchscreen";
> 	input_dev->phys =3D ts->phys;
>@@ -455,10 +445,11 @@ static int __devinit ad7879_construct(bus_device
>*bus, struct ad7879 *ts)
> 		goto err_free_mem;
> 	}
>
>-	ad7879_setup(bus, ts);
>+	ad7879_setup(ts);
>
>-	err =3D request_irq(bus->irq, ad7879_irq, IRQF_TRIGGER_FALLING |
>-		IRQF_SAMPLE_RANDOM, bus->dev.driver->name, ts);
>+	err =3D request_irq(bus->irq, ad7879_irq,
>+			  IRQF_TRIGGER_FALLING | IRQF_SAMPLE_RANDOM,
>+			  bus->dev.driver->name, ts);
>
> 	if (err) {
> 		dev_err(&bus->dev, "irq %d busy?\n", bus->irq);
>@@ -474,7 +465,7 @@ static int __devinit ad7879_construct(bus_device
*bus,
>struct ad7879 *ts)
> 		goto err_remove_attr;
>
> 	dev_info(&bus->dev, "Rev.%d touchscreen, irq %d\n",
>-		revid >> 8, bus->irq);
>+		 revid >> 8, bus->irq);
>
> 	return 0;
>
>@@ -491,8 +482,6 @@ err_free_mem:
> static int __devexit ad7879_destroy(bus_device *bus, struct ad7879
*ts)
> {
> 	ad7879_disable(ts);
>-	ad7879_write(ts->bus, AD7879_REG_CTRL2,
>-			AD7879_PM(AD7879_PM_SHUTDOWN));
> 	sysfs_remove_group(&ts->bus->dev.kobj, &ad7879_attr_group);
> 	free_irq(ts->bus->irq, ts);
> 	input_unregister_device(ts->input);
>@@ -507,8 +496,6 @@ static int ad7879_suspend(bus_device *bus,
pm_message_t
>message)
> 	struct ad7879 *ts =3D dev_get_drvdata(&bus->dev);
>
> 	ad7879_disable(ts);
>-	ad7879_write(bus, AD7879_REG_CTRL2,
>-			AD7879_PM(AD7879_PM_SHUTDOWN));
>
> 	return 0;
> }
>@@ -517,7 +504,6 @@ static int ad7879_resume(bus_device *bus)
> {
> 	struct ad7879 *ts =3D dev_get_drvdata(&bus->dev);
>
>-	ad7879_setup(bus, ts);
> 	ad7879_enable(ts);
>
> 	return 0;
>@@ -531,8 +517,8 @@ static int ad7879_resume(bus_device *bus)
> #define MAX_SPI_FREQ_HZ		5000000
> #define AD7879_CMD_MAGIC	0xE000
> #define AD7879_CMD_READ		(1 << 10)
>-#define AD7879_WRITECMD(reg)  	(AD7879_CMD_MAGIC | (reg & 0xF))
>-#define AD7879_READCMD(reg)  	(AD7879_CMD_MAGIC | AD7879_CMD_READ |
>(reg & 0xF))
>+#define AD7879_WRITECMD(reg)	(AD7879_CMD_MAGIC | (reg & 0xF))
>+#define AD7879_READCMD(reg)	(AD7879_CMD_MAGIC | AD7879_CMD_READ |
(reg &
>0xF))
>
> struct ser_req {
> 	u16			command;
>@@ -548,9 +534,10 @@ struct ser_req {
>
> static int ad7879_read(struct spi_device *spi, u8 reg)
> {
>-	struct ser_req *req =3D kzalloc(sizeof *req, GFP_KERNEL);
>+	struct ser_req *req;
> 	int status, ret;
>
>+	req =3D kzalloc(sizeof *req, GFP_KERNEL);
> 	if (!req)
> 		return -ENOMEM;
>
>@@ -567,11 +554,8 @@ static int ad7879_read(struct spi_device *spi, u8
reg)
> 	spi_message_add_tail(&req->xfer[1], &req->msg);
>
> 	status =3D spi_sync(spi, &req->msg);
>+	ret =3D status ? : req->data;
>
>-	if (status =3D=3D 0)
>-		status =3D req->msg.status;
>-
>-	ret =3D status ? status : req->data;
> 	kfree(req);
>
> 	return ret;
>@@ -579,9 +563,10 @@ static int ad7879_read(struct spi_device *spi, u8
reg)
>
> static int ad7879_write(struct spi_device *spi, u8 reg, u16 val)
> {
>-	struct ser_req *req =3D kzalloc(sizeof *req, GFP_KERNEL);
>+	struct ser_req *req;
> 	int status;
>
>+	req =3D kzalloc(sizeof *req, GFP_KERNEL);
> 	if (!req)
> 		return -ENOMEM;
>
>@@ -600,9 +585,6 @@ static int ad7879_write(struct spi_device *spi, u8
reg,
>u16 val)
>
> 	status =3D spi_sync(spi, &req->msg);
>
>-	if (status =3D=3D 0)
>-		status =3D req->msg.status;
>-
> 	kfree(req);
>
> 	return status;
>@@ -611,6 +593,7 @@ static int ad7879_write(struct spi_device *spi, u8
reg,
>u16 val)
> static void ad7879_collect(struct ad7879 *ts)
> {
> 	int status =3D spi_sync(ts->bus, &ts->msg);
>+
> 	if (status)
> 		dev_err(&ts->bus->dev, "spi_sync --> %d\n", status);
> }
>@@ -639,7 +622,7 @@ static void ad7879_setup_ts_def_msg(struct ad7879
*ts)
> static int __devinit ad7879_probe(struct spi_device *spi)
> {
> 	struct ad7879 *ts;
>-	int ret;
>+	int error;
>
> 	/* don't exceed max specified SPI CLK frequency */
> 	if (spi->max_speed_hz > MAX_SPI_FREQ_HZ) {
>@@ -656,14 +639,13 @@ static int __devinit ad7879_probe(struct
spi_device
>*spi)
>
> 	ad7879_setup_ts_def_msg(ts);
>
>-	ret =3D ad7879_construct(spi, ts);
>-	if (!ret)
>-		return ret;
>-
>-	dev_set_drvdata(&spi->dev, NULL);
>-	kfree(ts);
>+	error =3D ad7879_construct(spi, ts);
>+	if (error) {
>+		dev_set_drvdata(&spi->dev, NULL);
>+		kfree(ts);
>+	}
>
>-	return ret;
>+	return 0;
> }
>
> static int __devexit ad7879_remove(struct spi_device *spi)
>@@ -673,6 +655,7 @@ static int __devexit ad7879_remove(struct
spi_device
>*spi)
> 	ad7879_destroy(spi, ts);
> 	dev_set_drvdata(&spi->dev, NULL);
> 	kfree(ts);
>+
> 	return 0;
> }
>
>@@ -718,16 +701,17 @@ static int ad7879_write(struct i2c_client
*client, u8
>reg, u16 val)
> static void ad7879_collect(struct ad7879 *ts)
> {
> 	int i;
>+
> 	for (i =3D 0; i < AD7879_NR_SENSE; i++)
>-		ts->conversion_data[i] =3D
>-			ad7879_read(ts->bus, AD7879_REG_XPLUS + i);
>+		ts->conversion_data[i] =3D ad7879_read(ts->bus,
>+						     AD7879_REG_XPLUS +
i);
> }
>
> static int __devinit ad7879_probe(struct i2c_client *client,
> 					const struct i2c_device_id *id)
> {
> 	struct ad7879 *ts;
>-	int ret;
>+	int error;
>
> 	if (!i2c_check_functionality(client->adapter,
> 					I2C_FUNC_SMBUS_WORD_DATA)) {
>@@ -742,14 +726,13 @@ static int __devinit ad7879_probe(struct
i2c_client
>*client,
> 	i2c_set_clientdata(client, ts);
> 	ts->bus =3D client;
>
>-	ret =3D ad7879_construct(client, ts);
>-	if (!ret)
>-		return ret;
>-
>-	i2c_set_clientdata(client, NULL);
>-	kfree(ts);
>+	error =3D ad7879_construct(client, ts);
>+	if (error) {
>+		i2c_set_clientdata(client, NULL);
>+		kfree(ts);
>+	}
>
>-	return ret;
>+	return 0;
> }
>
> static int __devexit ad7879_remove(struct i2c_client *client)
>@@ -759,8 +742,10 @@ static int __devexit ad7879_remove(struct
i2c_client
>*client)
> 	ad7879_destroy(client, ts);
> 	i2c_set_clientdata(client, NULL);
> 	kfree(ts);
>+
> 	return 0;
> }
>+
> static const struct i2c_device_id ad7979_id[] =3D {
> 	{ "ad7879", 0 },
> 	{ }
>@@ -776,7 +761,7 @@ static struct i2c_driver ad7879_driver =3D {
> 	.remove		=3D __devexit_p(ad7879_remove),
> 	.suspend	=3D ad7879_suspend,
> 	.resume		=3D ad7879_resume,
>-	.id_table 	=3D ad7979_id,
>+	.id_table	=3D ad7979_id,
> };
>
> static int __init ad7879_init(void)

------_=_NextPart_001_01C9A0CE.CD158371
Content-Type: application/octet-stream;
	name="input-ad7879-fixups-fix-typos.patch"
Content-Transfer-Encoding: base64
Content-Description: input-ad7879-fixups-fix-typos.patch
Content-Disposition: attachment;
	filename="input-ad7879-fixups-fix-typos.patch"

LS0tIGRyaXZlcnMvaW5wdXQvdG91Y2hzY3JlZW4vYWQ3ODc5X2R0b3IuYwkyMDA5LTAzLTA5IDE2
OjEzOjA2LjAwMDAwMDAwMCArMDEwMAorKysgZHJpdmVycy9pbnB1dC90b3VjaHNjcmVlbi9hZDc4
NzkuYwkyMDA5LTAzLTA5IDE2OjE0OjIwLjAwMDAwMDAwMCArMDEwMApAQCAtMjM0LDYgKzIzNCwz
MSBAQCBzdGF0aWMgaXJxcmV0dXJuX3QgYWQ3ODc5X2lycShpbnQgaXJxLCB2CiAJcmV0dXJuIElS
UV9IQU5ETEVEOwogfQogCitzdGF0aWMgdm9pZCBhZDc4Nzlfc2V0dXAoc3RydWN0IGFkNzg3OSAq
dHMpCit7CisJdHMtPmNtZF9jcnRsMyA9IEFENzg3OV9ZUExVU19CSVQgfAorCQkJQUQ3ODc5X1hQ
TFVTX0JJVCB8CisJCQlBRDc4NzlfWjJfQklUIHwKKwkJCUFENzg3OV9aMV9CSVQgfAorCQkJQUQ3
ODc5X1RFTVBNQVNLX0JJVCB8CisJCQlBRDc4NzlfQVVYVkJBVE1BU0tfQklUIHwKKwkJCUFENzg3
OV9HUElPQUxFUlRNQVNLX0JJVDsKKworCXRzLT5jbWRfY3J0bDIgPSBBRDc4NzlfUE0oQUQ3ODc5
X1BNX0RZTikgfCBBRDc4NzlfREZSIHwKKwkJCUFENzg3OV9BVkcodHMtPmF2ZXJhZ2luZykgfAor
CQkJQUQ3ODc5X01GUyh0cy0+bWVkaWFuKSB8CisJCQlBRDc4NzlfRkNEKHRzLT5maXJzdF9jb252
ZXJzaW9uX2RlbGF5KSB8CisJCQl0cy0+Z3Bpb19pbml0OworCisJdHMtPmNtZF9jcnRsMSA9IEFE
Nzg3OV9NT0RFX0lOVCB8IEFENzg3OV9NT0RFX1NFUTEgfAorCQkJQUQ3ODc5X0FDUSh0cy0+YWNx
dWlzaXRpb25fdGltZSkgfAorCQkJQUQ3ODc5X1RNUih0cy0+cGVuX2Rvd25fYWNjX2ludGVydmFs
KTsKKworCWFkNzg3OV93cml0ZSh0cy0+YnVzLCBBRDc4NzlfUkVHX0NUUkwyLCB0cy0+Y21kX2Ny
dGwyKTsKKwlhZDc4Nzlfd3JpdGUodHMtPmJ1cywgQUQ3ODc5X1JFR19DVFJMMywgdHMtPmNtZF9j
cnRsMyk7CisJYWQ3ODc5X3dyaXRlKHRzLT5idXMsIEFENzg3OV9SRUdfQ1RSTDEsIHRzLT5jbWRf
Y3J0bDEpOworfQorCiBzdGF0aWMgdm9pZCBhZDc4NzlfZGlzYWJsZShzdHJ1Y3QgYWQ3ODc5ICp0
cykKIHsKIAltdXRleF9sb2NrKCZ0cy0+bXV0ZXgpOwpAQCAtMzQxLDMxICszNjYsNiBAQCBzdGF0
aWMgY29uc3Qgc3RydWN0IGF0dHJpYnV0ZV9ncm91cCBhZDc4CiAJLmF0dHJzID0gYWQ3ODc5X2F0
dHJpYnV0ZXMsCiB9OwogCi1zdGF0aWMgdm9pZCBhZDc4Nzlfc2V0dXAoc3RydWN0IGFkNzg3OSAq
dHMpCi17Ci0JdHMtPmNtZF9jcnRsMyA9IEFENzg3OV9ZUExVU19CSVQgfAotCQkJQUQ3ODc5X1hQ
TFVTX0JJVCB8Ci0JCQlBRDc4NzlfWjJfQklUIHwKLQkJCUFENzg3OV9aMV9CSVQgfAotCQkJQUQ3
ODc5X1RFTVBNQVNLX0JJVCB8Ci0JCQlBRDc4NzlfQVVYVkJBVE1BU0tfQklUIHwKLQkJCUFENzg3
OV9HUElPQUxFUlRNQVNLX0JJVDsKLQotCXRzLT5jbWRfY3J0bDIgPSBBRDc4NzlfUE0oQUQ3ODc5
X1BNX0RZTikgfCBBRDc4NzlfREZSIHwKLQkJCUFENzg3OV9BVkcodHMtPmF2ZXJhZ2luZykgfAot
CQkJQUQ3ODc5X01GUyh0cy0+bWVkaWFuKSB8Ci0JCQlBRDc4NzlfRkNEKHRzLT5maXJzdF9jb252
ZXJzaW9uX2RlbGF5KSB8Ci0JCQl0cy0+Z3Bpb19pbml0OwotCi0JdHMtPmNtZF9jcnRsMSA9IEFE
Nzg3OV9NT0RFX0lOVCB8IEFENzg3OV9NT0RFX1NFUTEgfAotCQkJQUQ3ODc5X0FDUSh0cy0+YWNx
dWlzaXRpb25fdGltZSkgfAotCQkJQUQ3ODc5X1RNUih0cy0+cGVuX2Rvd25fYWNjX2ludGVydmFs
KTsKLQotCWFkNzg3OV93cml0ZSh0cy0+YnVzLCBBRDc4NzlfUkVHX0NUUkwyLCB0cy0+Y21kX2Ny
dGwyKTsKLQlhZDc4Nzlfd3JpdGUodHMtPmJ1cywgQUQ3ODc5X1JFR19DVFJMMywgdHMtPmNtZF9j
cnRsMyk7Ci0JYWQ3ODc5X3dyaXRlKHRzLT5idXMsIEFENzg3OV9SRUdfQ1RSTDEsIHRzLT5jbWRf
Y3J0bDEpOwotfQotCiBzdGF0aWMgaW50IF9fZGV2aW5pdCBhZDc4NzlfY29uc3RydWN0KGJ1c19k
ZXZpY2UgKmJ1cywgc3RydWN0IGFkNzg3OSAqdHMpCiB7CiAJc3RydWN0IGlucHV0X2RldiAqaW5w
dXRfZGV2OwpAQCAtNzQ2LDExICs3NDYsMTEgQEAgc3RhdGljIGludCBfX2RldmV4aXQgYWQ3ODc5
X3JlbW92ZShzdHJ1YwogCXJldHVybiAwOwogfQogCi1zdGF0aWMgY29uc3Qgc3RydWN0IGkyY19k
ZXZpY2VfaWQgYWQ3OTc5X2lkW10gPSB7CitzdGF0aWMgY29uc3Qgc3RydWN0IGkyY19kZXZpY2Vf
aWQgYWQ3ODc5X2lkW10gPSB7CiAJeyAiYWQ3ODc5IiwgMCB9LAogCXsgfQogfTsKLU1PRFVMRV9E
RVZJQ0VfVEFCTEUoaTJjLCBhZDc5NzlfaWQpOworTU9EVUxFX0RFVklDRV9UQUJMRShpMmMsIGFk
Nzg3OV9pZCk7CiAKIHN0YXRpYyBzdHJ1Y3QgaTJjX2RyaXZlciBhZDc4NzlfZHJpdmVyID0gewog
CS5kcml2ZXIgPSB7CkBAIC03NjEsNyArNzYxLDcgQEAgc3RhdGljIHN0cnVjdCBpMmNfZHJpdmVy
IGFkNzg3OV9kcml2ZXIgPQogCS5yZW1vdmUJCT0gX19kZXZleGl0X3AoYWQ3ODc5X3JlbW92ZSks
CiAJLnN1c3BlbmQJPSBhZDc4Nzlfc3VzcGVuZCwKIAkucmVzdW1lCQk9IGFkNzg3OV9yZXN1bWUs
Ci0JLmlkX3RhYmxlCT0gYWQ3OTc5X2lkLAorCS5pZF90YWJsZQk9IGFkNzg3OV9pZCwKIH07CiAK
IHN0YXRpYyBpbnQgX19pbml0IGFkNzg3OV9pbml0KHZvaWQpCg==

------_=_NextPart_001_01C9A0CE.CD158371--
