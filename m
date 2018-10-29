From: Harry Cutts <hcutts@chromium.org>
Subject: Re: Logitech high-resolution scrolling..
Date: Mon, 29 Oct 2018 14:42:42 -0700
Message-ID: <CA+jURcvVAJbwazWBByh=GTEV-wC75mZA0oaiX0x4_89F_byM6A@mail.gmail.com>
References: <CAHk-=wjGKhoVaa60i5XZODEtzTUYVV3fouyYL4k=JsPY4K_xjQ@mail.gmail.com>
 <nycvar.YFH.7.76.1810291415570.23511@cbobk.fhfr.pm> <CAHk-=wgwgmcqxChVXQb66itd__qJOBc7LBsJ+nRAM86qJH-S2Q@mail.gmail.com>
 <CAHk-=wiRjotiAcy-=Jv5bMM2-r7KzWRGd84CwGmq1FLb1dWKcA@mail.gmail.com>
 <CA+jURcttJs05DFCuKCyOfe3oA9Q_KoiP3+g8-OVu4OPm9ufp6Q@mail.gmail.com> <CAHk-=wh3VO9hD9hUBS-H2d4jjGuYuVTudshHsPe9p-5sYhFfGg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAHk-=wh3VO9hD9hUBS-H2d4jjGuYuVTudshHsPe9p-5sYhFfGg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: torvalds@linux-foundation.org
Cc: jikos@kernel.org, benjamin.tissoires@redhat.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Peter Hutterer <peter.hutterer@who-t.net>
List-Id: linux-input@vger.kernel.org

On Mon, 29 Oct 2018 at 14:12, Linus Torvalds <torvalds@linux-foundation.org>
> So what the half-multiplier did, assuming a multiplier of 8 (which is
> what my MX Anywhere 2S reports) would be:
>
>  - remainder starts at 3
>  - high-res is +1
>  - now remainder is 3+1, and it triggers the >= half logic
>  - 4/8 is 0, but then the code added 1 because high-res was positive,
> so the code decides to add 1
>  - the code does a wheel update of 1, and updates remainder with -8,
> so now it's -4
>
> Next time around, if the high-res update is 0 or -1, it will go the
> other direction. And then it will oscillate.
>
> Notice how tiny movements of +1/-1 in the *high-res* count can
> translate into +1/-1 in the regular wheel movement.

Ah, I see what you mean. So, if we move the threshold to (multiplier -
1)/multiplier (7/8) in this case, I think the equivalent scenario
would be:

- remainder starts at 7
- high-res is +1
- remainder is now 7+1, triggering a low-res update
- 7/8 is 0, but we add one to the remainder in the check making it (7+1)/8 == 1
- we update remainder to -1

This way we're still at least 7/8ths of a notch from the threshold in
either direction, so we shouldn't get the oscillation problem. Does
that sound reasonable, or do you think I've missed something?

> I do not believe that you actually ever *used* that code, or if you
> did, you only did so with applications that were high-res aware and
> ignored the regular wheel entirely because you were testing in an
> environment with other changes than just the kernel.

I tested these changes with 5 different Logitech mice (see the
Logitech high-res support patch [0] for details), and did so mainly
with applications that were *not* high-res aware, using a mix of
clicky and smooth modes. Admittedly the MX Anywhere 2S was not one of
my test devices; I had assumed that its behaviour would be
sufficiently similar to that of the MX Anywhere 2 and the MX Master
2S.

Harry Cutts
Chrome OS Touch/Input team

[0]: https://patchwork.kernel.org/patch/10582935/
