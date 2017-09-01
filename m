From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH 2/3] input/keyboard: Add support for Dollar Cove TI
 power button
Date: Fri, 01 Sep 2017 14:09:36 +0300
Message-ID: <1504264176.25945.190.camel@linux.intel.com>
References: <20170822055710.26515-1-tiwai@suse.de>
         <20170822055710.26515-3-tiwai@suse.de> <20170831183355.GB14370@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20170831183355.GB14370@dtor-ws>
Sender: linux-acpi-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Takashi Iwai <tiwai@suse.de>
Cc: linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Mika Westerberg <mika.westerberg@linux.intel.com>, Johannes Stezenbach <js@sig21.net>, linux-input@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Thu, 2017-08-31 at 11:33 -0700, Dmitry Torokhov wrote:

> > +
> > +	ret = enable_irq_wake(irq);
> > +	if (ret)
> > +		dev_warn(dev, "Can't enable IRQ as wake source:
> > %d\n", ret);
> 
> We do not normally enable wake IRQs in probe, but instead do:
> 
> 	device_init_wakeup(&pdev->dev, true);
> 
> in probe() and then check it in suspend/resume:
> 
> 	if (device_may_wakeup(dev)) {
> 		err = enable_irq_wake(XXX->irq);
> 		if (!err)
> 			XXX->irq_wake_enabled = true;
> 	}
> 
> ...
> 
> 	if (XXX->irq_wake_enabled)

No need to duplicate a flag which IRQ core already has.

See, for example, commit
 aef3ad103a68 ("serial: core: remove unneeded irq_wake flag")

> 		disable_irq_wake(XXX->irq);
> 
> This allows userspace to inhibit wakeup, if needed.


-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
