From: Oliver Neukum <oneukum@suse.de>
Subject: Re: [PATCH 1/2] INPUT/HID: add touch support for SiS touch driver
Date: Fri, 16 Jan 2015 14:11:02 +0100
Message-ID: <1421413862.17198.23.camel@linux-0dmf.site>
References: <8322374EB97AA24A95D0DDBFC8F1CA1DBF987B@SISMBEV01.sis.com.tw>
	 <1421063449.12454.17.camel@linux-0dmf.site>
	 <CAKR5kVFXy4GdZdHFnW2AAjqkcHfgfM5b0NhkOa079bftOoKqUQ@mail.gmail.com>
	 <8322374EB97AA24A95D0DDBFC8F1CA1DBF9DE5@SISMBEV01.sis.com.tw>
	 <8322374EB97AA24A95D0DDBFC8F1CA1DBF9E1B@SISMBEV01.sis.com.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:40994 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751649AbbAPNLQ (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 16 Jan 2015 08:11:16 -0500
In-Reply-To: <8322374EB97AA24A95D0DDBFC8F1CA1DBF9E1B@SISMBEV01.sis.com.tw>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "=?UTF-8?Q?=E6=9B=BE=E5=A9=B7=E8=91=B3?= (tammy_tseng)" <tammy_tseng@sis.com>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, tammy0524@gmail.com

On Fri, 2015-01-16 at 18:59 +0800, =E6=9B=BE=E5=A9=B7=E8=91=B3 (tammy_t=
seng) wrote:
> Hey, Oliver
>=20
> On Mon, Jan 12, 2015 at 7:50 PM, Oliver Neukum <oneukum@suse.de> wrot=
e:
> On Mon, 2015-01-12 at 18:53 +0800, =E6=9B=BE=E5=A9=B7=E8=91=B3 (tammy=
_tseng) wrote:
> > > (Skip the code diff...)
> >=20
> > Again macros for endianness
> >=20
> > And the driver has a great number of conditional compilations are t=
hey=20
> > really needed? The driver as is has a number of issues and is hard =
to=20
> > review due to the use of "//" for comments and a lot of conditional=
=20
> > compilation and unnecessary variables used for constants. Could you=
=20
> > fix this up and resubmit?
>=20
> Thanks for the reply. I've modified the code (sis_i2c.c/sis_i2c.h/Kco=
nfig/Makefile) to fix them.
> Please help check them if anything needs to fix.

Hi,

I started from the lower end. I hope you find my comments
useful. A few general points need to be made before the
code is ready for review (it is obviously not ready for
inclusion)

1. We don't do conditional compilation unless we absolutely have
to in the kernel. The support for earlier kernel versions has
to be ripped out of the code.

2. You must use the symbolic names of error codes. They are not
guaranteed to be uniform among architectures.

3. If you need to sleep at places without obvious need, you need
to include comments explaining the reason.

4. No comments with "//"

Please redo these things and resubmit.

	Regards
		Oliver

> +/* for get system time */
> +static ssize_t sis_cdev_read( struct file *file, char __user *buf, s=
ize_t count, loff_t *f_pos )
> +{
> +	 int ret =3D 0;
> +	 char *kdata;
> +	 char cmd;
> +	 int i;
> +	=20
> +	 printk(KERN_INFO "sis_cdev_read.\n");
> +	=20
> +	 if (ts_bak =3D=3D 0)
> +    	return -13;
symbolic name necessary

> +    =09
> +    ret =3D access_ok(VERIFY_WRITE, buf, BUFFER_SIZE);
> +    if (!ret) {
> +        printk(KERN_ERR "cannot access user space memory\n");
> +        return -11;
symbolic name necessary
> +    }
> +
> +	 kdata =3D kmalloc(BUFFER_SIZE, GFP_KERNEL);
> +     if (kdata =3D=3D 0)
> +    	return -12;
symbolic name necessary
> +    =09
> +     ret =3D copy_from_user(kdata, buf, BUFFER_SIZE);
> +     if (ret) {
> +        printk(KERN_ERR "copy_from_user fail\n");
> +        kfree(kdata);
> +        return -14;
symbolic name necessary
> +     }   =20
> +#if 0
> +    PrintBuffer(0, count, kdata);
> +#endif
> +	 cmd =3D kdata[6];
> +	 /* for making sure AP communicates with SiS driver */
> +    if(cmd =3D=3D 0xa2)
> +    {
> +		kdata[0] =3D 5;
> +		kdata[1] =3D 0;
> +		kdata[3] =3D 'S';
> +		kdata[4] =3D 'i';
> +		kdata[5] =3D 'S';
> +		if ( copy_to_user((char*) buf, kdata, BUFFER_SIZE ) )
What is happening here?
> +		{
> +			printk(KERN_ERR "copy_to_user fail\n" );
> +			kfree( kdata );
> +			return -19;
symbolic name needed
> +		}
> +
> +		kfree( kdata );
> +		return 3;
Why?
> =09
> +	}
> +/* Write & Read */
> +    ret =3D sis_command_for_read(ts_bak->client, MAX_BYTE, kdata);
> +    if (ret < 0) {
> +        printk(KERN_ERR "i2c_transfer read error %d\n", ret);
> +		kfree(kdata);
> +		return -21;
symbolic name needed
> +	}
> +
> +	ret =3D kdata[0] | (kdata[1] << 8);
Use the macros endianness conversion.

In this case
ret =3D le16_to_cpu(kdata + 0);

> +    printk(KERN_INFO "%d\n", ret);
> +
> +    for ( i =3D 0; i < ret && i < BUFFER_SIZE; i++ )
> +    {
> +        printk("%02x ", kdata[i]);
> +    }
> +
> +    printk( "\n" );
> +
> +    if ( copy_to_user((char*) buf, kdata, BUFFER_SIZE ) )
> +    {
> +        printk(KERN_ERR "copy_to_user fail\n" );
> +        ret =3D -19;
What is this to mean? I suppose it is an error code. The symbolic
values must be used.
> +    }
> +
> +    kfree( kdata );
> +
> +	return ret;
> +}
> +
> +#undef BUFFER_SIZE
> +
> +static int sis_cdev_open(struct inode *inode, struct file *filp)
> +{
> +	printk(KERN_INFO "sis_cdev_open.\n");
> +	if ( ts_bak =3D=3D 0 )
> +    	return -13;

What is this to mean?
> +
> +	msleep(200);

Why?
> +	if (ts_bak->use_irq)
> +	{
> +#if ( LINUX_VERSION_CODE < KERNEL_VERSION (2, 6, 39) )
> +        if ((ts_bak->desc->status & IRQ_DISABLED) =3D=3D IRQ_STATUS_=
ENABLED)
> +#else
> +		if ((ts_bak->desc->irq_data.state_use_accessors & IRQD_IRQ_DISABLE=
D) =3D=3D IRQ_STATUS_ENABLED)
> +#endif=09
> +		{
> +			disable_irq(ts_bak->client->irq);
> +		}
> +		else
> +		{
> +#if ( LINUX_VERSION_CODE < KERNEL_VERSION (2, 6, 39) )
You are submitting for a defined kernel version. This needs to
go away.
> +			printk(KERN_INFO "sis_cdev_open: IRQ_STATUS: %x\n",(ts_bak->desc-=
>status & IRQ_DISABLED));
> +#else
> +			printk(KERN_INFO "sis_cdev_open: IRQ_STATUS: %x\n",(ts_bak->desc-=
>irq_data.state_use_accessors & IRQD_IRQ_DISABLED));
> +#endif=09
> +		}
> +	}
> +	hrtimer_cancel(&ts_bak->timer);
> +
> +	/* only flush sis_wq */
> +	flush_workqueue(sis_wq); 	  =20
> +   =20
> +    msleep(200);
Why?

> +
> +	return 0; /* success */
> +}
> +
> +static int sis_cdev_release(struct inode *inode, struct file *filp)
> +{
> +	printk(KERN_INFO "sis_cdev_release.\n");
> +=09
> +	msleep(200);
Why?
> +=09
> +    if (ts_bak =3D=3D 0)
> +    	return -13;

What is this to mean?
> +
> +	if (ts_bak->use_irq)
> +	{
> +#if ( LINUX_VERSION_CODE < KERNEL_VERSION (2, 6, 39) )
You are submitting for a defined kernel version. This needs to
go away.
> +        if ((ts_bak->desc->status & IRQ_DISABLED) =3D=3D IRQ_STATUS_=
DISABLED)
> +#else
> +		if ((ts_bak->desc->irq_data.state_use_accessors & IRQD_IRQ_DISABLE=
D) =3D=3D IRQ_STATUS_DISABLED)
> +#endif=09
> +		{
> +			enable_irq(ts_bak->client->irq);
> +		}
> +	}
> +	else
> +		hrtimer_start(&ts_bak->timer, ktime_set(1, 0), HRTIMER_MODE_REL);
> +
> +    return 0;
> +}
> +
> +static const struct file_operations sis_cdev_fops =3D {
> +	.owner	=3D THIS_MODULE,
> +	.read	=3D sis_cdev_read,
> +	.write	=3D sis_cdev_write,
> +	.open	=3D sis_cdev_open,
> +	.release=3D sis_cdev_release,
> +};
> +
> +static int sis_setup_chardev(struct sis_ts_data *ts)
> +{
> +=09
> +	dev_t dev =3D MKDEV(sis_char_major, 0);
> +	int alloc_ret =3D 0;
> +	int cdev_err =3D 0;
> +	int input_err =3D 0;
> +	struct device *class_dev =3D NULL;
> +	void *ptr_err;
> +=09
> +	printk("sis_setup_chardev.\n");
> +=09
> +	if (ts =3D=3D NULL)=20
> +	{
> +	  input_err =3D -ENOMEM;
> +	  goto error;
> +	}=20
> +	/* dynamic allocate driver handle */
> +	alloc_ret =3D alloc_chrdev_region(&dev, 0, sis_char_devs_count, DEV=
ICE_NAME);
> +	if (alloc_ret)
> +		goto error;
> +	=09
> +	sis_char_major =3D MAJOR(dev);
> +	cdev_init(&sis_char_cdev, &sis_cdev_fops);
> +	sis_char_cdev.owner =3D THIS_MODULE;
> +	cdev_err =3D cdev_add(&sis_char_cdev, MKDEV(sis_char_major, 0), sis=
_char_devs_count);
> +=09
> +	if (cdev_err)=20
> +		goto error;
> +=09
> +	printk(KERN_INFO "%s driver(major %d) installed.\n", DEVICE_NAME, s=
is_char_major);
> +=09
> +	/* register class */
> +	sis_char_class =3D class_create(THIS_MODULE, DEVICE_NAME);
> +	if(IS_ERR(ptr_err =3D sis_char_class))=20
> +	{
> +		goto err2;
> +	}
> +=09
> +	class_dev =3D device_create(sis_char_class, NULL, MKDEV(sis_char_ma=
jor, 0), NULL, DEVICE_NAME);
> +=09
> +	if(IS_ERR(ptr_err =3D class_dev))=20
> +	{
> +		goto err;
> +	}
> +=09
> +	return 0;
> +error:
> +	if (cdev_err =3D=3D 0)
> +		cdev_del(&sis_char_cdev);
> +	if (alloc_ret =3D=3D 0)
> +		unregister_chrdev_region(MKDEV(sis_char_major, 0), sis_char_devs_c=
ount);
> +	if(input_err !=3D 0)
> +	{
> +		printk("sis_ts_bak error!\n");
> +	}
> +err:
> +	device_destroy(sis_char_class, MKDEV(sis_char_major, 0));
> +err2:
> +	class_destroy(sis_char_class);
> +	return -1;
> +}
> +#endif
> +
> +static int sis_ts_probe(
> +	struct i2c_client *client, const struct i2c_device_id *id)
> +{
> +	int ret =3D 0;
> +	struct sis_ts_data *ts =3D NULL;
> +	struct sis_i2c_rmi_platform_data *pdata =3D NULL;
> +
> +    printk(KERN_INFO "sis_ts_probe\n");
> +
> +    TPInfo =3D kzalloc(sizeof(struct sisTP_driver_data), GFP_KERNEL)=
;
> +    if (TPInfo =3D=3D NULL)=20
> +    {
> +		ret =3D -ENOMEM;
> +		goto err_alloc_data_failed;
> +	}
> +
> +	ts =3D kzalloc(sizeof(struct sis_ts_data), GFP_KERNEL);
> +	if (ts =3D=3D NULL)=20
> +	{
> +		ret =3D -ENOMEM;
> +		goto err_alloc_data_failed;
> +	}
> +
> +	ts_bak =3D ts;
> +
> +	mutex_init(&ts->mutex_wq);
> +=09
> +	/* 1. Init Work queue and necessary buffers */
> +	INIT_WORK(&ts->work, sis_ts_work_func);
> +	ts->client =3D client;
> +	i2c_set_clientdata(client, ts);
> +    pdata =3D client->dev.platform_data;
> +
> +	if (pdata)
> +		ts->power =3D pdata->power;
> +	if (ts->power)=20
> +	{
> +		ret =3D ts->power(1);
> +		if (ret < 0)=20
> +		{
> +			printk(KERN_ERR "sis_ts_probe power on failed\n");
> +			goto err_power_failed;
> +		}
> +	}
> +
> +	/* 2. Allocate input device */
> +	ts->input_dev =3D input_allocate_device();
> +	if (ts->input_dev =3D=3D NULL)=20
> +	{
> +		ret =3D -ENOMEM;
> +		printk(KERN_ERR "sis_ts_probe: Failed to allocate input device\n")=
;
> +		goto err_input_dev_alloc_failed;
> +	}
> +
> +	/* This input device name should be the same to IDC file name. */
> +	ts->input_dev->name =3D "sis_touch";
> +
> +	set_bit(EV_ABS, ts->input_dev->evbit);
> +	set_bit(EV_KEY, ts->input_dev->evbit);
> +    set_bit(ABS_MT_POSITION_X, ts->input_dev->absbit);
> +    set_bit(ABS_MT_POSITION_Y, ts->input_dev->absbit);
> +    set_bit(ABS_MT_TRACKING_ID, ts->input_dev->absbit);
> +
> +#ifdef _ANDROID_4
> +	set_bit(INPUT_PROP_DIRECT, ts->input_dev->propbit);
> +    set_bit(ABS_MT_PRESSURE, ts->input_dev->absbit);
> +    set_bit(ABS_MT_TOUCH_MAJOR, ts->input_dev->absbit);
> +    set_bit(ABS_MT_TOUCH_MINOR, ts->input_dev->absbit);
> +    input_set_abs_params(ts->input_dev, ABS_MT_PRESSURE, 0, PRESSURE=
_MAX, 0, 0);
> +    input_set_abs_params(ts->input_dev, ABS_MT_TOUCH_MAJOR, 0, AREA_=
LENGTH_LONGER, 0, 0);
> +    input_set_abs_params(ts->input_dev, ABS_MT_TOUCH_MINOR, 0, AREA_=
LENGTH_SHORT, 0, 0);  =20
> +#else
> +    set_bit(ABS_MT_TOUCH_MAJOR, ts->input_dev->absbit);
> +    set_bit(ABS_MT_WIDTH_MAJOR, ts->input_dev->absbit);
> +    set_bit(ABS_MT_WIDTH_MINOR, ts->input_dev->absbit);
> +    input_set_abs_params(ts->input_dev, ABS_MT_TOUCH_MAJOR, 0, PRESS=
URE_MAX, 0, 0);
> +    input_set_abs_params(ts->input_dev, ABS_MT_WIDTH_MAJOR, 0, AREA_=
LENGTH_LONGER, 0, 0);
> +    input_set_abs_params(ts->input_dev, ABS_MT_WIDTH_MINOR, 0, AREA_=
LENGTH_SHORT, 0, 0);
> +#endif
> +
> +    input_set_abs_params(ts->input_dev, ABS_MT_POSITION_X, 0, SIS_MA=
X_X, 0, 0);
> +    input_set_abs_params(ts->input_dev, ABS_MT_POSITION_Y, 0, SIS_MA=
X_Y, 0, 0);
> +    input_set_abs_params(ts->input_dev, ABS_MT_TRACKING_ID, 0, 15, 0=
, 0);
> +=09
> +    /* add for touch keys */
> +	set_bit(KEY_COMPOSE, ts->input_dev->keybit);
> +	set_bit(KEY_BACK, ts->input_dev->keybit);
> +	set_bit(KEY_MENU, ts->input_dev->keybit);
> +	set_bit(KEY_HOME, ts->input_dev->keybit);
> +
> +	/* 3. Register input device to core */
> +	ret =3D input_register_device(ts->input_dev);
> +
> +	if (ret)=20
> +	{
> +		printk(KERN_ERR "sis_ts_probe: Unable to register %s input device\=
n", ts->input_dev->name);
> +		goto err_input_register_device_failed;
> +	}
> +=09
> +	/* 4. irq or timer setup */
> +	ret =3D initial_irq();
> +	if (ret < 0)=20
> +	{
> +
> +	}
> +	else
> +	{
> +		client->irq =3D gpio_to_irq(GPIO_IRQ);
> +		ret =3D request_irq(client->irq, sis_ts_irq_handler, IRQF_TRIGGER_=
=46ALLING, client->name, ts);
> +		if (ret =3D=3D 0)=20
> +		{
> +		   ts->use_irq =3D 1;
> +		}
> +		else=20
> +		{
> +			dev_err(&client->dev, "request_irq failed\n");
> +		}
> +	}
> +
> +	ts->desc =3D irq_to_desc(ts_bak->client->irq);
> +=09
> +	hrtimer_init(&ts->timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
> +	ts->timer.function =3D sis_ts_timer_func;
> +
> +	if (!ts->use_irq)=20
> +	{
> +		hrtimer_start(&ts->timer, ktime_set(1, 0), HRTIMER_MODE_REL);
> +	}
> +
> +#ifdef CONFIG_HAS_EARLYSUSPEND
> +	ts->early_suspend.level =3D EARLY_SUSPEND_LEVEL_BLANK_SCREEN + 1;
> +	ts->early_suspend.suspend =3D sis_ts_early_suspend;
> +	ts->early_suspend.resume =3D sis_ts_late_resume;
> +	register_early_suspend(&ts->early_suspend);
> +#endif
> +	printk(KERN_INFO "sis_ts_probe: Start touchscreen %s in %s mode\n",=
 ts->input_dev->name, ts->use_irq ? "interrupt" : "polling");
> +=09
> +	if (ts->use_irq)
> +	{
> +#ifdef _INT_MODE_1
> +		printk(KERN_INFO "sis_ts_probe: interrupt case 1 mode\n");
> +#else
> +		printk(KERN_INFO "sis_ts_probe: interrupt case 2 mode\n");
> +#endif
> +	}
> +=09
> +#ifdef _STD_RW_IO
> +	ret =3D sis_setup_chardev(ts);
> +	if(ret)
> +	{
> +		printk( KERN_INFO"sis_setup_chardev fail\n");
> +	}
> +#endif
> +
> +	printk( KERN_INFO"sis SIS_SLAVE_ADDR: %d\n", SIS_SLAVE_ADDR);
> +
> +	return 0;
> +
> +err_input_register_device_failed:
> +	input_free_device(ts->input_dev);
> +
> +err_input_dev_alloc_failed:
> +err_power_failed:
> +	kfree(ts);
> +err_alloc_data_failed:
> +	return ret;
> +}
> +
> +static int sis_ts_remove(struct i2c_client *client)
> +{
> +	struct sis_ts_data *ts =3D i2c_get_clientdata(client);
> +=09
> +#ifdef CONFIG_HAS_EARLYSUSPEND
> +	unregister_early_suspend(&ts->early_suspend);
> +#endif
> +	if (ts->use_irq)
> +		free_irq(client->irq, ts);
> +	else
> +		hrtimer_cancel(&ts->timer);
> +	input_unregister_device(ts->input_dev);
> +	kfree(ts);
> +=09
> +	return 0;
> +}
> +
> +static int sis_ts_suspend(struct i2c_client *client, pm_message_t me=
sg)
> +{
> +	int ret =3D 0;
> +	struct sis_ts_data *ts =3D i2c_get_clientdata(client);
> +
> +	TPInfo->pre_keybit_state =3D 0x0;
> +
> +	if (ts->use_irq)
> +	{
> +#if ( LINUX_VERSION_CODE < KERNEL_VERSION (2, 6, 39) )
You are submitting for a defined kernel version. This needs to
go away.
> +		if ((ts->desc->status & IRQ_DISABLED) =3D=3D IRQ_STATUS_ENABLED)
> +#else
> +		if ((ts->desc->irq_data.state_use_accessors & IRQD_IRQ_DISABLED) =3D=
=3D IRQ_STATUS_ENABLED)
> +#endif
> +		{
> +			disable_irq(client->irq);
> +		}
> +	}
> +	else
> +		hrtimer_cancel(&ts->timer);
> +	/* only flush sis_wq */
> +	flush_workqueue(sis_wq); 	   	=09
> +
> +	if (ts->power) {
> +		ret =3D ts->power(0);
> +		if (ret < 0)
> +			printk(KERN_ERR "sis_ts_suspend power off failed\n");
> +	}
> +=09
> +	return 0;
> +}
> +
> +static int sis_ts_resume(struct i2c_client *client)
> +{
> +	int ret =3D 0;
> +	struct sis_ts_data *ts =3D i2c_get_clientdata(client);
> +
> +	if (ts->power)
> +	{
> +		ret =3D ts->power(1);
> +		if (ret < 0)
> +			printk(KERN_ERR "sis_ts_resume power on failed\n");
> +	}
> +
> +	if (ts->use_irq)
> +	{
> +#if ( LINUX_VERSION_CODE < KERNEL_VERSION (2, 6, 39) )
You are submitting for a defined kernel version. This needs to
go away.
> +		if ((ts->desc->status & IRQ_DISABLED) =3D=3D IRQ_STATUS_DISABLED)
> +#else
> +		if ((ts->desc->irq_data.state_use_accessors & IRQD_IRQ_DISABLED) =3D=
=3D IRQ_STATUS_DISABLED)
> +#endif
> +		{
> +			enable_irq(client->irq);
> +		}
> +	}
> +	else
> +		hrtimer_start(&ts->timer, ktime_set(1, 0), HRTIMER_MODE_REL);
> +
> +	return 0;
> +}
> +

> +
> +static void __exit sis_ts_exit(void)
> +{
> +#ifdef _STD_RW_IO
> +	dev_t dev;
> +#endif
> +
> +	printk(KERN_INFO "sis_ts_exit\n");
> +=09
> +	i2c_del_driver(&sis_ts_driver);
> +=09
> +	if (sis_wq)
> +		destroy_workqueue(sis_wq);
> +
> +#ifdef _STD_RW_IO

Make up your mind what you want to support

> +	dev =3D MKDEV(sis_char_major, 0);
> +	cdev_del(&sis_char_cdev);
> +	unregister_chrdev_region(dev, sis_char_devs_count);
> +	device_destroy(sis_char_class, MKDEV(sis_char_major, 0));
> +	class_destroy(sis_char_class);
> +#endif
> +}

> +#define SIS_I2C_NAME "sis_i2c_ts"
> +#define SIS_SLAVE_ADDR					0x5c
> +#define TIMER_NS    					10000000 //10ms
> +#define MAX_FINGERS						10
> +
> +
> +/* For Android 4.0 							*/
> +/* Only for Linux kernel 2.6.34 and later 	*/
> +#define _ANDROID_4					//  ON/OFF

You are submitting for a defined kernel version. This needs to
go away.

> +
> +/* For standard R/W IO*/
> +#define _STD_RW_IO						//  ON/OFF
> +
> +/* Interrupt setting and modes */
> +#define _I2C_INT_ENABLE					//  ON/OFF
> +#define GPIO_IRQ 						133
> +
> +/*  Enable if use interrupt case 1 mode.  */
> +/* 	Disable if use interrupt case 2 mode. */
> +//#define _INT_MODE_1					//	ON/OFF
> +
> +/* IRQ STATUS */
> +#if ( LINUX_VERSION_CODE < KERNEL_VERSION (2, 6, 39) )

You are submitting for a defined kernel version. This needs to
go away.

> +#define IRQ_STATUS_DISABLED				0x200 =20
> +#else
> +#define IRQ_STATUS_DISABLED				(1<<16)
> +#endif
> +#define IRQ_STATUS_ENABLED				0x0
> +

[..]
> +struct sis_i2c_rmi_platform_data {
> +	int (*power)(int on);	/* Only valid in first array entry */
> +};
> +
> +static const unsigned short crc16tab[256]=3D {

What polynom is used for this? I am asking because the usual
polynom has a common table in the kernel. It may be good to share
this table more widely.



--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
