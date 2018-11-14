From: Jann Horn <jannh@google.com>
Subject: Re: [PATCH v2] HID: uhid: forbid UHID_CREATE under KERNEL_DS or
 elevated privileges
Date: Wed, 14 Nov 2018 23:37:47 +0100
Message-ID: <CAG48ez1GH5=d2LcSVA=+AoW6zB=BELr1QL34f3jrA8ip_6WMtQ@mail.gmail.com>
References: <CAG48ez3bPkh+DMPwiebM+r4ozX2CiVY=9=WMBP_xm1qVaSN4sQ@mail.gmail.com>
 <20181114215509.163600-1-ebiggers@kernel.org> <CAG48ez02ZYZOKRXuZ9yYUijZnaaw=G7-KYu1rB7C99+B45VqjQ@mail.gmail.com>
 <CAE_wzQ_GqjwkhUjoPs3h-s7KSVe8KoH-uu-4mf672JN0X89d6g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <CAE_wzQ_GqjwkhUjoPs3h-s7KSVe8KoH-uu-4mf672JN0X89d6g@mail.gmail.com>
Sender: stable-owner@vger.kernel.org
To: dtor@google.com
Cc: ebiggers@kernel.org, dh.herrmann@googlemail.com, Jiri Kosina <jikos@kernel.org>, benjamin.tissoires@redhat.com, linux-input@vger.kernel.org, kernel list <linux-kernel@vger.kernel.org>, syzkaller-bugs@googlegroups.com, Dmitry Vyukov <dvyukov@google.com>, syzbot+72473edc9bf4eb1c6556@syzkaller.appspotmail.com, stable@vger.kernel.org, Andy Lutomirski <luto@kernel.org>
List-Id: linux-input@vger.kernel.org

On Wed, Nov 14, 2018 at 11:29 PM Dmitry Torokhov <dtor@google.com> wrote:
> On Wed, Nov 14, 2018 at 2:05 PM Jann Horn <jannh@google.com> wrote:
> > On Wed, Nov 14, 2018 at 10:55 PM Eric Biggers <ebiggers@kernel.org> wrote:
> > > When a UHID_CREATE command is written to the uhid char device, a
> > > copy_from_user() is done from a user pointer embedded in the command.
> > > When the address limit is KERNEL_DS, e.g. as is the case during
> > > sys_sendfile(), this can read from kernel memory.  Alternatively,
> > > information can be leaked from a setuid binary that is tricked to write
> > > to the file descriptor.  Therefore, forbid UHID_CREATE in these cases.
> > >
> > > No other commands in uhid_char_write() are affected by this bug and
> > > UHID_CREATE is marked as "obsolete", so apply the restriction to
> > > UHID_CREATE only rather than to uhid_char_write() entirely.
[...]
> > > diff --git a/drivers/hid/uhid.c b/drivers/hid/uhid.c
[...]
> > > @@ -722,6 +723,17 @@ static ssize_t uhid_char_write(struct file *file, const char __user *buffer,
> > >
> > >         switch (uhid->input_buf.type) {
> > >         case UHID_CREATE:
> > > +               /*
> > > +                * 'struct uhid_create_req' contains a __user pointer which is
> > > +                * copied from, so it's unsafe to allow this with elevated
> > > +                * privileges (e.g. from a setuid binary) or via kernel_write().
> > > +                */
>
> uhid is a privileged interface so we would go from root to less
> privileged (if at all). If non-privileged process can open uhid it can
> construct virtual keyboard and inject whatever keystrokes it wants.
>
> Also, instead of disallowing access, can we ensure that we switch back
> to USER_DS before trying to load data from the user pointer?

Does that even make sense? You are using some deprecated legacy
interface; you interact with it by splicing a request from something
like a file or a pipe into the uhid device; but the request you're
splicing through contains a pointer into userspace memory? Do you know
of anyone who is actually doing that? If not, anyone who does want to
do this for some reason in the future can just go use UHID_CREATE2
instead.

> > > +               if (file->f_cred != current_cred() || uaccess_kernel()) {
> > > +                       pr_err_once("UHID_CREATE from different security context by process %d (%s), this is not allowed.\n",
> > > +                                   task_tgid_vnr(current), current->comm);
> > > +                       ret = -EACCES;
> > > +                       goto unlock;
> > > +               }
> > >                 ret = uhid_dev_create(uhid, &uhid->input_buf);
> > >                 break;
> > >         case UHID_CREATE2:
