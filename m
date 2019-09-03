From: syzbot <syzbot+1088533649dafa1c9004@syzkaller.appspotmail.com>
Subject: Re: general protection fault in pk_probe
Date: Tue, 03 Sep 2019 12:46:00 -0700
Message-ID: <00000000000083be0c0591ab561e@google.com>
References: <Pine.LNX.4.44L0.1909031516520.1859-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44L0.1909031516520.1859-100000@iolanthe.rowland.org>
Sender: linux-kernel-owner@vger.kernel.org
To: andreyknvl@google.com, benjamin.tissoires@redhat.com, jikos@kernel.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, stern@rowland.harvard.edu, syzkaller-bugs@googlegroups.com
List-Id: linux-input@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger  
crash:

Reported-and-tested-by:  
syzbot+1088533649dafa1c9004@syzkaller.appspotmail.com

Tested on:

commit:         eea39f24 usb-fuzzer: main usb gadget fuzzer driver
git tree:       https://github.com/google/kasan.git
kernel config:  https://syzkaller.appspot.com/x/.config?x=d0c62209eedfd54e
dashboard link: https://syzkaller.appspot.com/bug?extid=1088533649dafa1c9004
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
patch:          https://syzkaller.appspot.com/x/patch.diff?x=139bc892600000

Note: testing is done by a robot and is best-effort only.
