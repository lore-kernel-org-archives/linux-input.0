From: Bill Gatliff <bgat@billgatliff.com>
Subject: Re: Synchronizing evdev readers and drivers?
Date: Fri, 3 Dec 2010 11:36:50 -0600
Message-ID: <AANLkTimKyU9dhxE5pkwTZ_0m7C1z+KjB-FMqLkA_UsNf@mail.gmail.com>
References: <AANLkTik8X-Xe9fvYUtRObRBP1PyedOu+zwb1SKKf+kgy@mail.gmail.com>
	<20101202212223.GA9864@core.coreip.homeip.net>
	<AANLkTi=vc0b5Zcy=TuVq3=6yZ8eHCEwLQ0hkkk-x-AyZ@mail.gmail.com>
	<20101203124240.GH3182@sirena.org.uk>
	<AANLkTimFoyFksd1orc9Bf8y5y7xQf14i_hhDoRyR3vnE@mail.gmail.com>
	<20101203135346.GI3182@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ew0-f45.google.com ([209.85.215.45]:36844 "EHLO
	mail-ew0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751550Ab0LCRgw convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 3 Dec 2010 12:36:52 -0500
Received: by ewy10 with SMTP id 10so5726881ewy.4
        for <linux-input@vger.kernel.org>; Fri, 03 Dec 2010 09:36:51 -0800 (PST)
In-Reply-To: <20101203135346.GI3182@sirena.org.uk>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: linux-input@vger.kernel.org

Mark:


On Fri, Dec 3, 2010 at 7:53 AM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
>
> Surely that's what poll() and whatnot are for? =A0If userspace has to=
 poll
> at all that seems to be a failure in itself.

The poll() and blocking read() system calls allow an application to
tell an input device that it is prepared to receive an event, and for
an input device driver to tell userspace when an event has occurred.
As implemented in evdev, however, neither system call provides a
natural, consistent way for userspace to tell an input device driver
how often it wants data--- or even if it wants any (at the moment) at
all.

I think that you and I talking about two different scenarios.  You
seem to be focused on the one where userspace is informed when an
input event occurs, but has no ability to request or schedule those
events.  That model makes perfect sense for USB mice and keyboards
where the hardware itself is inherently event-driven.  For those kinds
of devices, users don't know or care when a key will be pressed---
they just need to respond when one is.  So they simply block in a
poll() or read() until a keypress shows up.  Problem solved.

I'm looking at input devices like accelerometers and compasses, which
must be explicitly sampled and can send events at upwards of 4K/sec if
you ask them to.  The vast majority of user applications don't need
data anywhere near that fast, but the range of desirable rates can't
be met by a simple "just sample it at 100 Hz" kernel thread because of
power consumption and phase error issues.  On a cell phone, for
example, some situations call for accelerometer data at 2 Hz while
other modes want the data at 200 Hz with minimal latency.  The current
architecture requires me to implement that range using a dedicated
kernel thread, plus a sysfs attribute/ioctl to dial the rate up or
down from userspace.

=46or something like a pushbutton, sometimes you simply don't care abou=
t
the state of the button except when you are asking for it--- and then
you don't want a sample that might be a few seconds old.  In other
situations, doing a poll() and getting blocked until the pushbutton
changes state works better.  Pushbuttons are therefore kind of a
corner case where the approach you choose depends more on what you
want the application to look like.  (Especially pushbuttons that
aren't connected to interrupt-capable inputs).

I don't want to do an ad-hoc method for communicating a polling rate
request to the hardware for each hardware driver that I have to deal
with.  One way to avoid this is to add a standard sysfs attribute or
ioctl for all input devices, which applications use to specify the
rate that they want the hardware to sample at--- if the hardware works
that way.  That's fine, except that it adds an extra step that
applications have to deal with.  It also forces you to pick an
arbitrary, default sampling rate if the application fails to specify
one.

The other option, which is the one I'm proposing and which seems more
natural for end users, is to add an optional read callback in the
input_dev structure that, if implemented by the driver, will call the
driver back whenever someone is asking for the state of the input
device.  Drivers can then choose to initiate a sampling operation only
when a user is asking for the data.  Users just call poll() or read()
at the rate they want the sampling to occur, and never get blocked for
longer than it takes to acquire a sample.

The advantage to the read callback approach is that users like Android
can completely eliminate all of the kernel threads, etc. that drivers
currently use to make high-rate hardware like accelerometers behave
more like keyboards and mice.  And this does more than simplify a
bunch of code: it also creates a natural place for powering up/down
the hardware between individual samples rather than just when the
interface is opened and closed.  It also automagically throttles up or
down the sampling request rate as necessary to precisely match the
user's demands.

=46inally, with the read callback approach there isn't any behavioral
change in the evdev interface at all for existing drivers (and
existing drivers will continue to work as they do now).  When drivers
start implementing the read callback, users will just notice that
their drivers are simpler and their data is more recent--- if they
care to investigate either of those.

What I'm proposing is something that is very similar to input-polldev,
except that users don't even have to specify the polling rate: they
just call read() or poll() at the rate they want the input device
hardware to scan/sample itself.  Some current users of input-polldev
might be better served by a read callback, in fact.

The read callback approach is completely wrong for USB-ish keyboards
and mice, so those drivers won't implement a read callback.  But for
accelerometers, pushbuttons and such, a read callback seems like a
very useful tool.  I hope to have first-hand evidence of that later
today, preferably in a way that will be useful to the broader
community as well.  :)



b.g.
--=20
Bill Gatliff
bgat@billgatliff.com
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
