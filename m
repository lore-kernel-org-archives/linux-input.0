From: Jiri Kosina <jikos@kernel.org>
Subject: Re: Logitech high-resolution scrolling..
Date: Mon, 29 Oct 2018 14:18:10 +0100 (CET)
Message-ID: <nycvar.YFH.7.76.1810291415570.23511@cbobk.fhfr.pm>
References: <CAHk-=wjGKhoVaa60i5XZODEtzTUYVV3fouyYL4k=JsPY4K_xjQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAHk-=wjGKhoVaa60i5XZODEtzTUYVV3fouyYL4k=JsPY4K_xjQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Harry Cutts <hcutts@chromium.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-input@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Peter Hutterer <peter.hutterer@who-t.net>
List-Id: linux-input@vger.kernel.org

On Sun, 28 Oct 2018, Linus Torvalds wrote:

> So I use a Logitech MX Anywhere 2S mouse, and really like it. I have
> the scroll-wheel unlocked, because I like flicking once to scroll a
> lot.
> 
> However, the new high-res scroll code means that the scroll wheel
> action is now much too sensitive. It's not even stable - it will
> scroll back-and-forth a bit occasionally, and in fact it sometimes
> seems to scroll not because I touch the scroll-wheel, but because the
> movement of the mouse itself causes the scroll wheel to move slightly
> and wiggle the scroll action.
> 
> So the recent change to enable the high-res scrolling really seems a
> bit *too* extreme.
> 
> Is there some middle ground that turns the mouse from "look at it
> sideways and it starts scrolling" to something slightly more
> reasonable?

Benjamin indicated that Peter probably has found the issue in the code 
(failure to properly reset on direction change) that might be causing 
this. Adding to CC.

Peter?

Thanks,

-- 
Jiri Kosina
SUSE Labs
