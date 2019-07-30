From: syzbot <syzbot+199ea16c7f26418b4365@syzkaller.appspotmail.com>
Subject: Re: WARNING in usbtouch_open
Date: Tue, 30 Jul 2019 03:31:00 -0700
Message-ID: <0000000000003de05e058ee38113@google.com>
References: <1564481531.25582.22.camel@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1564481531.25582.22.camel@suse.com>
Sender: linux-kernel-owner@vger.kernel.org
To: allison@lohutok.net, andreyknvl@google.com, dmitry.torokhov@gmail.com, gregkh@linuxfoundation.org, kstewart@linuxfoundation.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, mpe@ellerman.id.au, oneukum@suse.com, rydberg@bitmath.org, syzkaller-bugs@googlegroups.com, tglx@linutronix.de
List-Id: linux-input@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger  
crash:

Reported-and-tested-by:  
syzbot+199ea16c7f26418b4365@syzkaller.appspotmail.com

Tested on:

commit:         7f7867ff usb-fuzzer: main usb gadget fuzzer driver
git tree:       https://github.com/google/kasan.git usb-fuzzer
kernel config:  https://syzkaller.appspot.com/x/.config?x=792eb47789f57810
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1347ab44600000

Note: testing is done by a robot and is best-effort only.
