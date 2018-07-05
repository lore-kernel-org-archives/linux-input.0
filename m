From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v9 1/2] mfd: bd71837: mfd driver for ROHM BD71837 PMIC
Date: Thu, 5 Jul 2018 12:17:05 +0100
Message-ID: <20180705111705.GN496@dell>
References: <cover.1530776326.git.matti.vaittinen@fi.rohmeurope.com>
 <a304164cc3c1b31c7c6b62f8e233ce321a82cdd6.1530776326.git.matti.vaittinen@fi.rohmeurope.com>
 <20180705091813.GK496@dell>
 <20180705103442.GA8426@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180705103442.GA8426@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc: mturquette@baylibre.com, robh+dt@kernel.org, mark.rutland@arm.com, lgirdwood@gmail.com, broonie@kernel.org, mazziesaccount@gmail.com, arnd@arndb.de, dmitry.torokhov@gmail.com, sre@kernel.org, chenjh@rock-chips.com, andrew.smirnov@gmail.com, linus.walleij@linaro.org, kstewart@linuxfoundation.org, heiko@sntech.de, gregkh@linuxfoundation.org, eballetbo@gmail.com, sboyd@kernel.org, linux-clk@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, mikko.mutanen@fi.rohmeurope.com, heikki.haikola@fi.rohmeurope.com
List-Id: linux-input@vger.kernel.org

On Thu, 05 Jul 2018, Matti Vaittinen wrote:

> Thanks for taking the time to check this =)
> 
> On Thu, Jul 05, 2018 at 10:18:13AM +0100, Lee Jones wrote:
> > On Thu, 05 Jul 2018, Matti Vaittinen wrote:
> > 
> > > --- a/drivers/mfd/Kconfig
> > > +++ b/drivers/mfd/Kconfig
> > > @@ -1787,6 +1787,19 @@ config MFD_STW481X
> > >  	  in various ST Microelectronics and ST-Ericsson embedded
> > >  	  Nomadik series.
> > >  
> > > +config MFD_BD71837
> > 
> > It's be nice if you prefix this with the manufacturer.  Rohm?
> 
> Like MFD_ROHM_BD71837, right? How important this is? The already applied
> regulator part has depends_on for MFD_BD71837 in Kconfig so changing
> this will require change in regulator tree too. I guess it's doable if
> this is important though =)

How can it depend on something that doesn't exist. ;)

It's better, then similar devices can be grouped.

[...]

> > > new file mode 100644
> > > index 000000000000..677097bcea17
> > > --- /dev/null
> > > +++ b/drivers/mfd/bd71837.c
> > > @@ -0,0 +1,215 @@
> > > +// SPDX-License-Identifier: GPL-2.0-or-later
> > 
> > '\n' here please.
> > > +// Copyright (C) 2018 ROHM Semiconductors
> > 
> > '\n' here please.
> 
> As an empty line after licence line? Ok.

Just '//', yes.

> > > +#include <linux/i2c.h>
> > > +#include <linux/input.h>
> > > +#include <linux/interrupt.h>
> > > +#include <linux/mfd/bd71837.h>
> > > +#include <linux/mfd/core.h>
> > > +#include <linux/module.h>
> > > +#include <linux/regmap.h>
> > > +#include <linux/gpio_keys.h>
> > 
> > Alphabetical please.
> > 
> 
> There is a problem with gpio_key.h - it uses bool but does not include
> the header defining this type. So I get comple error when compiling this
> using my GCC arm cross-compiler. I've submitted a patch to fix this but
> as it is not yet accepted.
> https://lore.kernel.org/lkml/20180627073458.GA27800@localhost.localdomain/
>  Hence the gpio_keys.h is last one.

If the ordering is important, separate it from the pack and place a
little comment in to say why you've done so.  That way no well meaning
contributor will attempt to tidy it up in the future.  If this will be
fixed anyway, perhaps the point is moot?

> > > +static struct gpio_keys_button btns[] = {
> > > +	{
> > > +		.code = KEY_POWER,
> > > +		.gpio = -1,
> > > +		.type = EV_KEY,
> > > +	},
> > > +};
> > 
> > Does this need to be an array?
> 
> https://elixir.bootlin.com/linux/v4.17-rc1/source/include/linux/gpio_keys.h#L39
> gpio_keys_platform_data documentation states the buttons to be a pointer
> to an array. Thus I did an array. Do you think I should change this to
> single struct?

I can't think of any reason why not.

> > > +static struct gpio_keys_platform_data bd718xx_powerkey_data = {
> > > +	.buttons = &btns[0],
> > 
> > Why not just "btns"?
> > 
> > Also, I don't see any reason not to just call this 'buttons'.
> > 
> > Or even, 'button' if there will only ever be one of them.
> 
> I can rename this - and if I make the array to not be an array - well,
> then the &foo[0] gets cleared too =)

Exactly.

> > > +static struct mfd_cell bd71837_mfd_cells[] = {
> > > +	{
> > > +		.name = "bd71837-clk",
> > > +	}, {
> > > +		.name = "gpio-keys",
> > > +		.platform_data = &bd718xx_powerkey_data,
> > > +		.pdata_size = sizeof(bd718xx_powerkey_data),
> > > +	}, {
> > > +		.name = "bd71837-pmic",
> > > +	},
> > > +};
> > 
> > Place the one line entries on one line, like this:
> > 
> > 	{ .name = "bd71837-pmic", },
> > 
> > ... and if ordering is not important, place them at the bottom.
> 
> I'll fix this

It's best to simply snip all the parts you agree with.

[...]

> > > +	/*
> > > +	 * According to BD71847 datasheet the HW default for long press
> > > +	 * detection is 10ms. So lets change it to 10 sec so we can actually
> > > +	 * get the short push and allow gracefull shut down
> > > +	 */
> > 
> > I don't think this comment is necessary.
> > 
> > If anything it only needs to say "Configure long press to 10 seconds".
> > 
> > And if you do that, please add one for short press too.

> Difference between short and long push is that if PMIC detects log push
> it will kill the power without any gracefull handling. And the chip I am
> supporting right now is BD71837 - which has more sane default value (10
> seconds). But I am going to add support for BD71847 - which was shipped
> to me yesterday - and according the draft data-sheet the default on it
> is 10ms - which makes short push unusable. So comment is intended to
> point out _why_ I configure the long push here. Also someone might want
> to use the HW default (I guess such default was selected for some
> specific reason) so comment helps on removing this configuration for
> specific use-cases. But I guess I can reduce the comment to "Configure
> long press to 10 seconds" as you suggested - or do you think I should
> make difference between ICs BD71837 and BD71847 more visible here?

Honestly, I don't think it's required.  If anyone were to try to
change it, I would hope that they too would have read the datasheet
and understand what they are doing.

> > > +	ret = regmap_update_bits(bd71837->regmap,
> > > +				 BD71837_REG_PWRONCONFIG1,
> > > +				 BD718XX_PWRBTN_PRESS_DURATION_MASK,
> > > +				 BD718XX_PWRBTN_LONG_PRESS_10S);
> > > +
> > > +	if (ret < 0) {
> > > +		dev_err(&i2c->dev, "Failed to configure button long press timeout\n");
> > > +		goto err_out;
> > > +	}
> > > +
> > > +	btns[0].irq = regmap_irq_get_virq(bd71837->irq_data,
> > > +					  BD71837_INT_PWRBTN_S);
> > > +
> > > +	if (btns[0].irq < 0) {
> > > +		ret = btns[0].irq;
> > > +		dev_err(&i2c->dev, "Failed to get the IRQ\n");
> > > +		goto err_out;
> > 
> > No unwinding to be done, just return directly and save yourself an
> > superflouous goto.
> 
> So should I replace _all_ the gotos by in-place returns as Enric suggested
> yesterday? As I explained yesterday, my preference is to have only one
> point of exit but I can change gotos to returns if needed.

I'm not sure where the 'one point of exit' thing stems from and I
can't think of any good reason for it.  The main reason for using a
goto in the exit path is to save lines of code and code duplication.
Your method *adds* lines of code by firstly setting 'ret', then
calling the goto.  If nothing needs to be done before returning, just
return the error value with one line.

> > > +static const struct i2c_device_id bd71837_i2c_id[] = {
> > > +	{ .name = "bd71837", },
> > > +	{ }
> > > +};
> > > +MODULE_DEVICE_TABLE(i2c, bd71837_i2c_id);
> > 
> > You shouldn't need this table anymore.
> > 
> > See da10c06a044b ("i2c: Make I2C ID tables non-mandatory for DT'ed devices")
> 
> So if I read this correctly the 
> > > +		.of_match_table = bd71837_of_match,
> is now sufficient. Thanks.

Right.

> > > +++ b/include/linux/mfd/bd71837.h
> > > @@ -0,0 +1,391 @@
> > > +/* SPDX-License-Identifier: GPL-2.0-or-later */
> > 
> > I thought these were meant to use C++ (//) comments?
> 
> The checkpatch.pl did complain if I used // comment on SPDX line for
> header file. OTOH for c-file it required // comments and complained
> about /* */ - version. So I did as it suggested and used 

Well that's just dandy -- who comes up with this stuff?

> > > +/* Copyright (C) 2018 ROHM Semiconductors */
> > > +
> > > +/*
> > > + * ROHM BD71837MWV header file
> > > + */
> > 
> > If you prefix the mentions of (BD,bd)71837 with (ROHM,rohm) then this
> > comment becomes redundant and you can remove it.
> 
> I am sorry but I am not sure what you suggest here. Do you mean I should
> add ROHM or rohm to all definitions here? I think that would make
> definitions pretty long so I would certinly need to split more lines.
> Such cange would also impact already applied patches. So maybe I
> misinterpreted your comment? And in case I did not - can this prefixing of
> types - be done as a separate patch set as it impacts to regulators and
> clk too? (clk is not yet applied so that is easy to change though).

Any lines which are already long, you can justify as not having to do
this, however I think for the filenames and function names it would
be nice if they were prefixed.

Filenames are particularly important.  That way all of the Rohm
drivers will be grouped.  Unless you can be assured that all Rohm
devices will be prefixed by 'bd', then the point is slightly mooted,
however since 'bd' doesn't really correlate with 'rohm' it's still
difficult to assume that bd* drivers are associated with Rohm -- if
you catch my drift.

For instance
 - 'wm' for Wolfson Microelectonics 
 - 'max' for Maxim
 - 'intel' for, well, you know
Etc.
 
[...]

> > > +struct bd71837_pmic;
> > > +struct bd71837_clk;
> > > +struct bd718xx_pwrkey;
> > 
> > Where are these forward declared from?
> 
> bd71837_pmic is in drivers/regulator/bd71837-regulator.c
> clk will be in clk subdevice patch that is not yet applied.
> It is pending some fixes. Pwrkey must be dropped as the power-key driver
> I originally wrote was replaced using gpio_keys instead. Should there be
> some comment explaining this? Suggestions on how to do this without
> referring to file names which are subject to change... Should I just say
> they are defined in subdevice drivers? 

I just wanted you to think about if they were really necessary.

> > > +/*
> > > + * Board platform data may be used to initialize regulators.
> > > + */
> > > +
> > > +struct bd71837_board {
> > > +	struct regulator_init_data *init_data[BD71837_REGULATOR_CNT];
> > > +	int	gpio_intr;
> > > +};
> > 
> > Where is this populated?
> > 
> Currently nowhere as I use device-tree for getting the regulator/irq
> config. This is for architectures which do not use DT - but as I don't
> have one for testing I did leave the depends_on OF. If it was populated
> I would expect it to be done in some setup code.

Please don't add code for 'what ifs'.

Please remove it and add it back when you need it.

> > > +/*
> > > + * bd71837 sub-driver chip access routines
> > > + */
> > > +
> > 
> > Please don't abstract APIs for no reason.
> > 
> > Use the regmap_* API directly instead.
> > 
> 
> Yes. This was already pointed out by Stephen Boyd. But again, as part of
> the patches (reguators) were already applied using the wrappers - I asked
> if I can remove these in separate patch set after getting this initial
> version out.

That is one of the issues with applying related patches without each
of them being reviewed first.  Applying unsuitable code is not the
correct thing to do, sorry.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
