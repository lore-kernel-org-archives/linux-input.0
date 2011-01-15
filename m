From: Corentin Chary <corentin.chary@gmail.com>
Subject: Re: [PATCH 1/2] input: Pegatron Lucid accelerometer
Date: Sat, 15 Jan 2011 17:22:16 +0100
Message-ID: <AANLkTi=YY4Zsdzm6PjyLYkNZNdK=X1=70cK0xzE_dzGW@mail.gmail.com>
References: <1295036050-10553-1-git-send-email-andy@windriver.com>
	<1295036050-10553-2-git-send-email-andy@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <platform-driver-x86-owner@vger.kernel.org>
In-Reply-To: <1295036050-10553-2-git-send-email-andy@windriver.com>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Andy Ross <andy.ross@windriver.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, acpi4asus-user@lists.sourceforge.net, platform-driver-x86@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Fri, Jan 14, 2011 at 9:14 PM, Andy Ross <andy@windriver.com> wrote:
> From: Andy Ross <andy.ross@windriver.com>
>
> Add driver for the ACPI accelerometer interface on the Pegatron Lucid
> tablet.
>
> Signed-off-by: Andy Ross <andy.ross@windriver.com>
> ---
> =C2=A0drivers/input/misc/Kconfig =C2=A0 =C2=A0 =C2=A0| =C2=A0 11 +++
> =C2=A0drivers/input/misc/Makefile =C2=A0 =C2=A0 | =C2=A0 =C2=A02 +-
> =C2=A0drivers/input/misc/pega-accel.c | =C2=A0133 +++++++++++++++++++=
++++++++++++++++++++
> =C2=A03 files changed, 145 insertions(+), 1 deletions(-)
> =C2=A0create mode 100644 drivers/input/misc/pega-accel.c
>
> diff --git a/drivers/input/misc/Kconfig b/drivers/input/misc/Kconfig
> index b99b8cb..268c11d 100644
> --- a/drivers/input/misc/Kconfig
> +++ b/drivers/input/misc/Kconfig
> @@ -448,4 +448,15 @@ config INPUT_ADXL34X_SPI
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0To compile this driver as a module,=
 choose M here: the
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0module will be called adxl34x-spi.
>
> +config INPUT_PEGA_ACCEL
> + =C2=A0 =C2=A0 =C2=A0 tristate "Support Pegatron Lucid accelerometer=
"
> + =C2=A0 =C2=A0 =C2=A0 depends on ASUS_LAPTOP
> + =C2=A0 =C2=A0 =C2=A0 default y
> + =C2=A0 =C2=A0 =C2=A0 help
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 Say Y here if you want support for the =
built-in ACPI
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 accelerometer device on Pegatron Lucid =
tablet devices.
> +
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0To compile this driver as a module, choo=
se M here: the module
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0will be called pega_accel.
> +
> =C2=A0endif
> diff --git a/drivers/input/misc/Makefile b/drivers/input/misc/Makefil=
e
> index 1fe1f6c..2475305 100644
> --- a/drivers/input/misc/Makefile
> +++ b/drivers/input/misc/Makefile
> @@ -42,4 +42,4 @@ obj-$(CONFIG_INPUT_WINBOND_CIR) =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 +=3D winbond-cir.o
> =C2=A0obj-$(CONFIG_INPUT_WISTRON_BTNS) =C2=A0 =C2=A0 =C2=A0 +=3D wist=
ron_btns.o
> =C2=A0obj-$(CONFIG_INPUT_WM831X_ON) =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
+=3D wm831x-on.o
> =C2=A0obj-$(CONFIG_INPUT_YEALINK) =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0+=3D yealink.o
> -
> +obj-$(CONFIG_INPUT_PEGA_ACCEL) =C2=A0 =C2=A0 =C2=A0 =C2=A0 +=3D pega=
-accel.o
> diff --git a/drivers/input/misc/pega-accel.c b/drivers/input/misc/peg=
a-accel.c
> new file mode 100644
> index 0000000..9b7ef05
> --- /dev/null
> +++ b/drivers/input/misc/pega-accel.c
> @@ -0,0 +1,133 @@
> +/*
> + * pega_accel.c - driver for accelerometer in Pegatron Lucid tablets
> + *
> + * Copyright (c) 2011 Wind River Systems
> + *
> + * Author: Andy Ross <andy.ross@windriver.com>
> + *
> + * This program is free software; you can redistribute it and/or mod=
ify
> + * it under the terms of the GNU General Public License as published=
 by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. =C2=A0See th=
e
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write to the Free Software
> + * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA =C2=A002=
111-1307 =C2=A0USA
> + */
> +
> +#include <linux/input-polldev.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <acpi/acpi_bus.h>
> +
> +#define DRIVER_NAME "pega_accel"
> +#define DRIVER_DESC "Pegatron Lucid Tablet Accelerometer"
> +
> +/* 1G accel is reported as ~256, so clamp to 2G */
> +#define CLAMP 512
> +
> +static struct input_polled_dev *ipdev;
> +
> +/* FIXME: this mechanism is *very* slow: ~50ms to read the three
> + * values. =C2=A0Pre-caching an acpi handle with acpi_get_handle has=
 no
> + * effect, so the issue isn't in the parsing or tree walking... */
> +static int acpi_s16(char *method)
> +{
> + =C2=A0 =C2=A0 =C2=A0 unsigned long long val =3D 0;
> + =C2=A0 =C2=A0 =C2=A0 acpi_evaluate_integer(NULL, method, NULL, &val=
);
> + =C2=A0 =C2=A0 =C2=A0 return (short)val;
> +}
> +
> +static void pega_accel_poll(struct input_polled_dev *ipdev)
> +{
> + =C2=A0 =C2=A0 =C2=A0 /* Note transform, convert to "right/up/out" i=
n the native
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0* landscape orientation (i.e. the vector=
 is the direction of
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0* "real up" in the device's cartiesian c=
oordinates). =C2=A0FIXME:
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0* is there a relevant convention to adhe=
re to? */
> + =C2=A0 =C2=A0 =C2=A0 int x =3D -acpi_s16("\\_SB.ATKD.XLRX");
> + =C2=A0 =C2=A0 =C2=A0 int y =3D -acpi_s16("\\_SB.ATKD.XLRY");
> + =C2=A0 =C2=A0 =C2=A0 int z =3D =C2=A0acpi_s16("\\_SB.ATKD.XLRZ");

Using the absolute path (\\_SB.ATKD) may not work on new hardware, you
should find the path of the device using the HID (AKT0100, or
something like that). But we may not core in this case since it's pega
specific.

> + =C2=A0 =C2=A0 =C2=A0 x =3D clamp_val(x, -CLAMP, CLAMP);
> + =C2=A0 =C2=A0 =C2=A0 y =3D clamp_val(y, -CLAMP, CLAMP);
> + =C2=A0 =C2=A0 =C2=A0 z =3D clamp_val(z, -CLAMP, CLAMP);
> +
> + =C2=A0 =C2=A0 =C2=A0 input_report_abs(ipdev->input, ABS_X, x);
y> + =C2=A0 =C2=A0 =C2=A0 input_report_abs(ipdev->input, ABS_Y, y);
> + =C2=A0 =C2=A0 =C2=A0 input_report_abs(ipdev->input, ABS_Z, z);
> + =C2=A0 =C2=A0 =C2=A0 input_sync(ipdev->input);
> +}
> +
> +static void dev_noop_release(struct device *d) {}
> +
> +static int __devinit platform_probe(struct platform_device *pd)
> +{
> + =C2=A0 =C2=A0 =C2=A0 int err =3D 0;

You should check if the device exists here, before trying to do
anything, (using the path or the HID, depending of what you'll do
about my previous comment)

> + =C2=A0 =C2=A0 =C2=A0 ipdev =3D input_allocate_polled_device();
> + =C2=A0 =C2=A0 =C2=A0 if (!ipdev)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -ENOMEM;
> +
> + =C2=A0 =C2=A0 =C2=A0 ipdev->poll =3D pega_accel_poll;
> + =C2=A0 =C2=A0 =C2=A0 ipdev->poll_interval =3D 100;
> + =C2=A0 =C2=A0 =C2=A0 ipdev->poll_interval_min =3D 10;
> + =C2=A0 =C2=A0 =C2=A0 ipdev->poll_interval_max =3D 2000;
> +
> + =C2=A0 =C2=A0 =C2=A0 ipdev->input->dev.parent =3D &pd->dev;
> + =C2=A0 =C2=A0 =C2=A0 ipdev->input->dev.release =3D dev_noop_release=
;
> + =C2=A0 =C2=A0 =C2=A0 ipdev->input->id.bustype =3D BUS_HOST;
> +
> + =C2=A0 =C2=A0 =C2=A0 ipdev->input->name =3D DRIVER_DESC;
> + =C2=A0 =C2=A0 =C2=A0 ipdev->input->phys =3D DRIVER_NAME "/input0";
> +
> + =C2=A0 =C2=A0 =C2=A0 set_bit(EV_ABS, ipdev->input->evbit);
> + =C2=A0 =C2=A0 =C2=A0 input_set_abs_params(ipdev->input, ABS_X, -CLA=
MP, CLAMP, 0, 0);
> + =C2=A0 =C2=A0 =C2=A0 input_set_abs_params(ipdev->input, ABS_Y, -CLA=
MP, CLAMP, 0, 0);
> + =C2=A0 =C2=A0 =C2=A0 input_set_abs_params(ipdev->input, ABS_Z, -CLA=
MP, CLAMP, 0, 0);
> +
> + =C2=A0 =C2=A0 =C2=A0 err =3D input_register_polled_device(ipdev);
> + =C2=A0 =C2=A0 =C2=A0 if (err)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 input_free_polled_=
device(ipdev);
> +
> + =C2=A0 =C2=A0 =C2=A0 return err;
> +}
> +
> +static int __devexit platform_remove(struct platform_device *pd)
> +{
> + =C2=A0 =C2=A0 =C2=A0 input_unregister_polled_device(ipdev);
> + =C2=A0 =C2=A0 =C2=A0 input_free_polled_device(ipdev);
> + =C2=A0 =C2=A0 =C2=A0 ipdev =3D NULL;
> + =C2=A0 =C2=A0 =C2=A0 return 0;
> +}
> +
> +static struct platform_driver platform_driver =3D {
> + =C2=A0 =C2=A0 =C2=A0 .driver =3D {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .owner =3D THIS_MO=
DULE,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .name =C2=A0=3D DR=
IVER_NAME,
> + =C2=A0 =C2=A0 =C2=A0 },
> + =C2=A0 =C2=A0 =C2=A0 .probe =C2=A0=3D platform_probe,
> + =C2=A0 =C2=A0 =C2=A0 .remove =3D __devexit_p(platform_remove),
> +};
> +
> +static int __init mod_init(void)
> +{
> + =C2=A0 =C2=A0 =C2=A0 return platform_driver_register(&platform_driv=
er);
> +}
> +
> +static void __exit mod_exit(void)
> +{
> + =C2=A0 =C2=A0 =C2=A0 platform_driver_unregister(&platform_driver);
> +}
> +
> +module_init(mod_init);
> +module_exit(mod_exit);
> +
> +MODULE_AUTHOR("Andy Ross <andy.ross@windriver.com>");
> +MODULE_LICENSE("GPL");
> +MODULE_DESCRIPTION(DRIVER_DESC);
> +MODULE_ALIAS("dmi:*:bvrLucid-CE-133:*");
> --
> 1.7.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input=
" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.ht=
ml
>



--=20
Corentin Chary
http://xf.iksaif.net
