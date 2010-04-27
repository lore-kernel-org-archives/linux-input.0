From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH 2/2] hid: add PM support to PicoLCD device
Date: Tue, 27 Apr 2010 15:28:12 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1004271525330.9849@pobox.suse.cz>
References: <20100425214003.7e87c6a3@neptune.home> <20100425214306.5d7be049@neptune.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20100425214306.5d7be049@neptune.home>
Sender: linux-kernel-owner@vger.kernel.org
To: =?ISO-8859-15?Q?Bruno_Pr=E9mont?= <bonbons@linux-vserver.org>
Cc: Oliver Neukum <oliver@neukum.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, Nicu Pavel <npavel@ituner.com>, Jaya Kumar <jayakumar.lkml@gmail.com>, "Rick L. Vinyard Jr." <rvinyard@cs.nmsu.edu>
List-Id: linux-input@vger.kernel.org

On Sun, 25 Apr 2010, Bruno Pr=C3=A9mont wrote:

> Add PM support in order to turn off backlight on suspend, restore
> it on resume and especially restore complete state on reset-resume.
>=20
> Signed-off-by: Bruno Pr=C3=A9mont <bonbons@linux-vserver.org>
> ---
>  drivers/hid/hid-picolcd.c |   61 +++++++++++++++++++++++++++++++++++=
++++++++++
>  1 files changed, 61 insertions(+), 0 deletions(-)
>=20
> diff --git a/drivers/hid/hid-picolcd.c b/drivers/hid/hid-picolcd.c
> index aa6f2e1..c652390 100644
> --- a/drivers/hid/hid-picolcd.c
> +++ b/drivers/hid/hid-picolcd.c
> @@ -852,6 +852,20 @@ static inline int picolcd_resume_backlight(struc=
t picolcd_data *data)
>  	return picolcd_set_brightness(data->backlight);
>  }
> =20
> +#ifdef CONFIG_PM
> +static void picolcd_suspend_backlight(struct picolcd_data *data)
> +{
> +	int bl_power =3D data->lcd_power;
> +	if (!data->backlight)
> +		return;
> +
> +	data->backlight->props.power =3D FB_BLANK_POWERDOWN;
> +	picolcd_set_brightness(data->backlight);
> +	data->lcd_power =3D data->backlight->props.power =3D bl_power;
> +}
> +#else
> +#define picolcd_suspend_backlight(a)
> +#endif /* CONFIG_PM */

Stylistic thing -- it would be nice if this was actually=20

static inline void picolcd_suspend_backlight(struct picolcd_data *data)
{
	return 0;
}

But why do you need to have it defined in !CONFIG_PM situation anyway?=20
It's not used otherwise at all.

>  #else
>  static inline int picolcd_init_backlight(struct picolcd_data *data,
>  		struct hid_report *report)
> @@ -865,6 +879,7 @@ static inline int picolcd_resume_backlight(struct=
 picolcd_data *data)
>  {
>  	return 0;
>  }
> +#define picolcd_suspend_backlight(a)

Any why is it defined once more here?

Thanks,

--=20
Jiri Kosina
SUSE Labs, Novell Inc.
