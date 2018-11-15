From: Andy Lutomirski <luto@amacapital.net>
Subject: Re: [PATCH v2] HID: uhid: forbid UHID_CREATE under KERNEL_DS or elevated privileges
Date: Wed, 14 Nov 2018 16:39:41 -0800
Message-ID: <D1DFB962-DAC7-4CD6-A627-4A69062EDDE5@amacapital.net>
References: <CAG48ez3bPkh+DMPwiebM+r4ozX2CiVY=9=WMBP_xm1qVaSN4sQ@mail.gmail.com> <20181114215509.163600-1-ebiggers@kernel.org> <CAG48ez02ZYZOKRXuZ9yYUijZnaaw=G7-KYu1rB7C99+B45VqjQ@mail.gmail.com> <CAE_wzQ_GqjwkhUjoPs3h-s7KSVe8KoH-uu-4mf672JN0X89d6g@mail.gmail.com> <CAG48ez1GH5=d2LcSVA=+AoW6zB=BELr1QL34f3jrA8ip_6WMtQ@mail.gmail.com> <CAE_wzQ91=FQ1HYYvbOi5R5VSXjJibLwYWsAPFtvUemPa9+Turg@mail.gmail.com>
Mime-Version: 1.0 (1.0)
Content-Type: text/plain;
        charset=utf-8
Content-Transfer-Encoding: quoted-printable
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <CAE_wzQ91=FQ1HYYvbOi5R5VSXjJibLwYWsAPFtvUemPa9+Turg@mail.gmail.com>
Sender: stable-owner@vger.kernel.org
To: Dmitry Torokhov <dtor@google.com>
Cc: jannh@google.com, ebiggers@kernel.org, dh.herrmann@googlemail.com, Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>, syzkaller-bugs@googlegroups.com, Dmitry Vyukov <dvyukov@google.com>, syzbot+72473edc9bf4eb1c6556@syzkaller.appspotmail.com, stable@vger.kernel.org, luto@kernel.org
List-Id: linux-input@vger.kernel.org



> On Nov 14, 2018, at 2:46 PM, Dmitry Torokhov <dtor@google.com> wrote:
>=20
>> On Wed, Nov 14, 2018 at 2:38 PM Jann Horn <jannh@google.com> wrote:
>>=20
>>> On Wed, Nov 14, 2018 at 11:29 PM Dmitry Torokhov <dtor@google.com> wrote=
:
>>>> On Wed, Nov 14, 2018 at 2:05 PM Jann Horn <jannh@google.com> wrote:
>>>>> On Wed, Nov 14, 2018 at 10:55 PM Eric Biggers <ebiggers@kernel.org> wr=
ote:
>>>>> When a UHID_CREATE command is written to the uhid char device, a
>>>>> copy_from_user() is done from a user pointer embedded in the command.
>>>>> When the address limit is KERNEL_DS, e.g. as is the case during
>>>>> sys_sendfile(), this can read from kernel memory.  Alternatively,
>>>>> information can be leaked from a setuid binary that is tricked to writ=
e
>>>>> to the file descriptor.  Therefore, forbid UHID_CREATE in these cases.=

>>>>>=20
>>>>> No other commands in uhid_char_write() are affected by this bug and
>>>>> UHID_CREATE is marked as "obsolete", so apply the restriction to
>>>>> UHID_CREATE only rather than to uhid_char_write() entirely.
>> [...]
>>>>> diff --git a/drivers/hid/uhid.c b/drivers/hid/uhid.c
>> [...]
>>>>> @@ -722,6 +723,17 @@ static ssize_t uhid_char_write(struct file *file,=
 const char __user *buffer,
>>>>>=20
>>>>>        switch (uhid->input_buf.type) {
>>>>>        case UHID_CREATE:
>>>>> +               /*
>>>>> +                * 'struct uhid_create_req' contains a __user pointer w=
hich is
>>>>> +                * copied from, so it's unsafe to allow this with elev=
ated
>>>>> +                * privileges (e.g. from a setuid binary) or via kerne=
l_write().
>>>>> +                */
>>>=20
>>> uhid is a privileged interface so we would go from root to less
>>> privileged (if at all). If non-privileged process can open uhid it can
>>> construct virtual keyboard and inject whatever keystrokes it wants.
>>>=20
>>> Also, instead of disallowing access, can we ensure that we switch back
>>> to USER_DS before trying to load data from the user pointer?
>>=20
>> Does that even make sense? You are using some deprecated legacy
>> interface; you interact with it by splicing a request from something
>> like a file or a pipe into the uhid device; but the request you're
>> splicing through contains a pointer into userspace memory? Do you know
>> of anyone who is actually doing that? If not, anyone who does want to
>> do this for some reason in the future can just go use UHID_CREATE2
>> instead.
>=20
> I do not know if anyone is still using UHID_CREATE with sendpage and
> neither do you really. It is all about not breaking userspace without
> good reason and here ensuring that we switch to USER_DS and then back
> to whatever it was does not seem too hard.

It=E2=80=99s about not breaking userspace *except as needed for security fix=
es*. User pointers in a write() payload is a big no-no.

Also, that f_cred hack is only barely enough. This isn=E2=80=99t just about a=
ttacking suid things =E2=80=94 this bug allows poking at the address space o=
f an unsuspecting process. So, if a privileged program opens a uhid fd and i=
s then tricked into writing untrusted data to the same fd (which is supposed=
 to be safe), then we have a problem. Fortunately, identically privileged pr=
ograms usually still don=E2=80=99t share a cred pointer unless they came fro=
m the right place.

The real right fix is to remove UHID_CREATE outright. This is terminally bro=
ken.
