From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Logitech high-resolution scrolling..
Date: Tue, 30 Oct 2018 09:29:16 -0700
Message-ID: <CAHk-=wg5m-zt0Kc0o1mOaZSKUsWbjud9xjZssoHAth=ZxoAhQg@mail.gmail.com>
References: <CAHk-=wjGKhoVaa60i5XZODEtzTUYVV3fouyYL4k=JsPY4K_xjQ@mail.gmail.com>
 <nycvar.YFH.7.76.1810291415570.23511@cbobk.fhfr.pm> <CAHk-=wgwgmcqxChVXQb66itd__qJOBc7LBsJ+nRAM86qJH-S2Q@mail.gmail.com>
 <CAHk-=wiRjotiAcy-=Jv5bMM2-r7KzWRGd84CwGmq1FLb1dWKcA@mail.gmail.com>
 <CA+jURcttJs05DFCuKCyOfe3oA9Q_KoiP3+g8-OVu4OPm9ufp6Q@mail.gmail.com>
 <CAHk-=wh3VO9hD9hUBS-H2d4jjGuYuVTudshHsPe9p-5sYhFfGg@mail.gmail.com>
 <CA+jURcvVAJbwazWBByh=GTEV-wC75mZA0oaiX0x4_89F_byM6A@mail.gmail.com>
 <CAHk-=wihpgjONY2iw5mO9gHcQHxRyj+aQcaX2qd9Tjf-MdGNZg@mail.gmail.com>
 <CA+jURcvAQWP-fMLxNBF=PZ7moJZgorjO0SGXn8xSWKt=k+oe1w@mail.gmail.com> <20181030062657.GA5380@jelly>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181030062657.GA5380@jelly>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Hutterer <peter.hutterer@who-t.net>
Cc: Harry Cutts <hcutts@chromium.org>, Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-input@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

On Mon, Oct 29, 2018 at 11:27 PM Peter Hutterer
<peter.hutterer@who-t.net> wrote:
>
> Other issues I found with an MX Anywhere 2S is that on slow scroll and in
> ratchet mode we get some scroll jitter.  In ratchet mode  we can get this
> sequence if you scroll just past the notch and it snaps back:
>     [1, 1, 1, 1, 1, 1, 1, 1, -1]
> That's quite easy to trigger. In free-wheel mode we may get the same for
> slow motion due to human finger jitter (the Anywhere 2S didn't have HW
> jitter, but other devices may). So a perceived-consistent scroll motion may
> really look like this:
>     [1, 1, 1, 1, 1, -1, 1, 1]
> Hard to triggger but when it does, it feels like we're dropping events.
> The former isn't that much of an issue as long as the ratchet is enabled so
> you get the haptic feedback and we (usually) don't drop events.

Both of these actually argue that doing the reset on direction change
can be a real problem.

But equally clearly, _not_ doing the reset is unacceptable too.

I wonder if there's some docs on what Logitech does internally in the
mouse. It might involve a timeout (ie "if not moving for a while, do
the rounding _and_ reset), which would probably be too expensive to do
on the host side.

                    Linus
