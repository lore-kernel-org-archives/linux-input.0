From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v3 2/3] Input: gpio_keys - convert to use devm_*
Date: Mon, 28 Apr 2014 12:40:43 +0300
Message-ID: <1398678043.11914.284.camel@smile.fi.intel.com>
References: <1398442937-15309-1-git-send-email-andriy.shevchenko@linux.intel.com>
	 <1398442937-15309-3-git-send-email-andriy.shevchenko@linux.intel.com>
	 <20140426044346.GB27425@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20140426044346.GB27425@core.coreip.homeip.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Fri, 2014-04-25 at 21:43 -0700, Dmitry Torokhov wrote:
> On Fri, Apr 25, 2014 at 07:22:16PM +0300, Andy Shevchenko wrote:
> > This makes the error handling much more simpler than open-coding everything and
> > in addition makes the probe function smaller an tidier.

[]

> > -	pdata = kzalloc(sizeof(*pdata) + nbuttons * (sizeof *button),
> > -			GFP_KERNEL);
> > -	if (!pdata) {
> > -		error = -ENOMEM;
> > -		goto err_out;
> > -	}
> > +	pdata = devm_kzalloc(dev, sizeof(*pdata), GFP_KERNEL);
> > +	if (!pdata)
> > +		return ERR_PTR(-ENOMEM);
> > +
> > +	pdata->buttons = devm_kcalloc(dev, nbuttons, sizeof (*button),
> > +				      GFP_KERNEL);
> > +	if (!pdata->buttons)
> > +		return ERR_PTR(-ENOMEM);
> 
> Why are we splitting the allocation in 2?

Just for logical distinguishing, but I'm okay with one allocation.

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
