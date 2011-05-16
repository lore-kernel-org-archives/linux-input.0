From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH] input: Add Nintendo extension controller driver
Date: Mon, 16 May 2011 15:56:12 -0600
Message-ID: <BANLkTikzWJh1-hfik5_0W4ycz7XPwgy0+g@mail.gmail.com>
References: <20110516214608.17011.3075.stgit@ponder>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:34645 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751242Ab1EPV4c convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 16 May 2011 17:56:32 -0400
In-Reply-To: <20110516214608.17011.3075.stgit@ponder>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: simon@mungewell.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Oliver Neukum <oliver@neukum.org>

[fixed Oliver's email address]

On Mon, May 16, 2011 at 3:46 PM, Grant Likely <grant.likely@secretlab.c=
a> wrote:
> This driver adds support for Nintendo Wiimote extension controllers
> directly attached to an i2c bus, such as when using an adaptor like
> the Wiichuck.
>
> Signed-off-by: Grant Likely <grant.likely@secretlab.ca>

I should probably mention that I've only actually /tested/ this driver
with the Nunchuck.  I'm getting a classic controller, but I don't have
it in my hands just yet.  :-)

g.

> ---
> =A0drivers/input/joystick/Kconfig =A0 =A0| =A0 13 +
> =A0drivers/input/joystick/Makefile =A0 | =A0 =A01
> =A0drivers/input/joystick/wiichuck.c | =A0441 +++++++++++++++++++++++=
++++++++++++++
> =A03 files changed, 455 insertions(+), 0 deletions(-)
> =A0create mode 100644 drivers/input/joystick/wiichuck.c
>
> diff --git a/drivers/input/joystick/Kconfig b/drivers/input/joystick/=
Kconfig
> index 56eb471..5b7fba7 100644
> --- a/drivers/input/joystick/Kconfig
> +++ b/drivers/input/joystick/Kconfig
> @@ -193,6 +193,19 @@ config JOYSTICK_TWIDJOY
> =A0 =A0 =A0 =A0 =A0To compile this driver as a module, choose M here:=
 the
> =A0 =A0 =A0 =A0 =A0module will be called twidjoy.
>
> +config JOYSTICK_WIICHUCK
> + =A0 =A0 =A0 tristate "Nintendo Wiimote Extension connector on i2c b=
us"
> + =A0 =A0 =A0 depends on I2C
> + =A0 =A0 =A0 select INPUT_POLLDEV
> + =A0 =A0 =A0 help
> + =A0 =A0 =A0 =A0 Say Y here if you have a Nintendo Wiimote extension=
 connector
> + =A0 =A0 =A0 =A0 attached directly to an i2c bus, like the Sparcfun =
Wiichuck adapter
> + =A0 =A0 =A0 =A0 board. =A0This driver supports both the Nunchuck an=
d the Classic
> + =A0 =A0 =A0 =A0 Controller extensions.
> +
> + =A0 =A0 =A0 =A0 To compile this driver as a module, choose M here: =
the
> + =A0 =A0 =A0 =A0 modules will be called wiichuck.
> +
> =A0config JOYSTICK_ZHENHUA
> =A0 =A0 =A0 =A0tristate "5-byte Zhenhua RC transmitter"
> =A0 =A0 =A0 =A0select SERIO
> diff --git a/drivers/input/joystick/Makefile b/drivers/input/joystick=
/Makefile
> index 92dc0de..78466d6 100644
> --- a/drivers/input/joystick/Makefile
> +++ b/drivers/input/joystick/Makefile
> @@ -29,6 +29,7 @@ obj-$(CONFIG_JOYSTICK_TMDC) =A0 =A0 =A0 =A0 =A0 +=3D=
 tmdc.o
> =A0obj-$(CONFIG_JOYSTICK_TURBOGRAFX) =A0 =A0 =A0+=3D turbografx.o
> =A0obj-$(CONFIG_JOYSTICK_TWIDJOY) =A0 =A0 =A0 =A0 +=3D twidjoy.o
> =A0obj-$(CONFIG_JOYSTICK_WARRIOR) =A0 =A0 =A0 =A0 +=3D warrior.o
> +obj-$(CONFIG_JOYSTICK_WIICHUCK) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0+=3D =
wiichuck.o
> =A0obj-$(CONFIG_JOYSTICK_XPAD) =A0 =A0 =A0 =A0 =A0 =A0+=3D xpad.o
> =A0obj-$(CONFIG_JOYSTICK_ZHENHUA) =A0 =A0 =A0 =A0 +=3D zhenhua.o
> =A0obj-$(CONFIG_JOYSTICK_WALKERA0701) =A0 =A0 +=3D walkera0701.o
> diff --git a/drivers/input/joystick/wiichuck.c b/drivers/input/joysti=
ck/wiichuck.c
> new file mode 100644
> index 0000000..85a194f
> --- /dev/null
> +++ b/drivers/input/joystick/wiichuck.c
> @@ -0,0 +1,441 @@
> +/*
> + * i2c Wiichuck driver (Nintendo Wiimote accessory connector)
> + *
> + * This driver supports Nintendo Wiimote accessories like the Nunchu=
ck and
> + * the Classic Controller connected to an i2c bus.
> + *
> + * Copyright (c) 2011 Secret Lab Technologies Ltd.
> + *
> + * This program is free software; you can redistribute it and/or mod=
ify
> + * it under the terms of version 2 of the GNU General Public License=
 as
> + * published by the Free Software Foundation.
> + *
> + * This driver uses the polled input device abstraction to implement=
 an
> + * input driver for Nintendo expansion devices wired up to an i2c bu=
s.
> + *
> + * A state machine implements the protocol handling. =A0It starts in=
 the
> + * DISCONNECTED state initially and polls every second waiting for a
> + * device to get attached, and reading the device id when one does.
> + * If the device is recognized, then the polling period is bumped up
> + * to 50ms, and the state machine enters into a loop alternating
> + * between writing the data address (which triggers data capture) an=
d
> + * reading the data block out of the device. =A0If at any time the
> + * device is disconnected, then it goes back to DISCONNECTED state a=
nd
> + * drops the polling frequency back down to 1 second.
> + *
> + * A callback is implemented for each supported devices, currently t=
he
> + * Nunchuck and the Classic Controller. =A0Wii Motion Plus has yet t=
o be
> + * added.
> + */
> +
> +#include <linux/cache.h>
> +#include <linux/delay.h>
> +#include <linux/i2c.h>
> +#include <linux/interrupt.h>
> +#include <linux/input.h>
> +#include <linux/input-polldev.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/slab.h>
> +
> +MODULE_AUTHOR("Grant Likely <grant.likely@secretlab.ca>");
> +MODULE_DESCRIPTION("Wiichuck (i2c Nintendo Wiimote accessory) driver=
");
> +MODULE_LICENSE("GPL");
> +
> +#define WIICHUCK_POLL_PERIOD =A0 (1000) =A0/* 1 second */
> +#ifdef DEBUG
> +#define WIICHUCK_CAPTURE_PERIOD (500) =A0/* 1/2 second for debug */
> +#else
> +#define WIICHUCK_CAPTURE_PERIOD (100) =A0/* 100 milliseconds */
> +#endif /* DEBUG */
> +
> +enum wiichuck_state {
> + =A0 =A0 =A0 WIICHUCK_STATE_DISCONNECTED =3D 0,
> + =A0 =A0 =A0 WIICHUCK_STATE_DATA,
> +};
> +
> +struct wiichuck_device {
> + =A0 =A0 =A0 struct input_polled_dev *poll_dev;
> + =A0 =A0 =A0 struct i2c_client *i2c_client;
> + =A0 =A0 =A0 int (*process)(struct wiichuck_device *wiichuck);
> + =A0 =A0 =A0 enum wiichuck_state state;
> +
> + =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0* DMA buffer, with padding to give it its own cache =
line so that
> + =A0 =A0 =A0 =A0* the DMA streaming works on non-coherent architectu=
res.
> + =A0 =A0 =A0 =A0* Question: Is this the proper pattern, and is this =
really necessary?
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 uint8_t pad1[L1_CACHE_BYTES];
> + =A0 =A0 =A0 uint8_t buf[6];
> + =A0 =A0 =A0 uint8_t pad2[L1_CACHE_BYTES];
> +};
> +
> +static int wiichuck_transfer(struct wiichuck_device *wiichuck,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0int len, boo=
l read)
> +{
> + =A0 =A0 =A0 struct i2c_client *i2c =3D wiichuck->i2c_client;
> + =A0 =A0 =A0 struct i2c_msg msg =3D {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .addr =3D i2c->addr, .len =3D len, .buf=
 =3D wiichuck->buf };
> +
> + =A0 =A0 =A0 if (read)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 msg.flags =3D I2C_M_RD;
> + =A0 =A0 =A0 return i2c_transfer(i2c->adapter, &msg, 1);
> +}
> +
> +static int wiichuck_write(struct wiichuck_device *wiichuck,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0uint8_t addr, ui=
nt8_t val)
> +{
> + =A0 =A0 =A0 wiichuck->buf[0] =3D addr;
> + =A0 =A0 =A0 wiichuck->buf[1] =3D val;
> + =A0 =A0 =A0 return wiichuck_transfer(wiichuck, 2, false);
> +}
> +
> +static inline int wiichuck_setaddr(struct wiichuck_device *wiichuck,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 uint8_t addr)
> +{
> + =A0 =A0 =A0 wiichuck->buf[0] =3D addr;
> + =A0 =A0 =A0 return wiichuck_transfer(wiichuck, 1, false);
> +}
> +
> +static inline int wiichuck_read(struct wiichuck_device *wiichuck, in=
t len)
> +{
> + =A0 =A0 =A0 return wiichuck_transfer(wiichuck, len, true);
> +}
> +
> +static inline bool WIIBTN(int val, int bit)
> +{
> + =A0 =A0 =A0 return (val & BIT(bit)) =3D=3D 0;
> +}
> +
> +static int wiichuck_process_unknown(struct wiichuck_device *wiichuck=
)
> +{
> + =A0 =A0 =A0 return 0;
> +}
> +
> +static int wiichuck_process_nunchuck(struct wiichuck_device *wiichuc=
k)
> +{
> + =A0 =A0 =A0 struct input_dev *input_dev =3D wiichuck->poll_dev->inp=
ut;
> + =A0 =A0 =A0 uint8_t *b =3D wiichuck->buf;
> + =A0 =A0 =A0 int ax, ay, az, rc;
> +
> + =A0 =A0 =A0 rc =3D wiichuck_read(wiichuck, 6);
> + =A0 =A0 =A0 if (rc < 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return rc;
> +
> + =A0 =A0 =A0 ax =3D (b[2] << 2) | ((b[5] >> 2) & 0x3);
> + =A0 =A0 =A0 ay =3D (b[3] << 2) | ((b[5] >> 4) & 0x3);
> + =A0 =A0 =A0 az =3D (b[4] << 2) | ((b[5] >> 6) & 0x3);
> +
> + =A0 =A0 =A0 input_report_abs(input_dev, ABS_X, b[0]);
> + =A0 =A0 =A0 input_report_abs(input_dev, ABS_Y, b[1]);
> + =A0 =A0 =A0 input_report_abs(input_dev, ABS_RX, ax);
> + =A0 =A0 =A0 input_report_abs(input_dev, ABS_RY, ax);
> + =A0 =A0 =A0 input_report_abs(input_dev, ABS_RZ, ay);
> + =A0 =A0 =A0 input_report_key(input_dev, BTN_C, WIIBTN(b[5], 1));
> + =A0 =A0 =A0 input_report_key(input_dev, BTN_Z, WIIBTN(b[5], 0));
> + =A0 =A0 =A0 input_sync(input_dev);
> +
> + =A0 =A0 =A0 dev_dbg(&wiichuck->i2c_client->dev,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 "nunchuck: j=3D%.3i,%.3i a=3D%.3x,%.3x,=
%.3x c,z=3D%i,%i\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 b[0],b[1], ax,ay,az, WIIBTN(b[5], 1), W=
IIBTN(b[5], 0));
> + =A0 =A0 =A0 return 0;
> +};
> +
> +static int wiichuck_process_classic(struct wiichuck_device *wiichuck=
)
> +{
> + =A0 =A0 =A0 struct input_dev *input_dev =3D wiichuck->poll_dev->inp=
ut;
> + =A0 =A0 =A0 uint8_t *b =3D wiichuck->buf;
> + =A0 =A0 =A0 int lx, ly, lt, rx, ry, rt, rc;
> +
> + =A0 =A0 =A0 rc =3D wiichuck_read(wiichuck, 6);
> + =A0 =A0 =A0 if (rc < 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return rc;
> +
> + =A0 =A0 =A0 /* Analog measurements; some values are split between r=
egisters */
> + =A0 =A0 =A0 rx =3D ((b[0] >> 3) & 0x18) | ((b[1] >> 5) & 6) | ((b[2=
] >> 7) & 1);
> + =A0 =A0 =A0 ry =3D b[2] & 0x1f;
> + =A0 =A0 =A0 rt =3D b[3] & 0x1f;
> + =A0 =A0 =A0 lx =3D b[0] & 0x3f;
> + =A0 =A0 =A0 ly =3D b[1] & 0x3f;
> + =A0 =A0 =A0 lt =3D ((b[2] >> 2) & 0x18) | ((b[3] >> 5) & 7);
> +
> + =A0 =A0 =A0 input_report_abs(input_dev, ABS_HAT0X, lx); /* left joy=
stick */
> + =A0 =A0 =A0 input_report_abs(input_dev, ABS_HAT0Y, ly);
> + =A0 =A0 =A0 input_report_abs(input_dev, ABS_BRAKE, lt); /* left tri=
gger */
> + =A0 =A0 =A0 input_report_abs(input_dev, ABS_HAT1X, rx); /* right jo=
ystick */
> + =A0 =A0 =A0 input_report_abs(input_dev, ABS_HAT1Y, ry);
> + =A0 =A0 =A0 input_report_abs(input_dev, ABS_GAS, rt); /* right trig=
ger */
> +
> + =A0 =A0 =A0 /* D-pad */
> + =A0 =A0 =A0 input_report_abs(input_dev, ABS_HAT2X, WIIBTN(b[4],7) -=
 WIIBTN(b[5],1));
> + =A0 =A0 =A0 input_report_abs(input_dev, ABS_HAT2Y, WIIBTN(b[4],6) -=
 WIIBTN(b[5],0));
> +
> + =A0 =A0 =A0 /* Buttons */
> + =A0 =A0 =A0 input_report_key(input_dev, BTN_TL, WIIBTN(b[4], 5)); /=
* left trigger */
> + =A0 =A0 =A0 input_report_key(input_dev, BTN_SELECT, WIIBTN(b[4], 4)=
); /* minus */
> + =A0 =A0 =A0 input_report_key(input_dev, BTN_MODE, WIIBTN(b[4], 3));=
 /* home */
> + =A0 =A0 =A0 input_report_key(input_dev, BTN_START, WIIBTN(b[4], 2))=
; /* plus */
> + =A0 =A0 =A0 input_report_key(input_dev, BTN_TR, WIIBTN(b[4], 1)); /=
* right trigger */
> +
> + =A0 =A0 =A0 input_report_key(input_dev, BTN_TL2, WIIBTN(b[5], 7)); =
/* left z */
> + =A0 =A0 =A0 input_report_key(input_dev, BTN_B, WIIBTN(b[5], 6));
> + =A0 =A0 =A0 input_report_key(input_dev, BTN_Y, WIIBTN(b[5], 5));
> + =A0 =A0 =A0 input_report_key(input_dev, BTN_A, WIIBTN(b[5], 4));
> + =A0 =A0 =A0 input_report_key(input_dev, BTN_X, WIIBTN(b[5], 3));
> + =A0 =A0 =A0 input_report_key(input_dev, BTN_TR2, WIIBTN(b[5], 2)); =
/* right z */
> + =A0 =A0 =A0 input_sync(input_dev);
> +
> + =A0 =A0 =A0 dev_dbg(&wiichuck->i2c_client->dev,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 "classic: r=3D%.3i,%.3i,%.3i l=3D%.3x,%=
=2E3x,%.3x b=3D%.2x,%.2x\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 lx,ly,lt, rx,ry,rt, b[4],b[5]);
> + =A0 =A0 =A0 return 0;
> +};
> +
> +/**
> + * wiichuck_poll() - Protocol state machine implementation
> + *
> + * A state machine is used here to keep the protocol processing
> + * reentrant. =A0Any of the i2c transactions will indeed sleep becau=
se
> + * i2c transactions are slow, but there is a mandatory delay between
> + * triggering the data capture (set address) and reading the data
> + * back. =A0Using a state machine means the poll function can return=
 and
> + * free up the worker thread while waiting for the data.
> + */
> +static void wiichuck_poll(struct input_polled_dev *poll_dev)
> +{
> + =A0 =A0 =A0 struct wiichuck_device *wiichuck =3D poll_dev->private;
> + =A0 =A0 =A0 int id;
> +
> + =A0 =A0 =A0 switch (wiichuck->state) {
> + =A0 =A0 =A0 case WIICHUCK_STATE_DISCONNECTED:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Disable encryption */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (wiichuck_write(wiichuck, 0xf0, 0x55=
) < 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (wiichuck_write(wiichuck, 0xfb, 0x00=
) < 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Read device id */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (wiichuck_setaddr(wiichuck, 0xfe) < =
0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (wiichuck_read(wiichuck, 2) < 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 id =3D (wiichuck->buf[0] << 8) | wiichu=
ck->buf[1];
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 switch (id) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 case 0x0000: /* Nunchuc=
k */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 wiichuc=
k->process =3D wiichuck_process_nunchuck;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_inf=
o(&wiichuck->i2c_client->dev,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0"Connected Nunchuck\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 case 0x0101: /* Classic=
 Controller */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 wiichuc=
k->process =3D wiichuck_process_classic;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_inf=
o(&wiichuck->i2c_client->dev,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0"Connected Classic Controller\n");
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 default: /* No connecti=
on or unsupported device */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 wiichuc=
k->process =3D wiichuck_process_unknown;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg=
(&wiichuck->i2c_client->dev,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0"Connected unknown id: %x\n", id);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Setup the first data transfer */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (wiichuck_setaddr(wiichuck, 0) < 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 wiichuck->state =3D WIICHUCK_STATE_DATA=
;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 poll_dev->poll_interval =3D WIICHUCK_CA=
PTURE_PERIOD;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> +
> + =A0 =A0 =A0 case WIICHUCK_STATE_DATA:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Read the input report */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (wiichuck->process(wiichuck) < 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto disconnect;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Setup the next transfer */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (wiichuck_setaddr(wiichuck, 0) < 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto disconnect;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> +
> + =A0 =A0 =A0 default:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto disconnect;
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 return;
> +
> + disconnect:
> + =A0 =A0 =A0 dev_info(&wiichuck->i2c_client->dev, "disconnected\n");
> + =A0 =A0 =A0 wiichuck->state =3D WIICHUCK_STATE_DISCONNECTED;
> + =A0 =A0 =A0 poll_dev->poll_interval =3D WIICHUCK_POLL_PERIOD;
> +}
> +
> +/**
> + * wiichuck_open() - Set up initial state machine state
> + *
> + * Called exactly once the first time the device is opened by
> + * userspace. =A0Will not be called again unless all users close it
> + * before reopening. =A0This simply clears the state to disconnected=
 and
> + * sets the poll rate back to the slow speed
> + */
> +static void wiichuck_open(struct input_polled_dev *poll_dev)
> +{
> + =A0 =A0 =A0 struct wiichuck_device *wiichuck =3D poll_dev->private;
> +
> + =A0 =A0 =A0 wiichuck->process =3D wiichuck_process_unknown;
> + =A0 =A0 =A0 wiichuck->state =3D WIICHUCK_STATE_DISCONNECTED;
> + =A0 =A0 =A0 wiichuck->poll_dev->poll_interval =3D WIICHUCK_POLL_PER=
IOD;
> +}
> +
> +static int __devinit wiichuck_probe(struct i2c_client *client,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 const s=
truct i2c_device_id *id)
> +{
> + =A0 =A0 =A0 struct wiichuck_device *wiichuck;
> + =A0 =A0 =A0 struct input_polled_dev *poll_dev;
> + =A0 =A0 =A0 struct input_dev *input_dev;
> + =A0 =A0 =A0 int rc;
> +
> + =A0 =A0 =A0 wiichuck =3D kzalloc(sizeof(*wiichuck), GFP_KERNEL);
> + =A0 =A0 =A0 if (!wiichuck)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENOMEM;
> +
> + =A0 =A0 =A0 poll_dev =3D input_allocate_polled_device();
> + =A0 =A0 =A0 if (!poll_dev) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 rc =3D -ENOMEM;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_alloc;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 wiichuck->i2c_client =3D client;
> + =A0 =A0 =A0 wiichuck->poll_dev =3D poll_dev;
> +
> + =A0 =A0 =A0 poll_dev->private =3D wiichuck;
> + =A0 =A0 =A0 poll_dev->poll =3D wiichuck_poll;
> + =A0 =A0 =A0 poll_dev->open =3D wiichuck_open;
> +
> + =A0 =A0 =A0 input_dev =3D poll_dev->input;
> + =A0 =A0 =A0 input_dev->name =3D "Wiichuck expansion connector";
> + =A0 =A0 =A0 input_dev->id.bustype =3D BUS_I2C;
> + =A0 =A0 =A0 input_dev->dev.parent =3D &client->dev;
> +
> + =A0 =A0 =A0 /* Declare the events generated by this driver */
> + =A0 =A0 =A0 __set_bit(EV_ABS, input_dev->evbit);
> + =A0 =A0 =A0 __set_bit(EV_KEY, input_dev->evbit);
> +
> + =A0 =A0 =A0 /* Nunchuck ranges */
> + =A0 =A0 =A0 __set_bit(ABS_X, input_dev->absbit); /* joystick */
> + =A0 =A0 =A0 __set_bit(ABS_Y, input_dev->absbit);
> + =A0 =A0 =A0 input_set_abs_params(input_dev, ABS_X, 30, 220, 4, 8);
> + =A0 =A0 =A0 input_set_abs_params(input_dev, ABS_Y, 40, 200, 4, 8);
> +
> + =A0 =A0 =A0 __set_bit(ABS_RX, input_dev->absbit); /* accelerometer =
*/
> + =A0 =A0 =A0 __set_bit(ABS_RY, input_dev->absbit);
> + =A0 =A0 =A0 __set_bit(ABS_RZ, input_dev->absbit);
> + =A0 =A0 =A0 input_set_abs_params(input_dev, ABS_RX, 0, 0x3ff, 4, 8)=
;
> + =A0 =A0 =A0 input_set_abs_params(input_dev, ABS_RY, 0, 0x3ff, 4, 8)=
;
> + =A0 =A0 =A0 input_set_abs_params(input_dev, ABS_RZ, 0, 0x3ff, 4, 8)=
;
> +
> + =A0 =A0 =A0 /* Nunchuck buttons */
> + =A0 =A0 =A0 __set_bit(BTN_C, input_dev->keybit);
> + =A0 =A0 =A0 __set_bit(BTN_Z, input_dev->keybit);
> +
> + =A0 =A0 =A0 /* Classic ranges */
> + =A0 =A0 =A0 __set_bit(ABS_HAT0X, input_dev->absbit); /* Left Joysti=
ck */
> + =A0 =A0 =A0 __set_bit(ABS_HAT0Y, input_dev->absbit);
> + =A0 =A0 =A0 input_set_abs_params(input_dev, ABS_HAT0X, 0, 63, 2, 4)=
;
> + =A0 =A0 =A0 input_set_abs_params(input_dev, ABS_HAT0Y, 0, 63, 2, 4)=
;
> +
> + =A0 =A0 =A0 __set_bit(ABS_HAT1X, input_dev->absbit); /* Right Joyst=
ick */
> + =A0 =A0 =A0 __set_bit(ABS_HAT1Y, input_dev->absbit);
> + =A0 =A0 =A0 input_set_abs_params(input_dev, ABS_HAT1X, 0, 31, 1, 2)=
;
> + =A0 =A0 =A0 input_set_abs_params(input_dev, ABS_HAT1Y, 0, 31, 1, 2)=
;
> +
> + =A0 =A0 =A0 __set_bit(ABS_HAT2X, input_dev->absbit); /* D-pad */
> + =A0 =A0 =A0 __set_bit(ABS_HAT2Y, input_dev->absbit);
> + =A0 =A0 =A0 input_set_abs_params(input_dev, ABS_HAT2X, -1, 1, 0, 0)=
;
> + =A0 =A0 =A0 input_set_abs_params(input_dev, ABS_HAT2Y, -1, 1, 0, 0)=
;
> +
> + =A0 =A0 =A0 __set_bit(ABS_BRAKE, input_dev->absbit); /* Left trigge=
r */
> + =A0 =A0 =A0 input_set_abs_params(input_dev, ABS_BRAKE, 0, 31, 1, 2)=
;
> + =A0 =A0 =A0 __set_bit(ABS_GAS, input_dev->absbit);
> + =A0 =A0 =A0 input_set_abs_params(input_dev, ABS_GAS, 0, 31, 1, 2);
> +
> + =A0 =A0 =A0 /* Classic buttons */
> + =A0 =A0 =A0 __set_bit(BTN_TL, input_dev->keybit);
> + =A0 =A0 =A0 __set_bit(BTN_SELECT, input_dev->keybit);
> + =A0 =A0 =A0 __set_bit(BTN_MODE, input_dev->keybit);
> + =A0 =A0 =A0 __set_bit(BTN_START, input_dev->keybit);
> + =A0 =A0 =A0 __set_bit(BTN_TR, input_dev->keybit);
> + =A0 =A0 =A0 __set_bit(BTN_TL2, input_dev->keybit);
> + =A0 =A0 =A0 __set_bit(BTN_B, input_dev->keybit);
> + =A0 =A0 =A0 __set_bit(BTN_Y, input_dev->keybit);
> + =A0 =A0 =A0 __set_bit(BTN_A, input_dev->keybit);
> + =A0 =A0 =A0 __set_bit(BTN_X, input_dev->keybit);
> + =A0 =A0 =A0 __set_bit(BTN_TR2, input_dev->keybit);
> +
> + =A0 =A0 =A0 i2c_set_clientdata(client, wiichuck);
> +
> + =A0 =A0 =A0 /* Register the device; it is 'live' after this point *=
/
> + =A0 =A0 =A0 rc =3D input_register_polled_device(wiichuck->poll_dev)=
;
> + =A0 =A0 =A0 if (rc) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&client->dev, "Failed to regist=
er input device\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_register;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 return 0;
> +
> + err_register:
> + =A0 =A0 =A0 i2c_set_clientdata(client, NULL);
> + =A0 =A0 =A0 input_free_polled_device(poll_dev);
> + err_alloc:
> + =A0 =A0 =A0 kfree(wiichuck);
> +
> + =A0 =A0 =A0 return rc;
> +}
> +
> +static int __devexit wiichuck_remove(struct i2c_client *client)
> +{
> + =A0 =A0 =A0 struct wiichuck_device *wiichuck =3D i2c_get_clientdata=
(client);
> +
> + =A0 =A0 =A0 i2c_set_clientdata(client, NULL);
> + =A0 =A0 =A0 input_unregister_polled_device(wiichuck->poll_dev);
> + =A0 =A0 =A0 input_free_polled_device(wiichuck->poll_dev);
> + =A0 =A0 =A0 kfree(wiichuck);
> +
> + =A0 =A0 =A0 return 0;
> +}
> +
> +static const struct i2c_device_id wiichuck_id[] =3D {
> + =A0 =A0 =A0 { "wiichuck", 0 },
> + =A0 =A0 =A0 { }
> +};
> +MODULE_DEVICE_TABLE(i2c, wiichuck_id);
> +
> +#ifdef CONFIG_OF
> +static struct of_device_id wiichuck_match_table[] __devinitdata =3D =
{
> + =A0 =A0 =A0 { .compatible =3D "nintendo,wiimote-extension", },
> + =A0 =A0 =A0 { }
> +};
> +#else
> +#define wiichuck_match_table NULL
> +#endif
> +
> +static struct i2c_driver wiichuck_driver =3D {
> + =A0 =A0 =A0 .driver =3D {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =3D "wiichuck",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .owner =3D THIS_MODULE,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .of_match_table =3D wiichuck_match_tabl=
e,
> + =A0 =A0 =A0 },
> + =A0 =A0 =A0 .probe =A0 =A0 =A0 =A0 =A0=3D wiichuck_probe,
> + =A0 =A0 =A0 .remove =A0 =A0 =A0 =A0 =3D __devexit_p(wiichuck_remove=
),
> + =A0 =A0 =A0 .id_table =A0 =A0 =A0 =3D wiichuck_id,
> +};
> +
> +static int __init wiichuck_init(void)
> +{
> + =A0 =A0 =A0 return i2c_add_driver(&wiichuck_driver);
> +}
> +module_init(wiichuck_init);
> +
> +static void __exit wiichuck_exit(void)
> +{
> + =A0 =A0 =A0 i2c_del_driver(&wiichuck_driver);
> +}
> +module_exit(wiichuck_exit);
>
>



--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
