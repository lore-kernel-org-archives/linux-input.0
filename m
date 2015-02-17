From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH 3/4] HID: Introduce a module parameter to disable automatic
 switch of Logitech gaming wheels from compatibility to native mode. This
 only applies to multimode wheels.
Date: Tue, 17 Feb 2015 13:10:43 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1502171309390.2279@pobox.suse.cz>
References: <1423240486-6714-1-git-send-email-madcatxster@devoid-pointer.net> <1423240486-6714-4-git-send-email-madcatxster@devoid-pointer.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:33941 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755313AbbBQMKq (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 17 Feb 2015 07:10:46 -0500
In-Reply-To: <1423240486-6714-4-git-send-email-madcatxster@devoid-pointer.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?ISO-8859-15?Q?Michal_Mal=FD?= <madcatxster@devoid-pointer.net>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, simon@mungewell.org, elias.vds@gmail.com

On Fri, 6 Feb 2015, Michal Mal=C3=BD wrote:

> Introduce a module parameter to disable automatic switch of Logitech =
gaming
> wheels from compatibility to native mode. This only applies to multim=
ode wheels.
>=20
> Signed-off-by: Michal Mal=C3=BD <madcatxster@devoid-pointer.net>=20
> ---
>  drivers/hid/hid-lg.c    | 6 ++++++
>  drivers/hid/hid-lg4ff.c | 4 +++-
>  2 files changed, 9 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/hid/hid-lg.c b/drivers/hid/hid-lg.c
> index f91ff14..8dae03f 100644
> --- a/drivers/hid/hid-lg.c
> +++ b/drivers/hid/hid-lg.c
> @@ -818,4 +818,10 @@ static struct hid_driver lg_driver =3D {
>  };
>  module_hid_driver(lg_driver);
> =20
> +#ifdef CONFIG_LOGIWHEELS_FF
> +extern int lg4ff_no_autoswitch; /* From hid-lg4ff.c */
> +module_param_named(lg4ff_no_autoswitch, lg4ff_no_autoswitch, int, S_=
IRUGO);
> +MODULE_PARM_DESC(lg4ff_no_autoswitch, "Do not switch multimode wheel=
s to their native mode automatically");
> +#endif
> +
>  MODULE_LICENSE("GPL");
> diff --git a/drivers/hid/hid-lg4ff.c b/drivers/hid/hid-lg4ff.c
> index b9c9fe6..cbb000a 100644
> --- a/drivers/hid/hid-lg4ff.c
> +++ b/drivers/hid/hid-lg4ff.c
> @@ -67,6 +67,7 @@
>  #define LG4FF_FFEX_REV_MAJ 0x21
>  #define LG4FF_FFEX_REV_MIN 0x00
> =20
> +int lg4ff_no_autoswitch =3D 0;

This sharing of variable without header file is ugly. Could you please=20
declare it properly as extern in logitech header?

--=20
Jiri Kosina
SUSE Labs
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
