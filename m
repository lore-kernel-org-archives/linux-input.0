From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v4 05/10] mfd: max77650: new core mfd driver
Date: Tue, 12 Feb 2019 09:54:57 +0000
Message-ID: <20190212095457.GA20638@dell>
References: <20190205091237.6448-1-brgl@bgdev.pl>
 <20190205091237.6448-6-brgl@bgdev.pl>
 <20190212083642.GT20638@dell>
 <CAMRc=MderQf20_8aG4-otBkCv60FSNSSqV3NVALPkFL-MqmJbg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAMRc=MderQf20_8aG4-otBkCv60FSNSSqV3NVALPkFL-MqmJbg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Linus Walleij <linus.walleij@linaro.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jacek Anaszewski <jacek.anaszewski@gmail.com>, Pavel Machek <pavel@ucw.cz>, Sebastian Reichel <sre@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>, devicetree <devicetree@vger.kernel.org>, Linux Input <linux-input@vger.kernel.org>, Linux LED Subsystem <linux-leds@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>
List-Id: linux-input@vger.kernel.org

On Tue, 12 Feb 2019, Bartosz Golaszewski wrote:

> wt., 12 lut 2019 o 09:36 Lee Jones <lee.jones@linaro.org> napisał(a):
> >
> > On Tue, 05 Feb 2019, Bartosz Golaszewski wrote:
> >
> > > From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> > >
> > > Add the core mfd driver for max77650 PMIC. We define five sub-devices
> > > for which the drivers will be added in subsequent patches.
> > >
> > > Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> > > ---
> > >  drivers/mfd/Kconfig          |  11 ++
> > >  drivers/mfd/Makefile         |   1 +
> > >  drivers/mfd/max77650.c       | 342 +++++++++++++++++++++++++++++++++++
> > >  include/linux/mfd/max77650.h |  59 ++++++
> > >  4 files changed, 413 insertions(+)
> > >  create mode 100644 drivers/mfd/max77650.c
> > >  create mode 100644 include/linux/mfd/max77650.h

[...]

> > > +static const struct max77650_irq_mapping max77650_irq_mapping_table[] = {
> > > +     {
> > > +             .cell_num       = MAX77650_CELL_CHARGER,
> > > +             .irqs           = max77650_charger_irqs,
> > > +             .irq_names      = max77650_charger_irq_names,
> > > +             .num_irqs       = ARRAY_SIZE(max77650_charger_irqs),
> > > +     },
> > > +     {
> > > +             .cell_num       = MAX77650_CELL_GPIO,
> > > +             .irqs           = max77650_gpio_irqs,
> > > +             .irq_names      = max77650_gpio_irq_names,
> > > +             .num_irqs       = ARRAY_SIZE(max77650_gpio_irqs),
> > > +     },
> > > +     {
> > > +             .cell_num       = MAX77650_CELL_ONKEY,
> > > +             .irqs           = max77650_onkey_irqs,
> > > +             .irq_names      = max77650_onkey_irq_names,
> > > +             .num_irqs       = ARRAY_SIZE(max77650_onkey_irqs),
> > > +     },
> > > +};
> >
> > This is all a bit convoluted and nasty TBH.
> >
> > > +static const struct mfd_cell max77650_cells[] = {
> > > +     [MAX77650_CELL_REGULATOR] = {
> > > +             .name           = "max77650-regulator",
> > > +             .of_compatible  = "maxim,max77650-regulator",
> > > +     },
> > > +     [MAX77650_CELL_CHARGER] = {
> > > +             .name           = "max77650-charger",
> > > +             .of_compatible  = "maxim,max77650-charger",
> > > +     },
> > > +     [MAX77650_CELL_GPIO] = {
> > > +             .name           = "max77650-gpio",
> > > +             .of_compatible  = "maxim,max77650-gpio",
> > > +     },
> > > +     [MAX77650_CELL_LED] = {
> > > +             .name           = "max77650-led",
> > > +             .of_compatible  = "maxim,max77650-led",
> > > +     },
> > > +     [MAX77650_CELL_ONKEY] = {
> > > +             .name           = "max77650-onkey",
> > > +             .of_compatible  = "maxim,max77650-onkey",
> > > +     },
> > > +};
> >
> > Why are you numbering the cells?  There is no need to do this.
> >
> 
> Just for better readability. It makes sense to me coupled with
> MAX77650_NUM_CELLS.

You have it the wrong way around.  You define the cell data, then
provide the number of them using ARRAY_SIZE().  The enum containing
MAX77650_NUM_CELLS should not exist.

> > > +static const struct regmap_irq max77650_irqs[] = {
> > > +     [MAX77650_INT_GPI] = {
> > > +             .reg_offset             = MAX77650_INT_GLBL_OFFSET,
> > > +             .mask                   = MAX77650_INT_GPI_MSK,
> > > +             .type = {
> > > +                     .type_falling_val       = MAX77650_INT_GPI_F_MSK,
> > > +                     .type_rising_val        = MAX77650_INT_GPI_R_MSK,
> > > +                     .types_supported        = IRQ_TYPE_EDGE_BOTH,
> > > +             },
> > > +     },
> > > +     [MAX77650_INT_nEN_F] = {
> > > +             .reg_offset             = MAX77650_INT_GLBL_OFFSET,
> > > +             .mask                   = MAX77650_INT_nEN_F_MSK,
> > > +     },
> > > +     [MAX77650_INT_nEN_R] = {
> > > +             .reg_offset             = MAX77650_INT_GLBL_OFFSET,
> > > +             .mask                   = MAX77650_INT_nEN_R_MSK,
> > > +     },
> > > +     [MAX77650_INT_TJAL1_R] = {
> > > +             .reg_offset             = MAX77650_INT_GLBL_OFFSET,
> > > +             .mask                   = MAX77650_INT_TJAL1_R_MSK,
> > > +     },
> > > +     [MAX77650_INT_TJAL2_R] = {
> > > +             .reg_offset             = MAX77650_INT_GLBL_OFFSET,
> > > +             .mask                   = MAX77650_INT_TJAL2_R_MSK,
> > > +     },
> > > +     [MAX77650_INT_DOD_R] = {
> > > +             .reg_offset             = MAX77650_INT_GLBL_OFFSET,
> > > +             .mask                   = MAX77650_INT_DOD_R_MSK,
> > > +     },
> > > +     [MAX77650_INT_THM] = {
> > > +             .reg_offset             = MAX77650_INT_CHG_OFFSET,
> > > +             .mask                   = MAX77650_INT_THM_MSK,
> > > +     },
> > > +     [MAX77650_INT_CHG] = {
> > > +             .reg_offset             = MAX77650_INT_CHG_OFFSET,
> > > +             .mask                   = MAX77650_INT_CHG_MSK,
> > > +     },
> > > +     [MAX77650_INT_CHGIN] = {
> > > +             .reg_offset             = MAX77650_INT_CHG_OFFSET,
> > > +             .mask                   = MAX77650_INT_CHGIN_MSK,
> > > +     },
> > > +     [MAX77650_INT_TJ_REG] = {
> > > +             .reg_offset             = MAX77650_INT_CHG_OFFSET,
> > > +             .mask                   = MAX77650_INT_TJ_REG_MSK,
> > > +     },
> > > +     [MAX77650_INT_CHGIN_CTRL] = {
> > > +             .reg_offset             = MAX77650_INT_CHG_OFFSET,
> > > +             .mask                   = MAX77650_INT_CHGIN_CTRL_MSK,
> > > +     },
> > > +     [MAX77650_INT_SYS_CTRL] = {
> > > +             .reg_offset             = MAX77650_INT_CHG_OFFSET,
> > > +             .mask                   = MAX77650_INT_SYS_CTRL_MSK,
> > > +     },
> > > +     [MAX77650_INT_SYS_CNFG] = {
> > > +             .reg_offset             = MAX77650_INT_CHG_OFFSET,
> > > +             .mask                   = MAX77650_INT_SYS_CNFG_MSK,
> > > +     },
> > > +};
> >
> > If you get rid of all of the horrible hoop jumping in *_setup_irqs(),
> > you can use REGMAP_IRQ_REG() like everyone else does.
> >
> 
> I could even use it now - except for the first interrupt. I decided to
> not use it everywhere as it looks much better that way than having
> REGMAP_IRQ_REG() for all definitions and then the first one sticking
> out like that. It just looks better.

The way it's done at the moment looks terrible.

Please use the MACROs to simplify as much of the code as possible.

> > > +static const struct regmap_irq_chip max77650_irq_chip = {
> > > +     .name                   = "max77650-irq",
> > > +     .irqs                   = max77650_irqs,
> > > +     .num_irqs               = ARRAY_SIZE(max77650_irqs),
> > > +     .num_regs               = 2,
> > > +     .status_base            = MAX77650_REG_INT_GLBL,
> > > +     .mask_base              = MAX77650_REG_INTM_GLBL,
> > > +     .type_in_mask           = true,
> > > +     .type_invert            = true,
> > > +     .init_ack_masked        = true,
> > > +     .clear_on_unmask        = true,
> > > +};
> > > +
> > > +static const struct regmap_config max77650_regmap_config = {
> > > +     .name           = "max77650",
> > > +     .reg_bits       = 8,
> > > +     .val_bits       = 8,
> > > +};
> > > +
> > > +static int max77650_setup_irqs(struct device *dev, struct mfd_cell *cells)
> > > +{
> > > +     const struct max77650_irq_mapping *mapping;
> > > +     struct regmap_irq_chip_data *irq_data;
> > > +     struct i2c_client *i2c;
> > > +     struct mfd_cell *cell;
> > > +     struct resource *res;
> > > +     struct regmap *map;
> > > +     int i, j, irq, rv;
> > > +
> > > +     i2c = to_i2c_client(dev);
> > > +
> > > +     map = dev_get_regmap(dev, NULL);
> > > +     if (!map)
> > > +             return -ENODEV;
> > > +
> > > +     rv = devm_regmap_add_irq_chip(dev, map, i2c->irq,
> > > +                                   IRQF_ONESHOT | IRQF_SHARED, -1,
> >
> > What is -1?  Are you sure this isn't defined somewhere?
> >
> 
> I don't see any define for negative irq_base argument. I can add that
> in a separate series and convert the users, but for now I'd stick with
> -1.

IMO it should be defined.  You can define it locally for now.

> > > +                                   &max77650_irq_chip, &irq_data);
> > > +     if (rv)
> > > +             return rv;
> > > +
> > > +     for (i = 0; i < ARRAY_SIZE(max77650_irq_mapping_table); i++) {
> > > +             mapping = &max77650_irq_mapping_table[i];
> > > +             cell = &cells[mapping->cell_num];
> > > +
> > > +             res = devm_kcalloc(dev, sizeof(*res),
> > > +                                mapping->num_irqs, GFP_KERNEL);
> > > +             if (!res)
> > > +                     return -ENOMEM;
> > > +
> > > +             cell->resources = res;
> > > +             cell->num_resources = mapping->num_irqs;
> > > +
> > > +             for (j = 0; j < mapping->num_irqs; j++) {
> > > +                     irq = regmap_irq_get_virq(irq_data, mapping->irqs[j]);
> > > +                     if (irq < 0)
> > > +                             return irq;
> > > +
> > > +                     res[j].start = res[j].end = irq;
> > > +                     res[j].flags = IORESOURCE_IRQ;
> > > +                     res[j].name = mapping->irq_names[j];
> > > +             }
> > > +     }
> >
> > This is the first time I've seen it done like this (and I hate it).
> >
> > Why are you storing the virqs in resources?
> >
> > I think this is highly irregular.
> >
> 
> I initially just passed the regmap_irq_chip_data over i2c clientdata
> and sub-drivers would look up virq numbers from it but was advised by
> Dmitry Torokhov to use resources instead. After implementing it this
> way I too think it's more elegant in sub-drivers who can simply do
> platform_get_irq_byname(). Do you have a different idea?

> What exactly don't you like about this?

 * The declaration of a superfluous struct
 * 100 lines of additional/avoidable code
 * Hacky hoop jumping trying to fudge VIRQs into resources
 * Resources were designed for HWIRQs (unless a domain is present)
 * Loads of additional/avoidable CPU cycles setting all this up

Need I go on? :)

Surely the fact that you are using both sides of an API
(devm_regmap_init_i2c and regmap_irq_get_*) in the same driver, must
set some alarm bells ringing?

This whole HWIRQ setting, VIRQ getting, resource hacking is a mess.

And for what?  To avoid passing IRQ data to a child driver?

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
