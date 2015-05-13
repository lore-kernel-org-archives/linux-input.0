From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v2 01/17] mfd: add new driver for Sharp LoCoMo
Date: Wed, 13 May 2015 10:41:32 +0100
Message-ID: <20150513094132.GE3394@x1>
References: <1430178954-11138-1-git-send-email-dbaryshkov@gmail.com>
 <1430178954-11138-2-git-send-email-dbaryshkov@gmail.com>
 <20150428184525.GJ9169@x1>
 <CALT56yP6FPhGRZFJZkyjjpqGJ6bofg+a1BTC9KcVAgpmt2htoA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-gpio-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CALT56yP6FPhGRZFJZkyjjpqGJ6bofg+a1BTC9KcVAgpmt2htoA@mail.gmail.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
Cc: Russell King <linux@arm.linux.org.uk>, Daniel Mack <daniel@zonque.org>, Robert Jarzmik <robert.jarzmik@free.fr>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Wolfram Sang <wsa@the-dreams.de>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Bryan Wu <cooloney@gmail.com>, Richard Purdie <rpurdie@rpsys.net>, Samuel Ortiz <sameo@linux.intel.com>, Mark Brown <broonie@kernel.org>, Jingoo Han <jg1.han@samsung.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Liam Girdwood <lgirdwood@gmail.com>, Andrea Adami <andrea.adami@gmail.com>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, linux-i2c@vger.kernel.org, linux-input <linux-input@vger.kernel.org>, linux-leds <linux-leds@vger.kernel.org>, linux-spi <linux-spi@vger.kern>
List-Id: linux-input@vger.kernel.org

On Tue, 12 May 2015, Dmitry Eremin-Solenikov wrote:

> 2015-04-28 21:45 GMT+03:00 Lee Jones <lee.jones@linaro.org>:
> > On Tue, 28 Apr 2015, Dmitry Eremin-Solenikov wrote:
> >
> >> LoCoMo is a GA used on Sharp Zaurus SL-5x00. Current driver does h=
as
> >> several design issues (special bus instead of platform bus, doesn'=
t use
> >> mfd-core, etc).
> >>
> >> Implement 'core' parts of locomo support as an mfd driver.
> >>
> >> Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
> >> ---
>=20
> Thanks for the review. I agree (and have implemented) with most of
> your comments.
> However I have few questions. See below.
>=20
> >
> >> +/* the following is the overall data for the locomo chip */
> >> +struct locomo {
> >> +     struct device *dev;
> >> +     unsigned int irq;
> >> +     spinlock_t lock;
> >> +     struct irq_domain *domain;
> >> +     struct regmap *regmap;
> >> +};
> >> +
> >> +static struct resource locomo_kbd_resources[] =3D {
> >> +     DEFINE_RES_IRQ(IRQ_LOCOMO_KEY),
> >> +};
> >> +
> >> +static struct resource locomo_gpio_resources[] =3D {
> >> +     DEFINE_RES_IRQ(IRQ_LOCOMO_GPIO),
> >> +};
> >> +
> >> +/* Filled in locomo_probe() function. */
> >> +static struct locomo_gpio_platform_data locomo_gpio_pdata;
> >
> > I'd prefer you didn't use globals for this.
>=20
> Just for platform data, or for all the structures?

Just for this.  The remainder are standard.

> >> +static struct resource locomo_lt_resources[] =3D {
> >> +     DEFINE_RES_IRQ(IRQ_LOCOMO_LT),
> >> +};
> >> +
> >> +static struct resource locomo_spi_resources[] =3D {
> >> +     DEFINE_RES_IRQ(IRQ_LOCOMO_SPI),
> >> +};
> >> +
> >> +/* Filled in locomo_probe() function. */
> >> +static struct locomo_lcd_platform_data locomo_lcd_pdata;
> >> +
> >> +static struct mfd_cell locomo_cells[] =3D {
> >> +     {
> >> +             .name =3D "locomo-kbd",
> >> +             .resources =3D locomo_kbd_resources,
> >> +             .num_resources =3D ARRAY_SIZE(locomo_kbd_resources),
> >> +     },
> >> +     {
> >> +             .name =3D "locomo-gpio",
> >> +             .resources =3D locomo_gpio_resources,
> >> +             .num_resources =3D ARRAY_SIZE(locomo_gpio_resources)=
,
> >> +             .platform_data =3D &locomo_gpio_pdata,
> >> +             .pdata_size =3D sizeof(locomo_gpio_pdata),
> >> +     },
> >> +     {
> >> +             .name =3D "locomo-lt", /* Long time timer */
> >> +             .resources =3D locomo_lt_resources,
> >> +             .num_resources =3D ARRAY_SIZE(locomo_lt_resources),
> >> +     },
> >> +     {
> >> +             .name =3D "locomo-spi",
> >> +             .resources =3D locomo_spi_resources,
> >> +             .num_resources =3D ARRAY_SIZE(locomo_spi_resources),
> >> +     },
> >> +     {
> >> +             .name =3D "locomo-led",
> >> +     },
> >> +     {
> >> +             .name =3D "locomo-backlight",
> >> +     },
> >
> > Please make these:
> >
> >> +     { .name =3D "locomo-led" },
> >> +     { .name =3D "locomo-backlight" },
> >
> > ... and put them at the bottom.
>=20
> They will be populated by of_compatible lines, so it makes little sen=
se
> to me. What about adding of compatibility lines to this patch?

Also fine.

Although if you assure me you will do it, you can add them separately.

> >> +     while (1) {
> >> +             regmap_read(lchip->regmap, LOCOMO_ICR, &req);
> >> +             req &=3D 0x0f00;
> >
> > What is this magic number?  Please #define it.
>=20
> Adding comments to this function instead.

Also acceptable.

> >> +             if (!req)
> >> +                     break;
> >> +
> >> +             irq =3D ffs(req) - 9;
> >
> > Minus another random number?  Either define it or enter a comment.
> >
> >> +#ifdef CONFIG_PM_SLEEP
> >> +static int locomo_suspend(struct device *dev)
> >> +{
> >> +     struct locomo *lchip =3D dev_get_drvdata(dev);
> >> +
> >> +     /* AUDIO */
> >
> > WHY ARE YOU SHOUTING?  Ironic eh? ;)
> >
> >> +     regmap_write(lchip->regmap, LOCOMO_PAIF, 0x00);
> >> +
> >> +     /*
> >> +      * Original code disabled the clock depending on leds settin=
gs
> >> +      * However we disable leds before suspend, thus it's safe
> >> +      * to just assume this setting.
> >> +      */
> >> +     /* CLK32 off */
> >> +     regmap_write(lchip->regmap, LOCOMO_C32K, 0x00);
> >> +
> >> +     /* 22MHz/24MHz clock off */
> >> +     regmap_write(lchip->regmap, LOCOMO_ACC, 0x00);
> >> +
> >> +     return 0;
> >> +}
> >> +
> >> +static int locomo_resume(struct device *dev)
> >> +{
> >> +     struct locomo *lchip =3D dev_get_drvdata(dev);
> >
> > Do audio and clk sort themselves out?
>=20
> PAIF and ACC registers are used only by audio parts of the device. Ho=
wever
> there is no current Linux driver for those parts. The registers are c=
leared
> in case the firmware has set something in them, but in future it will
> be the task
> of the audio driver to properly clear and restore them.
>=20
> >> +     regmap_write(lchip->regmap, LOCOMO_C32K, 0x00);
> >> +
> >> +     return 0;
> >> +}
> >> +
>=20
> [skipped]
> >> +
> >> +     if (pdata) {
> >> +             locomo_gpio_pdata.gpio_base =3D pdata->gpio_base;
> >> +             locomo_lcd_pdata.comadj =3D pdata->comadj;
> >> +     } else {
> >> +             locomo_gpio_pdata.gpio_base =3D -1;
> >> +             locomo_lcd_pdata.comadj =3D 128;
> >> +     }
> >
> > struct locomo_gpio_platform_data locomo_gpio_pdata;
> >
> > locomo_gpio_pdata =3D devm_kzalloc(<blah>);
> >
> > locomo_cells[GPIO].platform_data =3D locomo_gpio_pdata;
>=20
> I do not quite agree with you at this place. The passed platform_data
> will be kmemdup()'ed inside platform core. So the whole struct will b=
e
> duplicated twice inside kmallocate'd memory. Ideally I'd like to drop
> the whole platform_data busyness, but that requires switching to DTS
> first.

Sounds reasonable.

> >> diff --git a/include/linux/mfd/locomo.h b/include/linux/mfd/locomo=
=2Eh
> >> new file mode 100644
> >> index 0000000..6729767
> >> --- /dev/null
> >> +++ b/include/linux/mfd/locomo.h
>=20
> >> +/* MCS decoder for boot selecting */
> >> +#define LOCOMO_MCSX0 0x10
> >> +#define LOCOMO_MCSX1 0x14
> >> +#define LOCOMO_MCSX2 0x18
> >> +#define LOCOMO_MCSX3 0x1c
> >
> > These are pretty cryptic.  Any way of making them easier to identif=
y.
>=20
> No way. The names are based on old Sharp code. The drivers do not use
> them, but I'd like to still keep the registers for the reference purp=
oses.

So they are not used at all?  Then why do you want to keep them?

> >> +struct locomo_gpio_platform_data {
> >> +     unsigned int gpio_base;
> >> +};
> >
> > A struct for a single int seems overkill.
> >
> >> +struct locomo_lcd_platform_data {
> >> +     u8 comadj;
> >> +};
> >> +
> >> +struct locomo_platform_data {
> >> +     unsigned int gpio_base;
> >> +     u8 comadj;
> >> +};
> >
> > Why do you need to pass gpio_base twice?
>=20
> First: machine file -> core driver
> Second: core driver -> gpio driver
>=20
> The other way to do the same would be:
>=20
> struct locomo_gpio_platform_data {
>      unsigned int gpio_base;
> };
>=20
> struct locomo_lcd_platform_data {
>      u8 comadj;
> };
>=20
> struct locomo_platform_data {
>      struct locomo_gpio_platform_data gpio_pdata;
>      struct locomo_lcd_platform_data lcd_pdata;
> };
>=20
> And to assign pointers to the passed data in the mfd_cells
> during locomo_probe. Does that look better to you?

Bingo.

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
--
To unsubscribe from this list: send the line "unsubscribe linux-gpio" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
