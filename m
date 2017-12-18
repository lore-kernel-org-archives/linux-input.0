From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH] Add touchscreen platform data for the Onda oBook 20 Plus tablet.
Date: Mon, 18 Dec 2017 14:41:04 +0200
Message-ID: <CAHp75Vfkoze4HjY8dw-aiKjREOEywsUsfXFRCn47j76DCc==fw@mail.gmail.com>
References: <20171210220213.19290-1-nerijus@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qt0-f193.google.com ([209.85.216.193]:37336 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752826AbdLRMlG (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Mon, 18 Dec 2017 07:41:06 -0500
In-Reply-To: <20171210220213.19290-1-nerijus@users.sourceforge.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Nerijus Baliunas <nerijus@users.sourceforge.net>
Cc: Hans de Goede <hdegoede@redhat.com>, linux-input <linux-input@vger.kernel.org>, Platform Driver <platform-driver-x86@vger.kernel.org>

On Mon, Dec 11, 2017 at 12:02 AM, Nerijus Baliunas
<nerijus@users.sourceforge.net> wrote:
> Signed-off-by: Nerijus Bali=C5=ABnas <nerijus@users.sourceforge.net>

Applied to my review and testing queue with massaged title and written
commit message, thanks. Please, don't forget to do it yourself next
time, otherwise it will slow review and promoting.

> ---
>  drivers/platform/x86/silead_dmi.c | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
>
> diff --git a/drivers/platform/x86/silead_dmi.c b/drivers/platform/x86/sil=
ead_dmi.c
> index 266535c2a72f..414293e8c448 100644
> --- a/drivers/platform/x86/silead_dmi.c
> +++ b/drivers/platform/x86/silead_dmi.c
> @@ -171,6 +171,23 @@ static const struct silead_ts_dmi_data digma_citi_e2=
00_data =3D {
>         .properties     =3D digma_citi_e200_props,
>  };
>
> +static const struct property_entry onda_obook_20_plus_props[] =3D {
> +       PROPERTY_ENTRY_U32("touchscreen-size-x", 1728),
> +       PROPERTY_ENTRY_U32("touchscreen-size-y", 1148),
> +       PROPERTY_ENTRY_BOOL("touchscreen-inverted-x"),
> +       PROPERTY_ENTRY_BOOL("touchscreen-inverted-y"),
> +       PROPERTY_ENTRY_BOOL("touchscreen-swapped-x-y"),
> +       PROPERTY_ENTRY_STRING("firmware-name", "gsl3676-onda-obook-20-plu=
s.fw"),
> +       PROPERTY_ENTRY_U32("silead,max-fingers", 10),
> +       PROPERTY_ENTRY_BOOL("silead,home-button"),
> +       { }
> +};
> +
> +static const struct silead_ts_dmi_data onda_obook_20_plus_data =3D {
> +       .acpi_name      =3D "MSSL1680:00",
> +       .properties     =3D onda_obook_20_plus_props,
> +};
> +
>  static const struct dmi_system_id silead_ts_dmi_table[] =3D {
>         {
>                 /* CUBE iwork8 Air */
> @@ -271,6 +288,14 @@ static const struct dmi_system_id silead_ts_dmi_tabl=
e[] =3D {
>                         DMI_MATCH(DMI_BOARD_NAME, "Cherry Trail CR"),
>                 },
>         },
> +       {
> +               /* Onda oBook 20 Plus */
> +               .driver_data =3D (void *)&onda_obook_20_plus_data,
> +               .matches =3D {
> +                       DMI_MATCH(DMI_SYS_VENDOR, "ONDA"),
> +                       DMI_MATCH(DMI_PRODUCT_NAME, "OBOOK 20 PLUS"),
> +               },
> +       },
>         { },
>  };
>
> --
> 2.14.3
>



--=20
With Best Regards,
Andy Shevchenko
