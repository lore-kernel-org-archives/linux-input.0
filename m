From: Trilok Soni <soni.trilok@gmail.com>
Subject: Re: [PATCH 1/2] input: misc: add twl4030-pwrbutton driver
Date: Sat, 28 Feb 2009 11:21:39 +0530
Message-ID: <5d5443650902272151g7595deb4gc91145a4c6938b74@mail.gmail.com>
References: <1235762883-20870-1-git-send-email-me@felipebalbi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751916AbZB1Fvv@vger.kernel.org>
In-Reply-To: <1235762883-20870-1-git-send-email-me@felipebalbi.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Felipe Balbi <me@felipebalbi.com>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Felipe Balbi <felipe.balbi@nokia.com>, David Brownell <dbrownell@users.sourceforge.net>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Samuel Ortiz <sameo@openedhand.com>
List-Id: linux-input@vger.kernel.org

Hi Felipe,

> +++ b/drivers/input/misc/twl4030-pwrbutton.c
> @@ -0,0 +1,147 @@
> +/**
> + * drivers/i2c/chips/twl4030-pwrbutton.c
> + *

Please remove this file path.

> +
> +static struct input_dev *powerbutton_dev;
> +static struct device *dbg_dev;
> +
> +static irqreturn_t powerbutton_irq(int irq, void *dev_id)
> +{
> + =A0 =A0 =A0 int err;
> + =A0 =A0 =A0 u8 value;
> +
> +#ifdef CONFIG_LOCKDEP
> + =A0 =A0 =A0 /* WORKAROUND for lockdep forcing IRQF_DISABLED on us, =
which
> + =A0 =A0 =A0 =A0* we don't want and can't tolerate. =A0Although it m=
ight be
> + =A0 =A0 =A0 =A0* friendlier not to borrow this thread context...
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 local_irq_enable();
> +#endif
> +
> + =A0 =A0 =A0 err =3D twl4030_i2c_read_u8(TWL4030_MODULE_PM_MASTER, &=
value,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 STS=
_HW_CONDITIONS);
> + =A0 =A0 =A0 if (!err) =A0{
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_report_key(powerbutton_dev, KEY_P=
OWER,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0valu=
e & PWR_PWRON_IRQ);


input_sync(...) please.

> + =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dbg_dev, "twl4030: i2c error %d=
 while reading TWL4030"
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 " PM_MASTER STS_HW_COND=
ITIONS register\n", err);
> + =A0 =A0 =A0 }
> +

> +static int __devexit twl4030_pwrbutton_remove(struct platform_device=
 *pdev)
> +{
> + =A0 =A0 =A0 int irq =3D platform_get_irq(pdev, 0);
> +
> + =A0 =A0 =A0 free_irq(irq, NULL);
> + =A0 =A0 =A0 input_unregister_device(powerbutton_dev);
> + =A0 =A0 =A0 input_free_device(powerbutton_dev);

No need of input_free_device after input_unregister_device.

> +
> + =A0 =A0 =A0 return 0;
> +}
> +
> +struct platform_driver twl4030_pwrbutton_driver =3D {
> + =A0 =A0 =A0 .probe =A0 =A0 =A0 =A0 =A0=3D twl4030_pwrbutton_probe,
> + =A0 =A0 =A0 .remove =A0 =A0 =A0 =A0 =3D twl4030_pwrbutton_remove,

__devexit_p(...)



--=20
---Trilok Soni
http://triloksoni.wordpress.com
http://www.linkedin.com/in/triloksoni
