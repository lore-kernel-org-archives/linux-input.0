From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH 3/3] ACPI / PMIC: Add opregion driver for Intel Dollar
 Cove TI PMIC
Date: Tue, 22 Aug 2017 15:08:27 +0300
Message-ID: <1503403707.25945.54.camel@linux.intel.com>
References: <20170822055710.26515-1-tiwai@suse.de>
         <20170822055710.26515-4-tiwai@suse.de>
         <1503395915.25945.48.camel@linux.intel.com> <s5ho9r7aohj.wl-tiwai@suse.de>
         <s5hefs3amsq.wl-tiwai@suse.de> <1503401841.25945.51.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1503401841.25945.51.camel@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Mika Westerberg <mika.westerberg@linux.intel.com>, Johannes Stezenbach <js@sig21.net>, linux-input@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Tue, 2017-08-22 at 14:37 +0300, Andy Shevchenko wrote:
> On Tue, 2017-08-22 at 13:01 +0200, Takashi Iwai wrote:
> > On Tue, 22 Aug 2017 12:25:12 +0200,
> > Takashi Iwai wrote:

> > > > Does it mean the register is big endian?
> > > 
> > > Good point, I need to check the original code and the values.
> > 
> > It's really big-endian, the order is hi:lo.
> > 
> > But, admittedly, the temperature code hasn't been tested, and it's
> > possibly missing something.  So I'm fine to drop that part in the
> > first version, too.
> 
> I don't know if regmap allows you to define registers with different
> sizes for same chip, perhaps it would make sense to start register
> from
> hi part (and not doing non-intuitive "- 1", or maybe "+ 1" instead)
> and
> mark it in comment that is BE16.

I have just checked datasheet, so, there are 4 pairs of BE16 registers. 

VBAT (Hi:Lo) 0x54
DIETEMP 0x56
BPTHERM 0x58
GPADC 0x5a 

So, I would create a separate address mapping for them, dropping out
that _LOW suffix and put a comment that they are BE16 since ADC has 10-
bit resolution.

Or even do a separate ADC driver under drivers/iio/adc for PMIC(s).

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
