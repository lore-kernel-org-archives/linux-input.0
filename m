From: Andy Lutomirski <luto@amacapital.net>
Subject: Re: [systemd-devel] Supporting U2F over HID on Linux?
Date: Fri, 12 Dec 2014 09:18:25 -0800
Message-ID: <CALCETrVfvK-BhaQMyfvLndfmX+gwAwshx3vdCFa7sOr+R1Jjpw@mail.gmail.com>
References: <CALCETrXKcU1KaEjFUm9QkEhZRh9wFnoR=hV7O9pUJmYRqNCxpg@mail.gmail.com>
 <CANq1E4QvuNHRq6Saca-KigTjmvyosqM6_JkqF-_OHqxLa=Zdow@mail.gmail.com>
 <CALCETrVU5Kq0wYGXNQ1dsihy1LN1WUmAN4J9puyVPv=b_WNrLw@mail.gmail.com>
 <CANq1E4Sa=D_hvSp2SqHy4cV-oxd-kchsNVivcF54cBv8DK7gOQ@mail.gmail.com>
 <alpine.LNX.2.00.1411032115140.19451@pobox.suse.cz> <CALCETrVkZxc9G+B9jYYFmiE20VGcnugrB21_MRvjNhDTvP00zQ@mail.gmail.com>
 <CALCETrXf4wX5OoGJs2HWbzSLOz764XXg09mSHiTV=-GVCEUQuQ@mail.gmail.com>
 <CALCETrU9Nfpt0Zch5Swi+OaK=KTjJoOw7GAx4B7q1B56SqrUbA@mail.gmail.com>
 <CANq1E4Q8gTgMj+twRE3xjs1OfKUmbOmOatk_sDPPAW2BB4jscw@mail.gmail.com>
 <CALCETrXcHKwBuOA0wpFzgSe8Z9+t8LyaB7U+vdgVsR=YZc+GjQ@mail.gmail.com> <CANq1E4SVQAkyxJpiYsiLkjsET27QUK9PHTHTAqp4wQZVLKrMiw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-la0-f47.google.com ([209.85.215.47]:63607 "EHLO
	mail-la0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030833AbaLLRSr (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 12 Dec 2014 12:18:47 -0500
Received: by mail-la0-f47.google.com with SMTP id hz20so6336385lab.6
        for <linux-input@vger.kernel.org>; Fri, 12 Dec 2014 09:18:46 -0800 (PST)
In-Reply-To: <CANq1E4SVQAkyxJpiYsiLkjsET27QUK9PHTHTAqp4wQZVLKrMiw@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: David Herrmann <dh.herrmann@gmail.com>
Cc: Benjamin Tissoires <benjamin.tissoires@gmail.com>, Jiri Kosina <jkosina@suse.cz>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>

On Dec 12, 2014 3:05 AM, "David Herrmann" <dh.herrmann@gmail.com> wrote:
>
> Hi
>
> On Thu, Dec 11, 2014 at 6:36 PM, Andy Lutomirski <luto@amacapital.net> wrote:
> > It happens during driver probe.  I don't set GET_REPORT to my device
> > -- the protocol consists solely of SET_REPORT from the driver followed
> > by an asynchronous (but generally reasonably quick) report back from
> > the device.
> >
> > During probe, I set INIT, and the device responds by saying "I'm a
> > device.  I speak this version of the protocol.
> >
> > Shouldn't that code be more like:
> >
> > mutex_lock(whatever);
> > if (driver loaded)
> >   deliver the report;
> > mutex_unlock(whatever);
> >
> > and then the core could hold the lock briefly as well when probing or
> > in hid_hw_open/hid_hw_close.
>
> If we only lock around a boolean flag, we need a wait-queue to make
> sure a driver-removal does not run before driver-probe is done. I
> haven't looked at it in detail, maybe we're only called from
> driver-core so we already have this guarantee. Not sure. Feel free to
> send patches.

Hmm.  I'll look, but I may just stick with hid_device_io_start.

>
> So far, the solution is to use hid_device_io_start() and
> hid_device_io_stop() in ->probe(). It's a hack to allow I/O during
> ->probe(). Maybe your idea is the way to go, but unless someone
> implements it, we're stuck with the current code.

That should work.

For normal HID drivers (those that don't start IO from probe), what
happens if userspace starts IO before probe returns?  Does the driver
code prevent that somehow?

Thanks,
Andy

>
> Please have a look at some other drivers in drivers/hid/ to see how
> hid_device_io_start() / hid_device_io_stop() is used. You should be
> fine by just calling hid_device_io_start() from ->probe() after your
> context setup is done and you called hid_hw_start().
>
> > (Also, shouldn't hid_hw_open have some kind of reference counting to
> > avoid interference between hidraw and real drivers?  Or does that
> > already work correctly somehow?)
>
> Kinda.. currently, hidraw is treated as a passive client. That is, the
> hid-device-driver manages the device and hidraw does not interfere. If
> no device-driver is loaded, hid_hw_start/stop is called by hid-core,
> so hidraw will usually work fine. However, if a device-driver is
> loaded, it gets exclusive access to the hardware so is also
> responsible of hid_hw_start/stop. hidraw will follow its lead. Note
> that this is _required_ by some devices as vendors are really crappy
> in writing HID firmware. Think like devices which need an
> initialization after transport-layer setup, or they will timeout... or
> continuous beacon events... It's stuff like that.. Not sure whether we
> still have drivers for broken devices like that, but afaik that's
> where this originated.
>
> Thanks
> David
