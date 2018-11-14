From: Eric Biggers <ebiggers@kernel.org>
Subject: Re: BUG: GPF in non-whitelisted uaccess (non-canonical address?)
Date: Wed, 14 Nov 2018 09:14:48 -0800
Message-ID: <20181114171447.GA87768@gmail.com>
References: <00000000000080f8fa057a67b75c@google.com>
 <0000000000002d2a5b057a94f7ff@google.com>
 <CANq1E4T6+bacZ9iGREtWiyM8eUkAQoxhgFM6rPrzNRkzAcnfJg@mail.gmail.com>
 <CACT4Y+b8801QqLe4axBct-cZ2a-jr2S2=MSRhg7rV20bPvUHxQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CACT4Y+b8801QqLe4axBct-cZ2a-jr2S2=MSRhg7rV20bPvUHxQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: David Herrmann <dh.herrmann@gmail.com>
Cc: Dmitry Vyukov <dvyukov@google.com>, Dmitry Torokhov <dtor@google.com>, syzbot+72473edc9bf4eb1c6556@syzkaller.appspotmail.com, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Jiri Kosina <jikos@kernel.org>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, syzkaller-bugs@googlegroups.com
List-Id: linux-input@vger.kernel.org

On Wed, Nov 14, 2018 at 08:52:46AM -0800, 'Dmitry Vyukov' via syzkaller-bugs wrote:
> On Wed, Nov 14, 2018 at 4:20 AM, David Herrmann <dh.herrmann@gmail.com> wrote:
> > Hey
> >
> > On Wed, Nov 14, 2018 at 1:25 AM syzbot
> > <syzbot+72473edc9bf4eb1c6556@syzkaller.appspotmail.com> wrote:
> >> syzbot has found a reproducer for the following crash on:
> >>
> >> HEAD commit:    ccda4af0f4b9 Linux 4.20-rc2
> >> git tree:       upstream
> >> console output: https://syzkaller.appspot.com/x/log.txt?x=13b4e77b400000
> >> kernel config:  https://syzkaller.appspot.com/x/.config?x=4a0a89f12ca9b0f5
> >> dashboard link: https://syzkaller.appspot.com/bug?extid=72473edc9bf4eb1c6556
> >> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
> >> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1646a225400000
> >> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=108a6533400000
> >>
> >> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> >> Reported-by: syzbot+72473edc9bf4eb1c6556@syzkaller.appspotmail.com
> >>
> > [...]
> >> BUG: GPF in non-whitelisted uaccess (non-canonical address?)
> >
> > This uses sendpage(2) to feed data from a file into a uhid chardev.
> > The default behavior of the kernel is to create a temporary pipe, then
> > splice from the file into the pipe, and then splice again from the
> > pipe into uhid.
> >
> > The kernel provides default implementations for splicing between files
> > and any other file. The default implementation of `.splice_write()`
> > uses kmap() to map the page from the pipe and then uses the
> > __kernel_write() (which uses .f_op->write()) to push the data into the
> > target file. The problem is, __kernel_write() sets the address-space
> > to KERNEL_DS `set_fs(get_ds())`, thus granting the UHID request access
> > to kernel memory.
> >
> > I see several ways to fix that, the most simple solution is to simply
> > prevent splice/sendpage on uhid (by setting f_op.splice_write to a
> > dummy). Alternatively, we can implement a proper splice helper that
> > takes the page directly, rather than through the __kernel_write()
> > default implementation.
> 
> also +dtor for uhid
> 

Well, the problem is that uhid_char_write() reads from a user pointer embedded
in the write() payload.  (Which really is abusing write(), but I assume it
cannot be changed at this point...)  Thus it's unsafe to be called under
KERNEL_DS.  So it needs:

	if (uaccess_kernel())
		return -EACCES;

See sg_check_file_access(), called from sg_read() and sg_write(), for another
example of this in the kernel.

- Eric
