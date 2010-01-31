From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: Securing non-root X input
Date: Sun, 31 Jan 2010 00:50:01 -0800
Message-ID: <20100131085000.GC12320@core.coreip.homeip.net>
References: <20100129232437.GB6992@parisc-linux.org>
 <20100130074546.GB30378@core.coreip.homeip.net>
 <20100131013534.GA1331@parisc-linux.org>
 <20100131071307.GB12320@core.coreip.homeip.net>
 <21d7e9971001310038y11a936f2g778f4a3119652692@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-px0-f182.google.com ([209.85.216.182]:63714 "EHLO
	mail-px0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751867Ab0AaIuH (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 31 Jan 2010 03:50:07 -0500
Received: by pxi12 with SMTP id 12so3158344pxi.33
        for <linux-input@vger.kernel.org>; Sun, 31 Jan 2010 00:50:05 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <21d7e9971001310038y11a936f2g778f4a3119652692@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dave Airlie <airlied@gmail.com>
Cc: Matthew Wilcox <matthew@wil.cx>, peter.hutterer@who-t.net, linux-input@vger.kernel.org, xorg@freedesktop.org

On Sun, Jan 31, 2010 at 06:38:51PM +1000, Dave Airlie wrote:
> On Sun, Jan 31, 2010 at 5:13 PM, Dmitry Torokhov
> <dmitry.torokhov@gmail.com> wrote:
> > On Sat, Jan 30, 2010 at 06:35:47PM -0700, Matthew Wilcox wrote:
> >> On Fri, Jan 29, 2010 at 11:45:46PM -0800, Dmitry Torokhov wrote:
> >> > Hi Matthew,
> >> >
> >> > On Fri, Jan 29, 2010 at 04:24:38PM -0700, Matthew Wilcox wrote:
> >> > > This tiny patch allows the X server to ask how many times the =
device has
> >> > > been opened. =A0If it's more than one, the X server can ask th=
e user what
> >> > > they want to do about it. =A0For bonus points, the X server ca=
n also run
> >> > > programs like lsof or fuser to find out which other processes =
have the
> >> > > device open, and tell the user that information too. =A0At tha=
t point,
> >> > > the sysadmin can call in the ICBM strike on the offending user=
=2E
> >> > >
> >> > > Does this approach work for everyone?
> >> >
> >> > I do not think so. What about the cases when event devices are
> >> > legitimately opened by several processes, like this:
> >> >
> >> > [dtor@dtor-d630 work]$ ps aux | grep hald-addon-input
> >> > root =A0 =A0 =A01132 =A00.0 =A00.0 =A022200 =A0 824 ? =A0 =A0 =A0=
 =A0S =A0 =A0Jan22 =A0 0:29
> >> > hald-addon-input: Listening on /dev/input/event7 /dev/input/even=
t2 /dev/input/event1 /dev/input/event6 /dev/input/event0 /dev/input/eve=
nt12 /dev/input/event4
> >> > dtor =A0 =A0 30424 =A00.0 =A00.0 102736 =A0 808 pts/3 =A0 =A0S+ =
=A0 23:23 =A0 0:00 grep hald-addon-input
> >> > [dtor@dtor-d630 work]$
> >> >
> >> > It might not be hald but some other daemon monitoring key presse=
s
> >> > (sleep, hibernate, wifi keys and switches, etc).
> >> >
> >> > If it was just about ensuring that only oneprocess accesses the =
device
> >> > then we could just use EVIOCGRAB but as experience shows it is n=
ot a
> >> > workable solution.
> >>
> >> Yes, that's right. =A0I didn't quite go far enough in my explanati=
on
> >> above ... =A0the X server can look around the system to see what t=
rusted
> >> daemons (running as either root or the same user as the one runnin=
g X)
> >> currently have the device open, and notify the user if there's add=
itional
> >> openers that it isn't expecting.
> >>
> >
> > Then it will be constant race between X and the rest of the world w=
ith X
> > pretty much always behind. Kind of like SELinux - as soon as try mo=
ving
> > left or right the thing starts screaming at you...
> >
> >> Maybe we don't need a kernel patch to make this work after all, ju=
st
> >> a suid helper for X that uses the code from lsof/fuser to list all=
 the
> >> current openers of /dev/input/eventN.
> >>
> >
> > But what about the case where malicious user opens the devices afte=
r the
> > X done its scan?
>=20
> That can't happen since we remove privs from the previous users of th=
e
> node before starting the new X server via ConsoleKit or at least that=
s the plan,
>=20
> The problem is only a user holding open the evdev device after they'v=
e lost
> perms on the device.
>=20

I see. How revoke will help here though? How will we know which
descriptors shoudl be revoked and which should be left alone?

> > mknod is a privileged operation, requiring CAP_MKNOD. Otherwise evc=
en
> > current setup would be completely insecure if any user could just m=
knod
> > in his home directory and snoop root's keypresses at console.
>=20
> Its more the other devices the kernel might make, or udev. Not sure i=
f
> that ever happens though.
>=20

This is distro config and may happen now (udev creates a non-root devic=
e
if misconfigured etc).

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
