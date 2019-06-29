From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH] platform/x86: touchscreen_dmi: Update Hi10 Air filter
Date: Sat, 29 Jun 2019 16:20:44 +0300
Message-ID: <CAHp75VcxiKMWnXe_oFu-9JCfDuXa9hOUi2Qy6bNQiREH_i621Q@mail.gmail.com>
References: <20190612124053.119182-1-me@myself5.de> <736848fd-1c45-0bd9-bfd1-747c716bd953@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <736848fd-1c45-0bd9-bfd1-747c716bd953@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Christian Oder <me@myself5.de>, Darren Hart <dvhart@infradead.org>, Andy Shevchenko <andy@infradead.org>, linux-input <linux-input@vger.kernel.org>, Platform Driver <platform-driver-x86@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

On Wed, Jun 12, 2019 at 3:55 PM Hans de Goede <hdegoede@redhat.com> wrote:
>
> Hi,
>
> On 12-06-19 14:40, Christian Oder wrote:
> > Turns out the Hi10 Air is built by multiple companies so using Hampoo
> > as a filter is not enough to cover all variants.
> >
> > This has been verified as working on the Hampoo and Morshow version.
> >
> > Signed-off-by: Christian Oder <me@myself5.de>
>
> Patch looks good to me:
>
> Reviewed-by: Hans de Goede <hdegoede@redhat.com>
>

I have pushed it, though I forget about this issue, it went without
this tag, sorry.

> Regards,
>
> Hans
>
>
> > ---
> >   drivers/platform/x86/touchscreen_dmi.c | 3 ++-
> >   1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/platform/x86/touchscreen_dmi.c b/drivers/platform/x86/touchscreen_dmi.c
> > index b662cb2d7cd5..61e7c4987d0d 100644
> > --- a/drivers/platform/x86/touchscreen_dmi.c
> > +++ b/drivers/platform/x86/touchscreen_dmi.c
> > @@ -597,7 +597,8 @@ static const struct dmi_system_id touchscreen_dmi_table[] = {
> >               /* Chuwi Hi10 Air */
> >               .driver_data = (void *)&chuwi_hi10_air_data,
> >               .matches = {
> > -                     DMI_MATCH(DMI_BOARD_VENDOR, "Hampoo"),
> > +                     DMI_MATCH(DMI_SYS_VENDOR, "CHUWI INNOVATION AND TECHNOLOGY(SHENZHEN)CO.LTD"),
> > +                     DMI_MATCH(DMI_BOARD_NAME, "Cherry Trail CR"),
> >                       DMI_MATCH(DMI_PRODUCT_SKU, "P1W6_C109D_B"),
> >               },
> >       },
> >



-- 
With Best Regards,
Andy Shevchenko
