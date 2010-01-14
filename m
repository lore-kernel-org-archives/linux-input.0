From: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v2] Input: ad7879: support
	auxiliary GPIOs via gpiolib
Date: Wed, 13 Jan 2010 22:24:31 -0800
Message-ID: <20100114062430.GA26078@core.coreip.homeip.net>
References: <20100107073114.GC2314@core.coreip.homeip.net>
	<1263330297-1387-1-git-send-email-vapier@gentoo.org>
	<20100113025456.GA2301@core.coreip.homeip.net>
	<8A42379416420646B9BFAC9682273B6D0F0DF094@limkexm3.ad.analog.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <uclinux-dist-devel-bounces-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <8A42379416420646B9BFAC9682273B6D0F0DF094-pcKY8lWzTjquVPpjEGsWsTcYPEmu4y7e@public.gmane.org>
List-Unsubscribe: <https://blackfin.uclinux.org/mailman/options/uclinux-dist-devel>,
	<mailto:uclinux-dist-devel-request-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org?subject=unsubscribe>
List-Archive: <http://blackfin.uclinux.org/pipermail/uclinux-dist-devel>
List-Post: <mailto:uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org>
List-Help: <mailto:uclinux-dist-devel-request-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org?subject=help>
List-Subscribe: <https://blackfin.uclinux.org/mailman/listinfo/uclinux-dist-devel>,
	<mailto:uclinux-dist-devel-request-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org?subject=subscribe>
Sender: uclinux-dist-devel-bounces-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org
Errors-To: uclinux-dist-devel-bounces-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org
To: "Hennerich, Michael" <Michael.Hennerich-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>
Cc: uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org, Mike Frysinger <vapier-aBrp7R+bbdUdnm+yROfE0A@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Wed, Jan 13, 2010 at 09:46:42AM +0000, Hennerich, Michael wrote:
> >From: Dmitry Torokhov [mailto:dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org]
> >
> >Hi Mike,
> >
> >On Tue, Jan 12, 2010 at 04:04:57PM -0500, Mike Frysinger wrote:
> >> +
> >> +		err = gpiochip_add(&ts->gc);
> >> +		if (err)
> >> +			dev_err(&bus->dev, "failed to register gpio
> %d\n",
> >> +				ts->gc.base);
> >> +	}
> >
> >So if it fails here...
> >
> >> +	struct ad7879_platform_data *pdata = bus->dev.platform_data;
> >> +	if (pdata->gpio_export) {
> >> +		if (gpiochip_remove(&ts->gc))
> >> +			dev_err(&bus->dev, "failed to remove gpio %d\n",
> >> +				ts->gc.base);
> >
> >... how valid is it to remove it here?
> 
> Right - I should use a flag to sense whether the gpiochip was added or
> not.

Another option would be to simply abort loading the driver, I don't have
a strong preference.

> 
> >
> >Also, could you stub out
> >ad7879_gptiochip_export/ad7879_gptiochip_unexport
> >in case of !CONFIG_GPIOLIB?
> 
> Can you explain - where do you see those?
> 

Sorry for not being clear. I was proposing to move the gpio export code
into new functions (and those were suggested name) and stub them out in
case gpiolib is configured out.

-- 
Dmitry
