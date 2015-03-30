From: Andrew Bresticker <abrestic-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH 1/2] Input: Add binding document for a generic ADC keypad
Date: Sun, 29 Mar 2015 21:56:03 -0700
Message-ID: <CAL1qeaHOORmp9+WUeq3ZkRp_wTKzR4L+fArgW7i3_H1XXD2e+g@mail.gmail.com>
References: <1427503398-19682-1-git-send-email-abrestic@chromium.org>
	<5516B4AB.1090805@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <5516B4AB.1090805-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
List-Id: linux-input@vger.kernel.org

On Sat, Mar 28, 2015 at 7:03 AM, Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
> On 28/03/15 00:43, Andrew Bresticker wrote:
>> Add a binding document for a generic ADC keypad.  Buttons on an ADC
>> keypad are connected in a resistor ladder to an ADC.  The binding
>> describes the mapping of ADC channel and voltage ranges to buttons.
>>
>> Signed-off-by: Andrew Bresticker <abrestic-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
>> Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
>> Cc: Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>
>> Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
>> Cc: Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>
>> Cc: Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
>
> Just thinking about this, what options do we have for how such a keypad might
> be wired.  The interesting cases are the more than one key at a time ones.
>
> If that happens, then we end up with a voltage that should allow us to
> work out which combination of keys is pressed.
>
> http://en.wikipedia.org/wiki/Resistor_ladder
>
> The binding as it stands only works for single keys being pressed at a time
> (I think!)

Right.  The binding was meant for the simplest resistor ladder case,
something like http://linksprite.com/wiki/images/d/d2/Lcd-button-ladder.png
where only a single button press can be detected.  It will also work
with the more complex resistor ladders, but will only be able to
detect if a single button is pressed.

> Do we want to make it flexible enough to cope with multiple keys?
> I guess we'd need to model the common resistor ladder forms and provide
> a way of specifying the different setups in the device tree.

Given that the hardware I'm dealing with doesn't support this, I'd
prefer to leave it as a possible future extension :).  That said, one
way to do this would be to specify a table mapping the possible
combinations to voltages in the DT, though that table would grow
exponentially.  Another way would be to describe the circuit (R-2R,
logarithmic, etc.) with resistor values in the DT and then have the
driver do the math.

Thanks,
Andrew
