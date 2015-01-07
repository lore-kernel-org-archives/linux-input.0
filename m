From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 1/1] Elantech touchpad detection fix for laptops
Date: Tue, 6 Jan 2015 23:44:33 -0800
Message-ID: <20150107074433.GC5256@dtor-ws>
References: <CAEK4c-_Kirwxj_Rgqn1c7x4h0Mj0r8vhSYb5qQcJvo5TbXdb0Q@mail.gmail.com>
 <CAEK4c-8CsrBaf8gaH2B2kuoMTHrLpLMgGQPrXTZAX3W5At0uoA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ie0-f181.google.com ([209.85.223.181]:33264 "EHLO
	mail-ie0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752302AbbAGHoi (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 7 Jan 2015 02:44:38 -0500
Received: by mail-ie0-f181.google.com with SMTP id rl12so2269257iec.12
        for <linux-input@vger.kernel.org>; Tue, 06 Jan 2015 23:44:38 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CAEK4c-8CsrBaf8gaH2B2kuoMTHrLpLMgGQPrXTZAX3W5At0uoA@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Srihari Vijayaraghavan <linux.bug.reporting@gmail.com>
Cc: linux-input@vger.kernel.org, Mateusz =?utf-8?Q?Jo=C5=84czyk?= <mat.jonczyk@o2.pl>, Zakariya Dehlawi <zdehlawi@gmail.com>, guillaum.bouchard@gmail.com

Hi Srihari,

On Mon, Jan 05, 2015 at 07:45:39PM +1100, Srihari Vijayaraghavan wrote:
> Hello Folks & Dmitry,
>=20
> Further to the previous patch, here is the current version (against
> mainline) updated with the DMI info of another laptop model where thi=
s
> fix had helped a user.
>=20
> Can you please review it & give some feedback? If it looks good as it
> is, then on behalf of all affected users (including yours truly), may
> I request for it to be merged upstream (and possibly stable too)?
>=20
> (If the patch gets spoiled by gmail, please ref to this bugzilla URL,
> where this patch is there as a file attachment:
> https://bugzilla.kernel.org/show_bug.cgi?id=3D81331)

I am not terribly happy with having fiddling with keyboard from i8042
core, but I guess that's what we have to do unless someone has better
idea...

I'll drop mention of Elantech from the option though as it may well be
needed for other devices in the future.

Thanks!


>=20
> Thanks

> commit c77a39a799b51fbb68b72330267c2d32a8e20542
> Author: Srihari Vijayaraghavan <linux.bug.reporting@gmail.com>
> Date:   Mon Jan 5 18:53:04 2015 +1100
>=20
>     As reported in kernel bugzilla 81331, on many laptops keyboard ne=
eds to be reset
>     for the detection of Elantech touchpad. Based on the original pat=
ch by Mateusz Jo=C5=84czyk
>     this version has been expanded to include DMI based detection & a=
pplication of the fix
>     automatically. Confirmed to fix the problem by three users alread=
y.
>    =20
>     Signed-off-by: Srihari Vijayaraghavan <linux.bug.reporting@gmail.=
com>
>     Acked-by: Mateusz Jo=C5=84czyk <mat.jonczyk@o2.pl>
>     Tested-by: Srihari Vijayaraghavan <linux.bug.reporting@gmail.com>
>     Tested by: Zakariya Dehlawi <zdehlawi@gmail.com>
>     Tested-by: Guillaum Bouchard <guillaum.bouchard@gmail.com>
>=20
> diff --git a/Documentation/kernel-parameters.txt b/Documentation/kern=
el-parameters.txt
> index 4df73da..c6e8cbc 100644
> --- a/Documentation/kernel-parameters.txt
> +++ b/Documentation/kernel-parameters.txt
> @@ -1277,6 +1277,7 @@ bytes respectively. Such letter suffixes can al=
so be entirely omitted.
>  	i8042.notimeout	[HW] Ignore timeout condition signalled by controll=
er
>  	i8042.reset	[HW] Reset the controller during init and cleanup
>  	i8042.unlock	[HW] Unlock (ignore) the keylock
> +	i8042.kbdreset  [HW] Reset keyboard to detect Elantech touchpad
> =20
>  	i810=3D		[HW,DRM]
> =20
> diff --git a/drivers/input/serio/i8042-x86ia64io.h b/drivers/input/se=
rio/i8042-x86ia64io.h
> index c66d1b5..734360b 100644
> --- a/drivers/input/serio/i8042-x86ia64io.h
> +++ b/drivers/input/serio/i8042-x86ia64io.h
> @@ -745,6 +745,36 @@ static const struct dmi_system_id __initconst i8=
042_dmi_dritek_table[] =3D {
>  	{ }
>  };
> =20
> +/*
> + * Just as per kernel bugzilla #81331, some Elantech touchpad based =
laptops
> + * need keyboard reset while probing for the tochpad to get detected=
,
> + * initialised & finally work.
> + */
> +static const struct dmi_system_id __initconst i8042_dmi_elantech_kbd=
reset_table[] =3D {
> +        {
> +                /* Gigabyte P35 v2 */
> +                .matches =3D {
> +                        DMI_MATCH(DMI_SYS_VENDOR, "GIGABYTE"),
> +                        DMI_MATCH(DMI_PRODUCT_NAME, "P35V2"),
> +                },
> +        },
> +	{
> +		/* Aorus branded Gigabyte X3 Plus */
> +		.matches =3D {
> +			DMI_MATCH(DMI_SYS_VENDOR, "GIGABYTE"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "X3"),
> +		},
> +	},
> +        {
> +                /* Gigabyte P34 */
> +                .matches =3D {
> +                        DMI_MATCH(DMI_SYS_VENDOR, "GIGABYTE"),
> +                        DMI_MATCH(DMI_PRODUCT_NAME, "P34"),
> +                },
> +        },
> +	{ }
> +};
> +
>  #endif /* CONFIG_X86 */
> =20
>  #ifdef CONFIG_PNP
> @@ -1040,6 +1070,9 @@ static int __init i8042_platform_init(void)
>  	if (dmi_check_system(i8042_dmi_dritek_table))
>  		i8042_dritek =3D true;
> =20
> +	if (dmi_check_system(i8042_dmi_elantech_kbdreset_table))
> +		i8042_kbdreset =3D true;
> +
>  	/*
>  	 * A20 was already enabled during early kernel init. But some buggy
>  	 * BIOSes (in MSI Laptops) require A20 to be enabled using 8042 to
> diff --git a/drivers/input/serio/i8042.c b/drivers/input/serio/i8042.=
c
> index 924e4bf..92d0aa8 100644
> --- a/drivers/input/serio/i8042.c
> +++ b/drivers/input/serio/i8042.c
> @@ -67,6 +67,10 @@ static bool i8042_notimeout;
>  module_param_named(notimeout, i8042_notimeout, bool, 0);
>  MODULE_PARM_DESC(notimeout, "Ignore timeouts signalled by i8042");
> =20
> +static bool i8042_kbdreset;
> +module_param_named(kbdreset, i8042_kbdreset, bool, 0);
> +MODULE_PARM_DESC(kbdreset, "Reset keyboard to detect Elantech touchp=
ad on some laptops");
> +
>  #ifdef CONFIG_X86
>  static bool i8042_dritek;
>  module_param_named(dritek, i8042_dritek, bool, 0);
> @@ -790,6 +794,14 @@ static int __init i8042_check_aux(void)
>  		return -1;
> =20
>  /*
> + * Reset keyboard to detect touchpad on some laptops having Elantech=
 touchpad
> + */
> +	if (i8042_kbdreset) {
> +		pr_warn("Resetting keyboard to detect Elantech touchpad on some la=
ptops\n");
> +		i8042_kbd_write(NULL, (unsigned char) 0xff);
> +	}
> +
> +/*
>   * Test AUX IRQ delivery to make sure BIOS did not grab the IRQ and
>   * used it for a PCI card or somethig else.
>   */


--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
