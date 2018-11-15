From: David Herrmann <dh.herrmann@gmail.com>
Subject: Re: [PATCH v2] HID: uhid: forbid UHID_CREATE under KERNEL_DS or
 elevated privileges
Date: Thu, 15 Nov 2018 13:06:53 +0100
Message-ID: <CANq1E4ThFYS8=QqnyUVMAafy3BHb8CiDqm9LmT22XZzm9wJSeg@mail.gmail.com>
References: <CAG48ez3bPkh+DMPwiebM+r4ozX2CiVY=9=WMBP_xm1qVaSN4sQ@mail.gmail.com>
 <20181114215509.163600-1-ebiggers@kernel.org> <CAG48ez02ZYZOKRXuZ9yYUijZnaaw=G7-KYu1rB7C99+B45VqjQ@mail.gmail.com>
 <CAE_wzQ_GqjwkhUjoPs3h-s7KSVe8KoH-uu-4mf672JN0X89d6g@mail.gmail.com>
 <20181114230046.GC87768@gmail.com> <CAE_wzQ_OS-BnRrXjKFhNBeRFRYsQkX2tNO3DEUQRFR7g7A7-2g@mail.gmail.com>
 <CAO-hwJJ3jkQFyf7oByERd98nqEUTjJRu_1tZpFK9sWvgT921iQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <CAO-hwJJ3jkQFyf7oByERd98nqEUTjJRu_1tZpFK9sWvgT921iQ@mail.gmail.com>
Sender: stable-owner@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Dmitry Torokhov <dtor@google.com>, ebiggers@kernel.org, jannh@google.com, Jiri Kosina <jikos@kernel.org>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, syzkaller-bugs@googlegroups.com, Dmitry Vyukov <dvyukov@google.com>, syzbot+72473edc9bf4eb1c6556@syzkaller.appspotmail.com, stable <stable@vger.kernel.org>, Andy Lutomirski <luto@kernel.org>
List-Id: linux-input@vger.kernel.org

Hey

On Thu, Nov 15, 2018 at 9:14 AM Benjamin Tissoires
<benjamin.tissoires@redhat.com> wrote:
>
> On Thu, Nov 15, 2018 at 12:20 AM Dmitry Torokhov <dtor@google.com> wrote:
> > > I think it's best not to make
> > > assumptions about how the interface will be used and to be consistent with how
> > > other ->write() methods in the kernel handle the misfeature where a __user
> > > pointer in the write() or read() payload is dereferenced.
> >
> > I can see that you might want to check credentials, etc, if interface
> > can be accessed by unprivileged process, however is it a big no no for
> > uhid/userio/uinput devices.
>
> Yep, any sane distribution would restrict the permissions of
> uhid/userio/uinput to only be accessed by root. If that ever changes,
> there is already an issue with the system and it was compromised
> either by a terribly dizzy sysadmin.

UHID is safe to be used by a non-root user. This does not imply that
you should open up access to the world, but you are free to have a
dedicated group or user with access to uhid. I agree that in most
common desktop-scenarios you should not grant world-access to it,
though.

> >
> > > Temporarily switching
> > > to USER_DS would only avoid one of the two problems.
> >
> > So because of the above there is only one problem. If your system
> > opened access to uhid to random processes you have much bigger
> > problems than exposing some data from a suid binary. You can spam "rm
> > -rf .; rm -rf /" though uhid if there is interactive session
> > somewhere.
> >
> > >
> > > Do you think the proposed restrictions would actually break anything?
> >
> > It would break if someone uses UHID_CREATE with sendpage. I do not
> > know if anyone does. If we were certain there are no users we'd simply
> > removed UHID_CREATE altogether.
>
> AFAICT, there are 2 users of uhid:
> - bluez for BLE devices (using HID over GATT)
> - hid-replay for debugging.

There are several more (eg., android bt-broadcom), and UHID_CREATE is
actively used. Dropping support for it will break these use-cases.

Thanks
David
