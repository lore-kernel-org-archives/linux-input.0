From: "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH v9 2/9] Input: goodix - reset device at init
Date: Tue, 13 Oct 2015 13:07:24 +0300
Message-ID: <20151013100724.GG1492@lahna.fi.intel.com>
References: <1444663477-30062-1-git-send-email-irina.tirdea@intel.com>
 <1444663477-30062-3-git-send-email-irina.tirdea@intel.com>
 <20151012164819.GA4010@dtor-ws>
 <1F3AC3675D538145B1661F571FE1805F2F0FE432@irsmsx105.ger.corp.intel.com>
 <20151013070824.GA22304@dtor-ws>
 <1F3AC3675D538145B1661F571FE1805F2F0FE683@irsmsx105.ger.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1F3AC3675D538145B1661F571FE1805F2F0FE683@irsmsx105.ger.corp.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Tirdea, Irina" <irina.tirdea@intel.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Bastien Nocera <hadess@hadess.net>, Aleksei Mamlin <mamlinav@gmail.com>, Karsten Merker <merker@debian.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>, "Purdila, Octavian" <octavian.purdila@intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

On Tue, Oct 13, 2015 at 08:54:12AM +0000, Tirdea, Irina wrote:
> > > I did not use devm_gpiod_get_optional() in order to ignore more errors
> > > than -ENOENT. This is needed because the ACPI gpio core will fall back
> > > to indexed gpios if named gpios are not found. In the common case of
> > > having 2 indexed gpio pins declared in the ACPI table, the first
> > > devm_gpiod_get() will successfully get indexed gpio pin 0 and the
> > > second devm_gpiod_get() will try to get the same gpio pin 0 and return
> > > -EBUSY. Considering this, I thought it is better to just ignore all errors in
> > > order not to break any platforms currently using this driver.
> > 
> > This seems like issue with ACPI gpio lookup implementation. If I am
> > requesting named gpio and it is not present then I definitely do not
> > need to be returned some random gpio. Doing so breaks all other drivers
> > that use several names to retrieve GPIOs. We basically can't trust GPIO
> > API on ACPI systems.
> > 
> 
> I'm not sure there is a way to avoid fall back to indexed gpios when requesting
> named gpios.
> Adding Mika to this thread as he might help answer this.

Before ACPI 5.1 _DSD device properties were introduced all we had was an
array of GPIOs returned by _CRS ACPI method. Ordering of those GPIOs
could change from one vendor to another :-(

We can (and do) use acpi_dev_add_driver_gpios() to pass correct mappings
where _DSD is not present based on the device ACPI ID for instance. Not
all drivers do that, though.

I would like to get rid of the fallback completely at some point. We
have had already problems with the API because then some ACPI only
drivers did this:

	reset_gpio = gpiod_get_index(dev, NULL, 0);
	power_gpio = gpiod_get_index(dev, NULL, 1);

which might not do what is expected on DT systems. That's why
acpi_dev_add_driver_gpios() was added in the first place IIRC.
