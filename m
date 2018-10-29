From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Logitech high-resolution scrolling..
Date: Mon, 29 Oct 2018 14:11:36 -0700
Message-ID: <CAHk-=wh3VO9hD9hUBS-H2d4jjGuYuVTudshHsPe9p-5sYhFfGg@mail.gmail.com>
References: <CAHk-=wjGKhoVaa60i5XZODEtzTUYVV3fouyYL4k=JsPY4K_xjQ@mail.gmail.com>
 <nycvar.YFH.7.76.1810291415570.23511@cbobk.fhfr.pm> <CAHk-=wgwgmcqxChVXQb66itd__qJOBc7LBsJ+nRAM86qJH-S2Q@mail.gmail.com>
 <CAHk-=wiRjotiAcy-=Jv5bMM2-r7KzWRGd84CwGmq1FLb1dWKcA@mail.gmail.com> <CA+jURcttJs05DFCuKCyOfe3oA9Q_KoiP3+g8-OVu4OPm9ufp6Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CA+jURcttJs05DFCuKCyOfe3oA9Q_KoiP3+g8-OVu4OPm9ufp6Q@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Harry Cutts <hcutts@chromium.org>
Cc: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-input@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, peter.hutterer@who-t.net
List-Id: linux-input@vger.kernel.org

On Mon, Oct 29, 2018 at 12:17 PM Harry Cutts <hcutts@chromium.org> wrote:
>
> I don't really understand why the half-multiplier thing would cause
> the instability; there's still a low-res threshold every 8 high-res
> units whichever way you do it

No there isn't.

So what the half-multiplier did, assuming a multiplier of 8 (which is
what my MX Anywhere 2S reports) would be:

 - remainder starts at 3
 - high-res is +1
 - now remainder is 3+1, and it triggers the >= half logic
 - 4/8 is 0, but then the code added 1 because high-res was positive,
so the code decides to add 1
 - the code does a wheel update of 1, and updates remainder with -8,
so now it's -4

Next time around, if the high-res update is 0 or -1, it will go the
other direction. And then it will oscillate.

Notice how tiny movements of +1/-1 in the *high-res* count can
translate into +1/-1 in the regular wheel movement.

And those tiny movements very definitely happen. Maybe it's just my
mouse, but the undeniable fact is that the old algorithm was simply
not stable.

It was literally unusable. I had to be careful not to even touch the
wheel at all, or it would scroll randomly.

I do not believe that you actually ever *used* that code, or if you
did, you only did so with applications that were high-res aware and
ignored the regular wheel entirely because you were testing in an
environment with other changes than just the kernel.

                    Linus
