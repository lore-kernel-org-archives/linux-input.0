From: Seth Forshee <seth.forshee@canonical.com>
Subject: Re: [PATCH] Input: synaptics - reject out of range position values
Date: Thu, 7 Jun 2012 14:56:58 -0500
Message-ID: <20120607195658.GB15138@thinkpad-t410>
References: <1337353224-12333-1-git-send-email-seth.forshee@canonical.com>
 <20120606153538.GC23884@thinkpad-t410>
 <CAGS+omBQ0PLvjRFVWrSSm1v3fegO5V968s7kLT3hGj3+Bhoebg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:35595 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750743Ab2FGT5D (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 7 Jun 2012 15:57:03 -0400
Content-Disposition: inline
In-Reply-To: <CAGS+omBQ0PLvjRFVWrSSm1v3fegO5V968s7kLT3hGj3+Bhoebg@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Daniel Kurtz <djkurtz@chromium.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org

On Fri, Jun 08, 2012 at 12:56:39AM +0800, Daniel Kurtz wrote:
> On Wed, Jun 6, 2012 at 11:35 PM, Seth Forshee
> <seth.forshee@canonical.com> wrote:
> > Ping. Any problem with this patch?
> >
> > On Fri, May 18, 2012 at 10:00:24AM -0500, Seth Forshee wrote:
> >> The synaptics touchpad on the Acer Aspire One D250 will report y
> >> coordinate values in excess of 8000 near the bottom of the touchpad,
> >> well outside of the range of values that the synaptics documentation
> >> says should be reported.
> >>
> >> In addition, the y values abruptly change from very low values to these
> >> very high values. After the calculation to invert the y coordinates,
> >> userspace gets y coordinates that can jump suddenly between large
> >> positive and moderately large negative values, causing sudden jumps in
> >> the pointer position.
> >>
> >> To work around this odd behavior, reject any coordinates with values
> >> outside of absolute limits specified by Synaptics, which is 6143 for
> >> both axes.
> >>
> >> BugLink: http://bugs.launchpad.net/bugs/1001251
> >> Cc: stable@vger.kernel.org
> >> Signed-off-by: Seth Forshee <seth.forshee@canonical.com>
> >> ---
> >> I'm not sure whether the limits here should be the hard-coded value or
> >> the coordinates reported by the device when that's supported (i.e.
> >> whether the coordinates reported by the device are always within the
> >> range of 0 to 6143). If the latter is more appropriate I can modify the
> >> patch to use the device-reported values and fall back to the hard-coded
> >> values.
> 
> Hi Seth,
> 
> The patch seems to do what it says it is doing, but perhaps we can do
> a little better?  The problem is, it would make fingers at the bottom
> of the pad simply disappear, which may not be a great user experience,
> either.

What we're loosing is pretty minimal, see below. All the same, I'm open
to doing something different.

> Do you have access to the hardware?

Yes.

> What is the y value reported at the top of the pad?
> Also, what are the max & min values reported by your device when queried?
>   Do they match the values that are actually reported?

The largest y value I see reported is 5490.

> Judging just from your comments, it sounds like the trackpad might be
> wrapping around, and trying to report "negative" 13-bit numbers near
> the bottom.

I suspect this is the case. I see a range of values that would go down
to about -7. Obviously we can't simply treat it as a signed value
though, as that's going to cause values at the top to go negative.

> Perhaps we can do this for your pad:
>  y = (y + 0x0800) & 0x1FFF;
> 
> Which would make those negative values positive.

My concern with this is that it would shift the range relative to the
min/max y values we report, but I don't know how those are consumed so
I'm not sure what impact this might have. For instance, could this
negatively impact edge scrolling?

> Or, alternatively, we could actually report negative values to
> userspace in this case:
> 
> y = (y <= 6143) ? y : (y - 8192);

Well, they won't be negative anymore when userspace sees them ;)

But yeah, either of these should work. I don't feel like it's necessary
since this is apparently a one-off problem on aging hardware, and since
Windows also doesn't seem to be using the portion of the touchpad
reporting the out of range values (although humorously I can get the
pointer to jump sometimes under Windows too). Between the two
implementations you suggest I'd feel more comfortable with the latter,
as it should leave the values reported unchanged for other hardware.

I do have one question I'd still like to clear up. Am I correct in
interpreting the Synaptics documentation to say that the touchpads
should never report values greater than 6143, even for models that
report the maximum possible x/y values? That's what I think it's saying,
but I also feel like there's a little ambiguity on the point. Especially
since I'm already seeing values outside of the documented range :)

Thanks,
Seth
