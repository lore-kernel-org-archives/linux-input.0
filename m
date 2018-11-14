From: David Herrmann <dh.herrmann@gmail.com>
Subject: Re: BUG: GPF in non-whitelisted uaccess (non-canonical address?)
Date: Wed, 14 Nov 2018 13:20:53 +0100
Message-ID: <CANq1E4T6+bacZ9iGREtWiyM8eUkAQoxhgFM6rPrzNRkzAcnfJg@mail.gmail.com>
References: <00000000000080f8fa057a67b75c@google.com> <0000000000002d2a5b057a94f7ff@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <0000000000002d2a5b057a94f7ff@google.com>
Sender: linux-kernel-owner@vger.kernel.org
To: syzbot+72473edc9bf4eb1c6556@syzkaller.appspotmail.com
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Jiri Kosina <jikos@kernel.org>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, syzkaller-bugs@googlegroups.com
List-Id: linux-input@vger.kernel.org

Hey

On Wed, Nov 14, 2018 at 1:25 AM syzbot
<syzbot+72473edc9bf4eb1c6556@syzkaller.appspotmail.com> wrote:
> syzbot has found a reproducer for the following crash on:
>
> HEAD commit:    ccda4af0f4b9 Linux 4.20-rc2
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=13b4e77b400000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=4a0a89f12ca9b0f5
> dashboard link: https://syzkaller.appspot.com/bug?extid=72473edc9bf4eb1c6556
> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1646a225400000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=108a6533400000
>
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+72473edc9bf4eb1c6556@syzkaller.appspotmail.com
>
[...]
> BUG: GPF in non-whitelisted uaccess (non-canonical address?)

This uses sendpage(2) to feed data from a file into a uhid chardev.
The default behavior of the kernel is to create a temporary pipe, then
splice from the file into the pipe, and then splice again from the
pipe into uhid.

The kernel provides default implementations for splicing between files
and any other file. The default implementation of `.splice_write()`
uses kmap() to map the page from the pipe and then uses the
__kernel_write() (which uses .f_op->write()) to push the data into the
target file. The problem is, __kernel_write() sets the address-space
to KERNEL_DS `set_fs(get_ds())`, thus granting the UHID request access
to kernel memory.

I see several ways to fix that, the most simple solution is to simply
prevent splice/sendpage on uhid (by setting f_op.splice_write to a
dummy). Alternatively, we can implement a proper splice helper that
takes the page directly, rather than through the __kernel_write()
default implementation.

Thanks
David
