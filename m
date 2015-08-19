From: Stephen Chandler Paul <cpaul@redhat.com>
Subject: Re: PROBLEM: Missing events on thinkpad trackpoint buttons
Date: Wed, 19 Aug 2015 17:33:27 -0400
Message-ID: <1440020007.14257.4.camel@redhat.com>
References: <CAN_QmVxOaqyZ8fJ29Jtjkb8YnckjQ=q53igOcQuAFmrQG7hiZQ@mail.gmail.com>
	 <CAN+gG=GbMrxCUJJJqgROmx6g4jYU+jqW2JKyt3Yz+DL-SMhd8A@mail.gmail.com>
	 <CAN+gG=HQ7ViGHSLfBuCSaqPFppOm-9ggEaZFwyXKse7CP_p25A@mail.gmail.com>
	 <20150819212748.GB19499@dtor-pixel>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:46655 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750933AbbHSVd3 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 19 Aug 2015 17:33:29 -0400
In-Reply-To: <20150819212748.GB19499@dtor-pixel>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Benjamin Tissoires <benjamin.tissoires@gmail.com>
Cc: Nick Bowler <nbowler@draconx.ca>, linux-input <linux-input@vger.kernel.org>, Andrew Duggan <andrew.duggan@gmail.com>

There is support in the spec for PS/2 guests believe it or not, it's
just mostly undocumented. Coincidentally, I was actually the one who
wrote the drivers for this in Benjamin's tree. Using that, we can
actually just create a serio port that goes through the rmi4 driver and
communicate with that using the normal TrackPoint driver. We have a
working implementation of this here: 
https://github.com/bentiss/linux/tree/synaptics-rmi4-smbus-v4.2-rc6%2B

Cheers,
	Stephen Chandler Paul

On Wed, 2015-08-19 at 14:27 -0700, Dmitry Torokhov wrote:
> On Wed, Aug 19, 2015 at 09:52:00AM -0400, Benjamin Tissoires wrote:
> > On Tue, Aug 18, 2015 at 3:06 PM, Benjamin Tissoires
> > <benjamin.tissoires@gmail.com> wrote:
> > > Hi Nick,
> > > 
> > > thanks for the report.
> > > 
> > > On Mon, Aug 17, 2015 at 10:31 PM, Nick Bowler <nbowler@draconx.ca
> > > > wrote:
> > > > Hi,
> > > > 
> > > > I'm not sure if this is actually a Linux issue but figured I'd
> > > > at least
> > > > report it here to start...
> > > > 
> > > > I have a Lenovo Thinkpad X250, with the newfangled trackpoint
> > > > buttons.
> > > > I have a problem with missing button press or release events:
> > > > sometimes
> > > > pressing a button has no effect, and sometimes releasing a
> > > > button has no
> > > > effect (the latter is especially annoying, as the button
> > > > remains depressed
> > > > as far as any applications are concerned).
> > > > 
> > > > After some testing, the problem apparently depends on the
> > > > position of my
> > > > hands over the touchpad.  I can reliably reproduce it as
> > > > follows: place
> > > > two fingers on the touchpad, then press the button repeatedly. 
> > > >  Watching
> > > > with evtest, several events (could be either press or release)
> > > > will
> > > > simply be missin, although the kernel never does anything weird
> > > > like
> > > > send two release events in a row.  There are no problems if
> > > > there are
> > > > 0 or 1 fingers on the touchpad.
> > > > 
> > > > My current kernel version is 4.1.6, although the problem occurs
> > > > in all
> > > > versions that I tried.
> > > > 
> > > > Here is the evtest result from placing two fingers on the
> > > > touchpad, then
> > > > pressing the left trackpoint button 10 times, counting 1 second
> > > > between
> > > > each press.  As you can see, only 3 presses and 3 release
> > > > events total
> > > > were sent by the kernel, sometimes with many physical button
> > > > presses
> > > > between the press and its corresponding release:
> > > 
> > > OK, so this is definitively weird. My first idea would be a
> > > firmware
> > > problem. I have asked Chandler to reproduce it on his t450 and
> > > see if
> > > we observe it on our laptops too.
> > 
> > Update on this one : Chandler reproduced it on the t450, so it's
> > likely that all of these sensors are affected. It is still unclear
> > if
> > it is a firmware bug or a driver problem, but the chances are huge
> > that this is a firmware bug. Anyway, that's one more reason to push
> > towards RMI4 over SMBus for these sensors: the bug is not present
> > with
> > this protocol :)
> 
> By the way, how are we going to handle Trackpoint (PS/2 device) with
> touchpads in RMI4 mode? I do not recall anything in RMI4 spec, but I
> looked at it quite some time ago.
> 
> Thanks.
> 
