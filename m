From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH] input/touchscreen: add S3C24XX SoC touchscreen input
	driver
Date: Mon, 19 Oct 2009 13:07:44 +0100
Message-ID: <20091019120744.GB7412@n2100.arm.linux.org.uk>
References: <mailman.4020.1255949705.2256.linux-arm-kernel@lists.infradead.org> <4ADC4D4D.5020508@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:54852 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750846AbZJSMII (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 19 Oct 2009 08:08:08 -0400
Content-Disposition: inline
In-Reply-To: <4ADC4D4D.5020508@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Maurus Cuelenaere <mcuelenaere@gmail.com>
Cc: Shine Liu <shinel@foxmail.com>, Nelson Castillo <arhuaco@freaks-unidos.net>, dtor@mail.ru, dmitry.torokhov@gmail.com, linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org

On Mon, Oct 19, 2009 at 01:28:13PM +0200, Maurus Cuelenaere wrote:
> Do you know that there's another patch (at Openmoko) created by Nelson  
> Castillo that does the same, but also has support for kernel-space  
> touchscreen filters? (I think [1] is his latest version)
> I don't know how your patch performs, but according to [2] the filters  
> should help a lot avoiding jitter etc.
>
> I'm not sure whether Nelson has submitted his patches for mainline  
> review yet and what the status is on the kernel filters, but IMHO doing  
> some filtering in kernel space (see the "Why are we doing filtering in  
> kernel space?" part of [2]) which results in a "cleaner" output is  
> preferred over reporting possible "jittery" data.

It doesn't really describe why doing the filtering in kernel space is
apparantly soo much better than doing it in tslib - it's seems to just
do some handwaving kind of argument:

   Let's say we would like to deliver a TS event to user space each 10
   milliseconds. In the GTA02 with the current configuration the
   Analog/Digital conversion time of a sample is 0.4697 milliseconds, thus
   can get 18 samples for each event that we send to user-space. Sending the
   event (with 18 samples) takes us about 8.45 milliseconds.

So far so good.  But, according to my maths, 8.45ms is less than 10ms.

                                                               Sometimes we
   even decide that the event should not be sent to user-space (because the
   hardware didn't provide reliable data), and our tests show that it's the
   right thing to do. In previous versions of the driver light taps would
   confuse the driver (that would report bad clicks) and this is no longer an
   issue.

Err, that doesn't seem to follow on from the previous point.

The reason that we decided raw events should be passed to userspace and
the processing done there is that it allows all of the _policy_ of
deciding how to process touchscreen events to be configured.  There's
lots of different parameters and ways to filter touchscreens, and some
are specific to individual touchscreen setups.

This is why tslib is entirely modular, and allows any combination of
modules to be loaded to process the touchscreen samples - it's there
to provide a totally flexible infrastructure to filter and scale
the output from the touchscreen in whatever way is required for the
hardware.

I don't think there is any single filtering system which can properly
filter the output of any one touchscreen, and I don't think that putting
this filtering in the kernel is a sane approach.  It _may_ be a sane
approach for one particular touchscreen setup, but it certainly isn't
for all.
