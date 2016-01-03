From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: i8042 add Fujitsu Lifebook U745 to the nomux list
Date: Sat, 2 Jan 2016 20:44:20 -0800
Message-ID: <20160103044420.GC23680@dtor-ws>
References: <20151230001423.GW8549@crashmenot.s3.eurecom.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f174.google.com ([209.85.192.174]:36724 "EHLO
	mail-pf0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750840AbcACEoY (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sat, 2 Jan 2016 23:44:24 -0500
Content-Disposition: inline
In-Reply-To: <20151230001423.GW8549@crashmenot.s3.eurecom.fr>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?iso-8859-1?Q?Aur=E9lien?= Francillon <aurelien@francillon.net>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, Dec 30, 2015 at 01:14:23AM +0100, Aur=E9lien Francillon wrote:
> Without i8042.nomux=3D1 the Elantech touch pad is not working at all =
on
> a Fujitsu Lifebook U745. This patch does not seem necessary for all
> U745 (maybe because of different BIOS versions?). However, it was
> verified that the patch does not break those (see opensuse bug 883192=
:
> https://bugzilla.opensuse.org/show_bug.cgi?id=3D883192).
>=20
> Signed-off-by: Aur=E9lien Francillon <aurelien@francillon.net>

Applied, thank you.

> ---
>  drivers/input/serio/i8042-x86ia64io.h | 7 +++++++
>  1 file changed, 7 insertions(+)
>=20
> diff --git a/drivers/input/serio/i8042-x86ia64io.h b/drivers/input/se=
rio/i8042-x86ia64io.h
> index c115565..68f5f4a 100644
> --- a/drivers/input/serio/i8042-x86ia64io.h
> +++ b/drivers/input/serio/i8042-x86ia64io.h
> @@ -258,6 +258,13 @@ static const struct dmi_system_id __initconst i8=
042_dmi_nomux_table[] =3D {
>  		},
>  	},
>  	{
> +		/* Fujitsu Lifebook U745 */
> +		.matches =3D {
> +			DMI_MATCH(DMI_SYS_VENDOR, "FUJITSU"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "LIFEBOOK U745"),
> +		},
> +	},
> +	{
>  		/* Fujitsu T70H */
>  		.matches =3D {
>  			DMI_MATCH(DMI_SYS_VENDOR, "FUJITSU"),
> --=20
> 2.6.4
>=20
>=20

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
