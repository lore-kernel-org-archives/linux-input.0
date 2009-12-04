From: Anisse Astier <anisse@astier.eu>
Subject: Re: [RFC PATCH 1/2] Input: add msi-wmi driver to support hotkeys in
  =?UTF-8?B?TVNJwqBXaW5kdG9w?= AE1900-WT
Date: Fri, 4 Dec 2009 11:15:06 +0100
Message-ID: <20091204111506.254dccef@destiny.ordissimo>
References: <20091202192603.3e1de98a@destiny.ordissimo>
	<200912031749.08734.trenn@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <200912031749.08734.trenn@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: linux-input@vger.kernel.org, linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>, Carlos Corbacho <carlos@strangeworlds.co.uk>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
List-Id: linux-input@vger.kernel.org

Hi Thomas,

On Thu, 3 Dec 2009 17:49:07 +0100, Thomas Renninger <trenn@suse.de>
wrote :

> On Wednesday 02 December 2009 19:26:03 Anisse Astier wrote:
> >=20
> > Signed-off-by: Anisse Astier <anisse@astier.eu>
> > ---
> > Hi,
> >=20
> > This driver (intiated by=20
> > http://sysmic.org/dotclear2/index.php?post/2009/06/02/83-msi-wmi-su=
pport) is
> > aimed at supporting WMI based hotkeys on MSI=C2=A0Windtop all-in-on=
e AE1900-WT.
> I've already submitted a driver together with some other fixes a mont=
h ago.
>=20
Indeed, I am sorry I didn't see it earlier. Did you write it from scrat=
ch
or base it on Jerome's patch?

> My driver not only registers an input device for backlight/volume up,=
 down,
> but also registers a backlight driver for software based backlight sw=
itching.
Indeed, and that's very nice!
>=20
> Not sure whether Len already submitted it to he's test branch, I hope=
 so:
> http://patchwork.kernel.org/patch/55944/
>=20
> Would be great if you can give it a try.

I gave it a try, it works great. Buttons works as expected, and the
backlight interface works as well. Now I have a few questions/comments:

> +static int backlight_map[] =3D { 0x00, 0x33, 0x66, 0x99, 0xCC, 0xFF =
};
Why just 6 levels for backlight? Wasn't it possible to map the whole
range? Does it work the same way in windows?

> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/init.h>
> +#include <linux/types.h>
> +#include <linux/input.h>
> +#include <acpi/acpi_drivers.h>
> +#include <linux/acpi.h>
> +#include <linux/string.h>
> +#include <linux/hrtimer.h>
> +#include <linux/backlight.h>
Do you need all these #includes? (e.g string.h)

> +#define dprintk(msg...)	do {			\
Isn't reimplementing some kind of dprintk a little outdated with
DYNAMIC_PRINTK now in kernel?

> +	kfree(obj);
Good thing you're freeing the allocated acpi objects.


> +			cur =3D ktime_get_real();
> +			/* Ignore event if the same event happened in a 50 ms
> +			   timeframe -> Key press may result in 10-20 GPEs */
> +			if (ktime_to_us(ktime_sub(cur, key->last_pressed))
> +			    < 1000 * 50) {

You're debouncing by computing the time difference instead of using
a kernel timer.

> +static int __init msi_wmi_init(void)
You're init method could use some gotos to remove code duplication. (an=
d
merge some init with input_setup.)=09


I would be happy to transform these comments into patches once I have t=
he
time, and if you don't mind.

I could also adapt it for sparse keymaps as I did with the other driver
(would reduce code size).


Best Regards,

Anisse
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
