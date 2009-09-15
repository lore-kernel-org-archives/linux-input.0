From: Mike Lothian <mike@fireburn.co.uk>
Subject: Re: Samsung R510
Date: Tue, 15 Sep 2009 22:03:25 +0100
Message-ID: <f3f71ab90909151403o688c31aew9bca512302d616d@mail.gmail.com>
References: <f3f71ab90909110117t4d9de95cv2f71b42f2a9a7992@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-fx0-f217.google.com ([209.85.220.217]:63433 "EHLO
	mail-fx0-f217.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754210AbZIOVDm convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 15 Sep 2009 17:03:42 -0400
Received: by fxm17 with SMTP id 17so1877169fxm.37
        for <linux-input@vger.kernel.org>; Tue, 15 Sep 2009 14:03:45 -0700 (PDT)
In-Reply-To: <f3f71ab90909110117t4d9de95cv2f71b42f2a9a7992@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

2009/9/11 Mike Lothian <mike@fireburn.co.uk>:
> Hi
>
> Please could the following patch be added to the kernel
>
> diff --git a/drivers/input/keyboard/atkbd.c b/drivers/input/keyboard/=
atkbd.c
> index 95fe045..592623e 100644
> --- a/drivers/input/keyboard/atkbd.c
> +++ b/drivers/input/keyboard/atkbd.c
> @@ -1572,6 +1572,16 @@ static struct dmi_system_id
> atkbd_dmi_quirk_table[] __initdata =3D {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.callback =3D atkbd_setup_forced_relea=
se,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.driver_data =3D atkbd_samsung_forced_=
release_keys,
> =A0 =A0 =A0 =A0},
> + =A0 =A0 =A0 =A0{
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.ident =3D "Samsung R510/P510",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.matches =3D {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0DMI_MATCH(DMI_SYS_VE=
NDOR, "SAMSUNG
> ELECTRONICS CO., LTD."),
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0DMI_MATCH(DMI_PRODUC=
T_NAME, "R510/P510"),
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0},
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.callback =3D atkbd_setup_forced_rel=
ease,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.driver_data =3D atkbd_samsung_force=
d_release_keys,
> + =A0 =A0 =A0 =A0},
> +
> =A0 =A0 =A0 =A0{
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.ident =3D "Fujitsu Amilo PA 1510",
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.matches =3D {
>
> This fixes the forced release keys for me
>
> Thanks
>
> Mike
>
> PS I'm not subscribed to this list so please CC me
>

Ping is this the correct list?
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
