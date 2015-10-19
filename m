From: "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH v9 2/9] Input: goodix - reset device at init
Date: Mon, 19 Oct 2015 17:52:39 +0300
Message-ID: <20151019145239.GA1526@lahna.fi.intel.com>
References: <1444663477-30062-3-git-send-email-irina.tirdea@intel.com>
 <20151012164819.GA4010@dtor-ws>
 <1F3AC3675D538145B1661F571FE1805F2F0FE432@irsmsx105.ger.corp.intel.com>
 <20151013070824.GA22304@dtor-ws>
 <1F3AC3675D538145B1661F571FE1805F2F0FE683@irsmsx105.ger.corp.intel.com>
 <20151013100724.GG1492@lahna.fi.intel.com>
 <20151014062303.GC20406@dtor-ws>
 <20151014111820.GV1492@lahna.fi.intel.com>
 <20151014134403.GA25691@lahna.fi.intel.com>
 <1F3AC3675D538145B1661F571FE1805F2F101AC0@irsmsx105.ger.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1F3AC3675D538145B1661F571FE1805F2F101AC0@irsmsx105.ger.corp.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Tirdea, Irina" <irina.tirdea@intel.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Bastien Nocera <hadess@hadess.net>, Aleksei Mamlin <mamlinav@gmail.com>, Karsten Merker <merker@debian.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>, "Purdila, Octavian" <octavian.purdila@intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "Dolca, Robert" <robert.dolca@intel.com>
List-Id: linux-input@vger.kernel.org

On Mon, Oct 19, 2015 at 02:32:24PM +0000, Tirdea, Irina wrote:
> 
> 
> > -----Original Message-----
> > From: linux-input-owner@vger.kernel.org [mailto:linux-input-owner@vger.kernel.org] On Behalf Of
> > mika.westerberg@linux.intel.com
> > Sent: 14 October, 2015 16:44
> > To: Dmitry Torokhov
> > Cc: Tirdea, Irina; Bastien Nocera; Aleksei Mamlin; Karsten Merker; linux-input@vger.kernel.org; Mark Rutland; Purdila, Octavian; linux-
> > kernel@vger.kernel.org; devicetree@vger.kernel.org
> > Subject: Re: [PATCH v9 2/9] Input: goodix - reset device at init
> > 
> > On Wed, Oct 14, 2015 at 02:18:20PM +0300, mika.westerberg@linux.intel.com wrote:
> > > On Tue, Oct 13, 2015 at 11:23:03PM -0700, Dmitry Torokhov wrote:
> > > > I understand why one might use acpi_dev_add_driver_gpios() to augment
> > > > data in ACPI, however here we have completely different issue: driver
> > > > that expects named gpios gets returned gpio that has nothing to do with
> > > > what it requested, because gpiolib acpi code always falls back to
> > > > unnamed gpio if it does not find named gpio. That can be acceptable if
> > > > driver uses the same con_id for all requests to gpiolib, but is not
> > > > working when driver supplies different con_ids.
> > >
> > > Right, the ACPI fallback ignores con_id completely and uses only the
> > > index.
> > >
> > > AFAIK there is only one driver using ACPI _CRS index method:
> > > sdhci-[acpi|pci].c. If we can convert that to use acpi_dev_add_driver_gpios()
> > > to feed names for card detection GPIOs, I think we can remove the
> > > fallback alltogether in favor of named GPIOs for ACPI.
> > 
> > Nah, there seems to be several drivers relying on this already :-/
> 
> Would it be possible to add an optional parameter to the GPIO API
> to specify whether we want to fall back to indexed GPIOs for ACPI?

I don't think it's a good idea to add ACPI specifics to generic APIs.

I went through ACPI enabled drivers calling GPIO APIs and majority of
them are doing this:

static int stk8312_gpio_probe(struct i2c_client *client)
{
        struct device *dev;
        struct gpio_desc *gpio;
        int ret;

        if (!client)
                return -EINVAL;

        dev = &client->dev;

        /* data ready gpio interrupt pin */
        gpio = devm_gpiod_get_index(dev, STK8312_GPIO, 0, GPIOD_IN);
        if (IS_ERR(gpio)) {
                dev_err(dev, "acpi gpio get index failed\n");
                return PTR_ERR(gpio);
        }

        ret = gpiod_to_irq(gpio);
        dev_dbg(dev, "GPIO resource, no:%d irq:%d\n", desc_to_gpio(gpio), ret);

        return ret;
}

We can drop all this because I2C core already handles GpioInt -> interrupt
number translation.

Few drivers are doing something more complex but I think we can still convert
them to use acpi_dev_add_driver_gpios() and eventually get rid of the whole
_CRS index lookup.
