From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH] platform/x86: touchscreen_dmi: Add info for the Cube
 KNote i1101 tablet
Date: Tue, 31 Jul 2018 14:32:32 +0300
Message-ID: <CAHp75Vfp+EZjt_bg3iieKG0NPBvqzURXKh97D4=ULrKnbE4mvQ@mail.gmail.com>
References: <20180731093256.30533-1-youling257@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180731093256.30533-1-youling257@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: youling257 <youling257@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Platform Driver <platform-driver-x86@vger.kernel.org>, linux-input <linux-input@vger.kernel.org>, Andy Shevchenko <andy@infradead.org>, Darren Hart <dvhart@infradead.org>, Hans de Goede <hdegoede@redhat.com>
List-Id: linux-input@vger.kernel.org

On Tue, Jul 31, 2018 at 12:32 PM, youling257 <youling257@gmail.com> wrote:
> Add touchscreen info for the Cube KNote i1101 tablet.
>

Thanks for the patch.
Unfortunately I can't take it w/o SoB line. If Hans volunteering to
give a such again, I guess we're fine.

> Reported-and-tested-by: lkongl <lkongl@163.com>
> ---
>  drivers/platform/x86/touchscreen_dmi.c | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
>
> diff --git a/drivers/platform/x86/touchscreen_dmi.c b/drivers/platform/x86/touchscreen_dmi.c
> index 85e425420da2..cb204f973491 100644
> --- a/drivers/platform/x86/touchscreen_dmi.c
> +++ b/drivers/platform/x86/touchscreen_dmi.c
> @@ -117,6 +117,22 @@ static const struct ts_dmi_data cube_iwork8_air_data = {
>         .properties     = cube_iwork8_air_props,
>  };
>
> +static const struct property_entry cube_knote_i1101_props[] = {
> +       PROPERTY_ENTRY_U32("touchscreen-min-x", 20),
> +       PROPERTY_ENTRY_U32("touchscreen-min-y",  22),
> +       PROPERTY_ENTRY_U32("touchscreen-size-x", 1961),
> +       PROPERTY_ENTRY_U32("touchscreen-size-y", 1513),
> +       PROPERTY_ENTRY_STRING("firmware-name", "gsl3692-cube-knote-i1101.fw"),
> +       PROPERTY_ENTRY_U32("silead,max-fingers", 10),
> +       PROPERTY_ENTRY_BOOL("silead,home-button"),
> +       { }
> +};
> +
> +static const struct ts_dmi_data cube_knote_i1101_data = {
> +       .acpi_name      = "MSSL1680:00",
> +       .properties     = cube_knote_i1101_props,
> +};
> +
>  static const struct property_entry dexp_ursus_7w_props[] = {
>         PROPERTY_ENTRY_U32("touchscreen-size-x", 890),
>         PROPERTY_ENTRY_U32("touchscreen-size-y", 630),
> @@ -458,6 +474,16 @@ static const struct dmi_system_id touchscreen_dmi_table[] = {
>                         DMI_MATCH(DMI_BOARD_NAME, "Cherry Trail CR"),
>                 },
>         },
> +       {
> +               /* Cube KNote i1101 */
> +               .driver_data = (void *)&cube_knote_i1101_data,
> +               .matches = {
> +                       DMI_MATCH(DMI_BOARD_VENDOR, "Hampoo"),
> +                       DMI_MATCH(DMI_BOARD_NAME, "L1W6_I1101"),
> +                       DMI_MATCH(DMI_SYS_VENDOR, "ALLDOCUBE"),
> +                       DMI_MATCH(DMI_PRODUCT_NAME, "i1101"),
> +               },
> +       },
>         {
>                 /* DEXP Ursus 7W */
>                 .driver_data = (void *)&dexp_ursus_7w_data,
> --
> 2.18.0
>



-- 
With Best Regards,
Andy Shevchenko
