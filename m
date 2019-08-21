From: syzbot <syzbot+5a6c4ec678a0c6ee84ba@syzkaller.appspotmail.com>
Subject: Re: KASAN: slab-out-of-bounds Read in hidraw_ioctl
Date: Wed, 21 Aug 2019 09:13:00 -0700
Message-ID: <000000000000d45a4c0590a2d8bd@google.com>
References: <Pine.LNX.4.44L0.1908211152230.1816-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44L0.1908211152230.1816-100000@iolanthe.rowland.org>
Sender: linux-kernel-owner@vger.kernel.org
To: andreyknvl@google.com, benjamin.tissoires@redhat.com, jikos@kernel.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, stern@rowland.harvard.edu, syzkaller-bugs@googlegroups.com
List-Id: linux-input@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger  
crash:

Reported-and-tested-by:  
syzbot+5a6c4ec678a0c6ee84ba@syzkaller.appspotmail.com

Tested on:

commit:         e96407b4 usb-fuzzer: main usb gadget fuzzer driver
git tree:       https://github.com/google/kasan.git
kernel config:  https://syzkaller.appspot.com/x/.config?x=cfa2c18fb6a8068e
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
patch:          https://syzkaller.appspot.com/x/patch.diff?x=13dca42e600000

Note: testing is done by a robot and is best-effort only.
