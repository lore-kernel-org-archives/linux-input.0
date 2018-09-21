From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: WARNING: kmalloc bug in input_mt_init_slots
Date: Fri, 21 Sep 2018 10:52:19 -0700
Message-ID: <CAKdAkRS7PSXv65MTnvKOewqESxt0_FtKohd86ioOuYR3R0z9dw@mail.gmail.com>
References: <000000000000e5f76c057664e73d@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <000000000000e5f76c057664e73d@google.com>
Sender: linux-kernel-owner@vger.kernel.org
To: syzbot+87829a10073277282ad1@syzkaller.appspotmail.com, Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>, Henrik Rydberg <rydberg@bitmath.org>, syzkaller-bugs@googlegroups.com
List-Id: linux-input@vger.kernel.org

On Fri, Sep 21, 2018 at 10:24 AM syzbot
<syzbot+87829a10073277282ad1@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following crash on:
>
> HEAD commit:    234b69e3e089 ocfs2: fix ocfs2 read block panic
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=131f761a400000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=5fa12be50bca08d8
> dashboard link: https://syzkaller.appspot.com/bug?extid=87829a10073277282ad1
> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=126ca61a400000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=119d6511400000
>
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+87829a10073277282ad1@syzkaller.appspotmail.com
>
> input: syz0 as /devices/virtual/input/input25382
> WARNING: CPU: 0 PID: 11238 at mm/slab_common.c:1031 kmalloc_slab+0x56/0x70
> mm/slab_common.c:1031
> Kernel panic - not syncing: panic_on_warn set ...

This is coming from:

commit 6286ae97d10ea2b5cd90532163797ab217bfdbdf
Author: Christoph Lameter <cl@linux.com>
Date:   Fri May 3 15:43:18 2013 +0000

   slab: Return NULL for oversized allocations

   The inline path seems to have changed the SLAB behavior for very large
   kmalloc allocations with  commit e3366016 ("slab: Use common
   kmalloc_index/kmalloc_size functions"). This patch restores the old
   behavior but also adds diagnostics so that we can figure where in the
   code these large allocations occur.

   Reported-and-tested-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
   Signed-off-by: Christoph Lameter <cl@linux.com>
   Link: http://lkml.kernel.org/r/201305040348.CIF81716.OStQOHFJMFLOVF@I-love.SAKURA.ne.jp
   [ penberg@kernel.org: use WARN_ON_ONCE ]
   Signed-off-by: Pekka Enberg <penberg@kernel.org>

You'll have to convince Cristoph that WARN_ON_ONCE() there is evil and
has to be eradicated so that KASAN can run (but then we'd not know
easily that some allocation failed because it was too big and never
had a chance of succeeding vs. ordinary memory failure).

Can I recommend that maybe you introduce infrastructure for
panic_on_warn to ignore certain "well known" warnings?

Thanks.

-- 
Dmitry
