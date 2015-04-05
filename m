From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: atkbd: Fix release quirk for Dell models
Date: Sun, 5 Apr 2015 14:48:33 -0700
Message-ID: <20150405214833.GD31564@dtor-ws>
References: <1427639779-27377-1-git-send-email-pali.rohar@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ig0-f179.google.com ([209.85.213.179]:34399 "EHLO
	mail-ig0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752530AbbDEVsi (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sun, 5 Apr 2015 17:48:38 -0400
Content-Disposition: inline
In-Reply-To: <1427639779-27377-1-git-send-email-pali.rohar@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Matthew Garrett <mjg59@srcf.ucam.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Pali,

On Sun, Mar 29, 2015 at 04:36:19PM +0200, Pali Roh=E1r wrote:
> This patch fixes commit 61579ba83934 ("Input: atkbd - expand Latitude=
's force
> release quirk to other Dells"). Before that commit release quirks wer=
e called
> for all Dell Latitude models. After that commit only for Portable Del=
l devices.
> But lot of Latitude models are Laptop or Notebook DMI devices so quir=
ks are not
> called.
>=20
> Release quirks are still needed also for new Dell Latitude models, so=
 this patch
> enables quirks for all Portable, Laptop, Notebook and Sub-Notebook De=
ll devices.

Does Dell use all these types for their laptops? What models do you kno=
w
that need this quirk?

Thanks.

>=20
> Signed-off-by: Pali Roh=E1r <pali.rohar@gmail.com>
> ---
>  drivers/input/keyboard/atkbd.c |   48 ++++++++++++++++++++++++++++++=
++++++++++
>  1 file changed, 48 insertions(+)
>=20
> diff --git a/drivers/input/keyboard/atkbd.c b/drivers/input/keyboard/=
atkbd.c
> index 387c51f..3188493 100644
> --- a/drivers/input/keyboard/atkbd.c
> +++ b/drivers/input/keyboard/atkbd.c
> @@ -1664,6 +1664,30 @@ static const struct dmi_system_id atkbd_dmi_qu=
irk_table[] __initconst =3D {
>  	},
>  	{
>  		.matches =3D {
> +			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
> +			DMI_MATCH(DMI_CHASSIS_TYPE, "9"), /* Laptop */
> +		},
> +		.callback =3D atkbd_setup_forced_release,
> +		.driver_data =3D atkbd_dell_laptop_forced_release_keys,
> +	},
> +	{
> +		.matches =3D {
> +			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
> +			DMI_MATCH(DMI_CHASSIS_TYPE, "10"), /* Notebook */
> +		},
> +		.callback =3D atkbd_setup_forced_release,
> +		.driver_data =3D atkbd_dell_laptop_forced_release_keys,
> +	},
> +	{
> +		.matches =3D {
> +			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
> +			DMI_MATCH(DMI_CHASSIS_TYPE, "14"), /* Sub-Notebook */
> +		},
> +		.callback =3D atkbd_setup_forced_release,
> +		.driver_data =3D atkbd_dell_laptop_forced_release_keys,
> +	},
> +	{
> +		.matches =3D {
>  			DMI_MATCH(DMI_SYS_VENDOR, "Dell Computer Corporation"),
>  			DMI_MATCH(DMI_CHASSIS_TYPE, "8"), /* Portable */
>  		},
> @@ -1672,6 +1696,30 @@ static const struct dmi_system_id atkbd_dmi_qu=
irk_table[] __initconst =3D {
>  	},
>  	{
>  		.matches =3D {
> +			DMI_MATCH(DMI_SYS_VENDOR, "Dell Computer Corporation"),
> +			DMI_MATCH(DMI_CHASSIS_TYPE, "9"), /* Laptop */
> +		},
> +		.callback =3D atkbd_setup_forced_release,
> +		.driver_data =3D atkbd_dell_laptop_forced_release_keys,
> +	},
> +	{
> +		.matches =3D {
> +			DMI_MATCH(DMI_SYS_VENDOR, "Dell Computer Corporation"),
> +			DMI_MATCH(DMI_CHASSIS_TYPE, "10"), /* Notebook */
> +		},
> +		.callback =3D atkbd_setup_forced_release,
> +		.driver_data =3D atkbd_dell_laptop_forced_release_keys,
> +	},
> +	{
> +		.matches =3D {
> +			DMI_MATCH(DMI_SYS_VENDOR, "Dell Computer Corporation"),
> +			DMI_MATCH(DMI_CHASSIS_TYPE, "14"), /* Sub-Notebook */
> +		},
> +		.callback =3D atkbd_setup_forced_release,
> +		.driver_data =3D atkbd_dell_laptop_forced_release_keys,
> +	},
> +	{
> +		.matches =3D {
>  			DMI_MATCH(DMI_SYS_VENDOR, "Hewlett-Packard"),
>  			DMI_MATCH(DMI_PRODUCT_NAME, "HP 2133"),
>  		},
> --=20
> 1.7.9.5
>=20

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
