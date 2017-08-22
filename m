From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH 3/3] ACPI / PMIC: Add opregion driver for Intel Dollar
 Cove TI PMIC
Date: Tue, 22 Aug 2017 14:37:21 +0300
Message-ID: <1503401841.25945.51.camel@linux.intel.com>
References: <20170822055710.26515-1-tiwai@suse.de>
         <20170822055710.26515-4-tiwai@suse.de>
         <1503395915.25945.48.camel@linux.intel.com> <s5ho9r7aohj.wl-tiwai@suse.de>
         <s5hefs3amsq.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <s5hefs3amsq.wl-tiwai@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Mika Westerberg <mika.westerberg@linux.intel.com>, Johannes Stezenbach <js@sig21.net>, linux-input@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Tue, 2017-08-22 at 13:01 +0200, Takashi Iwai wrote:
> On Tue, 22 Aug 2017 12:25:12 +0200,
> Takashi Iwai wrote:
> > 
> > On Tue, 22 Aug 2017 11:58:35 +0200,
> > Andy Shevchenko wrote:
> > > 
> > > On Tue, 2017-08-22 at 07:57 +0200, Takashi Iwai wrote:
> > > > This patch adds the opregion driver for Dollar Cove TI PMIC on
> > > > Intel
> > > > Cherry Trail devices.  The patch is based on the original work
> > > > by
> > > > Intel, found at:
> > > >       https://github.com/01org/ProductionKernelQuilts
> > > > with many cleanups and rewrites.
> > > > 
> > > > The driver is currently provided only as built-in to follow
> > > > other
> > > > PMIC opregion drivers convention.
> > > > 
> > > > The re-enumeration of devices at probe is required for fixing
> > > > the
> > > > issues on HP x2 210 G2.  See bug#195689.
> > > > 
> > > > 
> > > > +static int dc_ti_pmic_get_raw_temp(struct regmap *regmap, int
> > > > reg)
> > > > +{
> > > > +	int temp_l, temp_h;
> > > > +
> > > > +	if (regmap_read(regmap, reg, &temp_l) ||
> > > > +	    regmap_read(regmap, reg - 1, &temp_h))
> > > > +		return -EIO;
> > > > +
> > > > +	return temp_l | (temp_h & 0x3) << 8;
> > > > +}
> > > 
> > > I'm not sure I understand this "- 1" part along with choice of l
> > > and h
> > > suffixes.
> > > 
> > > Does it mean the register is big endian?
> > 
> > Good point, I need to check the original code and the values.
> 
> It's really big-endian, the order is hi:lo.
> 
> But, admittedly, the temperature code hasn't been tested, and it's
> possibly missing something.  So I'm fine to drop that part in the
> first version, too.

I don't know if regmap allows you to define registers with different
sizes for same chip, perhaps it would make sense to start register from
hi part (and not doing non-intuitive "- 1", or maybe "+ 1" instead) and
mark it in comment that is BE16.

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
