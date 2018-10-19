From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH] platform/x86: touchscreen_dmi: Add info for the Trekstor
 Primetab T13B tablet
Date: Fri, 19 Oct 2018 15:48:19 +0300
Message-ID: <CAHp75Ve=n6oFRr7zoDfHMUGOACmgk1XbqU_q0n+j0D3D+6B0sg@mail.gmail.com>
References: <20181008072505.GA8334@mcepok-pc>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181008072505.GA8334@mcepok-pc>
Sender: linux-kernel-owner@vger.kernel.org
To: marian.cepok@gmail.com
Cc: Hans de Goede <hdegoede@redhat.com>, Darren Hart <dvhart@infradead.org>, Andy Shevchenko <andy@infradead.org>, linux-input <linux-input@vger.kernel.org>, Platform Driver <platform-driver-x86@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

On Mon, Oct 8, 2018 at 10:25 AM Marian Cepok <marian.cepok@gmail.com> wrote:
>
> Add touchscreen info for the Trekstor Primetab T13B tablet.
>

Pushed to my review and testing queue, thanks!

> Reviewed-by: Hans de Goede <hdegoede@redhat.com>
> Signed-off-by: Marian Cepok <marian.cepok@gmail.com>
> ---
>  drivers/platform/x86/touchscreen_dmi.c | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
>
> diff --git a/drivers/platform/x86/touchscreen_dmi.c b/drivers/platform/x86/touchscreen_dmi.c
> index cb204f973491..c07954f0efc6 100644
> --- a/drivers/platform/x86/touchscreen_dmi.c
> +++ b/drivers/platform/x86/touchscreen_dmi.c
> @@ -381,6 +381,22 @@ static const struct ts_dmi_data trekstor_primebook_c13_data = {
>         .properties     = trekstor_primebook_c13_props,
>  };
>
> +static const struct property_entry trekstor_primetab_t13b_props[] = {
> +       PROPERTY_ENTRY_U32("touchscreen-size-x", 2500),
> +       PROPERTY_ENTRY_U32("touchscreen-size-y", 1900),
> +       PROPERTY_ENTRY_STRING("firmware-name",
> +                             "gsl1680-trekstor-primetab-t13b.fw"),
> +       PROPERTY_ENTRY_U32("silead,max-fingers", 10),
> +       PROPERTY_ENTRY_BOOL("silead,home-button"),
> +       PROPERTY_ENTRY_BOOL("touchscreen-inverted-y"),
> +       { }
> +};
> +
> +static const struct ts_dmi_data trekstor_primetab_t13b_data = {
> +       .acpi_name  = "MSSL1680:00",
> +       .properties = trekstor_primetab_t13b_props,
> +};
> +
>  static const struct property_entry trekstor_surftab_twin_10_1_props[] = {
>         PROPERTY_ENTRY_U32("touchscreen-size-x", 1900),
>         PROPERTY_ENTRY_U32("touchscreen-size-y", 1280),
> @@ -648,6 +664,14 @@ static const struct dmi_system_id touchscreen_dmi_table[] = {
>                         DMI_MATCH(DMI_PRODUCT_NAME, "Primebook C13"),
>                 },
>         },
> +       {
> +               /* Trekstor Primetab T13B */
> +               .driver_data = (void *)&trekstor_primetab_t13b_data,
> +               .matches = {
> +                       DMI_MATCH(DMI_SYS_VENDOR, "TREKSTOR"),
> +                       DMI_MATCH(DMI_PRODUCT_NAME, "Primetab T13B"),
> +               },
> +       },
>         {
>                 /* TrekStor SurfTab twin 10.1 ST10432-8 */
>                 .driver_data = (void *)&trekstor_surftab_twin_10_1_data,
> --
> 2.17.1
>


-- 
With Best Regards,
Andy Shevchenko
