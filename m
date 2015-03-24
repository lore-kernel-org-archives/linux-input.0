From: Peter Hutterer <peter.hutterer@who-t.net>
Subject: Re: Logitech T650 is unusable since 3.19.0
Date: Tue, 24 Mar 2015 16:00:05 +1000
Message-ID: <20150324060005.GA24791@jelly.local>
References: <CAJc7LbqPY0hcF-JJh+NUDws8UcoMRfodzZ35q34BPQ+3JAktCA@mail.gmail.com>
 <20150323090920.GA32082@pd.tnic>
 <CAN+gG=H0-uMc9wp8jjy-KbwS+WEse5DSNn0prMs_Fkks2QsD=g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from leo.clearchain.com ([199.73.29.74]:25551 "EHLO
	mail.clearchain.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751013AbbCXGBE (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 24 Mar 2015 02:01:04 -0400
Content-Disposition: inline
In-Reply-To: <CAN+gG=H0-uMc9wp8jjy-KbwS+WEse5DSNn0prMs_Fkks2QsD=g@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Cc: Borislav Petkov <bp@alien8.de>, =?utf-8?B?0JvQtdC20LDQvdC60LjQvSDQmNCy0LDQvQ==?= <abyss.7@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Jiri Kosina <jkosina@suse.cz>, linux-input <linux-input@vger.kernel.org>, Hans de Goede <hdegoede@redhat.com>

On Mon, Mar 23, 2015 at 10:59:24AM -0400, Benjamin Tissoires wrote:
> Hi,
>=20
> On Mon, Mar 23, 2015 at 5:09 AM, Borislav Petkov <bp@alien8.de> wrote=
:
> > CC people.
> >
> > On Mon, Mar 23, 2015 at 11:21:02AM +0300, =D0=9B=D0=B5=D0=B6=D0=B0=D0=
=BD=D0=BA=D0=B8=D0=BD =D0=98=D0=B2=D0=B0=D0=BD wrote:
> >> Hi,
> >>
> >> after update from 3.18.7 to 3.19.x my Logitech touchpad became alm=
ost
> >> unusable. I use OpenSUSE Thumbleweed and tried both custom and van=
illa
> >> kernels. AFAIK, the problem may come with this changes:
> >> http://lkml.iu.edu/hypermail/linux/kernel/1412.1/03246.html
>=20
> Indeed, in 3.19, the touchpad is switched into a "raw" mode where it
> forwards the multitouch points rather than using the mouse emulation
> mode.
>=20
> >>
> >> The symptoms are as follows.
> >>
> >> 1. The touch density is twice reduced: I have to make longer finge=
r
> >> motion for a smaller pointer movement. Possibly, it's because the =
KDE
> >> starts to detect the touchpad as touchpad - and not the mouse as i=
t
> >> was before - and applies some preferences like the pointer
> >> acceleration, etc.
>=20
> That's either a xorg-synaptics or a KDE bug. But that's somewhat
> expected. The synaptics driver was written a long time ago, at a time
> where the touchpads were quite small. With a touchpad this big, the
> xorg driver simply reduces the speed thinking that your finger is not
> moving much.

It's probably a synaptics bug, I'll add it to my todo list to test this
locally.

> Fortunately, in libinput (and so xf86-input-libinput too), we take
> into account the resolution and provide a consistent feeling across
> touchpads from different sizes.
>=20
> >>
> >> 2. Some gestures stopped to work: 3-finger swipe up, down, left, r=
ight
> >> - so, there are no more "history back-forward", "SuperKey", and
> >> "SuperKey + d".
>=20
> That's expected too, and I was not expecting people to rely that much
> on these features.
> Again, this should be handled by the upper layer, not by the kernel t=
o
> provide a consistent experience with different touchpads.
> Libinput began to implement a gesture support, and maybe we should
> consider adding the 3 finger swipes to the supported gestures.

fwiw, we have some rough long-term plans to provide touchpad gestures i=
n X,
but nothing implemented yet. libinput already has patches for this on t=
he
list, it's down to getting the API right and then exporting the data th=
rough
the X protocol.

Having said that: until this is all in place, touchpad gestures simply =
won't
work.

> >> 3. Multi-finger tap detection is awful: it doesn't detect 3-finger=
 tap
> >> in 50%, it sometimes detects 2-finger tap instead of click+drag, o=
r
> >> when the second finger is slightly touching the surface.
>=20
> That is worrisome. It might be a xorg-synaptics bug or a kernel one.
> We (Peter and I) both have a T650, so I guess we can try to reproduce
> this. We might need you to record some evemu traces of the various
> failures.

indeed, please file a bug on bugs.freedesktop.org and assign it to me (=
with
evemu recordings please).

Cheers,
   Peter
=20
> >> Can anyone make a suggestion what should I do, but to stay on an o=
lder
> >> kernel version?
>=20
> To sum up, apologies for breaking your current setup. I still believe
> that we should not rely on the firmware to provide gestures because
> this generates kind of random shortcuts that are more or less properl=
y
> handled by the desktop environment.
> That being said, it broke your setup, so I will add a parameter that
> you can pass on boot to disable this mode. It's not ideal though, I
> concede.
>=20
> I'll come back to you once I have something you can test.
>=20
> Jiri, Peter, Hans, if any of you has a better solution (beside
> reverting the raw mode) or want to add something, please do.
>=20
> Cheers,
> Benjamin
>=20
=20
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
