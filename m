From: syzbot <syzbot+14b53bfeb17f2b210eb7@syzkaller.appspotmail.com>
Subject: Re: WARNING: ODEBUG bug in usbhid_disconnect (2)
Date: Thu, 05 Sep 2019 04:27:00 -0700
Message-ID: <000000000000a2044d0591cc99b2@google.com>
References: <CAAeHK+xJrv1hCbO5qOGTBu=c8STo+-obatOGZ4cHkbuhqmEvrg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAAeHK+xJrv1hCbO5qOGTBu=c8STo+-obatOGZ4cHkbuhqmEvrg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Roderick.Colenbrander@sony.com, andreyknvl@google.com, benjamin.tissoires@redhat.com, jikos@kernel.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, stern@rowland.harvard.edu, syzkaller-bugs@googlegroups.com
List-Id: linux-input@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger  
crash:

Reported-and-tested-by:  
syzbot+14b53bfeb17f2b210eb7@syzkaller.appspotmail.com

Tested on:

commit:         eea39f24 usb-fuzzer: main usb gadget fuzzer driver
git tree:       https://github.com/google/kasan.git
kernel config:  https://syzkaller.appspot.com/x/.config?x=d0c62209eedfd54e
dashboard link: https://syzkaller.appspot.com/bug?extid=14b53bfeb17f2b210eb7
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
patch:          https://syzkaller.appspot.com/x/patch.diff?x=12b6944e600000

Note: testing is done by a robot and is best-effort only.
