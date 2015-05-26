From: "Cooper Jr., Franklin" <fcooper-l0cyMroinI0@public.gmane.org>
Subject: RE: AM335x touchscreen issues
Date: Tue, 26 May 2015 21:15:53 +0000
Message-ID: <8F29D6B095ED194EA1980491A5E029710C89C445@DFLE08.ent.ti.com>
References: <20150526181157.GA8009@deathray>
 <20150526183713.GU26599@saruman.tx.rr.com> <20150526205310.GA2104@deathray>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150526205310.GA2104@deathray>
Content-Language: en-US
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Michael Welling <mwelling-EkmVulN54Sk@public.gmane.org>, "Balbi, Felipe" <balbi-l0cyMroinI0@public.gmane.org>
Cc: "dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "R, Vignesh" <vigneshr-l0cyMroinI0@public.gmane.org>, "Griffis, Brad" <bgriffis-l0cyMroinI0@public.gmane.org>, "jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org" <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, "linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "GWilson-+8BKOH/0X5NWk0Htik3J/w@public.gmane.org" <GWilson-+8BKOH/0X5NWk0Htik3J/w@public.gmane.org>, "linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-input@vger.kernel.org



> -----Original Message-----
> From: Michael Welling [mailto:mwelling79-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org] On Behalf Of Michael
> Welling
> Sent: Tuesday, May 26, 2015 3:53 PM
> To: Balbi, Felipe
> Cc: Cooper Jr., Franklin; dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org; R, Vignesh; Griffis,
> Brad; jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org; wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org; linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org;
> GWilson-+8BKOH/0X5NWk0Htik3J/w@public.gmane.org; linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> Subject: Re: AM335x touchscreen issues
> 
> On Tue, May 26, 2015 at 01:37:13PM -0500, Felipe Balbi wrote:
> > Hi,
> >
> > On Tue, May 26, 2015 at 01:11:57PM -0500, Michael Welling wrote:
> > > Greetings,
> > >
> > > I have been porting Linux to a new AM3554 based SoM and have found
> > > issues with the touchscreen reporting touch releases repeatedly to
> > > userspace without actually touching the screen when running
> > > ts_calibrate, ts_test or other graphical touchscreen applications.
> > >
> > > This started happening after updating pulling recent changes.
> >
> > Can you bisect and find the offending commit ? Which recent changes
> > are you talking about ?
> 
> Sorry that it took so long to find the offending commit, it appears that the
> issue occurs on my 4.3" display but not on my 7" display. I first performed the
> git bisect on the 7" display which ended up being fruitless.
> 
> Then I switched over the the 4.3" display and found the commit which starts
> having the issue.
> 
> michael@deathray:~/projects/linux/linux-torvalds$ git bisect start HEAD
> v3.18 -- drivers/input/touchscreen/ti_am335x_tsc.c
> .
> .
> michael@deathray:~/projects/linux/linux-torvalds$ git bisect bad
> 344d635b9a41b19837ccf8083a99ea688027019c is the first bad commit commit
> 344d635b9a41b19837ccf8083a99ea688027019c
> Author: Brad Griffis <bgriffis-l0cyMroinI0@public.gmane.org>
> Date:   Tue Feb 3 11:44:12 2015 -0800
> 
>     Input: ti_am335x_tsc - remove udelay in interrupt handler
> 
>     TSC interrupt handler had udelay to avoid reporting of false pen-up
>     interrupt to user space. This patch implements workaround suggesting in
>     Advisory 1.0.31 of silicon errata for am335x, thus eliminating udelay and
>     touchscreen lag. This also improves performance of touchscreen and
>     eliminates sudden jump of cursor at touch release.
> 
>     IDLECONFIG and CHARGECONFIG registers are to be configured with same
> values
>     in order to eliminate false pen-up events. This workaround may result in
>     false pen-down to be detected, hence considerable charge step delay
> needs
>     to be added. The charge delay is set to 0xB000 (in terms of ADC clock
>     cycles) by default.
> 
>     TSC steps are disabled at the end of every sampling cycle and EOS bit is
>     set. Once the EOS bit is set, the TSC steps need to be re-enabled to begin
>     next sampling cycle.
> 
>     Signed-off-by: Brad Griffis <bgriffis-l0cyMroinI0@public.gmane.org>
>     [vigneshr-l0cyMroinI0@public.gmane.org: Ported the patch from v3.12 to v3.19rc1]
>     Signed-off-by: Vignesh R <vigneshr-l0cyMroinI0@public.gmane.org>
>     Signed-off-by: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> 
> Hope this sheds some light.
> 
> >
> > > It has also been confirmed to be happening on the beagle bone black:
> > > http://www.spinics.net/lists/linux-iio/msg18580.html
> > >
> > > If you look further into this thread you will see a workaround patch
> > > that I came up with:
> > > http://www.spinics.net/lists/linux-iio/msg18583.html
> > >
> > > Though this fix stops the reported events in userspace, interrupts
> > > are still occuring repeatedly.
> > >
> > > Does anyone have any suggestions beyond what I have done to remedy
> > > this issue?
> >
> > yeah, it sounds similar to what Franklin has been working on.
> >
> > Franklin, any comments ?
[Franklin]
Michael,

Can you send me the output of ts_test_raw after you done a 5 or so touch down and touch up events? In the output let me know at which point in the log that the issue you observed has occurred. Please try to avoid moving your finger since I want to see the full output of that program but I'm not interested any unnecessary pen down events.

I recently encountered several touchscreen problems that I am working on submitting to mainline. Below are the variety of issues I discovered and fixed but its currently based on 3.14 kernel.

1. The x and y location right before a penup event is usually incorrect. Visibly the causes the cursor to jump right before a touchup. So I implemented a way to ignore that incorrect event.
2. I discovered that for some reason a series of touch up events are sent back to back. So I added something to ignore consecutive pen up events.
3. Sometimes a pen down event is reported with a pressure of 0. I noticed applications like ts_lib looked at the pressure and thought a pressure of 0 means a finger was lifted. So I added a patch that ignored 0 pressure pen down events. This prevented premature touchups.
4. I added debouncing. Essentially the driver didn't report any touch events for a user specified number of ms after a pen up occured. It was noticed especially during touchscreen calibration that after a person lifted their finger after touching the screen a combination of pen up and pen down events were incorrectly detected.

Most likely a combination of 2-4 is your problem. I think the udelay acted like an unintentional debounce which is probably why it wasn't discovered sooner.
> >
> > --
> > balbi
> 
