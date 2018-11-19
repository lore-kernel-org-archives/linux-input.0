From: David Herrmann <dh.herrmann@gmail.com>
Subject: Re: [PATCH v2] HID: uhid: forbid UHID_CREATE under KERNEL_DS or
 elevated privileges
Date: Mon, 19 Nov 2018 14:21:47 +0100
Message-ID: <CANq1E4QDP9EiJZG2pqfKtA_ESoBgNb5ECjause2tTUdYWaqYZA@mail.gmail.com>
References: <CAG48ez3bPkh+DMPwiebM+r4ozX2CiVY=9=WMBP_xm1qVaSN4sQ@mail.gmail.com>
 <20181114215509.163600-1-ebiggers@kernel.org> <nycvar.YFH.7.76.1811191351020.21108@cbobk.fhfr.pm>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <nycvar.YFH.7.76.1811191351020.21108@cbobk.fhfr.pm>
Sender: stable-owner@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>
Cc: ebiggers@kernel.org, Benjamin Tissoires <benjamin.tissoires@redhat.com>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, syzkaller-bugs@googlegroups.com, Dmitry Vyukov <dvyukov@google.com>, Dmitry Torokhov <dtor@google.com>, syzbot+72473edc9bf4eb1c6556@syzkaller.appspotmail.com, stable <stable@vger.kernel.org>, Jann Horn <jannh@google.com>, Andy Lutomirski <luto@kernel.org>
List-Id: linux-input@vger.kernel.org

Hey

On Mon, Nov 19, 2018 at 1:52 PM Jiri Kosina <jikos@kernel.org> wrote:
>
>
> [ David added to CC ]
>
> On Wed, 14 Nov 2018, Eric Biggers wrote:
>
> > From: Eric Biggers <ebiggers@google.com>
> >
> > When a UHID_CREATE command is written to the uhid char device, a
> > copy_from_user() is done from a user pointer embedded in the command.
> > When the address limit is KERNEL_DS, e.g. as is the case during
> > sys_sendfile(), this can read from kernel memory.  Alternatively,
> > information can be leaked from a setuid binary that is tricked to write
> > to the file descriptor.  Therefore, forbid UHID_CREATE in these cases.
> >
> > No other commands in uhid_char_write() are affected by this bug and
> > UHID_CREATE is marked as "obsolete", so apply the restriction to
> > UHID_CREATE only rather than to uhid_char_write() entirely.
> >
> > Thanks to Dmitry Vyukov for adding uhid definitions to syzkaller and to
> > Jann Horn for commit 9da3f2b740544 ("x86/fault: BUG() when uaccess
> > helpers fault on kernel addresses"), allowing this bug to be found.
> >
> > Reported-by: syzbot+72473edc9bf4eb1c6556@syzkaller.appspotmail.com
> > Fixes: d365c6cfd337 ("HID: uhid: add UHID_CREATE and UHID_DESTROY events")
> > Cc: <stable@vger.kernel.org> # v3.6+
> > Cc: Jann Horn <jannh@google.com>
> > Cc: Andy Lutomirski <luto@kernel.org>
> > Signed-off-by: Eric Biggers <ebiggers@google.com>
>
> Thanks for the patch. I however believe the fix below is more generic, and
> would prefer taking that one in case noone sees any major flaw in that
> I've overlooked. Thanks.

As Andy rightly pointed out, the credentials check is actually needed.
The scenario here is using a uhid-fd as stdout when executing a
setuid-program. This will possibly end up reading arbitrary memory
from the setuid program and use it as input for the hid-descriptor.

To my knowledge, this is a rather small attack surface. UHID is
usually a privileged interface, which in itself already gives you
ridiculous privileges. Furthermore, it only allows read-access if you
happen to be able to craft the message the setuid program writes
(which must be a valid user-space pointer, pointing to a valid hid
descriptor).
But people have been creative in the past, and they will find a way to
use this. So I do think Eric's patch here is the way to go.

Lastly, this only guards UHID_CREATE, which is already a deprecated
interface for several years. I don't think we can drop it any time
soon, but at least the other uhid interfaces should be safe.

Thanks
David
