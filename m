From: Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [RFP] iio: Support of gesture sensor as a standard IIO sensor
Date: Sat, 6 Jan 2018 13:12:31 +0000
Message-ID: <20180106131231.078492c3@archlinux>
References: <1515197240.26317.65.camel@intel.com>
        <20180106002024.012f44c0@alans-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20180106002024.012f44c0@alans-desktop>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alan Cox <gnomes-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>
Cc: "Pandruvada, Srinivas" <srinivas.pandruvada-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Sat, 6 Jan 2018 00:20:24 +0000
Alan Cox <gnomes-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org> wrote:

> > >From an IIO sensor point of view A Gesture sensor:    
> > Outputs
> > 	A pre defined activity type
> > 		WAKE
> > 		TILT
> > 		GLANCE
> > 		PICK_UP
> > 		 &
> > 		 more
> > 
> > 	A user defined activity type as "string"
> > 
> > Inputs
> > 	A raw binary cdev interface to download templates/patterns
> > 
> > 
> > I want to gather more opinions before submitting a RFC patch.  
> 
> The only question I have is should it appear under IIO or should it be an
> input event interface. It feels to me more like an input device in that in
> this case while it's not keys or joystick it is still 'please do X'. That
> might also make it much easier (in the non-Android space in particular)
> to bind these activities to actions in things like web browsers.
> 
I agree that this may well be an option for many of the gestures specifically
metioned (flicks etc and glyphs).

However, there are other obvious uses of this technology such as step detection
or activity classification (running, walking sitting) that so far have fallen
in the scope of IIO as they aren't really things you expect the device to
perform an an action in response to.  Another one of those messy corners
that fall through the gaps!

The drivers/iio/accel/mma9553.c does activity detection, but that isn't
really 'events' in the same way as we have here...

So right answer might be a hybrid of an underlying flexible IIO device
and an input front end for when it makes sense.

We probably need to get the in kernel use of IIO events sorted.  Non event
stuff has been sorted for years, but this last corner was never of enough
interest to anyone to actually implement it (it's fairly straight forward
to do).

> (+ linux-input)
> 
> Alan
