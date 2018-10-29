From: Harry Cutts <hcutts@chromium.org>
Subject: Re: Logitech high-resolution scrolling..
Date: Mon, 29 Oct 2018 16:03:54 -0700
Message-ID: <CA+jURcvAQWP-fMLxNBF=PZ7moJZgorjO0SGXn8xSWKt=k+oe1w@mail.gmail.com>
References: <CAHk-=wjGKhoVaa60i5XZODEtzTUYVV3fouyYL4k=JsPY4K_xjQ@mail.gmail.com>
 <nycvar.YFH.7.76.1810291415570.23511@cbobk.fhfr.pm> <CAHk-=wgwgmcqxChVXQb66itd__qJOBc7LBsJ+nRAM86qJH-S2Q@mail.gmail.com>
 <CAHk-=wiRjotiAcy-=Jv5bMM2-r7KzWRGd84CwGmq1FLb1dWKcA@mail.gmail.com>
 <CA+jURcttJs05DFCuKCyOfe3oA9Q_KoiP3+g8-OVu4OPm9ufp6Q@mail.gmail.com>
 <CAHk-=wh3VO9hD9hUBS-H2d4jjGuYuVTudshHsPe9p-5sYhFfGg@mail.gmail.com>
 <CA+jURcvVAJbwazWBByh=GTEV-wC75mZA0oaiX0x4_89F_byM6A@mail.gmail.com> <CAHk-=wihpgjONY2iw5mO9gHcQHxRyj+aQcaX2qd9Tjf-MdGNZg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAHk-=wihpgjONY2iw5mO9gHcQHxRyj+aQcaX2qd9Tjf-MdGNZg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: torvalds@linux-foundation.org
Cc: jikos@kernel.org, benjamin.tissoires@redhat.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Peter Hutterer <peter.hutterer@who-t.net>
List-Id: linux-input@vger.kernel.org

On Mon, 29 Oct 2018 at 15:01, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> That would work, yes.

OK, I'll write a patch for this. (It may be next week, though, as I
have a deadline on a separate project this week.)

> Except I think you *do* want the "reset on direction change" logic,
> because otherwise we still end up having the:
>
> > - we update remainder to -1
>
> where it now gets easier to next time go the wrong way, for no good
> reason.  So now you only need another 6/8ths the other way to get to
> within 7/8ths of -8 and scroll back.
>
> In other words, the whole "round partial scrolling" also causes that
> whole "now the other direction is closer" issue.
>
> At 7/8's it is less obviously a problem than it was at 1/2, but I
> still think it's a sign of an unstable algorithm, where changes get
> triggered too easily in the non-highres world.
>
> Also, honestly, I'm not sure I see the point. *IF* you actually scroll
> more in one direction, it doesn't matter one whit whether you pick
> 1/2, 7/8, or whole multipliers: the *next* step is still always going
> to be one whole multiplier away.
>
> So I think the whole rounding is actually misguided. I think it may
> come from the very fact that you did *not* reset the remainder on
> direction changes, so you could scroll in one direction to -3, and
> then you change direction and go a "whole" tick the other way, but now
> it's just at +5, so you think you need to round up.
>
> With the whole "reset when changing direction", I don't think the
> rounding is necessary, and I don't think it makes sense.

Resetting on direction change would certainly make complete sense in
smooth mode. The reason that I'm reluctant to do it is for clicky
mode, where we think it's important that the low-res event happen at a
consistent point in the movement between notches (the resting
positions of the wheel). For example, imagine the following scenario
with a wheel multiplier of 8 and the threshold initially at 7/8ths of
a notch:

- I scroll one notch down. The low-res event occurs just before the
wheel settles in to its notch, leaving a -1/8th remainder, and then
(on most wheels) the ratchet mechanism settles the wheel 1/8th further
into its resting position, eliminating the remainder.
- I move the wheel 3/8ths further down, then change my mind and start
scrolling upwards.

If we reset on direction change at this point, then the "zero point"
will have moved, so that we trigger the low-res movement at -4/8ths
(at the peak of resistance between the two notches) instead of at
7/8ths. If we don't reset but allow the 3/8ths remainder to be
cleared, the trigger point stays at 7/8ths. It's a minor thing, to be
sure, but we think that keeping the on-screen response consistent with
the tactile feel of the wheel is important for the user experience.

Harry Cutts
Chrome OS Touch/Input team
