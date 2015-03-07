From: Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v7 1/8] ARM: dt: Binding documentation for imx25 ADC/TSC
Date: Sat, 07 Mar 2015 18:07:24 +0000
Message-ID: <54FB3E5C.7080803@kernel.org>
References: <1425369498-25541-1-git-send-email-mpa@pengutronix.de> <1425369498-25541-2-git-send-email-mpa@pengutronix.de> <2620642.Qp1W4O8uh6@wuerfel> <20150305071252.GA8062@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150305071252.GA8062-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Markus Pargmann <mpa-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Cc: Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Fabio Estevam <festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Peter Meerwald <pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org>, Hartmut Knaack <knaack.h-Mmb7MZpHnFY@public.gmane.org>, Denis Carikli <denis-fO0SIAKYzcbQT0dZR+AlfA@public.gmane.org>, =?UTF-8?B?RXJpYyBCw6luYXJk?= <eric-fO0SIAKYzcbQT0dZR+AlfA@public.gmane.org>, Sascha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
List-Id: linux-input@vger.kernel.org

On 05/03/15 07:12, Markus Pargmann wrote:
> Hi,
> 
> On Tue, Mar 03, 2015 at 10:02:12AM +0100, Arnd Bergmann wrote:
>> On Tuesday 03 March 2015 08:58:11 Markus Pargmann wrote:
>>> +Example:
>>> +       tscadc: tscadc@50030000 {
>>> +               compatible = "fsl,imx25-tsadc";
>>> +               reg = <0x50030000 0xc>;
>>> +               interrupts = <46>;
>>> +               clocks = <&clks 119>;
>>> +               clock-names = "ipg";
>>> +               interrupt-controller;
>>> +               #interrupt-cells = <1>;
>>> +               #address-cells = <1>;
>>> +               #size-cells = <1>;
>>> +               ranges;
>>> +
>>> +               tsc: tcq@50030400 {
>>> +                       compatible = "fsl,imx25-tcq";
>>> +                       reg = <0x50030400 0x60>;
>>> +                       ...
>>> +               };
>>> +
>>> +               adc: gcq@50030800 {
>>> +                       compatible = "fsl,imx25-gcq";
>>> +                       reg = <0x50030800 0x60>;
>>> +                       ...
>>> +               };
>>> +       };
>>>
>>
>> I wonder if we should just treat this MFD as a single IIO device
>> that also registers to the input layer.
>>
>> Are there any other registers in the 0x50030000-0x50031000
>> range, or could the fsl,imx25-tcq and fsl,imx25-gcq devices
>> be reused outside of a fsl,imx25-tsadc device?
> 
> There are no other registers in this range. The tcq and gcq devices can
> not be used outside of the tsadc. gcq and tcq are identical units so it
> may work to use both of them as gcq for example but nothing else.
> 
> It may work to have this as single IIO device. However this would be a
> major rework of this series. There are a lot less users of imx25 than
> imx6 for example. And of these users barely anyone uses this unit at
> all. I really would like to get these drivers mainline so others can use
> it. But after 1 year and 7 versions of this series I don't want to put
> a lot of work into these drivers. I think there are other components in
> the kernel where the time is better used.
> 
> Best Regards,
> 
> Markus
> 
I was pretty much against the IIO driver registering with input at least
where it was vaguely separable.  Pushed a few drivers in this direction.
Slightly more code, but often these devices are pretty separable (even
if like here it's two identical hardware blocks) and we normally get
a whole chunk of touch screen specific magic hardware that isn't of
general use.

It would be lovely to try and generalize some of this stuff and have
the touchscreen driver act as a client of IIO, but the
hardware is too fiddly for it to be obvious how to do it so far.

Jonathan
