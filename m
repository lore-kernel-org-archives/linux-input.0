From: Andrey Konovalov <andreyknvl@google.com>
Subject: Re: KASAN: slab-out-of-bounds Read in hidraw_ioctl
Date: Wed, 21 Aug 2019 18:26:33 +0200
Message-ID: <CAAeHK+z-o9naQXZoxwTXRh2WWQzFiRU9XruabNTTm31_1AbjAw@mail.gmail.com>
References: <CAAeHK+xQc5Ce6TwtERTmQ+6qSbuAmGikxCU5SNTdcDAynDEiig@mail.gmail.com>
 <Pine.LNX.4.44L0.1908211223070.1816-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44L0.1908211223070.1816-100000@iolanthe.rowland.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: syzbot <syzbot+5a6c4ec678a0c6ee84ba@syzkaller.appspotmail.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Jiri Kosina <jikos@kernel.org>, linux-input@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, USB list <linux-usb@vger.kernel.org>, syzkaller-bugs <syzkaller-bugs@googlegroups.com>
List-Id: linux-input@vger.kernel.org

On Wed, Aug 21, 2019 at 6:24 PM Alan Stern <stern@rowland.harvard.edu> wrote:
>
> On Wed, 21 Aug 2019, Andrey Konovalov wrote:
>
> > On Wed, Aug 21, 2019 at 3:37 PM syzbot
> > <syzbot+5a6c4ec678a0c6ee84ba@syzkaller.appspotmail.com> wrote:
> > >
> > > Hello,
> > >
> > > syzbot has tested the proposed patch but the reproducer still triggered
> > > crash:
> > > KASAN: slab-out-of-bounds Read in hidraw_ioctl
> >
> > Same here, a different bug.
>
> It looks like I've got the fix for both these bugs.  Testing now...

Great! Do you think "BUG: bad usercopy in hidraw_ioctl" can also be
fixed by one of those fixes?

>
> > > Tested on:
> > >
> > > commit:         e96407b4 usb-fuzzer: main usb gadget fuzzer driver
> > > git tree:       https://github.com/google/kasan.git
> > > console output: https://syzkaller.appspot.com/x/log.txt?x=14f14a1e600000
> > > kernel config:  https://syzkaller.appspot.com/x/.config?x=cfa2c18fb6a8068e
> > > compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> > > patch:          https://syzkaller.appspot.com/x/patch.diff?x=171cd95a600000
>
> Why don't these patch-test reports include the dashboard link?  It sure
> would be handy to have a copy of it here.
>
> Alan Stern
>
