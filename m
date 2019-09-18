From: syzbot <syzbot+403741a091bf41d4ae79@syzkaller.appspotmail.com>
Subject: Re: KASAN: slab-out-of-bounds Write in ga_probe
Date: Wed, 18 Sep 2019 05:07:00 -0700
Message-ID: <000000000000a400c60592d2ac8f@google.com>
References: <CAAeHK+xJgJoR9rODcRH74knaRKmEq+DDVarNNwDMT_Vtg+gV2Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAAeHK+xJgJoR9rODcRH74knaRKmEq+DDVarNNwDMT_Vtg+gV2Q@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: andreyknvl@google.com, benjamin.tissoires@redhat.com, jikos@kernel.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, stern@rowland.harvard.edu, syzkaller-bugs@googlegroups.com
List-Id: linux-input@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger  
crash:

Reported-and-tested-by:  
syzbot+403741a091bf41d4ae79@syzkaller.appspotmail.com

Tested on:

commit:         f0df5c1b usb-fuzzer: main usb gadget fuzzer driver
git tree:       https://github.com/google/kasan.git
kernel config:  https://syzkaller.appspot.com/x/.config?x=5c6633fa4ed00be5
dashboard link: https://syzkaller.appspot.com/bug?extid=403741a091bf41d4ae79
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
patch:          https://syzkaller.appspot.com/x/patch.diff?x=131651c9600000

Note: testing is done by a robot and is best-effort only.
