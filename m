From: Johan Hovold <johan@kernel.org>
Subject: Re: KASAN: use-after-free Read in usb_anchor_resume_wakeups
Date: Wed, 25 Sep 2019 09:16:14 +0200
Message-ID: <20190925071614.GA14159@localhost>
References: <000000000000e9312b058d3eadb8@google.com>
 <CAAeHK+yPewmT9J0mAYL0P2Wz55asVFD0DbQnwkBS7zdRTkyN2A@mail.gmail.com>
 <CAL411-o09wBhiPtRixFo4=6pB1rAmUsTKc2sBQmn4MjQcPBy2A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAL411-o09wBhiPtRixFo4=6pB1rAmUsTKc2sBQmn4MjQcPBy2A@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Chen <hzpeterchen@gmail.com>
Cc: Andrey Konovalov <andreyknvl@google.com>, syzbot <syzbot+58e201002fe1e775e1ae@syzkaller.appspotmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, Allison Randal <allison@lohutok.net>, Ramses =?iso-8859-1?Q?Ram=EDrez?= <ramzeto@gmail.com>, Richard Fontana <rfontana@redhat.com>, Cameron Gutman <aicommander@gmail.com>, Tom Panfil <tom@steelseries.com>, linux-input@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Gustavo A. R. Silva" <gustavo@embeddedor.com>, LKML <linux-kernel@vger.kernel.org>, USB list <linux-usb@vger.kernel.org>, syzkaller-bugs <syzkaller-bugs@googlegroups.com>
List-Id: linux-input@vger.kernel.org

On Mon, Sep 23, 2019 at 05:41:54PM +0800, Peter Chen wrote:
> > On Tue, Jul 9, 2019 at 2:27 PM syzbot
> > <syzbot+58e201002fe1e775e1ae@syzkaller.appspotmail.com> wrote:
> > >
> > > Hello,
> > >
> > > syzbot found the following crash on:
> > >
> > > HEAD commit:    7829a896 usb-fuzzer: main usb gadget fuzzer driver
> > > git tree:       https://github.com/google/kasan.git usb-fuzzer
> > > console output: https://syzkaller.appspot.com/x/log.txt?x=118d136da00000
> > > kernel config:  https://syzkaller.appspot.com/x/.config?x=f6d4561982f71f63
> > > dashboard link: https://syzkaller.appspot.com/bug?extid=58e201002fe1e775e1ae
> > > compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> > >
> > > Unfortunately, I don't have any reproducer for this crash yet.
> > >
> > > IMPORTANT: if you fix the bug, please add the following tag to the commit:
> > > Reported-by: syzbot+58e201002fe1e775e1ae@syzkaller.appspotmail.com
> > >
> > > dummy_hcd dummy_hcd.5: no ep configured for urb 00000000c6093b7b
> > > xpad 6-1:0.169: xpad_irq_out - usb_submit_urb failed with result -19
> > > ==================================================================
> > > BUG: KASAN: use-after-free in debug_spin_lock_before
> > > kernel/locking/spinlock_debug.c:83 [inline]
> > > BUG: KASAN: use-after-free in do_raw_spin_lock+0x24d/0x280
> > > kernel/locking/spinlock_debug.c:112
> > > Read of size 4 at addr ffff8881d0e584dc by task kworker/1:4/2786
> > >
> 
> It should due to URB is freed at xpad_disconnect, but xpad_irq_out
> still tries to access
> freed URB.
> 
> Peter
> 
> #syz test: https://github.com/google/kasan.git 7829a896
> 
> diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
> index 6b40a1c68f9f..32b7a199b580 100644
> --- a/drivers/input/joystick/xpad.c
> +++ b/drivers/input/joystick/xpad.c
> @@ -1850,6 +1850,7 @@ static void xpad_disconnect(struct usb_interface *intf)
> 
>         xpad_deinit_input(xpad);
> 
> +       usb_kill_urb(xpad->irq_out);

I'm not sure this is the right fix. The interrupt-urb should have been
stopped by xpad_stop_output() just above. Perhaps the type test in that
function is broken, or we may have a race where another thread is
submitting the URB after we tried to stop it which we fail to handle.

Didn't check that closely, though.

Johan
