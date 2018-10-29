From: Harry Cutts <hcutts@chromium.org>
Subject: Re: Logitech high-resolution scrolling..
Date: Mon, 29 Oct 2018 12:17:12 -0700
Message-ID: <CA+jURcttJs05DFCuKCyOfe3oA9Q_KoiP3+g8-OVu4OPm9ufp6Q@mail.gmail.com>
References: <CAHk-=wjGKhoVaa60i5XZODEtzTUYVV3fouyYL4k=JsPY4K_xjQ@mail.gmail.com>
 <nycvar.YFH.7.76.1810291415570.23511@cbobk.fhfr.pm> <CAHk-=wgwgmcqxChVXQb66itd__qJOBc7LBsJ+nRAM86qJH-S2Q@mail.gmail.com>
 <CAHk-=wiRjotiAcy-=Jv5bMM2-r7KzWRGd84CwGmq1FLb1dWKcA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAHk-=wiRjotiAcy-=Jv5bMM2-r7KzWRGd84CwGmq1FLb1dWKcA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: torvalds@linux-foundation.org
Cc: jikos@kernel.org, benjamin.tissoires@redhat.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Peter Hutterer <peter.hutterer@who-t.net>
List-Id: linux-input@vger.kernel.org

As I explained in the comments, the reason for triggering at the half
multiplier point and then setting a negative remainder is to cater for
wheels that sometimes rest just before they complete a whole "notch"
in clicky mode. On those mice, setting the threshold at a full notch
means that you frequently have to move the wheel a little past its
resting point to trigger the low-res scroll event.

I don't really understand why the half-multiplier thing would cause
the instability; there's still a low-res threshold every 8 high-res
units whichever way you do it, it's just that with the half-multiplier
method it's 4 closer to the point where the wheel was when the device
was connected. Once you've scrolled around a bit in smooth mode that
should be irrelevant, unless you're somehow managing to move the wheel
in whole-notch increments without the help of the ratchet.

Maybe the long-term solution is to use more than just the value of the
current scroll event when deciding whether to send a low-res event. In
the meantime, I'll write a patch putting the threshold at 7/8ths of a
notch, to see if that can solve both issues.

Thanks,

Harry Cutts
Chrome OS Touch/Input team
Harry Cutts
Chrome OS Touch/Input team


On Mon, 29 Oct 2018 at 11:33, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Mon, Oct 29, 2018 at 8:16 AM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > Patch I'm using attached. I'm inclined to just commit it, but if
> > somebody has a better idea, I can test alternatives too.
>
> I committed my patch, as it at least makes the scroll wheel usable.
>
> I'm more than open to further improvements, but I wasn't willing to
> live with the status quo, and carrying this around in my tree as a
> patch kept confusing me while doing merges whenever a conflict
> happened (because the "git diff" that I use to see the conflicts
> obviously also showed my own local modifications).
>
>                  Linus
