From: Michael Welling <mwelling-EkmVulN54Sk@public.gmane.org>
Subject: Re: AM335x touchscreen issues
Date: Tue, 26 May 2015 15:53:10 -0500
Message-ID: <20150526205310.GA2104@deathray>
References: <20150526181157.GA8009@deathray>
 <20150526183713.GU26599@saruman.tx.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20150526183713.GU26599-HgARHv6XitJaoMGHk7MhZQC/G2K4zDHf@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Cc: "Franklin Cooper Jr." <fcooper-l0cyMroinI0@public.gmane.org>, dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, vigneshr-l0cyMroinI0@public.gmane.org, bgriffis-l0cyMroinI0@public.gmane.org, jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, GWilson-+8BKOH/0X5NWk0Htik3J/w@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Tue, May 26, 2015 at 01:37:13PM -0500, Felipe Balbi wrote:
> Hi,
> 
> On Tue, May 26, 2015 at 01:11:57PM -0500, Michael Welling wrote:
> > Greetings,
> > 
> > I have been porting Linux to a new AM3554 based SoM and have found issues
> > with the touchscreen reporting touch releases repeatedly to userspace
> > without actually touching the screen when running ts_calibrate, ts_test
> > or other graphical touchscreen applications.
> > 
> > This started happening after updating pulling recent changes.
> 
> Can you bisect and find the offending commit ? Which recent changes are
> you talking about ?

Sorry that it took so long to find the offending commit, it appears that
the issue occurs on my 4.3" display but not on my 7" display. I first
performed the git bisect on the 7" display which ended up being fruitless.

Then I switched over the the 4.3" display and found the commit which starts
having the issue.

michael@deathray:~/projects/linux/linux-torvalds$ git bisect start HEAD v3.18 -- drivers/input/touchscreen/ti_am335x_tsc.c
.
.
michael@deathray:~/projects/linux/linux-torvalds$ git bisect bad
344d635b9a41b19837ccf8083a99ea688027019c is the first bad commit
commit 344d635b9a41b19837ccf8083a99ea688027019c
Author: Brad Griffis <bgriffis-l0cyMroinI0@public.gmane.org>
Date:   Tue Feb 3 11:44:12 2015 -0800

    Input: ti_am335x_tsc - remove udelay in interrupt handler
    
    TSC interrupt handler had udelay to avoid reporting of false pen-up
    interrupt to user space. This patch implements workaround suggesting in
    Advisory 1.0.31 of silicon errata for am335x, thus eliminating udelay and
    touchscreen lag. This also improves performance of touchscreen and
    eliminates sudden jump of cursor at touch release.
    
    IDLECONFIG and CHARGECONFIG registers are to be configured with same values
    in order to eliminate false pen-up events. This workaround may result in
    false pen-down to be detected, hence considerable charge step delay needs
    to be added. The charge delay is set to 0xB000 (in terms of ADC clock
    cycles) by default.
    
    TSC steps are disabled at the end of every sampling cycle and EOS bit is
    set. Once the EOS bit is set, the TSC steps need to be re-enabled to begin
    next sampling cycle.
    
    Signed-off-by: Brad Griffis <bgriffis-l0cyMroinI0@public.gmane.org>
    [vigneshr-l0cyMroinI0@public.gmane.org: Ported the patch from v3.12 to v3.19rc1]
    Signed-off-by: Vignesh R <vigneshr-l0cyMroinI0@public.gmane.org>
    Signed-off-by: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

Hope this sheds some light.

> 
> > It has also been confirmed to be happening on the beagle bone black:
> > http://www.spinics.net/lists/linux-iio/msg18580.html
> > 
> > If you look further into this thread you will see a workaround patch that
> > I came up with:
> > http://www.spinics.net/lists/linux-iio/msg18583.html
> > 
> > Though this fix stops the reported events in userspace, interrupts are
> > still occuring repeatedly.
> > 
> > Does anyone have any suggestions beyond what I have done to remedy this
> > issue?
> 
> yeah, it sounds similar to what Franklin has been working on.
> 
> Franklin, any comments ?
> 
> -- 
> balbi
