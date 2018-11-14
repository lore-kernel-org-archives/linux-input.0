From: Jann Horn <jannh@google.com>
Subject: Re: [PATCH] HID: uhid: prevent uhid_char_write() under KERNEL_DS
Date: Wed, 14 Nov 2018 19:18:39 +0100
Message-ID: <CAG48ez3bPkh+DMPwiebM+r4ozX2CiVY=9=WMBP_xm1qVaSN4sQ@mail.gmail.com>
References: <20181114171447.GA87768@gmail.com> <20181114180217.195917-1-ebiggers@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181114180217.195917-1-ebiggers@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: ebiggers@kernel.org
Cc: dh.herrmann@googlemail.com, Jiri Kosina <jikos@kernel.org>, benjamin.tissoires@redhat.com, linux-input@vger.kernel.org, kernel list <linux-kernel@vger.kernel.org>, syzkaller-bugs@googlegroups.com, Dmitry Vyukov <dvyukov@google.com>, dtor@google.com, syzbot+72473edc9bf4eb1c6556@syzkaller.appspotmail.com, stable@vger.kernel.org, Andy Lutomirski <luto@kernel.org>
List-Id: linux-input@vger.kernel.org

+cc Andy

On Wed, Nov 14, 2018 at 7:03 PM Eric Biggers <ebiggers@kernel.org> wrote:
> When a UHID_CREATE command is written to the uhid char device, a
> copy_from_user() is done from a user pointer embedded in the command.
> When the address limit is KERNEL_DS, e.g. as is the case during
> sendfile(), this can read from kernel memory.  Therefore, UHID_CREATE
> must not be allowed in this case.
>
> For consistency and to make sure all current and future uhid commands
> are covered, apply the restriction to uhid_char_write() as a whole
> rather than to UHID_CREATE specifically.
>
> Thanks to Dmitry Vyukov for adding uhid definitions to syzkaller and to
> Jann Horn for commit 9da3f2b740544 ("x86/fault: BUG() when uaccess
> helpers fault on kernel addresses"), allowing this bug to be found.
>
> Reported-by: syzbot+72473edc9bf4eb1c6556@syzkaller.appspotmail.com

Wheeeee, it found something! :)

> Fixes: d365c6cfd337 ("HID: uhid: add UHID_CREATE and UHID_DESTROY events")
> Cc: <stable@vger.kernel.org> # v3.6+
> Cc: Jann Horn <jannh@google.com>
> Signed-off-by: Eric Biggers <ebiggers@google.com>
> ---
>  drivers/hid/uhid.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/drivers/hid/uhid.c b/drivers/hid/uhid.c
> index 3c55073136064..e94c5e248b56e 100644
> --- a/drivers/hid/uhid.c
> +++ b/drivers/hid/uhid.c
> @@ -705,6 +705,12 @@ static ssize_t uhid_char_write(struct file *file, const char __user *buffer,
>         int ret;
>         size_t len;
>
> +       if (uaccess_kernel()) { /* payload may contain a __user pointer */
> +               pr_err_once("%s: process %d (%s) called from kernel context, this is not allowed.\n",
> +                           __func__, task_tgid_vnr(current), current->comm);
> +               return -EACCES;
> +       }

If this file can conceivably be opened by a process that doesn't have
root privileges, this check should be something along the lines of
ib_safe_file_access() or sg_check_file_access().

Checking for uaccess_kernel() prevents the symptom that syzkaller
notices - a user being able to cause a kernel memory access -, but it
doesn't deal with the case where a user opens a file descriptor to
this device and tricks a more privileged process into writing into it
(e.g. by passing it to a suid binary as stdout or stderr).

Looking closer, I wonder whether this kind of behavior is limited to
the UHID_CREATE request, which has a comment on it saying "/*
Obsolete! Use UHID_CREATE2. */". If we could keep this kind of ugly
kludge away from the code paths you're supposed to be using, that
would be nice...
