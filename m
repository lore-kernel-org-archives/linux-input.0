From: David Herrmann <dh.herrmann@gmail.com>
Subject: Re: [PATCH v2] HID: uhid: forbid UHID_CREATE under KERNEL_DS or
 elevated privileges
Date: Thu, 15 Nov 2018 13:09:55 +0100
Message-ID: <CANq1E4Qr+k5hWbxKBQQTO0dSP0QFk4V+hJ9Fmmqz6=cOmfD1KA@mail.gmail.com>
References: <CAG48ez3bPkh+DMPwiebM+r4ozX2CiVY=9=WMBP_xm1qVaSN4sQ@mail.gmail.com>
 <20181114215509.163600-1-ebiggers@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20181114215509.163600-1-ebiggers@kernel.org>
Sender: stable-owner@vger.kernel.org
To: ebiggers@kernel.org
Cc: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, syzkaller-bugs@googlegroups.com, Dmitry Vyukov <dvyukov@google.com>, Dmitry Torokhov <dtor@google.com>, syzbot+72473edc9bf4eb1c6556@syzkaller.appspotmail.com, stable <stable@vger.kernel.org>, jannh@google.com, Andy Lutomirski <luto@kernel.org>
List-Id: linux-input@vger.kernel.org

Hi

On Wed, Nov 14, 2018 at 10:55 PM Eric Biggers <ebiggers@kernel.org> wrote:
> From: Eric Biggers <ebiggers@google.com>
>
> When a UHID_CREATE command is written to the uhid char device, a
> copy_from_user() is done from a user pointer embedded in the command.
> When the address limit is KERNEL_DS, e.g. as is the case during
> sys_sendfile(), this can read from kernel memory.  Alternatively,
> information can be leaked from a setuid binary that is tricked to write
> to the file descriptor.  Therefore, forbid UHID_CREATE in these cases.
>
> No other commands in uhid_char_write() are affected by this bug and
> UHID_CREATE is marked as "obsolete", so apply the restriction to
> UHID_CREATE only rather than to uhid_char_write() entirely.
>
> Thanks to Dmitry Vyukov for adding uhid definitions to syzkaller and to
> Jann Horn for commit 9da3f2b740544 ("x86/fault: BUG() when uaccess
> helpers fault on kernel addresses"), allowing this bug to be found.
>
> Reported-by: syzbot+72473edc9bf4eb1c6556@syzkaller.appspotmail.com
> Fixes: d365c6cfd337 ("HID: uhid: add UHID_CREATE and UHID_DESTROY events")
> Cc: <stable@vger.kernel.org> # v3.6+
> Cc: Jann Horn <jannh@google.com>
> Cc: Andy Lutomirski <luto@kernel.org>
> Signed-off-by: Eric Biggers <ebiggers@google.com>
> ---
>  drivers/hid/uhid.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/drivers/hid/uhid.c b/drivers/hid/uhid.c
> index 3c55073136064..051639c09f728 100644
> --- a/drivers/hid/uhid.c
> +++ b/drivers/hid/uhid.c
> @@ -12,6 +12,7 @@
>
>  #include <linux/atomic.h>
>  #include <linux/compat.h>
> +#include <linux/cred.h>
>  #include <linux/device.h>
>  #include <linux/fs.h>
>  #include <linux/hid.h>
> @@ -722,6 +723,17 @@ static ssize_t uhid_char_write(struct file *file, const char __user *buffer,
>
>         switch (uhid->input_buf.type) {
>         case UHID_CREATE:
> +               /*
> +                * 'struct uhid_create_req' contains a __user pointer which is
> +                * copied from, so it's unsafe to allow this with elevated
> +                * privileges (e.g. from a setuid binary) or via kernel_write().
> +                */
> +               if (file->f_cred != current_cred() || uaccess_kernel()) {

I think `uaccess_kernel()` would be enough. UHID does not check any
credentials. If you believe this should be there nevertheless, feel
free to keep it. Either way:

Acked-by: David Herrmann <dh.herrmann@gmail.com>

Thanks
David

> +                       pr_err_once("UHID_CREATE from different security context by process %d (%s), this is not allowed.\n",
> +                                   task_tgid_vnr(current), current->comm);
> +                       ret = -EACCES;
> +                       goto unlock;
> +               }
>                 ret = uhid_dev_create(uhid, &uhid->input_buf);
>                 break;
>         case UHID_CREATE2:
> --
> 2.19.1.930.g4563a0d9d0-goog
>
