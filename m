From: ulrik.debie-os@e2big.org
Subject: Re: Elantech touchpad does not work on Asus
Date: Wed, 25 Mar 2015 21:34:29 +0100
Message-ID: <20150325203428.GA24094@lantern>
References: <20150319220546.GA4999@lantern>
 <20150320163955.GB21014@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from e2big.org ([198.61.226.133]:48617 "EHLO e2big.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752938AbbCYUef (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 25 Mar 2015 16:34:35 -0400
Content-Disposition: inline
In-Reply-To: <20150320163955.GB21014@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, George Moutsopoulos <gmoutso@yahoo.co.uk>

Hi Dmitry,

On Fri, Mar 20, 2015 at 09:39:55AM -0700, Dmitry Torokhov wrote:
> Hi Ulrik,
> 
> On Thu, Mar 19, 2015 at 11:05:46PM +0100, ulrik.debie-os@e2big.org wrote:
> > Hi all,
> > 
> > I looked at the bugzilla bugreport on 
> > https://bugzilla.kernel.org/show_bug.cgi?id=84491
> > "Elantech touchpad does not work on Asus TransformerBook Flip 500"
> > 
> > There are problems reported on two variants:
> > Asus TransformerBook Flip TP500LN
> > Asus TP500LN
> > 
> > George (in CC:) helped me to investigate on his hardware what happened
> > by trying a few patches and reporting what happens.
> > 
> > It seems that the absolute mode setting somehow gets cancelled after the
> > elantech drivers initializes. This results in relative motion packets
> > coming in, elantech driver not recognizing them and consequentially
> > "lost sync at byte 6" messages.
> > 
> > When one, after the psmouse driver is loaded, does the following:
> > echo 1 > /sys/devices/platform/i8042/serio4/reg_07
> > ,the touchpad will work like a charm until suspend2ram. After a 
> > suspend2ram, another echo is required. 
> > 
> > This exact same value is written during initialization of v4 hardware. 
> > As a test, I even read it back in elantech_set_absolute_mode after 
> > writing and at that moment in the driver the value 1 is read.
> > 
> > But when one performs the read later on the commandline of reg_07, value
> > 0 is read, so probably for a reason unknown to me, the value goes to
> > 0 because of some timeout or serio communiation.
> > 
> > I also tried putting elantech_set_input_params call in front of
> > elantech_set_absolute_mode, but that didn't help either.
> > 
> > Also the suspend2ram seems to result in the same thing.
> > 
> > Anyone an idea why this reg_07 1 value could become a 0 between the time
> > the function elantech_set_absolute_mode during loading of the psmouse
> > module and the time when reading the value from sysfs from the 
> > command line ?
> 
> Hmm, so after Elantech code has done with the init you see the correct
> value in r7? Psmouse driver does [re]set scale, rate and resolution
> after protocol has been initialized, maybe that confuses Elantech in the
> same fashion as it does Focaltech?

Indeed, this time it is specifically the set_rate that resets the 
value of reg_07 to 0, resulting in the disabling of the absolute mode.

I made a patch on kernel v3.16 that solves the problem and will send it out
in like an hour after a final check if it also compiles on kernel v3.19. 
(The person that tested it is on v3.16 kernel).


> 
> Thanks.
> 
> -- 
> Dmitry

Thanks for once again your valuable input,
Ulrik

