From: Andy Lutomirski <luto@amacapital.net>
Subject: Re: [PATCH v2] HID: uhid: forbid UHID_CREATE under KERNEL_DS or elevated privileges
Date: Thu, 15 Nov 2018 06:49:10 -0800
Message-ID: <58434835-159E-45BC-BD66-EDDAC654A224@amacapital.net>
References: <CAG48ez3bPkh+DMPwiebM+r4ozX2CiVY=9=WMBP_xm1qVaSN4sQ@mail.gmail.com> <20181114215509.163600-1-ebiggers@kernel.org> <CANq1E4Qr+k5hWbxKBQQTO0dSP0QFk4V+hJ9Fmmqz6=cOmfD1KA@mail.gmail.com>
Mime-Version: 1.0 (1.0)
Content-Type: text/plain;
        charset=utf-8
Content-Transfer-Encoding: quoted-printable
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <CANq1E4Qr+k5hWbxKBQQTO0dSP0QFk4V+hJ9Fmmqz6=cOmfD1KA@mail.gmail.com>
Sender: stable-owner@vger.kernel.org
To: David Herrmann <dh.herrmann@gmail.com>
Cc: ebiggers@kernel.org, Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, syzkaller-bugs@googlegroups.com, Dmitry Vyukov <dvyukov@google.com>, Dmitry Torokhov <dtor@google.com>, syzbot+72473edc9bf4eb1c6556@syzkaller.appspotmail.com, stable <stable@vger.kernel.org>, jannh@google.com, Andy Lutomirski <luto@kernel.org>
List-Id: linux-input@vger.kernel.org


> On Nov 15, 2018, at 4:09 AM, David Herrmann <dh.herrmann@gmail.com> wrote:=

>=20
> Hi
>=20
>> On Wed, Nov 14, 2018 at 10:55 PM Eric Biggers <ebiggers@kernel.org> wrote=
:
>> From: Eric Biggers <ebiggers@google.com>
>>=20
>> When a UHID_CREATE command is written to the uhid char device, a
>> copy_from_user() is done from a user pointer embedded in the command.
>> When the address limit is KERNEL_DS, e.g. as is the case during
>> sys_sendfile(), this can read from kernel memory.  Alternatively,
>> information can be leaked from a setuid binary that is tricked to write
>> to the file descriptor.  Therefore, forbid UHID_CREATE in these cases.
>>=20
>> No other commands in uhid_char_write() are affected by this bug and
>> UHID_CREATE is marked as "obsolete", so apply the restriction to
>> UHID_CREATE only rather than to uhid_char_write() entirely.
>>=20
>> Thanks to Dmitry Vyukov for adding uhid definitions to syzkaller and to
>> Jann Horn for commit 9da3f2b740544 ("x86/fault: BUG() when uaccess
>> helpers fault on kernel addresses"), allowing this bug to be found.
>>=20
>> Reported-by: syzbot+72473edc9bf4eb1c6556@syzkaller.appspotmail.com
>> Fixes: d365c6cfd337 ("HID: uhid: add UHID_CREATE and UHID_DESTROY events"=
)
>> Cc: <stable@vger.kernel.org> # v3.6+
>> Cc: Jann Horn <jannh@google.com>
>> Cc: Andy Lutomirski <luto@kernel.org>
>> Signed-off-by: Eric Biggers <ebiggers@google.com>
>> ---
>> drivers/hid/uhid.c | 12 ++++++++++++
>> 1 file changed, 12 insertions(+)
>>=20
>> diff --git a/drivers/hid/uhid.c b/drivers/hid/uhid.c
>> index 3c55073136064..051639c09f728 100644
>> --- a/drivers/hid/uhid.c
>> +++ b/drivers/hid/uhid.c
>> @@ -12,6 +12,7 @@
>>=20
>> #include <linux/atomic.h>
>> #include <linux/compat.h>
>> +#include <linux/cred.h>
>> #include <linux/device.h>
>> #include <linux/fs.h>
>> #include <linux/hid.h>
>> @@ -722,6 +723,17 @@ static ssize_t uhid_char_write(struct file *file, co=
nst char __user *buffer,
>>=20
>>        switch (uhid->input_buf.type) {
>>        case UHID_CREATE:
>> +               /*
>> +                * 'struct uhid_create_req' contains a __user pointer whi=
ch is
>> +                * copied from, so it's unsafe to allow this with elevate=
d
>> +                * privileges (e.g. from a setuid binary) or via kernel_w=
rite().
>> +                */
>> +               if (file->f_cred !=3D current_cred() || uaccess_kernel())=
 {
>=20
> I think `uaccess_kernel()` would be enough. UHID does not check any
> credentials. If you believe this should be there nevertheless, feel
> free to keep it.

The free check is needed.  Without it, consider what sudo >uhid_fd does.  It=
 doesn=E2=80=99t use sudo=E2=80=99s credentials, but it does read its addres=
s space.

Can this patch get a comment added?


> Either way:
>=20
> Acked-by: David Herrmann <dh.herrmann@gmail.com>
>=20
> Thanks
> David
