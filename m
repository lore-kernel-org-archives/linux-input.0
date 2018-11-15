From: Andy Lutomirski <luto@amacapital.net>
Subject: Re: [PATCH v2] HID: uhid: forbid UHID_CREATE under KERNEL_DS or elevated privileges
Date: Thu, 15 Nov 2018 06:50:05 -0800
Message-ID: <A3AEDFEA-7810-4200-BBB9-055285062266@amacapital.net>
References: <CAG48ez3bPkh+DMPwiebM+r4ozX2CiVY=9=WMBP_xm1qVaSN4sQ@mail.gmail.com> <20181114215509.163600-1-ebiggers@kernel.org> <CAG48ez02ZYZOKRXuZ9yYUijZnaaw=G7-KYu1rB7C99+B45VqjQ@mail.gmail.com> <CAE_wzQ_GqjwkhUjoPs3h-s7KSVe8KoH-uu-4mf672JN0X89d6g@mail.gmail.com> <20181114230046.GC87768@gmail.com> <CAE_wzQ_OS-BnRrXjKFhNBeRFRYsQkX2tNO3DEUQRFR7g7A7-2g@mail.gmail.com> <CAO-hwJJ3jkQFyf7oByERd98nqEUTjJRu_1tZpFK9sWvgT921iQ@mail.gmail.com> <CANq1E4ThFYS8=QqnyUVMAafy3BHb8CiDqm9LmT22XZzm9wJSeg@mail.gmail.com>
Mime-Version: 1.0 (1.0)
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <CANq1E4ThFYS8=QqnyUVMAafy3BHb8CiDqm9LmT22XZzm9wJSeg@mail.gmail.com>
Sender: stable-owner@vger.kernel.org
To: David Herrmann <dh.herrmann@gmail.com>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Dmitry Torokhov <dtor@google.com>, ebiggers@kernel.org, jannh@google.com, Jiri Kosina <jikos@kernel.org>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, syzkaller-bugs@googlegroups.com, Dmitry Vyukov <dvyukov@google.com>, syzbot+72473edc9bf4eb1c6556@syzkaller.appspotmail.com, stable <stable@vger.kernel.org>, Andy Lutomirski <luto@kernel.org>
List-Id: linux-input@vger.kernel.org



> On Nov 15, 2018, at 4:06 AM, David Herrmann <dh.herrmann@gmail.com> wrote:=

>=20
> Hey
>=20
> On Thu, Nov 15, 2018 at 9:14 AM Benjamin Tissoires
> <benjamin.tissoires@redhat.com> wrote:
>>=20
>> On Thu, Nov 15, 2018 at 12:20 AM Dmitry Torokhov <dtor@google.com> wrote:=

>>>> I think it's best not to make
>>>> assumptions about how the interface will be used and to be consistent w=
ith how
>>>> other ->write() methods in the kernel handle the misfeature where a __u=
ser
>>>> pointer in the write() or read() payload is dereferenced.
>>>=20
>>> I can see that you might want to check credentials, etc, if interface
>>> can be accessed by unprivileged process, however is it a big no no for
>>> uhid/userio/uinput devices.
>>=20
>> Yep, any sane distribution would restrict the permissions of
>> uhid/userio/uinput to only be accessed by root. If that ever changes,
>> there is already an issue with the system and it was compromised
>> either by a terribly dizzy sysadmin.
>=20
> UHID is safe to be used by a non-root user. This does not imply that
> you should open up access to the world, but you are free to have a
> dedicated group or user with access to uhid. I agree that in most
> common desktop-scenarios you should not grant world-access to it,
> though.
>=20
>>>=20
>>>> Temporarily switching
>>>> to USER_DS would only avoid one of the two problems.
>>>=20
>>> So because of the above there is only one problem. If your system
>>> opened access to uhid to random processes you have much bigger
>>> problems than exposing some data from a suid binary. You can spam "rm
>>> -rf .; rm -rf /" though uhid if there is interactive session
>>> somewhere.
>>>=20
>>>>=20
>>>> Do you think the proposed restrictions would actually break anything?
>>>=20
>>> It would break if someone uses UHID_CREATE with sendpage. I do not
>>> know if anyone does. If we were certain there are no users we'd simply
>>> removed UHID_CREATE altogether.
>>=20
>> AFAICT, there are 2 users of uhid:
>> - bluez for BLE devices (using HID over GATT)
>> - hid-replay for debugging.
>=20
> There are several more (eg., android bt-broadcom), and UHID_CREATE is
> actively used. Dropping support for it will break these use-cases.
>=20
>=20

Is the support story for these programs such that we could add a big scary w=
arning and remove UHID_CREATE in a couple months?=
