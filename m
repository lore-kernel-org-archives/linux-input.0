From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input:Adding support for Wacom Stylus with I2c interface
Date: Fri, 7 Oct 2011 09:48:56 -0700
Message-ID: <20111007164856.GA17274@core.coreip.homeip.net>
References: <1317714263-9851-1-git-send-email-tobita.tatsunosuke@wacom.co.jp>
 <20111005071059.GC11260@core.coreip.homeip.net>
 <4e8ee2bf.a808440a.3441.ffffc8e5SMTPIN_ADDED@mx.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qy0-f174.google.com ([209.85.216.174]:35621 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965514Ab1JGQtE (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 7 Oct 2011 12:49:04 -0400
Received: by qyk30 with SMTP id 30so782775qyk.19
        for <linux-input@vger.kernel.org>; Fri, 07 Oct 2011 09:49:03 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4e8ee2bf.a808440a.3441.ffffc8e5SMTPIN_ADDED@mx.google.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Tobita Tatsunosuke <tobita.tatsunosuke@wacom.co.jp>
Cc: linux-input@vger.kernel.org

On Fri, Oct 07, 2011 at 08:30:03PM +0900, Tobita Tatsunosuke wrote:
> Hi Dmitry
>=20
> -----Original Message-----
> From: Dmitry Torokhov [mailto:dmitry.torokhov@gmail.com]=20
> Sent: Wednesday, October 05, 2011 4:11 PM
> To: Tatsunosuke Tobita
> Cc: linux-input@vger.kernel.org; Tatsunosuke Tobita
> Subject: Re: [PATCH] input:Adding support for Wacom Stylus with I2c
> interface
>=20
> Hi Tatsunosuke,
>=20
> On Tue, Oct 04, 2011 at 04:44:23PM +0900, Tatsunosuke Tobita wrote:
> > From: Tatsunosuke Tobita <tobita.tatsunosuke@wacom.co.jp>
> >=20
> > This driver has the same pen input process logic as wacom_w8001.c d=
oes.
> > Also some modifications for structures were applied.
> >=20
> > Signed-off-by: Tatsunosuke Tobita <tobita.tatsunosuke@wacom.co.jp>
> > ---
> >  drivers/input/touchscreen/wacom_i2c.c      |  216
> ++++++++++++++++++++++++++++
> >  drivers/input/touchscreen/wacom_i2c.h      |   66 +++++++++
> >  drivers/input/touchscreen/wacom_i2c_func.c |   96 ++++++++++++
> >  drivers/input/touchscreen/wacom_i2c_func.h |    8 +
> >  4 files changed, 386 insertions(+), 0 deletions(-)
> >  create mode 100644 drivers/input/touchscreen/wacom_i2c.c
> >  create mode 100644 drivers/input/touchscreen/wacom_i2c.h
> >  create mode 100644 drivers/input/touchscreen/wacom_i2c_func.c
> >  create mode 100644 drivers/input/touchscreen/wacom_i2c_func.h
> >=20
> > diff --git a/drivers/input/touchscreen/wacom_i2c.c
> b/drivers/input/touchscreen/wacom_i2c.c
> > new file mode 100644
> > index 0000000..88a232b
> > --- /dev/null
> > +++ b/drivers/input/touchscreen/wacom_i2c.c
> > @@ -0,0 +1,216 @@
> > +/*
> > + * Wacom Penabled Driver for I2C
> > + *
> > + * Copyright (c) 2011 Tatsunosuke Tobita, Wacom.
> > + * <tobita.tatsunosuke@wacom.co.jp>
> > + *
> > + * This program is free software; you can redistribute it
> > + * and/or modify it under the terms of the GNU General
> > + * Public License as published by the Free Software
> > + * Foundation; either version of 2 of the License,
> > + * or (at your option) any later version.
> > + *
> > + * Note: Wacom Penabled Driver for I2C obtains data by polling.
> > + * If you use irq, you must use the edge based rising
> > + * interruption with low level pin.
> > + */
> > +
> > +#include <linux/device.h>
> > +#include "wacom_i2c_func.h"
> > +
> > +const unsigned short addr[2];
> > +
> > +static void wacom_i2c_workqueue(struct work_struct *workq)
> > +{
> > +	struct wacom_i2c *wac_i2c =3D container_of(workq, struct wacom_i2=
c,
> workq);
> > +	wacom_set_coordination(wac_i2c);
> > +}
> > +
> > +static enum hrtimer_restart wacom_i2c_timer(struct hrtimer *timer)
> > +{
> > +	struct wacom_i2c *wac_i2c =3D container_of(timer, struct wacom_i2=
c,
> timer);
> > +
> > +	queue_work(wacom_i2c_wq, &wac_i2c->workq);
> > +	hrtimer_start(&wac_i2c->timer, ktime_set(0, POLL_RATE),
> HRTIMER_MODE_REL);
> > +
>=20
> >>So we have a timer and a workqueue. Why not use delayed_work?
> When I was starting developing these codes, I looked at several text =
books
> about writing drivers
> and "workqueue" is mostly recommended to use when running such amount=
 of
> work in kernel context.
> I haven't known "delayed work". But, as you suggested, it definitely =
looks
> that the "delayed work" is more useful combination
> for both polling and workqueue. I'll work on changing this to delayed=
_work.
>=20
> > +	return HRTIMER_NORESTART;
> > +}
> > +
> > +static int wacom_i2c_input_open(struct input_dev *dev)
> > +{
> > +	struct wacom_i2c *wac_i2c =3D input_get_drvdata(dev);
> > +
> > +	mutex_lock(&wac_i2c->lock);
> > +	wac_i2c->dev->open =3D true;
>=20
> >>Did you try actually compiling this?
> Yes, I did, I compiled it in bunch of times and checked it working.

Here is what I get when trying to compile the driver:

[dtor@hammer work]$ make drivers/input/touchscreen/wacom_i2c.o=20
  CHK     include/linux/version.h
  CHK     include/generated/utsrelease.h
  CALL    scripts/checksyscalls.sh
  CC      drivers/input/touchscreen/wacom_i2c.o
drivers/input/touchscreen/wacom_i2c.c: In function
=E2=80=98wacom_i2c_input_open=E2=80=99:
drivers/input/touchscreen/wacom_i2c.c:44:21: warning: assignment makes
pointer from integer without a cast [enabled by default]
drivers/input/touchscreen/wacom_i2c.c: At top level:
drivers/input/touchscreen/wacom_i2c.c:193:122: warning: function
declaration isn=E2=80=99t a prototype [-Wstrict-prototypes]
drivers/input/touchscreen/wacom_i2c.c:203:149: warning: function
declaration isn=E2=80=99t a prototype [-Wstrict-prototypes]

The reason for the first warning is because you do=20

	wac_i2c->dev->open =3D true;

but "open" here is not a flag, it is a method that is called when first
user opens the input device. In fact, it is the method that is currentl=
y
running, wacom_i2c_input_open().

So when you close the device and open it again, you will get an oops.

> If there's some suspect-able statement which may affect the system se=
riously
> and
> output the errors when compiling, please let me know.
> I'll try to get rid of that as much as possible.

You can not only act on errors and ignore warnings. There should not be
a single warning produced when compiling a kernel driver It is also
advisable to pass the patch through scripst/checkpath.pl and also check
it with sparse (just install it and then do 'make C=3D2
drivers/input/touchscreen/synaptics_i2c.o').

>=20
> > +	mutex_unlock(&wac_i2c->lock);
> > +
> > +	return 0;
> > +}
> > +
> > +static void wacom_i2c_input_close(struct input_dev *dev)
> > +{
> > +	struct wacom_i2c *wac_i2c =3D input_get_drvdata(dev);
> > +
> > +	mutex_lock(&wac_i2c->lock);
> > +	wac_i2c->dev->open =3D false;
> > +	mutex_unlock(&wac_i2c->lock);
> > +}
> > +
> > +static void wacom_i2c_set_input_values(struct i2c_client *client,
> > +				       struct wacom_i2c *wac_i2c, struct
> input_dev *dev)
> > +{
> > +	dev->name =3D "WACOM_I2C_DIGITIZER";
> > +	dev->id.bustype =3D BUS_I2C;
> > +	dev->id.vendor =3D 0x56a;
> > +	dev->dev.parent =3D &client->dev;
> > +	dev->open =3D wacom_i2c_input_open;
> > +	dev->close =3D wacom_i2c_input_close;
> > +	dev->evbit[0] |=3D BIT_MASK(EV_KEY) | BIT_MASK(EV_ABS);
> > +
> > +	__set_bit(ABS_X, dev->absbit);
> > +	__set_bit(ABS_Y, dev->absbit);
> > +	__set_bit(ABS_PRESSURE, dev->absbit);
> > +	__set_bit(BTN_TOOL_PEN, dev->keybit);
> > +	__set_bit(BTN_TOOL_RUBBER, dev->keybit);
> > +	__set_bit(BTN_STYLUS, dev->keybit);
> > +	__set_bit(BTN_STYLUS2, dev->keybit);
> > +	__set_bit(BTN_TOUCH, dev->keybit);
>=20
> >>Just put this into probe().
> I thought it was too long to see the order of the codes in probe if I=
 put
> this into it. I thought this way is more easy to read what happens in=
 the
> code
> for people trying to customize it.
> However, if this caused some trouble when probing, I would gladly rem=
ove it
> and place
> the same statement in probe(). So, could you just give me the advice =
for
> this change?

probe() is quite simple and most of the drivers initialize input device=
s
there. I guess it is just my preference.

>=20
> > +}
> > +
> > +static int wacom_i2c_probe(struct i2c_client *client,
> > +			   const struct i2c_device_id *id)
> > +{
> > +	struct wacom_i2c *wac_i2c;
> > +	int i, ret;
> > +	i =3D ret =3D 0;
> > +
> > +	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C))
> > +		goto err2;
> > +
> > +	wac_i2c =3D kzalloc(sizeof(struct wacom_i2c), GFP_KERNEL);
> > +	wac_i2c->wac_feature =3D wacom_feature_EMR;
>=20
> >>Should we get this from i2c_device_id, platform data, device tree o=
r
> >>something else instead of hard-coding?
> Right, there's no reason for leaving this hard-coding here anymore,
> I forget it. This is just useful for us to test or check; My apology.
> I will find another way to initialize it.
>=20
> > +
> > +	mutex_init(&wac_i2c->lock);
> > +
> > +	wac_i2c->dev =3D input_allocate_device();
> > +	if (wac_i2c =3D=3D NULL || wac_i2c->dev =3D=3D NULL)
> > +		goto fail;
> > +	wacom_i2c_set_input_values(client, wac_i2c, wac_i2c->dev);
> > +
> > +	wac_i2c->client =3D client;
> > +
> > +	INIT_WORK(&wac_i2c->workq, wacom_i2c_workqueue);
> > +
> > +	ret =3D wacom_send_query(wac_i2c);
> > +	if (ret < 0)
> > +		goto err1;
> > +
> > +	wac_i2c->dev->id.version =3D wac_i2c->wac_feature.fw_version;
> > +	input_set_abs_params(wac_i2c->dev, ABS_X, 0,
> > +			     wac_i2c->wac_feature.x_max, 0, 0);
> > +	input_set_abs_params(wac_i2c->dev, ABS_Y, 0,
> > +			     wac_i2c->wac_feature.y_max, 0, 0);
> > +	input_set_abs_params(wac_i2c->dev, ABS_PRESSURE, 0,
> > +			     wac_i2c->wac_feature.pressure_max, 0, 0);
> > +	input_set_drvdata(wac_i2c->dev, wac_i2c);
> > +
> > +	i2c_set_clientdata(client, wac_i2c);
> > +	if (input_register_device(wac_i2c->dev))
> > +		goto err1;
>=20
>=20
> >>You should report error returned by input_register_device().
> I understand that, I could do it.
>=20
> > +
> > +	hrtimer_init(&wac_i2c->timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
> > +	wac_i2c->timer.function =3D wacom_i2c_timer;
> > +	hrtimer_start(&wac_i2c->timer, ktime_set(1, 0), HRTIMER_MODE_REL)=
;
>=20
> >>Why start timer if nobody has the device opened yet?
> Do your "device" mean "input" subsystem?

By device I mean instance of struct input_dev.

> I thought, at this point, the i2c driver was completed the initializa=
tion
> and started probing.
> The reason I put this here is because I thought the device has almost=
 been
> ready to work as a device and opened.
> I guess I made a mistake in the order of the running these i2c and in=
put
> sybsystem.
> Can you tell more in detail, which initializes first, input or i2c?
> Thanks.

It does not really matter, but we do know that by the time this probe()
runs I2C core, I2C controller and input core should be fully functional=
=2E
However that does not mean that there are consumers for the input event=
s
generated by the touchscreen, so we should not rush and start polling
right now. We'll get notified when first users appears - input core wil=
l
call our open() method and then we can start our polling. Also, input
core will notify us when last user closes the device by calling our
close() method to give us chance to stop polling or otherwise quiesce
the device.

>=20
> > +	printk(KERN_INFO "WACOM_I2C_DIGITIZER: initialized and started \n=
");
> > +
> > +	return 0;
> > +
> > + err2:
> > +	printk(KERN_ERR "wacom_i2c:No I2C functionality found\n");
> > +	return -ENODEV;
> > +
> > + err1:
> > +	printk(KERN_ERR "wacom_i2c:err1 occured(num:%d)\n", ret);
> > +	input_free_device(wac_i2c->dev);
> > +	wac_i2c->dev =3D NULL;
> > +	return -EIO;
> > +
> > + fail:
> > +	printk(KERN_ERR "wacom_i2c:fail occured\n");
> > +	return -ENOMEM;
> > +}
> > +
> > +static int wacom_i2c_remove(struct i2c_client *client)
> > +{
> > +	struct wacom_i2c *wac_i2c =3D i2c_get_clientdata(client);
> > +
> > +	input_unregister_device(wac_i2c->dev);
>=20
> >>Timer fires here -> *BOOM*. You should cancel the timer in close().
> Thanks for letting me know that. I will definitely put the cancel in
> close().
>=20
> >>Also, polling-only mode is hardly useful for a touchscreen driver. =
Is
> >>there a chance you could switch to interrupt-driven mode instead?
> Be honest with you, we are OEM vendors and found the setting of the i=
2c's
> irq lines depends(relays) on customers implementation and
> there's no single way to use i2c's irq.
> For example, one customer simply implements the i2c's irq line by gpi=
o and
> set their address and pins on it in a single
> code for gpio, but the others may have the settings and the initializ=
ation
> before enabling its i2c's irq on their system in=20
> different or separated codes.
> Then, these customer's settings sometimes affect to irq handler in th=
is code
> in different way.
> I mean I may also change the codes in irq handler differently for eac=
h
> customers.
> This happens because each customer produces their own individual syst=
em for
> i2c's irq lines.

Setting up interrupts should happen in board code, by the time we get t=
o
the driver binding it shoudl simply use irq line specified in i2c clien=
t
structure. If special processing is needed we could think about adding
some platform data with necessary methods at a later point, however for
now just drop the polling and switch to threaded IRQ model for the
driver.

> However, the most of the customers just want to know how our device w=
orks
> with the driver.
> Since the code is under GPL, that means the customers freely customiz=
e the
> codes; that means they can implement
> interrupt cods by themselves for their own devices.
> So, polling would give them easier way to see if just our device work=
s on
> the screen.
> I guess this complex happens because i2c controller doesn't have irq =
line on
> itself but relies on the system io port.
>=20
> However, I understand what you concern as well, so I will try to add
> something for irq on the next patching release;
> If you are not clear, please let me know; maybe my explanation is eno=
ugh.
>=20

As I mention, please switch to pure interrupt model for the driver -
polling is not suitable for production use and mainline kernel is
supposed to have production-quality code.

> > +	hrtimer_cancel(&wac_i2c->timer);
> > +	kfree(wac_i2c);
> > +
> > +	return 0;
> > +}
> > +
> > +static int wacom_i2c_suspend(struct i2c_client *client, pm_message=
_t
> mesg)
> > +{
> > +	int ret;
> > +	struct wacom_i2c *wac_i2c =3D i2c_get_clientdata(client);
> > +
> > +	hrtimer_cancel(&wac_i2c->timer);
> > +	cancel_work_sync(&wac_i2c->workq);
> > +	ret =3D wac_i2c->power(0);
> > +
> > +	return 0;
> > +}
> > +
> > +static int wacom_i2c_resume(struct i2c_client *client)
> > +{
> > +	struct wacom_i2c *wac_i2c =3D i2c_get_clientdata(client);
> > +
> > +	hrtimer_start(&wac_i2c->timer, ktime_set(1, 0), HRTIMER_MODE_REL)=
;
> > +
> > +	return 0;
> > +}
> > +
> > +static const struct i2c_device_id wacom_i2c_id[] =3D {
> > +	{WACNAME, 0},
> > +	{},
> > +};
> > +MODULE_DEVICE_TABLE(i2c, wacom_i2c_id);
> > +
> > +static struct i2c_driver wacom_i2c_driver =3D {
> > +	.driver =3D {
> > +		.name =3D "wacom_i2c",
> > +	},
> > +
> > +	.probe =3D wacom_i2c_probe,
> > +	.remove =3D wacom_i2c_remove,
> > +	.suspend =3D wacom_i2c_suspend,
> > +	.resume =3D wacom_i2c_resume,
>=20
> >>Please use dev_pm_ops.
> I understand, deve_pm_ops is commonly and safely used for suspending,
> resuming, or other power management.
>=20
> > +	.id_table =3D wacom_i2c_id,
> > +};
> > +
> > +static int __init wacom_i2c_init()
> > +{
> > +
> > +	wacom_i2c_wq =3D create_singlethread_workqueue("wacom_i2c_wq");
> > +	if (!wacom_i2c_wq)
> > +		return -ENOMEM;
>=20
> >>There is no reason for dedicated workqueue in mainline.
> I'll work on it and I'm thinking replace this in probe() as well.
>=20
> > +
> > +	return i2c_add_driver(&wacom_i2c_driver);
> > +}
> > +
> > +static void __exit wacom_i2c_exit()
> > +{
> > +	if (wacom_i2c_wq)
>=20
> >>The test is useless.
> Right, I'll take this away.
>=20
> > +		destroy_workqueue(wacom_i2c_wq);
> > +
> > +	i2c_del_driver(&wacom_i2c_driver);
> > +}
> > +
> > +module_init(wacom_i2c_init);
> > +module_exit(wacom_i2c_exit);
> > +
> > +MODULE_AUTHOR("Tatsunosuke Tobita <tobita.tatsunosuke@wacom.co.jp>=
");
> > +MODULE_DESCRIPTION("WACOM EMR I2C Driver");
> > +MODULE_LICENSE("GPL");
> > diff --git a/drivers/input/touchscreen/wacom_i2c.h
> b/drivers/input/touchscreen/wacom_i2c.h
> > new file mode 100644
> > index 0000000..390b765
> > --- /dev/null
> > +++ b/drivers/input/touchscreen/wacom_i2c.h
> > @@ -0,0 +1,66 @@
> > +#ifndef WACOM_I2C_H
> > +#define WAOCM_I2C_H
> > +
> > +#include <linux/module.h>
> > +#include <linux/init.h>
> > +#include <linux/kernel.h>
> > +#include <linux/input.h>
> > +#include <linux/i2c.h>
> > +#include <linux/slab.h>
> > +#include <linux/hrtimer.h>
> > +#include <linux/delay.h>
> > +#include <linux/uaccess.h>
> > +#include <asm/unaligned.h>
> > +
> > +#define NAMEBUF 12
> > +#define WACNAME "WAC_I2C_EMR"
> > +
> > +/*Wacom Command*/
> > +#define COM_COORD_NUM      256
> > +#define COM_SAMPLERATE_40  0x33
> > +#define COM_SAMPLERATE_80  0x32
> > +#define COM_SAMPLERATE_133 0x31
> > +#define CMD_QUERY0         0x04
> > +#define CMD_QUERY1         0x00
> > +#define CMD_QUERY2         0x33
> > +#define CMD_QUERY3         0x02
> > +#define CMD_THROW0         0x05
> > +#define CMD_THROW1         0x00
> > +#define QUERY_SIZE           19
> > +
> > +/*I2C address for digitizer*/
> > +#define WACOM_I2C_ADDR   0x09
> > +
> > +/*Polling Rate*/
> > +#define POLL_RATE 7500000
> > +
> > +static struct workqueue_struct *wacom_i2c_wq;
>=20
> >>There shouldn't be static variables in header files.
> I understand it. I'll find another proper space for it.
>=20
> > +
> > +/*Parameters for wacom own features*/
> > +struct wacom_features {
> > +	int x_max;
> > +	int y_max;
> > +	int pressure_max;
> > +	char fw_version;
> > +};
> > +
> > +static struct wacom_features wacom_feature_EMR =3D {
> > +	16128,
> > +	8448,
> > +	256,
> > +	0x10,
> > +};
> > +
> > +/*Parameters for i2c driver*/
> > +struct wacom_i2c {
> > +	struct i2c_client *client;
> > +	struct input_dev *dev;
> > +	struct mutex lock;
> > +	struct work_struct workq;
> > +	struct hrtimer timer;
> > +	struct wacom_features wac_feature;
> > +	int (*power)(int on);
> > +	int type;
> > +	const char name[NAMEBUF];
> > +};
> > +#endif
> > diff --git a/drivers/input/touchscreen/wacom_i2c_func.c
> b/drivers/input/touchscreen/wacom_i2c_func.c
> > new file mode 100644
> > index 0000000..97f086c
> > --- /dev/null
> > +++ b/drivers/input/touchscreen/wacom_i2c_func.c
> > @@ -0,0 +1,96 @@
> > +#include "wacom_i2c_func.h"
> > +
>=20
> >>Why is is split? Also, what license does this code have?
> Do you mean "why did I have two codes, wac_i2c.c and wac_i2c_func.c ?=
".
> If you do so, I will answer that I split up because it is clear to se=
e
> the difference between the driver initialization and the other
> functionalities which
> are mostly influenced by our device such as querying or contacting to=
 our
> firmware when
> the device gets ready for the users to operate the digitizers.
> So, wac_i2c is mostly dedicated to the driver initialization and
> wac_i2c_func is dedicated to querying and getting the coordination or=
 other
> stuffs related
> to our firmware.

The driver is too small for it to be split in several source files. It
just obscures what is happening.

> wac_i2c_func.c has the license as GPL, the same as wac_i2c.c.
> I should add the license also in it at the last line, right?

No, you should add a comment at the top with the license note. There
should only be one MODULE_LICENSE() per kernel module and you already
have it.

>=20
> > +int wacom_send_query(struct wacom_i2c *wac_i2c)
> > +{
> > +	int ret;
> > +	u8 cmd[4] =3D {CMD_QUERY0, CMD_QUERY1, CMD_QUERY2, CMD_QUERY3};
> > +	u8 data[COM_COORD_NUM];
> > +
> > +	ret =3D i2c_master_send(wac_i2c->client, cmd, sizeof(cmd));
> > +	if (ret < 0) {
> > +		printk(KERN_ERR "wacom_i2c: Sending Query failed \n");
> > +		return -1;
> > +	}
> > +
> > +	cmd[0] =3D CMD_THROW0; cmd[1] =3D CMD_THROW1;
> > +	ret =3D i2c_master_send(wac_i2c->client, cmd, 2);
> > +	if (ret < 0) {
> > +		printk(KERN_ERR "wacom_i2c: Sending Query failed \n");
> > +		return -1;
> > +	}
> > +
> > +	ret =3D i2c_master_recv(wac_i2c->client, data, QUERY_SIZE);
> > +	if (ret < 0) {
> > +		printk(KERN_ERR "wacom_i2c: Receiving Query failed\n");
> > +		return -1;
> > +	}
> > +
> > +	wac_i2c->wac_feature.x_max =3D get_unaligned_le16(&data[3]);
> > +	wac_i2c->wac_feature.y_max =3D get_unaligned_le16(&data[5]);
> > +	wac_i2c->wac_feature.pressure_max =3D get_unaligned_le16(&data[11=
]);
> > +	wac_i2c->wac_feature.fw_version =3D get_unaligned_le16(&data[13])=
;
> > +
> > +	printk(KERN_INFO "wacom_i2c: x_max:%d, y_max:%d, pressure:%d,
> fw:%d\n",
> > +	       wac_i2c->wac_feature.x_max, wac_i2c->wac_feature.y_max,
> > +	       wac_i2c->wac_feature.pressure_max,
> wac_i2c->wac_feature.fw_version);
> > +
>=20
> >>Please use dev_xxx() for reporting.
> I'll check it and change it to dev_xxx() as you requested for all rep=
orting.
>=20
> > +	return 0;
> > +}
> > +
> > +int wacom_set_coordination(struct wacom_i2c *wac_i2c)
> > +{
> > +	int ret =3D 0;
> > +	unsigned int x, y, pressure;
> > +	unsigned char rdy, tsw, f1, f2, ers;
> > +	u8 data[COM_COORD_NUM];
> > +
> > +	ret =3D i2c_master_recv(wac_i2c->client, data, QUERY_SIZE);
> > +	if (ret >=3D 0) {
> > +		tsw =3D data[3]&0x01;
> > +		ers =3D data[3]&0x04;
> > +		f1 =3D data[3]&0x02;
> > +		f2 =3D data[3]&0x10;
> > +		rdy =3D data[3]&0x20;
> > +		x =3D le16_to_cpup((__le16 *)&data[4]);
> > +		y =3D le16_to_cpup((__le16 *)&data[6]);
> > +		pressure =3D le16_to_cpup((__le16 *)&data[8]);
> > +
> > +		switch (wac_i2c->type) {
> > +		case BTN_TOOL_RUBBER:
> > +			if (!f2) {
> > +				input_report_abs(wac_i2c->dev, ABS_PRESSURE,
> 0);
> > +				input_report_key(wac_i2c->dev, BTN_TOUCH,
> 0);
> > +				input_report_key(wac_i2c->dev, BTN_STYLUS,
> 0);
> > +				input_report_key(wac_i2c->dev, BTN_STYLUS2,
> 0);
> > +				input_report_key(wac_i2c->dev,
> BTN_TOOL_RUBBER, 0);
> > +				input_sync(wac_i2c->dev);
> > +				wac_i2c->type =3D BTN_TOOL_PEN;
> > +			}
> > +			break;
> > +
> > +		case KEY_RESERVED:
> > +			wac_i2c->type =3D f2 ? BTN_TOOL_RUBBER : BTN_TOOL_PEN;
> > +			break;
> > +
> > +		default:
> > +			input_report_key(wac_i2c->dev, BTN_STYLUS2, f2);
> > +			break;
> > +		}
> > +
> > +		input_report_abs(wac_i2c->dev, ABS_X, x);
> > +		input_report_abs(wac_i2c->dev, ABS_Y, y);
> > +		input_report_abs(wac_i2c->dev, ABS_PRESSURE, pressure);
> > +		input_report_key(wac_i2c->dev, BTN_TOUCH, (tsw || ers));
> > +		input_report_key(wac_i2c->dev, BTN_STYLUS, f1);
> > +
> > +		input_sync(wac_i2c->dev);
> > +
> > +		if (!rdy)
> > +			wac_i2c->type =3D KEY_RESERVED;
> > +
> > +	} else {
> > +		return -1;
> > +	}
> > +
> > +	return 0;
> > +}
> > diff --git a/drivers/input/touchscreen/wacom_i2c_func.h
> b/drivers/input/touchscreen/wacom_i2c_func.h
> > new file mode 100644
> > index 0000000..cce35c4
> > --- /dev/null
> > +++ b/drivers/input/touchscreen/wacom_i2c_func.h
> > @@ -0,0 +1,8 @@
> > +#ifndef WACOM_I2C_FUNC_H
> > +#define WACOM_I2C_FUNC_H
> > +
> > +#include "wacom_i2c.h"
> > +
> > +int wacom_set_coordination(struct wacom_i2c *wac_i2c);
> > +int wacom_send_query(struct wacom_i2c *wac_i2c);
> > +#endif
>=20
> Thank you for taking your time to read such long comments.
> I will be looking forward to seeing your reply.
> Please let me know if there's something that you are not sure or does=
n't
> make sense.

I will sure do so when you send the updated version of the driver ;)

Thanks.

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
