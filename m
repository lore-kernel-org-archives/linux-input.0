From: Dave Airlie <airlied@gmail.com>
Subject: Re: Securing non-root X input
Date: Sun, 31 Jan 2010 18:38:51 +1000
Message-ID: <21d7e9971001310038y11a936f2g778f4a3119652692@mail.gmail.com>
References: <20100129232437.GB6992@parisc-linux.org>
	 <20100130074546.GB30378@core.coreip.homeip.net>
	 <20100131013534.GA1331@parisc-linux.org>
	 <20100131071307.GB12320@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iw0-f173.google.com ([209.85.223.173]:37686 "EHLO
	mail-iw0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750728Ab0AaIiw convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 31 Jan 2010 03:38:52 -0500
Received: by iwn3 with SMTP id 3so3334350iwn.23
        for <linux-input@vger.kernel.org>; Sun, 31 Jan 2010 00:38:51 -0800 (PST)
In-Reply-To: <20100131071307.GB12320@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Matthew Wilcox <matthew@wil.cx>, peter.hutterer@who-t.net, linux-input@vger.kernel.org, xorg@freedesktop.org

On Sun, Jan 31, 2010 at 5:13 PM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> On Sat, Jan 30, 2010 at 06:35:47PM -0700, Matthew Wilcox wrote:
>> On Fri, Jan 29, 2010 at 11:45:46PM -0800, Dmitry Torokhov wrote:
>> > Hi Matthew,
>> >
>> > On Fri, Jan 29, 2010 at 04:24:38PM -0700, Matthew Wilcox wrote:
>> > > This tiny patch allows the X server to ask how many times the de=
vice has
>> > > been opened. =A0If it's more than one, the X server can ask the =
user what
>> > > they want to do about it. =A0For bonus points, the X server can =
also run
>> > > programs like lsof or fuser to find out which other processes ha=
ve the
>> > > device open, and tell the user that information too. =A0At that =
point,
>> > > the sysadmin can call in the ICBM strike on the offending user.
>> > >
>> > > Does this approach work for everyone?
>> >
>> > I do not think so. What about the cases when event devices are
>> > legitimately opened by several processes, like this:
>> >
>> > [dtor@dtor-d630 work]$ ps aux | grep hald-addon-input
>> > root =A0 =A0 =A01132 =A00.0 =A00.0 =A022200 =A0 824 ? =A0 =A0 =A0 =
=A0S =A0 =A0Jan22 =A0 0:29
>> > hald-addon-input: Listening on /dev/input/event7 /dev/input/event2=
 /dev/input/event1 /dev/input/event6 /dev/input/event0 /dev/input/event=
12 /dev/input/event4
>> > dtor =A0 =A0 30424 =A00.0 =A00.0 102736 =A0 808 pts/3 =A0 =A0S+ =A0=
 23:23 =A0 0:00 grep hald-addon-input
>> > [dtor@dtor-d630 work]$
>> >
>> > It might not be hald but some other daemon monitoring key presses
>> > (sleep, hibernate, wifi keys and switches, etc).
>> >
>> > If it was just about ensuring that only oneprocess accesses the de=
vice
>> > then we could just use EVIOCGRAB but as experience shows it is not=
 a
>> > workable solution.
>>
>> Yes, that's right. =A0I didn't quite go far enough in my explanation
>> above ... =A0the X server can look around the system to see what tru=
sted
>> daemons (running as either root or the same user as the one running =
X)
>> currently have the device open, and notify the user if there's addit=
ional
>> openers that it isn't expecting.
>>
>
> Then it will be constant race between X and the rest of the world wit=
h X
> pretty much always behind. Kind of like SELinux - as soon as try movi=
ng
> left or right the thing starts screaming at you...
>
>> Maybe we don't need a kernel patch to make this work after all, just
>> a suid helper for X that uses the code from lsof/fuser to list all t=
he
>> current openers of /dev/input/eventN.
>>
>
> But what about the case where malicious user opens the devices after =
the
> X done its scan?

That can't happen since we remove privs from the previous users of the
node before starting the new X server via ConsoleKit or at least thats =
the plan,

The problem is only a user holding open the evdev device after they've =
lost
perms on the device.

Dave.

> mknod is a privileged operation, requiring CAP_MKNOD. Otherwise evcen
> current setup would be completely insecure if any user could just mkn=
od
> in his home directory and snoop root's keypresses at console.

Its more the other devices the kernel might make, or udev. Not sure if
that ever happens though.

Dave.
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
