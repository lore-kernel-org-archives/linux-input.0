From: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
Subject: Re: Spurious touchpad events with closed LID
Date: Thu, 29 Jun 2017 12:24:35 +0200
Message-ID: <20170629102435.GL25196@pali>
References: <201706261854.53970@pali>
 <20170626170312.GB4965@dtor-ws>
 <201706262109.42628@pali>
 <20170628201530.GB18101@amd>
 <1498689867.6564.6.camel@hadess.net>
 <20170629073102.GG25196@pali>
 <20170629100837.GA1709@amd>
 <20170629101112.GK25196@pali>
 <20170629101500.GB1709@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wr0-f196.google.com ([209.85.128.196]:36756 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751953AbdF2KYi (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Thu, 29 Jun 2017 06:24:38 -0400
Content-Disposition: inline
In-Reply-To: <20170629101500.GB1709@amd>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Bastien Nocera <hadess@hadess.net>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

On Thursday 29 June 2017 12:15:00 Pavel Machek wrote:
> On Thu 2017-06-29 12:11:12, Pali Rohár wrote:
> > On Thursday 29 June 2017 12:08:37 Pavel Machek wrote:
> > > Hi!
> > > 
> > > On Thu 2017-06-29 09:31:02, Pali Rohár wrote:
> > > > On Thursday 29 June 2017 00:44:27 Bastien Nocera wrote:
> > > > > On Wed, 2017-06-28 at 22:15 +0200, Pavel Machek wrote:
> > > > > > 
> > > > > <snip>
> > > > > > While policy normally belongs to userspace, I'd argue this is
> > > > > > workaround for a hardware bug, and in-kernel solution would be
> > > > > > acceptable.
> > > > > > 
> > > > > > Anyway, disable attribute would be nice first step.
> > > > > 
> > > > > It's already fixed for those of us on recent distributions. The
> > > > > "ID_INPUT_TOUCHPAD_INTEGRATION=internal" touchpads will be disabled
> > > > > when the lid is closed, when libinput is used to process the events.
> > > > 
> > > > But this does not fix other usage of /dev/input/* and also does not fix
> > > > pressing spurious keys in linux virtual tty (ctrl+alt+f1). So it is not
> > > > a fix.
> > > > 
> > > > Also important question is: How you detect which input device is
> > > > "internal", non-removable part of notebook and which one is external?
> > > > 
> > > > You can have external USB touchpad, and also you can have external PS/2
> > > > keyboard connected to docking station (which was e.g. my situation).
> > > > 
> > > > Also there are PS/2 to active USB converters, to make whole situation
> > > > complicated.
> > > > 
> > > > And moreover some internal notebook keyboards are connected via USB and
> > > > some touchpads via i2c/smbus.
> > > > 
> > > > I think this detection is not easy or at least I have no idea how to do
> > > > properly. Existence of PS/2 keyboard does not mean it is internal and
> > > > existence of USB keyboard does not mean it is external.
> > > > 
> > > > Maybe ACPI/DSDT provides some information? (No idea, just asking)
> > > 
> > > I'm not sure it is complex. You simply add DMI blacklist of the bad
> > > systems, with IDs of bad devices.
> > 
> > My original request is to disable internal keyboard, touchpad and
> > trackpoint on notebook when it is docked and LID is closed.
> > 
> > It has nothing to do with DMI blacklist or so.
> 
> Well, you have a buggy notebook. On non-buggy ones, touchpad will not
> generate events when closed.
> 
> That's where the DMI blacklist comes to mind.

Such blacklist would be huge. Lot of notebooks working in this way.

> (Of course, disable attribute would still be nice for other cases.)

Yes.

-- 
Pali Rohár
pali.rohar@gmail.com
