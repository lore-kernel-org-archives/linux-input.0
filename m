From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Logitech high-resolution scrolling..
Date: Mon, 29 Oct 2018 15:00:40 -0700
Message-ID: <CAHk-=wihpgjONY2iw5mO9gHcQHxRyj+aQcaX2qd9Tjf-MdGNZg@mail.gmail.com>
References: <CAHk-=wjGKhoVaa60i5XZODEtzTUYVV3fouyYL4k=JsPY4K_xjQ@mail.gmail.com>
 <nycvar.YFH.7.76.1810291415570.23511@cbobk.fhfr.pm> <CAHk-=wgwgmcqxChVXQb66itd__qJOBc7LBsJ+nRAM86qJH-S2Q@mail.gmail.com>
 <CAHk-=wiRjotiAcy-=Jv5bMM2-r7KzWRGd84CwGmq1FLb1dWKcA@mail.gmail.com>
 <CA+jURcttJs05DFCuKCyOfe3oA9Q_KoiP3+g8-OVu4OPm9ufp6Q@mail.gmail.com>
 <CAHk-=wh3VO9hD9hUBS-H2d4jjGuYuVTudshHsPe9p-5sYhFfGg@mail.gmail.com> <CA+jURcvVAJbwazWBByh=GTEV-wC75mZA0oaiX0x4_89F_byM6A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CA+jURcvVAJbwazWBByh=GTEV-wC75mZA0oaiX0x4_89F_byM6A@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Harry Cutts <hcutts@chromium.org>
Cc: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-input@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Peter Hutterer <peter.hutterer@who-t.net>
List-Id: linux-input@vger.kernel.org

On Mon, Oct 29, 2018 at 2:42 PM Harry Cutts <hcutts@chromium.org> wrote:
>
> Ah, I see what you mean. So, if we move the threshold to (multiplier -
> 1)/multiplier (7/8) in this case, I think the equivalent scenario
> would be:

That would work, yes.

Except I think you *do* want the "reset on direction change" logic,
because otherwise we still end up having the:

> - we update remainder to -1

where it now gets easier to next time go the wrong way, for no good
reason.  So now you only need another 6/8ths the other way to get to
within 7/8ths of -8 and scroll back.

In other words, the whole "round partial scrolling" also causes that
whole "now the other direction is closer" issue.

At 7/8's it is less obviously a problem than it was at 1/2, but I
still think it's a sign of an unstable algorithm, where changes get
triggered too easily in the non-highres world.

Also, honestly, I'm not sure I see the point. *IF* you actually scroll
more in one direction, it doesn't matter one whit whether you pick
1/2, 7/8, or whole multipliers: the *next* step is still always going
to be one whole multiplier away.

So I think the whole rounding is actually misguided. I think it may
come from the very fact that you did *not* reset the remainder on
direction changes, so you could scroll in one direction to -3, and
then you change direction and go a "whole" tick the other way, but now
it's just at +5, so you think you need to round up.

With the whole "reset when changing direction", I don't think the
rounding is necessary, and I don't think it makes sense.

But I'm willing to test patches. I would suggest looking at the "oops,
direction changed" issue, though, because it really was very annoying.

> I tested these changes with 5 different Logitech mice (see the
> Logitech high-res support patch [0] for details), and did so mainly
> with applications that were *not* high-res aware, using a mix of
> clicky and smooth modes. Admittedly the MX Anywhere 2S was not one of
> my test devices; I had assumed that its behaviour would be
> sufficiently similar to that of the MX Anywhere 2 and the MX Master
> 2S.

I happen to have a MX Master 2S too, but I don't use it because I find
I like the smaller and lightweight "anywhere" mice.

I didn't try the broken case with it, but one thing I notice with the
Master 2S is that it seems to have a "heftier" feel to its wheel. It
may simply have more mass and not be as flighty, and thus show the
issue less.

But that's just a theory. It could just be something that is
individual to some mice.

                       Linus
