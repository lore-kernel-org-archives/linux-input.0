From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v9 2/9] Input: goodix - reset device at init
Date: Fri, 30 Oct 2015 09:33:28 -0700
Message-ID: <20151030163328.GA17589@dtor-pixel>
References: <20151012164819.GA4010@dtor-ws>
 <1F3AC3675D538145B1661F571FE1805F2F0FE432@irsmsx105.ger.corp.intel.com>
 <20151013070824.GA22304@dtor-ws>
 <1F3AC3675D538145B1661F571FE1805F2F0FE683@irsmsx105.ger.corp.intel.com>
 <20151013100724.GG1492@lahna.fi.intel.com>
 <20151014062303.GC20406@dtor-ws>
 <20151014111820.GV1492@lahna.fi.intel.com>
 <20151014134403.GA25691@lahna.fi.intel.com>
 <1F3AC3675D538145B1661F571FE1805F2F101AC0@irsmsx105.ger.corp.intel.com>
 <20151019145239.GA1526@lahna.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20151019145239.GA1526@lahna.fi.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>
Cc: "Tirdea, Irina" <irina.tirdea@intel.com>, Bastien Nocera <hadess@hadess.net>, Aleksei Mamlin <mamlinav@gmail.com>, Karsten Merker <merker@debian.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>, "Purdila, Octavian" <octavian.purdila@intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "Dolca, Robert" <robert.dolca@intel.com>
List-Id: linux-input@vger.kernel.org

On Mon, Oct 19, 2015 at 05:52:39PM +0300, mika.westerberg@linux.intel.com wrote:
> On Mon, Oct 19, 2015 at 02:32:24PM +0000, Tirdea, Irina wrote:
> > 
> > 
> > > -----Original Message-----
> > > From: linux-input-owner@vger.kernel.org [mailto:linux-input-owner@vger.kernel.org] On Behalf Of
> > > mika.westerberg@linux.intel.com
> > > Sent: 14 October, 2015 16:44
> > > To: Dmitry Torokhov
> > > Cc: Tirdea, Irina; Bastien Nocera; Aleksei Mamlin; Karsten Merker; linux-input@vger.kernel.org; Mark Rutland; Purdila, Octavian; linux-
> > > kernel@vger.kernel.org; devicetree@vger.kernel.org
> > > Subject: Re: [PATCH v9 2/9] Input: goodix - reset device at init
> > > 
> > > On Wed, Oct 14, 2015 at 02:18:20PM +0300, mika.westerberg@linux.intel.com wrote:
> > > > On Tue, Oct 13, 2015 at 11:23:03PM -0700, Dmitry Torokhov wrote:
> > > > > I understand why one might use acpi_dev_add_driver_gpios() to augment
> > > > > data in ACPI, however here we have completely different issue: driver
> > > > > that expects named gpios gets returned gpio that has nothing to do with
> > > > > what it requested, because gpiolib acpi code always falls back to
> > > > > unnamed gpio if it does not find named gpio. That can be acceptable if
> > > > > driver uses the same con_id for all requests to gpiolib, but is not
> > > > > working when driver supplies different con_ids.
> > > >
> > > > Right, the ACPI fallback ignores con_id completely and uses only the
> > > > index.
> > > >
> > > > AFAIK there is only one driver using ACPI _CRS index method:
> > > > sdhci-[acpi|pci].c. If we can convert that to use acpi_dev_add_driver_gpios()
> > > > to feed names for card detection GPIOs, I think we can remove the
> > > > fallback alltogether in favor of named GPIOs for ACPI.
> > > 
> > > Nah, there seems to be several drivers relying on this already :-/
> > 
> > Would it be possible to add an optional parameter to the GPIO API
> > to specify whether we want to fall back to indexed GPIOs for ACPI?
> 
> I don't think it's a good idea to add ACPI specifics to generic APIs.
> 
> I went through ACPI enabled drivers calling GPIO APIs and majority of
> them are doing this:
> 
> static int stk8312_gpio_probe(struct i2c_client *client)
> {
>         struct device *dev;
>         struct gpio_desc *gpio;
>         int ret;
> 
>         if (!client)
>                 return -EINVAL;
> 
>         dev = &client->dev;
> 
>         /* data ready gpio interrupt pin */
>         gpio = devm_gpiod_get_index(dev, STK8312_GPIO, 0, GPIOD_IN);
>         if (IS_ERR(gpio)) {
>                 dev_err(dev, "acpi gpio get index failed\n");
>                 return PTR_ERR(gpio);
>         }
> 
>         ret = gpiod_to_irq(gpio);
>         dev_dbg(dev, "GPIO resource, no:%d irq:%d\n", desc_to_gpio(gpio), ret);
> 
>         return ret;
> }
> 
> We can drop all this because I2C core already handles GpioInt -> interrupt
> number translation.
> 
> Few drivers are doing something more complex but I think we can still convert
> them to use acpi_dev_add_driver_gpios() and eventually get rid of the whole
> _CRS index lookup.

cpi_dev_add_driver_gpios() does not really help with generic drivers
(unless we keep adding more and more board specific data to them). How
about we keep track of names used and only allow conversion for the
first name used, like in the patch below?

-- 
Dmitry

gpiolib: tighten up ACPI legacy gpio lookups

From: Dmitry Torokhov <dmitry.torokhov@gmail.com>

We should not fall back to the legacy unnamed gpio lookup style if the
driver requests gpios with different names, because we'll give out the same
gpio twice. Let's keep track of the names that were used for the device and
only do the fallback for the first name used.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/gpio/gpiolib.c |   42 +++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 41 insertions(+), 1 deletion(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 5db3445..4ae5447 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -1738,6 +1738,45 @@ static struct gpio_desc *of_find_gpio(struct device *dev, const char *con_id,
 	return desc;
 }
 
+struct acpi_gpio_lookup {
+	struct list_head node;
+	struct device *dev;
+	const char *con_id;
+};
+
+static DEFINE_MUTEX(acpi_gpio_lookup_lock);
+static LIST_HEAD(acpi_gpio_lookup_list);
+
+static bool acpi_can_fallback_crs(struct device *dev, const char *con_id)
+{
+	struct acpi_gpio_lookup *l, *lookup = NULL;
+
+	mutex_lock(&acpi_gpio_lookup_lock);
+
+	list_for_each_entry(l, &acpi_gpio_lookup_list, node) {
+		if (l->dev == dev) {
+			lookup = l;
+			break;
+		}
+	}
+
+	if (!lookup) {
+		lookup = kmalloc(sizeof(*lookup), GFP_KERNEL);
+		if (lookup) {
+			lookup->dev = dev;
+			lookup->con_id = con_id;
+			list_add_tail(&lookup->node, &acpi_gpio_lookup_list);
+		}
+	}
+
+	mutex_lock(&acpi_gpio_lookup_lock);
+
+	return lookup &&
+		((!lookup->con_id && !con_id) ||
+		 (lookup->con_id && con_id &&
+		  strcmp(lookup->con_id, con_id) == 0));
+}
+
 static struct gpio_desc *acpi_find_gpio(struct device *dev, const char *con_id,
 					unsigned int idx,
 					enum gpio_lookup_flags *flags)
@@ -1765,7 +1804,8 @@ static struct gpio_desc *acpi_find_gpio(struct device *dev, const char *con_id,
 
 	/* Then from plain _CRS GPIOs */
 	if (IS_ERR(desc)) {
-		desc = acpi_get_gpiod_by_index(adev, NULL, idx, &info);
+		if (acpi_can_fallback_crs(dev, con_id))
+			desc = acpi_get_gpiod_by_index(adev, NULL, idx, &info);
 		if (IS_ERR(desc))
 			return desc;
 	}
