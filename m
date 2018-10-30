From: Harry Cutts <hcutts@chromium.org>
Subject: Re: Logitech high-resolution scrolling..
Date: Tue, 30 Oct 2018 10:48:25 -0700
Message-ID: <CA+jURctDNnVjKEZD6jm3ACv1r8_Me9f+6T_aRiApR=Nd_+upvw@mail.gmail.com>
References: <CAHk-=wjGKhoVaa60i5XZODEtzTUYVV3fouyYL4k=JsPY4K_xjQ@mail.gmail.com>
 <nycvar.YFH.7.76.1810291415570.23511@cbobk.fhfr.pm> <CAHk-=wgwgmcqxChVXQb66itd__qJOBc7LBsJ+nRAM86qJH-S2Q@mail.gmail.com>
 <CAHk-=wiRjotiAcy-=Jv5bMM2-r7KzWRGd84CwGmq1FLb1dWKcA@mail.gmail.com>
 <CA+jURcttJs05DFCuKCyOfe3oA9Q_KoiP3+g8-OVu4OPm9ufp6Q@mail.gmail.com>
 <CAHk-=wh3VO9hD9hUBS-H2d4jjGuYuVTudshHsPe9p-5sYhFfGg@mail.gmail.com>
 <CA+jURcvVAJbwazWBByh=GTEV-wC75mZA0oaiX0x4_89F_byM6A@mail.gmail.com>
 <CAHk-=wihpgjONY2iw5mO9gHcQHxRyj+aQcaX2qd9Tjf-MdGNZg@mail.gmail.com>
 <CA+jURcvAQWP-fMLxNBF=PZ7moJZgorjO0SGXn8xSWKt=k+oe1w@mail.gmail.com>
 <20181030062657.GA5380@jelly> <CAHk-=wg5m-zt0Kc0o1mOaZSKUsWbjud9xjZssoHAth=ZxoAhQg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAHk-=wg5m-zt0Kc0o1mOaZSKUsWbjud9xjZssoHAth=ZxoAhQg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: torvalds@linux-foundation.org
Cc: Peter Hutterer <peter.hutterer@who-t.net>, jikos@kernel.org, benjamin.tissoires@redhat.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Nestor Lopez Casado <nlopezcasad@logitech.com>
List-Id: linux-input@vger.kernel.org

Thanks for the analysis, Peter.

On Mon, 29 Oct 2018 at 23:27, Peter Hutterer <peter.hutterer@who-t.net> wro=
te:
> IMO this is a lost battle because you cannot know when the ratchet is
> enabled or not (at least not on all mice). Users switch between ratchet a=
nd
> freewheeling time and once you're out of one mode, you have no reference
> to the other mode's reset point anymore.

It would be a lost battle, if it weren't for the fact that on all the
mice I've tested, putting the wheel back into clicky mode causes the
wheel to jump to the nearest notch resting point, which should mean
that the remainder resets to 0 (or maybe =C2=B11 if the mechanism is worn).

> So my suggestion is to combine Linus' reset with your approach and use th=
e
> center-point for the trigger. This gives us a few events to slide and sti=
ll
> do the right thing, and any direction change will reset anyway. Biggest
> drawback is that the first event after a direction change is triggered
> faster than the next event. Otherwise it feels correct to me, both in
> free-wheeling and in ratchet mode now.

This sounds like a reasonable approach if we find that we can't keep
the triggering point consistent.

> Also, WTF moment: I managed to get the mouse into a state where it would
> only give me 1 hi-res event per notch movement but failed to reproduce th=
at
> again.

Interesting; let me know if you manage to reliably reproduce it. The
only time I've encountered this in the past was when connecting to the
mouse over BLE, where we don't seem to be able to detect if the mouse
is power cycled (meaning that the mouse resets to low-res mode but the
kernel is still expecting high-res reports). I held off on enabling
high-res scrolling over Bluetooth for this reason.

On Tue, 30 Oct 2018 at 09:29, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> I wonder if there's some docs on what Logitech does internally in the
> mouse. It might involve a timeout (ie "if not moving for a while, do
> the rounding _and_ reset), which would probably be too expensive to do
> on the host side.

I've been wondering this as well. Nestor (CCed), is there anything you
can tell us about this?

Harry Cutts
Chrome OS Touch/Input team
