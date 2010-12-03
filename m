From: Bill Gatliff <bgat@billgatliff.com>
Subject: Re: Synchronizing evdev readers and drivers?
Date: Fri, 3 Dec 2010 13:41:37 -0600
Message-ID: <AANLkTimG0t-1e1s+t-ytXf7e-ZpXFq32C_XVZY6vh59n@mail.gmail.com>
References: <AANLkTik8X-Xe9fvYUtRObRBP1PyedOu+zwb1SKKf+kgy@mail.gmail.com>
	<20101202212223.GA9864@core.coreip.homeip.net>
	<AANLkTi=vc0b5Zcy=TuVq3=6yZ8eHCEwLQ0hkkk-x-AyZ@mail.gmail.com>
	<20101203124240.GH3182@sirena.org.uk>
	<AANLkTimFoyFksd1orc9Bf8y5y7xQf14i_hhDoRyR3vnE@mail.gmail.com>
	<20101203135346.GI3182@sirena.org.uk>
	<AANLkTimKyU9dhxE5pkwTZ_0m7C1z+KjB-FMqLkA_UsNf@mail.gmail.com>
	<20101203185250.GA730@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:35154 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752606Ab0LCTlj convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 3 Dec 2010 14:41:39 -0500
Received: by eye27 with SMTP id 27so5291324eye.19
        for <linux-input@vger.kernel.org>; Fri, 03 Dec 2010 11:41:37 -0800 (PST)
In-Reply-To: <20101203185250.GA730@opensource.wolfsonmicro.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: linux-input@vger.kernel.org

Mark:

On Fri, Dec 3, 2010 at 12:52 PM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> On Fri, Dec 03, 2010 at 11:36:50AM -0600, Bill Gatliff wrote:
>
> I guess my main thing here is that I don't see why we'd want to prese=
nt
> applications with an interface which means we can't make use of hardw=
are
> scheduling facilities where they exist.

We'll still have the option to use those facilities, by merely not
using the read() callback.  The callback option just provides a much
cleaner way to move the problem out to userspace for situations where
that makes more sense.

It isn't a hypothetical situation: as far as I can tell right now,
most Android ports are already pacing their input device sampling in
userspace already.  That in itself doesn't justify implementing the
read callback, but it does suggest that there are situations (ok, at
least one) where users can truly benefit from that control.

I'll also note that even though Android *thinks* it is pacing the
reads, in many of the ports I have looked at it actually isn't--- or
it isn't pacing them strictly by pacing its own read() calls.

> =A0The other thing is that this
> feels like a workaround for applications that are already doing
> application layer scheduling rather than anything else and that feels
> more like a workaround for a lack of control provided by the kernel t=
han
> anything else.

Yes.  And the read callback seems a very clean way to implement that co=
ntrol.

> This is what I'm saying the sysfs interface polldev provides (or a
> similar interface done via ioctl() or whatever) should do.

True, except in this specific situation we can get the behavior we
want without adding interfaces.  (It probably still makes sense to
standardize a sysfs/ioctl API anyway, for situations where
applications don't want to do the pacing themselves).

> No, not at all. =A0What I'm saying is that userspace should be able t=
o
> express to the kernel that it wants events delivering at a given rate
> and the kernel should then attempt to deliver events at that rate.

Right.  And I'm saying that the other way to do that is for
applications to just ask for the data at whatever rate they want, and
we give the data to them at that rate.

> This is also true for things like touchscreens which work by
> continuously delivering samples (ideally only while there is a touch)=
 at
> intervals which currently can't be configured in the application laye=
r -
> they're also polling, and they may not even be doing so in hardware.

True.  The tsc2003 and similar resistive touch "controllers" come to
mind.  They are really just two ADCs that you can read as fast--- or
as slow--- as you want.

> Right, and what I'm saying is that userspace should just say what rat=
e
> it wants and then get that.

We're mostly in violent agreement here.  :)  We just differ in how the
application communicates the desired rate to the interface.  I'm not
sure that the two approaches are mutually-exclusive.

> Resolving the rate needs of multiple simultaneous users sounds like a
> tractable bit of programming which we'd only ever need to do once in =
the
> input layer, surely?

Heck if I know.  :)  I hadn't though much about this problem until a
few days ago.  I certainly can't claim to understand the entire scope
of it just yet...

> For a devices like touchscreens driving the reads from the applicatio=
n
> would typically be a 50-100% overhead on the I/O costs and involves
> blocking the application while the conversion happens, neither of whi=
ch
> seems desirable.

So a touch controller driver probably isn't going to bother with the
read callback.

> This seems painful for applications, it means they need to deal with
> their own data scheduling and means we have to take the hit of
> explicitly polling the device even when it is capable of pushing the
> data at us. =A0If we triggered the callback on poll() they'd also hav=
e
> issues blocking on other file descriptors simultaneously.

Yea, I'm not sure that hitting the callback in poll() is appropriate.
Still noodling on that one.

> Assuming the applications are behaving as you describe and not blocki=
ng
> waiting for data - I'd expect that if they block waiting for data the=
y'd
> also end up seeing data delievered much faster.

Even in my read callback implementation, the application still always
gets blocked until a sample shows up in the event FIFO.  The read
callback just gives a driver a chance to know when the application is
desiring another sample.

> I don't see any meaningful difference in the timeliness of data
> delivery with the two approaches - no matter who's clocking the poll =
the
> application will get the data at pretty much the same time after the
> sample, the difference would be for applications that current schedul=
e
> their own reads.

If the driver is doing periodic sampling, without consideration for
whether an application is actually reading the interface, it will fill
the event FIFO with data that the application doesn't pick up until
later.  Depending on the sampling rate, that can amount to a very
large delay (relatively speaking) between when the sample is taken by
the hardware and when it's delivered to applications.

> Perhaps I'm missing something here but my experience has always been
> that having to worry about time periods adds rather than removes
> complexity in applications

True.  But in this case, the code on the application side is already
there: a pthread running a while(1) loop with an msleep.  Ugly to
some, but it works.

> Pushbuttons seem like they'd want to be event driven, surely?

In many cases, yes.  I mentioned them mostly because they are easier
to discuss/type than accelerometers and such.  :)


b.g.
--=20
Bill Gatliff
bgat@billgatliff.com
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
