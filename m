From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] elan_i2c: Add ACPI ID "ELAN1000"
Date: Tue, 1 Sep 2015 14:00:35 -0700
Message-ID: <CAKdAkRTWs1T7ZnMYABKtw2j3vfpVz5ngLdnehPcFoY4pz_jAoQ@mail.gmail.com>
References: <1441137231-615-1-git-send-email-jprvita@endlessm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ob0-f172.google.com ([209.85.214.172]:34204 "EHLO
	mail-ob0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752299AbbIAVAg convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 1 Sep 2015 17:00:36 -0400
Received: by obcts10 with SMTP id ts10so5236406obc.1
        for <linux-input@vger.kernel.org>; Tue, 01 Sep 2015 14:00:35 -0700 (PDT)
In-Reply-To: <1441137231-615-1-git-send-email-jprvita@endlessm.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?UTF-8?Q?Jo=C3=A3o_Paulo_Rechi_Vita?= <jprvita@gmail.com>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Duson Lin <dusonlin@emc.com.tw>, =?UTF-8?Q?Jo=C3=A3o_Paulo_Rechi_Vita?= <jprvita@endlessm.com>

On Tue, Sep 1, 2015 at 12:53 PM, Jo=C3=A3o Paulo Rechi Vita
<jprvita@gmail.com> wrote:
> This ACPI ID present in the DSDT of the ASUS E202SA laptop.

Can it be driven buy the standard hid-multitouch by any chance?

>
> Signed-off-by: Jo=C3=A3o Paulo Rechi Vita <jprvita@endlessm.com>
> ---
>  drivers/input/mouse/elan_i2c_core.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/input/mouse/elan_i2c_core.c b/drivers/input/mous=
e/elan_i2c_core.c
> index d4a38ca..5e45402 100644
> --- a/drivers/input/mouse/elan_i2c_core.c
> +++ b/drivers/input/mouse/elan_i2c_core.c
> @@ -1170,6 +1170,7 @@ static const struct acpi_device_id elan_acpi_id=
[] =3D {
>         { "ELAN0000", 0 },
>         { "ELAN0100", 0 },
>         { "ELAN0600", 0 },
> +       { "ELAN1000", 0 },
>         { }
>  };
>  MODULE_DEVICE_TABLE(acpi, elan_acpi_id);
> --
> 2.1.4
>



--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
