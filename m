From: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 1/4] input: Add new sun4i-lradc-keys drivers
Date: Thu, 02 Jan 2014 23:36:33 +0100
Message-ID: <52C5E9F1.9010700@redhat.com>
References: <1388604610-20380-1-git-send-email-hdegoede@redhat.com> <20140101205603.GA1141@core.coreip.homeip.net> <52C5336B.9010903@redhat.com> <1700375.GaI3zFl6RI@phil> <52C56D79.1060506@redhat.com> <20140102202022.GK3144@lukather>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Return-path: <linux-sunxi+bncBDL4X2GMZUKRBBWUS6LAKGQES6B2WBQ-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
In-Reply-To: <20140102202022.GK3144@lukather>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
To: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: =?ISO-8859-1?Q?Heiko_St=FCbner?= <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>
List-Id: linux-input@vger.kernel.org

Hi,

On 01/02/2014 09:20 PM, Maxime Ripard wrote:
> On Thu, Jan 02, 2014 at 02:45:29PM +0100, Hans de Goede wrote:
>>> Also, instead of inventing yet another vendor-specific property, why not re-use
>>> a button binding similar to gpio-keys like:
>>>
>>>         lradc: lradc@01c22800 {
>>>                 compatible = "allwinner,sun4i-lradc-keys";
>>>                 reg = <0x01c22800 0x100>;
>>>                 interrupts = <31>;
>>>                 allwinner,chan0-step = <200>;
>>>
>>> 		#address-cells = <1>;
>>> 		#size-cells = <0>;
>>>
>>> 		button@0 {
>>> 			reg = <0>; /* your channel index from above */
>>> 			linux,code = <115>; /* already used as dt-property */
>>> 		};
>>>
>>> 		button@1 {
>>> 			reg = <1>;
>>> 			linux,code = <114>;
>>> 		};
>>
>> Ugh no. Having a vendor specific property which is KISS certainly
>> beats this, both wrt ease of writing dts files as well as wrt the
>> dts parsing code in the driver.
>
> I'd agree with Heiko here. This is pretty much the same construct
> that's already in use in other input drivers, like gpio-keys.

In the gpio case there is a 1 on 1 relation between a single hw
entity (the gpio-pin) and a single keycode. Here there is 1 hw entity
which maps to an array of key-codes, certainly using an array rather
then a much more complicated construct is the correct data-structure
to represent this.

>
> This is also something that can really easily be made generic, since
> this is something that is rather common.
>
> Speaking of which. I believe this should actually come in two
> different drivers:
>    - The ADC driver itself, using IIO
>    - A generic button handler driver on top of IIO.
 >
 > The fact that on most board this adc is used for buttons doesn't make
 > any difference, it's actually a hardware designer choice, we should
 > support that choice, but we should also be able to use it just as an
 > ADC.

No, this is not a generic adc, as mentioned in the commit msg, this
adc is specifically designed to be used this way.

The adc won't start sampling data, and won't generate any interrupts
until a button is pressed. That is until the input voltage drops below
2/3 of Vref, this is checked through a built-in analog comparator, which
hooks into the control logic.

It has button down and button up interrupts, and can detect long
presses (unused) and generate a second type of down interrupt for those.

This really is an input device, which happens to use an adc.

> Carlo Caione already started to work on an IIO driver for the LRADC:
> https://github.com/carlocaione/linux/tree/sunxi-lradc
> maybe you can take over his work.

That won't work because the adc won't sample if the input gets above
2/3 of Vref. There may be some other mode which does not do that, but
that is not clearly documented.

Even if an IIO driver turns out to be doable, I strongly believe that
having a separate input driver for this is best, since this device
was designed to be used as such. Building input on top of IIO would
mean polling the adc, while with my driver it actually generates
button down / up interrupts without any polling being involved.

And no boards I know of are using this as a generic analog input,
where as many boards are using it as designed.

Regards,

Hans
