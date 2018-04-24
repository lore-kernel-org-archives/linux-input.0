From: "Theodore Y. Ts'o" <tytso@mit.edu>
Subject: Re: WARNING: HARDIRQ-safe -> HARDIRQ-unsafe lock order detected
Date: Tue, 24 Apr 2018 08:55:41 -0400
Message-ID: <20180424125541.GB4189@thunk.org>
References: <0000000000008bce26056a7a6c23@google.com>
 <CAKdAkRRyRPEnghR6YqE++-H=HJbFL0ejK73Z_vMp_TMyNTT4ew@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAKdAkRRyRPEnghR6YqE++-H=HJbFL0ejK73Z_vMp_TMyNTT4ew@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: syzbot <syzbot+e1670f554caa60fb147b@syzkaller.appspotmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>, Henrik Rydberg <rydberg@bitmath.org>, syzkaller-bugs@googlegroups.com
List-Id: linux-input@vger.kernel.org

On Mon, Apr 23, 2018 at 10:49:12AM -0700, Dmitry Torokhov wrote:
> On Sun, Apr 22, 2018 at 7:02 PM, syzbot
> <syzbot+e1670f554caa60fb147b@syzkaller.appspotmail.com> wrote:
> >
> > Hello,
> >
> > syzbot hit the following crash on upstream commit
> > 285848b0f4074f04ab606f1e5dca296482033d54 (Sun Apr 22 04:20:48 2018 +0000)
> > Merge tag 'random_for_linus_stable' of git://git.kernel.org/pub/scm/linux/kernel/git/tytso/random
> > syzbot dashboard link: https://syzkaller.appspot.com/bug?extid=e1670f554caa60fb147b
> 
> Ted,
> 
> input_add_randomness() (that ends up calling crng_reseed() and the new
> numa_crng_init()) is called (and has been called ever since inception)
> from an interrupt context and thus may not sleep. The following commit
> breaks this:

Fixed by: https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1672186.html

Will be pushed to Linux shortly.

						- Ted
