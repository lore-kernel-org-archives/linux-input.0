From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v2] platform/x86: silead_dmi: Add touchscreen platform
 data for the Chuwi Hi8 Air tablet
Date: Tue, 5 Feb 2019 20:18:58 +0200
Message-ID: <CAHp75Ve5BgpwqRrhfQixZRjMzGR5k6W02q_wFuira3Z0NW6-kw@mail.gmail.com>
References: <20190203183423.7661-1-k.renzig@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190203183423.7661-1-k.renzig@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kai Renzig <k.renzig@gmail.com>
Cc: Hans de Goede <hdegoede@redhat.com>, Darren Hart <dvhart@infradead.org>, Andy Shevchenko <andy@infradead.org>, linux-input <linux-input@vger.kernel.org>, Platform Driver <platform-driver-x86@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

On Sun, Feb 3, 2019 at 8:34 PM Kai Renzig <k.renzig@gmail.com> wrote:
>
> Add touchscreen platform data for the Chuwi Hi8 Air tablet.
>

Pushed to my review and testing queue, thanks!

> Signed-off-by: Kai Renzig <k.renzig@gmail.com>
> ---
> Changes in v2:
>  - Fix the firmware filename to match the actual touchscreen controller.
>
>  drivers/platform/x86/touchscreen_dmi.c | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
>
> diff --git a/drivers/platform/x86/touchscreen_dmi.c b/drivers/platform/x86/touchscreen_dmi.c
> index 8c5d47c0aea6..1f66405928a9 100644
> --- a/drivers/platform/x86/touchscreen_dmi.c
> +++ b/drivers/platform/x86/touchscreen_dmi.c
> @@ -41,6 +41,20 @@ static const struct ts_dmi_data chuwi_hi8_data = {
>         .properties     = chuwi_hi8_props,
>  };
>
> +static const struct property_entry chuwi_hi8_air_props[] = {
> +       PROPERTY_ENTRY_U32("touchscreen-size-x", 1728),
> +       PROPERTY_ENTRY_U32("touchscreen-size-y", 1148),
> +       PROPERTY_ENTRY_BOOL("touchscreen-swapped-x-y"),
> +       PROPERTY_ENTRY_STRING("firmware-name", "gsl3676-chuwi-hi8-air.fw"),
> +       PROPERTY_ENTRY_U32("silead,max-fingers", 10),
> +       { }
> +};
> +
> +static const struct ts_dmi_data chuwi_hi8_air_data = {
> +       .acpi_name      = "MSSL1680:00",
> +       .properties     = chuwi_hi8_air_props,
> +};
> +
>  static const struct property_entry chuwi_hi8_pro_props[] = {
>         PROPERTY_ENTRY_U32("touchscreen-min-x", 6),
>         PROPERTY_ENTRY_U32("touchscreen-min-y", 3),
> @@ -497,6 +511,15 @@ static const struct dmi_system_id touchscreen_dmi_table[] = {
>                         DMI_MATCH(DMI_BIOS_VERSION, "H1D_S806_206"),
>                 },
>         },
> +       {
> +               /* Chuwi Hi8 Air (CWI543) */
> +               .driver_data = (void *)&chuwi_hi8_air_data,
> +               .matches = {
> +                       DMI_MATCH(DMI_BOARD_VENDOR, "Default string"),
> +                       DMI_MATCH(DMI_BOARD_NAME, "Cherry Trail CR"),
> +                       DMI_MATCH(DMI_PRODUCT_NAME, "Hi8 Air"),
> +               },
> +       },
>         {
>                 /* Chuwi Hi8 Pro (CWI513) */
>                 .driver_data = (void *)&chuwi_hi8_pro_data,
> --
> 2.19.1
>


-- 
With Best Regards,
Andy Shevchenko
