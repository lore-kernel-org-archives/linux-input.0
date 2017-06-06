From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH v3 00/19] Report power supply from hid-logitech-hidpp
Date: Tue, 6 Jun 2017 09:25:49 +0200
Message-ID: <20170606072549.GS1293@mail.corp.redhat.com>
References: <20170327145939.29824-1-benjamin.tissoires@redhat.com>
 <0cdc8dda-de3f-c3d0-07da-65612860a70f@intel.com>
 <1496345185.2570.3.camel@hadess.net>
 <20170602072907.GK1293@mail.corp.redhat.com>
 <02006322-6be2-f169-497e-06fc010a4bdb@intel.com>
 <alpine.LSU.2.20.1706050959500.30709@cbobk.fhfr.pm>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:47876 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751073AbdFFHZz (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Tue, 6 Jun 2017 03:25:55 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LSU.2.20.1706050959500.30709@cbobk.fhfr.pm>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>
Cc: Dave Hansen <dave.hansen@intel.com>, Bastien Nocera <hadess@hadess.net>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

[Sorry for the delay, public holiday yesterday and I wasn't home]

On Jun 05 2017 or thereabouts, Jiri Kosina wrote:
> On Fri, 2 Jun 2017, Dave Hansen wrote:
> 
> > >>>> This will allow upower to not handle those devices anymore and to
> > >>>> have more
> > >>>> immediate reportng of the device to the system.
> > >>> FWIW, I'm on Ubuntu 14.04, and upower *is* reporting my mouse battery
> > >>> as
> > >>> if it were a laptop battery.  It's mostly garbage, and always reports
> > >>> 0%, which makes upower always tell me my laptop is 2/3 charged (I
> > >>> have 2
> > >>> real batteries).
> > > Well, the exported battery might be sending levels instead of
> > > pourcentages. And upower needs to be upgraded to handle those :(
> > 
> > It sounds like there are a number of things here where newer kernels are
> > breaking older userspace.  It's also causing some very end-user visible
> > effects, like having folks' systems auto shut down because upower thinks
> > their batteries are dead.
> > 
> > Old versions of upower are obviously confused here.  It would be really
> > nice to ensure that newer kernels don't break it like this.
> > 
> > IOW, it would be really nice if this were treated like a regression,
> > because it's tantalizingly close.

Believe me, I really try to avoid any regression. However, in this
situation, it's a user space bug and the only solution to not hit the
user space bug from the kernel is to not export the extra device, or
teach your upower daemon to ignore this particular device through a
udev rule (if that's possible, I'll check that today).


> 
> I agree with Dave. If there is no solution found in time for -rc5, 
> reverting to previous state would be the proper way to go.
>

Well, as Bastien said, the issue is that old user space is buggy, and
even if we postpone the switch to 4.13, there will always be someone who
did not updated upower and who will complain.

As soon as I started the development of this series, Bastien upgraded
upower with the required changes, and usually the development cycle of
the kernel gives plenty of time for users to upgrade their user space
tools before the kernel hits mainline.

[...after a little bit of digging...]

I tried today with a Fedora 25 and the shipped upower that doesn't have
the bits Bastien worked on last March.

I couldn't expose the bug as reported here. The reason being what
Bastien said, there is a "scope" property exported by the kernel device
which is set to "Device" telling upower to ignore the device completely
in this version.

A git blame game gives me 28c8653ed8d43 being the original addition of
the "scope" handling and this commit is dated "Wed Apr 18 16:46:41 2012
+0100". It was shipped in UPOWER_0_9_16, and there has been 7 minor
releases of upower since, and there has been the final 1.0 branch since
too.

So, no, I don't think this is a regression if you are running a 5 year
old user space that doesn't handle properties introduced in kernel v3.4.
Any HID keyboard you plug in that exports a battery will show the very
same upower bug, and there has been countless since 2012.

Cheers,
Benjamin

