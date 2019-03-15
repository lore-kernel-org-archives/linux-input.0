From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH] platform/x86: touchscreen_dmi: Add info for Myria MY8307 2-in-1
Date: Fri, 15 Mar 2019 20:43:21 +0200
Message-ID: <CAHp75VeAdFdHWWRXe-Jr=kvufCrQzq5dOCj9rW3tBvtzHEcEYA@mail.gmail.com>
References: <20190315133113.21215-1-gabriel.lazar@com.utcluj.ro> <12a67eb2-18ff-dd9f-4c48-4d01a01a2aa7@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <12a67eb2-18ff-dd9f-4c48-4d01a01a2aa7@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Gabriel Lazar <gabriel.lazar@com.utcluj.ro>, Darren Hart <dvhart@infradead.org>, Andy Shevchenko <andy@infradead.org>, linux-input <linux-input@vger.kernel.org>, Platform Driver <platform-driver-x86@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

On Fri, Mar 15, 2019 at 7:47 PM Hans de Goede <hdegoede@redhat.com> wrote:
>
> Hi,
>
> On 3/15/19 2:31 PM, Gabriel Lazar wrote:
> > Add touchscreen platform data for the Myrya MY8307 2-in-1 laptop.
> >
> > Signed-off-by: Gabriel Lazar <gabriel.lazar@com.utcluj.ro>
>
> Patch looks good to me:
>
> Reviewed-by: Hans de Goede <hdegoede@redhat.com>
>

OK, thanks for explanation.
I'll take it after merge window will be closed.

> Regards,
>
> Hans
>
>
>
> > ---
> >   drivers/platform/x86/touchscreen_dmi.c | 25 +++++++++++++++++++++++++
> >   1 file changed, 25 insertions(+)
> >
> > diff --git a/drivers/platform/x86/touchscreen_dmi.c b/drivers/platform/x86/touchscreen_dmi.c
> > index 2d56ff7c8230..3319f0cbb558 100644
> > --- a/drivers/platform/x86/touchscreen_dmi.c
> > +++ b/drivers/platform/x86/touchscreen_dmi.c
> > @@ -265,6 +265,23 @@ static const struct ts_dmi_data jumper_ezpad_mini3_data = {
> >       .properties     = jumper_ezpad_mini3_props,
> >   };
> >
> > +static const struct property_entry myria_my8307_props[] = {
> > +     PROPERTY_ENTRY_U32("touchscreen-size-x", 1720),
> > +     PROPERTY_ENTRY_U32("touchscreen-size-y", 1140),
> > +     PROPERTY_ENTRY_BOOL("touchscreen-inverted-x"),
> > +     PROPERTY_ENTRY_BOOL("touchscreen-inverted-y"),
> > +     PROPERTY_ENTRY_BOOL("touchscreen-swapped-x-y"),
> > +     PROPERTY_ENTRY_STRING("firmware-name", "gsl1680-myria-my8307.fw"),
> > +     PROPERTY_ENTRY_U32("silead,max-fingers", 10),
> > +     PROPERTY_ENTRY_BOOL("silead,home-button"),
> > +     { }
> > +};
> > +
> > +static const struct ts_dmi_data myria_my8307_data = {
> > +     .acpi_name      = "MSSL1680:00",
> > +     .properties     = myria_my8307_props,
> > +};
> > +
> >   static const struct property_entry onda_obook_20_plus_props[] = {
> >       PROPERTY_ENTRY_U32("touchscreen-size-x", 1728),
> >       PROPERTY_ENTRY_U32("touchscreen-size-y", 1148),
> > @@ -690,6 +707,14 @@ static const struct dmi_system_id touchscreen_dmi_table[] = {
> >                       DMI_MATCH(DMI_PRODUCT_NAME, "FlexBook edge11 - M-FBE11"),
> >               },
> >       },
> > +     {
> > +             /* Myria MY8307 */
> > +             .driver_data = (void *)&myria_my8307_data,
> > +             .matches = {
> > +                     DMI_MATCH(DMI_SYS_VENDOR, "Complet Electro Serv"),
> > +                     DMI_MATCH(DMI_PRODUCT_NAME, "MY8307"),
> > +             },
> > +     },
> >       {
> >               /* Onda oBook 20 Plus */
> >               .driver_data = (void *)&onda_obook_20_plus_data,
> >



-- 
With Best Regards,
Andy Shevchenko
