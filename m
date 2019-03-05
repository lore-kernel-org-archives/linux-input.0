From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v2] platform/x86: touchscreen_dmi: Add info for the CHUWI
 Hi10 Air tablet
Date: Tue, 5 Mar 2019 15:42:23 +0200
Message-ID: <CAHp75VfHVWj-JBxqDMu1R249M_WpkzHgyX2dQr40JkPUNwNL5A@mail.gmail.com>
References: <c6b0c2ef-eed9-ffae-e974-92260d5356aa@redhat.com>
 <20190303134727.6680-1-me@myself5.de> <f4937ec1-9dac-0810-7386-a15ec5d306ae@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <f4937ec1-9dac-0810-7386-a15ec5d306ae@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Christian Oder <me@myself5.de>, Andy Shevchenko <andy@infradead.org>, Darren Hart <dvhart@infradead.org>, linux-input <linux-input@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Platform Driver <platform-driver-x86@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

On Sun, Mar 3, 2019 at 3:59 PM Hans de Goede <hdegoede@redhat.com> wrote:
>
> Hi Christian,
>
> On 03-03-19 14:47, Christian Oder wrote:
> > Add  touchscreen info for the CHUWUI Hi10 Air tablet.
> >
> > Signed-off-by: Christian Oder <me@myself5.de>
> > Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Pushed to my review and testing queue, thanks!

> > ---
> > Changes in v2:
> > - added review tag
>
> A quick note for any patches you may submit in the future, there
> is no need to send a v2 just to add someones Reviewed-by or Acked-by,
> these will be picked up automatically by the subsys-maintainer when
> they add the patch to their tree.
>
> Regards,
>
> Hans
>
> >
> >   drivers/platform/x86/touchscreen_dmi.c | 27 ++++++++++++++++++++++++++
> >   1 file changed, 27 insertions(+)
> >
> > diff --git a/drivers/platform/x86/touchscreen_dmi.c b/drivers/platform/x86/touchscreen_dmi.c
> > index 167a156e3cc7..2d56ff7c8230 100644
> > --- a/drivers/platform/x86/touchscreen_dmi.c
> > +++ b/drivers/platform/x86/touchscreen_dmi.c
> > @@ -72,6 +72,25 @@ static const struct ts_dmi_data chuwi_hi8_pro_data = {
> >       .properties     = chuwi_hi8_pro_props,
> >   };
> >
> > +static const struct property_entry chuwi_hi10_air_props[] = {
> > +     PROPERTY_ENTRY_U32("touchscreen-size-x", 1981),
> > +     PROPERTY_ENTRY_U32("touchscreen-size-y", 1271),
> > +     PROPERTY_ENTRY_U32("touchscreen-min-x", 99),
> > +     PROPERTY_ENTRY_U32("touchscreen-min-y", 9),
> > +     PROPERTY_ENTRY_BOOL("touchscreen-swapped-x-y"),
> > +     PROPERTY_ENTRY_U32("touchscreen-fuzz-x", 5),
> > +     PROPERTY_ENTRY_U32("touchscreen-fuzz-y", 4),
> > +     PROPERTY_ENTRY_STRING("firmware-name", "gsl1680-chuwi-hi10-air.fw"),
> > +     PROPERTY_ENTRY_U32("silead,max-fingers", 10),
> > +     PROPERTY_ENTRY_BOOL("silead,home-button"),
> > +     { }
> > +};
> > +
> > +static const struct ts_dmi_data chuwi_hi10_air_data = {
> > +     .acpi_name      = "MSSL1680:00",
> > +     .properties     = chuwi_hi10_air_props,
> > +};
> > +
> >   static const struct property_entry chuwi_vi8_props[] = {
> >       PROPERTY_ENTRY_U32("touchscreen-min-x", 4),
> >       PROPERTY_ENTRY_U32("touchscreen-min-y", 6),
> > @@ -546,6 +565,14 @@ static const struct dmi_system_id touchscreen_dmi_table[] = {
> >                       DMI_MATCH(DMI_PRODUCT_NAME, "X1D3_C806N"),
> >               },
> >       },
> > +     {
> > +             /* Chuwi Hi10 Air */
> > +             .driver_data = (void *)&chuwi_hi10_air_data,
> > +             .matches = {
> > +                     DMI_MATCH(DMI_BOARD_VENDOR, "Hampoo"),
> > +                     DMI_MATCH(DMI_PRODUCT_SKU, "P1W6_C109D_B"),
> > +             },
> > +     },
> >       {
> >               /* Chuwi Vi8 (CWI506) */
> >               .driver_data = (void *)&chuwi_vi8_data,
> >



-- 
With Best Regards,
Andy Shevchenko
