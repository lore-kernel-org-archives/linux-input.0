From: Peter Hutterer <peter.hutterer@who-t.net>
Subject: Re: ALPS Trackpoint & pressure
Date: Fri, 9 Feb 2018 09:57:03 +1000
Message-ID: <20180208235703.GA4300@jelly>
References: <20180204150839.b5qm4wb26vic35st@pali>
 <20180205224955.GB46524@dtor-ws>
 <20180206002947.GB27776@jelly>
 <20180208232141.2jxjd2xzkfua42mr@pali>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from leo.clearchain.com ([199.73.29.74]:13105 "EHLO
        mail.clearchain.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751317AbeBHX5K (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Thu, 8 Feb 2018 18:57:10 -0500
Content-Disposition: inline
In-Reply-To: <20180208232141.2jxjd2xzkfua42mr@pali>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Masaki Ota <masaki.ota@jp.alps.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Fri, Feb 09, 2018 at 12:21:41AM +0100, Pali Rohár wrote:
> On Tuesday 06 February 2018 10:29:47 Peter Hutterer wrote:
> > On Mon, Feb 05, 2018 at 02:49:55PM -0800, Dmitry Torokhov wrote:
> > > On Sun, Feb 04, 2018 at 04:08:39PM +0100, Pali Rohár wrote:
> > > > Hi! Now playing again with trackpoint connected to ALPS rushmore
> > > > touchpad and I'm seeking a nice feature. Via ALPS PS/2 protocol it
> > > > reports pressure of trackpoint. Parser for it is already implemented in
> > > > alps.c and value is assigned to variable "z". When I just move
> > > > trackpoint z is zero, when I push trackpoint while moving, then z is
> > > > number higher, maximally 32. Variable "z" is set, but unused.
> > > > 
> > > > Do we have some input interface which can be used to report this
> > > > pressure of trackpoint to userspace? I can use this feature e.g. as
> > > > additional button...
> > > 
> > > We could either do the conversion in kernel and emit BTN_LEFT, or
> > > report ABS_PRESSURE and see if userspace will be able to handle
> > > REL_X/REL_Y/ABS_PRESSURE device.
> > > 
> > > Adding Peter.
> > 
> > judging by trackpoint history, I'd leave the pressure->click conversion to
> > userspace because every trackpoint may need a different threshold setting.
> > "easier" to have this in userspace with dmi matches etc. plus, converting to
> > BTN_LEFT in the kernel means we cannot use it as a separate interaction
> > anymore.
> 
> Also BTN_LEFT is already reported when left button under trackpoint is
> pressed. Therefore it would not be possible to distinguish between
> trackpoint "press" and real left button press.

yep, that's what I meant with "we cannot use it as separate interaction",
we'd have no way to know how the click was generated.

> 
> > That aside, I think exporting ABS_PRESSURE is fine, that's what it's there
> > for. Nothing will use it for now though, tbh not sure yet how that would be
> > exported from libinput. but worth filing a bug for, please assign it to me.
> 
> Ok, so ABS_PRESSURE? Also then question is, how to report minimal and
> maximal (possible) value? If we are going to "standardize" API for it,
> we should also define min/max values, so userspace would be able to
> normalize this pressure event. I can imagine that some devices can
> report 8bit value, but ALPS rushmore reports only 5bit value.

tbh, I'm not putting my hopes on this being an accurate range ever. So
what's likely going to happen is that you pick a best-guess min/max for the
kernel and then we have dmi-based overrides for every single trackpoint in
userspace to tell us what a realistic threshold value for a click is and
what the actual min/max ranges is.

This is relatively easy to measure in userspace, we can pop it into
60-evdev.hwdb to override the min/max and ship the threshold values as
libinput-specific files. It's awful, but most likely the best we can do.

But hey, at least a min of 0 will be accurate ;)

Cheers,
   Peter
