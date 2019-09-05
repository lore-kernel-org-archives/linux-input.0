From: Andrey Konovalov <andreyknvl@google.com>
Subject: Re: WARNING: ODEBUG bug in usbhid_disconnect (2)
Date: Thu, 5 Sep 2019 13:28:57 +0200
Message-ID: <CAAeHK+xVqvBGJ9dXTijuHusJr6vq85DVnKZbHsdyE8-pbWf-9Q@mail.gmail.com>
References: <CAAeHK+xJrv1hCbO5qOGTBu=c8STo+-obatOGZ4cHkbuhqmEvrg@mail.gmail.com>
 <000000000000a2044d0591cc99b2@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <000000000000a2044d0591cc99b2@google.com>
Sender: linux-kernel-owner@vger.kernel.org
To: syzbot <syzbot+14b53bfeb17f2b210eb7@syzkaller.appspotmail.com>
Cc: Roderick.Colenbrander@sony.com, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Jiri Kosina <jikos@kernel.org>, linux-input@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, USB list <linux-usb@vger.kernel.org>, Alan Stern <stern@rowland.harvard.edu>, syzkaller-bugs <syzkaller-bugs@googlegroups.com>
List-Id: linux-input@vger.kernel.org

On Thu, Sep 5, 2019 at 1:27 PM syzbot
<syzbot+14b53bfeb17f2b210eb7@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot has tested the proposed patch and the reproducer did not trigger
> crash:
>
> Reported-and-tested-by:
> syzbot+14b53bfeb17f2b210eb7@syzkaller.appspotmail.com
>
> Tested on:
>
> commit:         eea39f24 usb-fuzzer: main usb gadget fuzzer driver
> git tree:       https://github.com/google/kasan.git
> kernel config:  https://syzkaller.appspot.com/x/.config?x=d0c62209eedfd54e
> dashboard link: https://syzkaller.appspot.com/bug?extid=14b53bfeb17f2b210eb7
> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> patch:          https://syzkaller.appspot.com/x/patch.diff?x=12b6944e600000
>
> Note: testing is done by a robot and is best-effort only.

Nice! Let's mark this one as fixed:

#syz fix: HID: sony: Fix memory corruption issue on cleanup.
