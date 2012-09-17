From: "Patil, Rachna" <rachna-l0cyMroinI0@public.gmane.org>
Subject: RE: [PATCH v3 4/5] IIO : ADC: tiadc: Add support of TI's ADC driver
Date: Mon, 17 Sep 2012 06:11:53 +0000
Message-ID: <4CE347531D4CA947960AF71FF095B9323E954363@DBDE01.ent.ti.com>
References: <1347532819-505-1-git-send-email-rachna@ti.com>
 <1347532819-505-5-git-send-email-rachna@ti.com>
 <5051CDEA.5080200@kernel.org>
 <4CE347531D4CA947960AF71FF095B9323E953D32@DBDE01.ent.ti.com>
 <5052E8E9.4030206@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <5052E8E9.4030206-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Content-Language: en-US
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Dmitry Torokhov <dtor-JGs/UdohzUI@public.gmane.org>
List-Id: linux-input@vger.kernel.org

On Fri, Sep 14, 2012 at 13:50:57, Jonathan Cameron wrote:
> On 14/09/12 07:00, Patil, Rachna wrote:
> > On Thu, Sep 13, 2012 at 17:43:30, Jonathan Cameron wrote:
> >> On 13/09/12 11:40, Patil, Rachna wrote:
> >>> This patch adds support for TI's ADC driver.
> >>> This is a multifunctional device.
> >>> Analog input lines are provided on which voltage measurements can be 
> >>> carried out.
> >>> You can have upto 8 input lines.
> >>>
> >>> Signed-off-by: Patil, Rachna <rachna-l0cyMroinI0@public.gmane.org>
> >>
> >> There's a little fuzz in applying this due to other drivers that have gone in recently.
> >>
> >> Actually this is going to be 'interesting' to merge. Dmitry, Samuel thoughts on who takes this one and how?  Maybe this is a case for a 'special' branch pulled into more than one tree?
> >>
> >>
> >> One minor thing inline.  I have an aversion to dynamic allocation of 
> >> things that are then constant.
> >>
> >> Also the module name is simply ti_adc. Does seem a little 'vague'
> >> given the range of ADC's TI makes :)  Perhaps keep the reference to 
> >> the tsc in there?  Personally I'd have preferred the whole thing 
> >> being named after a particular part number (any one it support would
> >> do) to avoid a clash in future with a new touch screen adc from TI.
> >> Bit late for that though I guess ;)
> >
> > Yes, true.
> > TI definitely might come up with more IP's of this type.
> > This IP(TSC / ADC) is present on AM335x. If necessary we can rename the driver to ti_am335x_XXX.
> I'd be in favour of doing this now rather than when the problem presents itself.  Anyone mind?

I will also rename the touchscreen and the MFD driver to reflect the same.

<SNIP>

Regards,
Rachna
