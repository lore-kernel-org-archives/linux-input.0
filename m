From: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Subject: Re: [PATCH v7 4/4] input/power: Add driver for BD71837/BD71847 PMIC
 power button
Date: Thu, 21 Jun 2018 13:25:47 +0300
Message-ID: <20180621102547.GA6076@localhost.localdomain>
References: <cover.1529404894.git.matti.vaittinen@fi.rohmeurope.com>
 <af60857c6db5fcf14fbf0112f74719d898952459.1529404894.git.matti.vaittinen@fi.rohmeurope.com>
 <20180619175028.GA71788@dtor-ws>
 <20180620064316.GB28784@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180620064316.GB28784@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com, lee.jones@linaro.org, lgirdwood@gmail.com, broonie@kernel.org, mazziesaccount@gmail.com, arnd@arndb.de, sre@kernel.org, chenjh@rock-chips.com, andrew.smirnov@gmail.com, linus.walleij@linaro.org, kstewart@linuxfoundation.org, heiko@sntech.de, gregkh@linuxfoundation.org, linux-clk@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, mikko.mutanen@fi.rohmeurope.com, heikki.haikola@fi.rohmeurope.com
List-Id: linux-input@vger.kernel.org

On Wed, Jun 20, 2018 at 09:43:16AM +0300, Matti Vaittinen wrote:
> On Tue, Jun 19, 2018 at 10:50:28AM -0700, Dmitry Torokhov wrote:
> > Hi Matti,
> > 
> > On Tue, Jun 19, 2018 at 01:57:09PM +0300, Matti Vaittinen wrote:
> > > ROHM BD71837 PMIC power button driver providing power-key press
> > > information to user-space.
> > > 
> > > Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
> > > ---
> > >  drivers/input/misc/Kconfig          | 10 +++++
> > >  drivers/input/misc/Makefile         |  1 +
> > >  drivers/input/misc/bd718xx-pwrkey.c | 90 +++++++++++++++++++++++++++++++++++++
> > >  3 files changed, 101 insertions(+)
> > >  create mode 100644 drivers/input/misc/bd718xx-pwrkey.c
> > > 
> > > +	platform_set_drvdata(pdev, pk);
> > > +	err = regmap_update_bits(pk->mfd->regmap,
> > > +				 BD71837_REG_PWRONCONFIG0,
> > > +				 BD718XX_PWRBTN_SHORT_PRESS_MASK,
> > > +				 BD718XX_PWRBTN_SHORT_PRESS_10MS);
> > 
> > This seems to be the only custom bit of set up in the driver, the rest I
> > think can easily be handled by gpio-keys.c in interrupt-only mode. Maybe
> > we could move this into MFD piece and drop this driver?

I did following in MFD driver - is this what you suggested:
+static struct gpio_keys_button btns[] = {
+       {
+               .code = KEY_POWER,
+               .gpio = -1,
+               .type = EV_KEY,
+       },
+};
+
+static struct gpio_keys_platform_data bd718xx_powerkey_data = {
+       .buttons = &btns[0],
+       .nbuttons = ARRAY_SIZE(btns),
+       .name = "bd718xx-pwrkey",
+};
+
+/* bd71837 multi function cells */
+
+static struct mfd_cell bd71837_mfd_cells[] = {
+       {
+               .name = "bd71837-clk",
+       }, {
+               .name = "gpio-keys",
+               .platform_data = &bd718xx_powerkey_data,
+               .pdata_size = sizeof(bd718xx_powerkey_data),
+       }, {

//snip

+static int bd71837_i2c_probe(struct i2c_client *i2c,
+                           const struct i2c_device_id *id)
+{

// snip

+       ret = regmap_add_irq_chip(bd71837->regmap, bd71837->chip_irq,
+               IRQF_ONESHOT, 0,
+               &bd71837_irq_chip, &bd71837->irq_data);
+       if (ret < 0) {
+               dev_err(bd71837->dev, "Failed to add irq_chip %d\n", ret);
+               goto err_out;
+       }
+       /* I think this should be done conditionally and only when pwrkey is used
+        * What would be the correct way to decide if we want to touch rhw button
+        * press detection times?
+        */
+       ret = regmap_update_bits(bd71837->regmap,
+                                BD71837_REG_PWRONCONFIG0,
+                                BD718XX_PWRBTN_PRESS_DURATION_MASK,
+                                BD718XX_PWRBTN_SHORT_PRESS_10MS);
+       if (ret < 0) {
+               dev_err(bd71837->dev, "Failed to configure button short press timeout %d\n", ret);
+               goto err_out;
+       }
+       /* According to BD71847 datasheet the HW default for long press detection
+        * is 10ms. So letch change it to 10 sec so we can actually get the short
+        * push and allow gracefull shut down
+        */
+       ret = regmap_update_bits(bd71837->regmap,
+                                BD71837_REG_PWRONCONFIG1,
+                                BD718XX_PWRBTN_PRESS_DURATION_MASK,
+                                BD718XX_PWRBTN_LONG_PRESS_10S);
+       if (ret < 0) {
+               dev_err(bd71837->dev, "Failed to configure button long press timeout %d\n", ret);
+               goto err_out;
+       }
+       btns[0].irq = regmap_irq_get_virq(bd71837->irq_data,
+                                         BD71837_INT_PWRBTN_S);
+
+       if (btns[0].irq < 0) {
+               ret = btns[0].irq;
+               goto err_out;
+       }
+
+       ret = mfd_add_devices(bd71837->dev, PLATFORM_DEVID_AUTO,
+                             bd71837_mfd_cells, ARRAY_SIZE(bd71837_mfd_cells),
+                             NULL, 0,
+                             regmap_irq_get_domain(bd71837->irq_data));

If looks is Ok I will send new patch with this approach at next week -
unless I get lost during the traditional midsummer festival here in
Finland.

> Finally, there may be cases when power button is not attached to PMIC
> or is needing different configuration for 'short push'. This is why I
> would prefer having own Kconfig option for this power-key driver. I am
> not sure if it is easily doable if we use gpio_keys?

What would be the preferred mechanism for skipping the button push duration
configurations (time it takes for PMIC to detect short or long push)? Or
setting the durations to values user(s) would prefer? To me this sounds again
something we could configure from DT. Would adding propereties
rohm,short-press-ms and rohm,long-press-ms sound reasonable? I will send
the first version with no option to skip/specify the configuration
(fixed 10ms for short press, 10 sec for long press) but I would like to add
support for specifying the duration as next step.

Br,
	Matti Vaittinen
