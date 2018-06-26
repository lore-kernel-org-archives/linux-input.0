From: Enric Balletbo Serra <eballetbo@gmail.com>
Subject: Re: [PATCH v7 1/4] mfd: bd71837: mfd driver for ROHM BD71837 PMIC
Date: Tue, 26 Jun 2018 13:40:40 +0200
Message-ID: <CAFqH_52NERfORwSkBh0stW+mvzRpw0to9CiWPwLB9mFo_TsW_w@mail.gmail.com>
References: <cover.1529404894.git.matti.vaittinen@fi.rohmeurope.com>
 <7e1888375c979accc402e9ddd7316e528b2ac52c.1529404894.git.matti.vaittinen@fi.rohmeurope.com>
 <CAFqH_51izuVgHukAORvwjZqGhxy85tdNdaHL9mOUnPnbCQmQjA@mail.gmail.com> <20180626112455.GC2118@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180626112455.GC2118@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: matti.vaittinen@fi.rohmeurope.com
Cc: Michael Turquette <mturquette@baylibre.com>, sboyd@kernel.org, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Lee Jones <lee.jones@linaro.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, mazziesaccount@gmail.com, Arnd Bergmann <arnd@arndb.de>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Sebastian Reichel <sre@kernel.org>, chenjh@rock-chips.com, andrew.smirnov@gmail.com, Linus Walleij <linus.walleij@linaro.org>, Kate Stewart <kstewart@linuxfoundation.org>, =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-clk@vger.kernel.org, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, linux-input@vger.kernel.or
List-Id: linux-input@vger.kernel.org

Hi Matti,
Missatge de Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com> del
dia dt., 26 de juny 2018 a les 13:25:
>
> Hello Eric,
>
> Thanks for the comments! I'll be addressing these in patch series v8
> - except the regmap wrapper one which will be taken care of by another
> patch set.
>
> On Tue, Jun 26, 2018 at 11:06:33AM +0200, Enric Balletbo Serra wrote:
> > Hi Matti,
> >
> > Thanks for the patch, a few comments below, some are feedback I
> > received when I sent some patches to this subsystem.
> >
> > Missatge de Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com> del
> > dia dt., 19 de juny 2018 a les 12:57:
> > >
> > > ROHM BD71837 PMIC MFD driver providing interrupts and support
> > > for two subsystems:
> > > - clk
> > > - Regulators
> > >
> > > Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
> > > ---
> > >  drivers/mfd/Kconfig         |  13 ++
> > >  drivers/mfd/Makefile        |   1 +
> > >  drivers/mfd/bd71837.c       | 221 ++++++++++++++++++++++++++
> > >  include/linux/mfd/bd71837.h | 367 ++++++++++++++++++++++++++++++++++++++++++++
> > >  4 files changed, 602 insertions(+)
> > >  create mode 100644 drivers/mfd/bd71837.c
> > >  create mode 100644 include/linux/mfd/bd71837.h
> > >
> > > diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> > > index b860eb5aa194..7aa05fc9ed8e 100644
> > > --- a/drivers/mfd/Kconfig
> > > +++ b/drivers/mfd/Kconfig
> > > @@ -1787,6 +1787,19 @@ config MFD_STW481X
> > >           in various ST Microelectronics and ST-Ericsson embedded
> > >           Nomadik series.
> > >
> > > +config MFD_BD71837
> > > +       bool "BD71837 Power Management chip"
> >
> > I know that some drivers need to be built-in, is this really a
> > requirement for this driver? Or should work as a module too.
> >
>
> I have been writing power/reset driver for this PMIC. I thought that the
> modules would be unload before reset hook is ran - which seems to be
> not true on platform where I tested this. So you are correct, at least
> on cases where reset is not used via PMIC - or where the platform is not
> unloading modules prior reset - these drivers can indeed be modules. So
> it is fair to allow building them as modules. Users who want to build
> this in kernel can still do so. => I'll change this.
>
> > > +       depends on I2C=y
> > > +       depends on OF
> > > +       select REGMAP_I2C
> > > +       select REGMAP_IRQ
> > > +       select MFD_CORE
> > > +       help
> > > +         Select this option to get support for the ROHM BD71837
> > > +         Power Management chips. BD71837 is designed to power processors like
> > > +         NXP i.MX8. It contains 8 BUCK outputs and 7 LDOs, voltage monitoring
> > > +         and emergency shut down as well as 32,768KHz clock output.
> > > +
> > >  config MFD_STM32_LPTIMER
> > >         tristate "Support for STM32 Low-Power Timer"
> > >         depends on (ARCH_STM32 && OF) || COMPILE_TEST
> > > diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
> > > index e9fd20dba18d..09dc9eb3782c 100644
> > > --- a/drivers/mfd/Makefile
> > > +++ b/drivers/mfd/Makefile
> > > @@ -227,4 +227,5 @@ obj-$(CONFIG_MFD_STM32_TIMERS)      += stm32-timers.o
> > >  obj-$(CONFIG_MFD_MXS_LRADC)     += mxs-lradc.o
> > >  obj-$(CONFIG_MFD_SC27XX_PMIC)  += sprd-sc27xx-spi.o
> > >  obj-$(CONFIG_RAVE_SP_CORE)     += rave-sp.o
> > > +obj-$(CONFIG_MFD_BD71837)      += bd71837.o
> > >
> > > diff --git a/drivers/mfd/bd71837.c b/drivers/mfd/bd71837.c
> > > new file mode 100644
> > > index 000000000000..0f0361d6cad6
> > > --- /dev/null
> > > +++ b/drivers/mfd/bd71837.c
> > > @@ -0,0 +1,221 @@
> > > +// SPDX-License-Identifier: GPL-2.0
> >
> > There is a mismatch between what SPDX says and MODULE_LICENSE says.
> >
> > GPL-2.0 = GPL v2 only
> > MODULE_LICENSE(GPL) = GPL v2 or later.
> >
> >  You'd like to change the SPDX identifier to GPL-2.0-or-later or set
> > module license to "GPL v2".
>
> Right. Thanks for pointing that out.
>
> >
> > > +// Copyright (C) 2018 ROHM Semiconductors
> > > +// bd71837.c -- ROHM BD71837MWV mfd driver
> > > +//
> > > +// Datasheet available from
> > > +// https://www.rohm.com/datasheet/BD71837MWV/bd71837mwv-e
> > > +
> > > +#include <linux/module.h>
> > > +#include <linux/moduleparam.h>
> > This include is not required.
> >
> > > +#include <linux/init.h>
> > > +#include <linux/slab.h>
> > > +#include <linux/i2c.h>
> > > +#include <linux/interrupt.h>
> > > +#include <linux/irq.h>
> > ditto
> >
> > > +#include <linux/irqdomain.h>
> > ditto
> >
> > > +#include <linux/gpio.h>
> > ditto
> >
> > > +#include <linux/regmap.h>
> > > +#include <linux/of_device.h>
> > > +#include <linux/of_gpio.h>
> > ditto
> > > +#include <linux/mfd/core.h>
> > > +#include <linux/mfd/bd71837.h>
> > > +
> >
> > Please review the needed includes.
>
> I'll do that, thanks.
>
> > > +static const struct resource irqs[] = {
> > > +       {
> > > +               .start = BD71837_INT_PWRBTN,
> > > +               .end = BD71837_INT_PWRBTN,
> > > +               .flags = IORESOURCE_IRQ,
> > > +               .name = "pwr-btn",
> > > +       }, {
> > > +               .start = BD71837_INT_PWRBTN_L,
> > > +               .end = BD71837_INT_PWRBTN_L,
> > > +               .flags = IORESOURCE_IRQ,
> > > +               .name = "pwr-btn-l",
> > > +       }, {
> > > +               .start = BD71837_INT_PWRBTN_S,
> > > +               .end = BD71837_INT_PWRBTN_S,
> > > +               .flags = IORESOURCE_IRQ,
> > > +               .name = "pwr-btn-s",
> > > +       },
> >
> > nit: no comma at the end
>
> Whole struct will be removed. I will use gpio-keys and remove the
> bd718xx-pwrkey driver as suggested by Dmitry Torokhov.
>
> > > +};
> > > +
> > > +/* bd71837 multi function cells */
> > > +static struct mfd_cell bd71837_mfd_cells[] = {
> > > +       {
> > > +               .name = "bd71837-clk",
> > > +       }, {
> > > +               .name = "bd718xx-pwrkey",
> > > +               .resources = &irqs[0],
> > > +               .num_resources = ARRAY_SIZE(irqs),
> > > +       }, {
> > > +               .name = "bd71837-pmic",
> > > +       },
> > nit: no comma at the end
>
> Ok.
>
> > > +};
> > > +
> > > +static const struct regmap_irq bd71837_irqs[] = {
> > > +       REGMAP_IRQ_REG(BD71837_INT_SWRST, 0, BD71837_INT_SWRST_MASK),
> > > +       REGMAP_IRQ_REG(BD71837_INT_PWRBTN_S, 0, BD71837_INT_PWRBTN_S_MASK),
> > > +       REGMAP_IRQ_REG(BD71837_INT_PWRBTN_L, 0, BD71837_INT_PWRBTN_L_MASK),
> > > +       REGMAP_IRQ_REG(BD71837_INT_PWRBTN, 0, BD71837_INT_PWRBTN_MASK),
> > > +       REGMAP_IRQ_REG(BD71837_INT_WDOG, 0, BD71837_INT_WDOG_MASK),
> > > +       REGMAP_IRQ_REG(BD71837_INT_ON_REQ, 0, BD71837_INT_ON_REQ_MASK),
> > > +       REGMAP_IRQ_REG(BD71837_INT_STBY_REQ, 0, BD71837_INT_STBY_REQ_MASK),
> > > +};
> > > +
> > > +static struct regmap_irq_chip bd71837_irq_chip = {
> > > +       .name = "bd71837-irq",
> > > +       .irqs = bd71837_irqs,
> > > +       .num_irqs = ARRAY_SIZE(bd71837_irqs),
> > > +       .num_regs = 1,
> > > +       .irq_reg_stride = 1,
> > > +       .status_base = BD71837_REG_IRQ,
> > > +       .mask_base = BD71837_REG_MIRQ,
> > > +       .ack_base = BD71837_REG_IRQ,
> > > +       .init_ack_masked = true,
> > > +       .mask_invert = false,
> > > +};
> > > +
> > > +static int bd71837_irq_exit(struct bd71837 *bd71837)
> > > +{
> > > +       if (bd71837->chip_irq > 0)
> > > +               regmap_del_irq_chip(bd71837->chip_irq, bd71837->irq_data);
> > > +       return 0;
> > > +}
> > > +
> > > +static const struct regmap_range pmic_status_range = {
> > > +       .range_min = BD71837_REG_IRQ,
> > > +       .range_max = BD71837_REG_POW_STATE,
> > > +};
> > > +
> > > +static const struct regmap_access_table volatile_regs = {
> > > +       .yes_ranges = &pmic_status_range,
> > > +       .n_yes_ranges = 1,
> > > +};
> > > +
> > > +static const struct regmap_config bd71837_regmap_config = {
> > > +       .reg_bits = 8,
> > > +       .val_bits = 8,
> > > +       .volatile_table = &volatile_regs,
> > > +       .max_register = BD71837_MAX_REGISTER - 1,
> > > +       .cache_type = REGCACHE_RBTREE,
> > > +};
> > > +
> > > +#ifdef CONFIG_OF
>
> > The driver is DT-only and depends on OF so you don't need to protect this.
> True. I'll remove this
>
> > > +static const struct of_device_id bd71837_of_match[] = {
> > > +       { .compatible = "rohm,bd71837", .data = (void *)0},
> > > +       { },
> >
> > nit: { /* sentinel */ }
>
> I am sorry but I didn't quite get the point here. Could you please
> explain what did you expect to be added here?
>

It's a nit but It is a good practice to specify that the last entry is
a sentinel. Just this.

+static const struct of_device_id bd71837_of_match[] = {
+       { .compatible = "rohm,bd71837", .data = (void *)0},
+       { /* sentinel */ }
+};

And just noticed, is .data = (void *)0 really required?

> > > +};
> > > +MODULE_DEVICE_TABLE(of, bd71837_of_match);
> > > +#endif //CONFIG_OF
> > > +
> > > +static int bd71837_i2c_probe(struct i2c_client *i2c,
> > > +                           const struct i2c_device_id *id)
> > > +{
> > > +       struct bd71837 *bd71837;
> > > +       struct bd71837_board *board_info;
> > > +       int ret = -EINVAL;
> > > +
> > > +       board_info = dev_get_platdata(&i2c->dev);
> > > +
> > > +       if (!board_info) {
> > > +               board_info = devm_kzalloc(&i2c->dev, sizeof(*board_info),
> > > +                                         GFP_KERNEL);
> > > +               if (!board_info) {
> > > +                       ret = -ENOMEM;
> > > +                       goto err_out;
> > > +               } else if (i2c->irq) {
> > > +                       board_info->gpio_intr = i2c->irq;
> > > +               } else {
> > > +                       ret = -ENOENT;
> > > +                       goto err_out;
> > > +               }
> > > +       }
> > > +
> > > +       if (!board_info)
> > > +               goto err_out;
> > > +
> > > +       bd71837 = devm_kzalloc(&i2c->dev, sizeof(struct bd71837), GFP_KERNEL);
> > > +       if (bd71837 == NULL)
> > > +               return -ENOMEM;
> > > +
> > > +       i2c_set_clientdata(i2c, bd71837);
> > > +       bd71837->dev = &i2c->dev;
> > > +       bd71837->i2c_client = i2c;
> > > +       bd71837->chip_irq = board_info->gpio_intr;
> > > +
> > > +       bd71837->regmap = devm_regmap_init_i2c(i2c, &bd71837_regmap_config);
> > > +       if (IS_ERR(bd71837->regmap)) {
> > > +               ret = PTR_ERR(bd71837->regmap);
> > > +               dev_err(&i2c->dev, "regmap initialization failed: %d\n", ret);
> > > +               goto err_out;
> > > +       }
> > > +
> > > +       ret = bd71837_reg_read(bd71837, BD71837_REG_REV);
> > > +       if (ret < 0) {
> > > +               dev_err(bd71837->dev,
> > > +                       "%s(): Read BD71837_REG_DEVICE failed!\n", __func__);
> > > +               goto err_out;
> > > +       }
> > > +
> > > +       ret = regmap_add_irq_chip(bd71837->regmap, bd71837->chip_irq,
> > > +               IRQF_ONESHOT, 0,
> > > +               &bd71837_irq_chip, &bd71837->irq_data);
> >
> > I think that you can use 'devm_regmap_add_irq_chip' here and remove
> > the code to delete the irq chip
>
> Right. Good point. Makes this lot leaner and cleaner.
>
> > > +       if (ret < 0) {
> > > +               dev_err(bd71837->dev, "Failed to add irq_chip %d\n", ret);
> > > +               goto err_out;
> > > +       }
> > > +
> > > +       ret = mfd_add_devices(bd71837->dev, PLATFORM_DEVID_AUTO,
> > > +                             bd71837_mfd_cells, ARRAY_SIZE(bd71837_mfd_cells),
> > > +                             NULL, 0,
> > > +                             regmap_irq_get_domain(bd71837->irq_data));
> >
> > Same here, I think you can use the devm_mfd_add_devices.
>
> Right. Good point. Makes this lot leaner and cleaner.
>
> > > +
> > > +       return 0;
> > > +}
> > > +
> > > +static const struct i2c_device_id bd71837_i2c_id[] = {
> > > +       { .name = "bd71837", },
> > > +       { }
> >
> > nit: { /* sentinel */ }
>
> I am sorry but I didn't quite get the point here. Could you please
> explain what did you expect to be added here?
>
> > > +};
> > > +MODULE_DEVICE_TABLE(i2c, bd71837_i2c_id);
> > > +
> > > +static struct i2c_driver bd71837_i2c_driver = {
> > > +       .driver = {
> > > +               .name = "bd71837-mfd",
> > > +               .owner = THIS_MODULE,
> >
> > Remove this, it is not needed, the core does it for you.
>
> True. Thanks.
>
> > > +               .of_match_table = of_match_ptr(bd71837_of_match),
> >
> > The driver is DT-only, don't need to call of_match_ptr.
>
> Ok.
>
> > > +       },
> > > +       .probe = bd71837_i2c_probe,
> > > +       .remove = bd71837_i2c_remove,
> > > +       .id_table = bd71837_i2c_id,
> > > +};
> > > +
> > > +static int __init bd71837_i2c_init(void)
> > > +{
> > > +       return i2c_add_driver(&bd71837_i2c_driver);
> > > +}
> > > +/* init early so consumer devices can complete system boot */
> > > +subsys_initcall(bd71837_i2c_init);
> > > +
> > > +static void __exit bd71837_i2c_exit(void)
> > > +{
> > > +       i2c_del_driver(&bd71837_i2c_driver);
> > > +}
> > > +module_exit(bd71837_i2c_exit);
> > > +
> >
> > Can't you use module_i2c_driver here and get rid of init/exit calls?
>
> I did this because of subsys_initcall() and how other drivers had used
> that.
>
> > > +MODULE_AUTHOR("Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>");
> > > +MODULE_DESCRIPTION("BD71837 chip multi-function driver");
> > > +MODULE_LICENSE("GPL");
> >
> > License mismatch.
>
> Thanks again
>
> > > diff --git a/include/linux/mfd/bd71837.h b/include/linux/mfd/bd71837.h
> > > new file mode 100644
> > > index 000000000000..125c7478ec29
> > > --- /dev/null
> > > +++ b/include/linux/mfd/bd71837.h
> > > @@ -0,0 +1,367 @@
> > > +
> > > +/* register write induced reset settings */
> >
> > /* Register ...
>
> Ok.
>
> > > +
> > > +/* even though the bit zero is not SWRESET type we still want to write zero
> >
> > /*
> >  * Even
>
> Ok.
>
> > > + * to it when changing type. Biz zero is 'SWRESET' trigger bit and if we
> >
> > s/Biz/Bit/
>
> Ok.
>
> > > +/*
> > > + * bd71837 sub-driver chip access routines
> > > + */
> > > +
> >
> > All these access routines only hide the regmap_* calls, so why not use
> > the regmap calls directly in the driver and remove all this?
>
> This was also discussed with Stephen during the review for clk patches:
> https://lore.kernel.org/lkml/152997029783.143105.16692843405899913246@swboyd.mtv.corp.google.com/
>
> I will later send a new patch set which only removes these wrappers from
> this MFD and also the submodules. I like to introduce that as a separate
> change set after the whole driver is applied as it impacts to some already
> applied parts. I don't want any mismatches which jump out as compile errors
> when MFD gets applied and config dependencies get solved.
>
> But yes, you are correct - the write/read to BD71837 is plain regmap access
> and same simple access seems to be working with the BD71847 when it comes.
> So these are not needed and will be removed.
>
> Br,
>         Matti Vaittinen
