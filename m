From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: Synchronizing evdev readers and drivers?
Date: Fri, 3 Dec 2010 13:24:46 -0800
Message-ID: <20101203212445.GE21277@core.coreip.homeip.net>
References: <AANLkTik8X-Xe9fvYUtRObRBP1PyedOu+zwb1SKKf+kgy@mail.gmail.com>
 <20101202212223.GA9864@core.coreip.homeip.net>
 <AANLkTi=vc0b5Zcy=TuVq3=6yZ8eHCEwLQ0hkkk-x-AyZ@mail.gmail.com>
 <20101203124240.GH3182@sirena.org.uk>
 <AANLkTimFoyFksd1orc9Bf8y5y7xQf14i_hhDoRyR3vnE@mail.gmail.com>
 <20101203135346.GI3182@sirena.org.uk>
 <AANLkTimKyU9dhxE5pkwTZ_0m7C1z+KjB-FMqLkA_UsNf@mail.gmail.com>
 <20101203195030.GB21277@core.coreip.homeip.net>
 <AANLkTim_f9dVdUVRmqO4dVfdta6b3LRbMKZArtON0ggb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:54405 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750837Ab0LCVY5 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 3 Dec 2010 16:24:57 -0500
Received: by yxt3 with SMTP id 3so4528577yxt.19
        for <linux-input@vger.kernel.org>; Fri, 03 Dec 2010 13:24:57 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <AANLkTim_f9dVdUVRmqO4dVfdta6b3LRbMKZArtON0ggb@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Bill Gatliff <bgat@billgatliff.com>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-input@vger.kernel.org

On Fri, Dec 03, 2010 at 02:17:36PM -0600, Bill Gatliff wrote:
> Dmitry:
> 
> 
> On Fri, Dec 3, 2010 at 1:50 PM, Dmitry Torokhov
> <dmitry.torokhov@gmail.com> wrote:
> > Right. The indication that application wants the data is open() call. If
> > userspace does not want data, it should close() the interface.
> 
> It *does* want the data, just at a specified rate.  And right now, we
> have no consistent way of having applications express that rate to the
> input device.  A read callback is one, very flexible way of correcting
> that.

No it is not. Please re-read the paragraph below for the reasons why
read, as it was proposed, does not correct this.

> 
> > Drivers have no idea what users want to do with the data so they can't
> > decide whether to ignore the hardware or query it and queue events up.
> > Some applications might be interested in "sample on demand", while
> > others would prefer events to be queued and consumed at once.
> 
> Yep.  We've already covered that.
> 
> > [... cut long argument for an inconsistent and incompatible change to
> > the interface ...]
> 
> I object.
> 
> My proposed change is carefully considered to be neither inconsistent
> nor incompatible with the current interface.  Existing drivers will
> continue to work exactly as they do now.  Future drivers that don't
> utilize the read callback will work exactly as conventional drivers do
> now.
> 
> Certain hardware drivers will want to take advantage of the read
> callback, and those drivers will perform differently in ways that some
> applications won't care about, and others won't even notice.  And
> those drivers will perform usefully for applications that *do* care
> about the differences.

What about applications which will observe the change in behavior and it
will stop them from working?

You are arguing for interface which behavior changes from driver to
driver, from one version of driver to another. I do not believe you will
find many supporters for it.

> 
> I predicted (and welcomed) a lot of constructive challenges to making
> a change to such a widely used API.  But your outright hostility isn't
> a productive use of anyone's time.

It is not hostility. I simply state the fact - the proposed interface
change is inconsistent (behavior varies from driver to driver) and
incompatible (the same application get different behavior from drivers
which utilize the callback in the way you suggest).

> 
> > BTW, if application reads (supplies space for) just one event should we
> > disacard the rest of hardware state that we read from the device? You
> > know, just asking...
> 
> Ridiculously hypothetical, distracting and unrelated question, but
> I'll answer it anyway.  If the application wants more than one event,
> it had better make room for them.

For how many? Lets say we have ABS_X, ABS_Y, ABS_Z. We post a read for 4
events (including EV_SYN), driver starts poll as you want it to and
userspace gets all 3. Then we post another read for 4, driver reads HW
state and this time Y stays the same so only 3 events (ABS_X, ABS_Z and
EV_SYN). So what to do with the 4th slot? Should it start another poll
so we could deliver another ABS_X and then what to do with the rest of
the state. Or maybe you say that we need to reset the whole internal
device state on every "read"? But what about other users reading from
the same device? And it gets close and closer to already existing
solution - open/close - anyway.

>  As for the events that remain in
> the queue, if any: that depends on how the driver works.  Just like it
> does today.

Today it does not depend on how the driver works. All events generated
stay in the client queue unless it is so slow that it overfills.

-- 
Dmitry
