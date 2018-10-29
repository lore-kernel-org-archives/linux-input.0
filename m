From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Logitech high-resolution scrolling..
Date: Mon, 29 Oct 2018 11:32:56 -0700
Message-ID: <CAHk-=wiRjotiAcy-=Jv5bMM2-r7KzWRGd84CwGmq1FLb1dWKcA@mail.gmail.com>
References: <CAHk-=wjGKhoVaa60i5XZODEtzTUYVV3fouyYL4k=JsPY4K_xjQ@mail.gmail.com>
 <nycvar.YFH.7.76.1810291415570.23511@cbobk.fhfr.pm> <CAHk-=wgwgmcqxChVXQb66itd__qJOBc7LBsJ+nRAM86qJH-S2Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAHk-=wgwgmcqxChVXQb66itd__qJOBc7LBsJ+nRAM86qJH-S2Q@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>
Cc: Harry Cutts <hcutts@chromium.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-input@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, peter.hutterer@who-t.net
List-Id: linux-input@vger.kernel.org

On Mon, Oct 29, 2018 at 8:16 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Patch I'm using attached. I'm inclined to just commit it, but if
> somebody has a better idea, I can test alternatives too.

I committed my patch, as it at least makes the scroll wheel usable.

I'm more than open to further improvements, but I wasn't willing to
live with the status quo, and carrying this around in my tree as a
patch kept confusing me while doing merges whenever a conflict
happened (because the "git diff" that I use to see the conflicts
obviously also showed my own local modifications).

                 Linus
