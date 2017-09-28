From: Jaejoong Kim <climbbb.kim@gmail.com>
Subject: Re: [PATCH] HID: usbhid: fix out-of-bounds bug
Date: Thu, 28 Sep 2017 17:44:22 +0900
Message-ID: <CAL6iAaJQZ4JB6udi3UFyGM0uYYE4NECZ5fK8ujb+ANfwe9tYDw@mail.gmail.com>
References: <CAAZ5spCffHnU_EtnhKpP5cDqsEKaGMatpaqAJqorvph+vZm1Sw@mail.gmail.com>
 <Pine.LNX.4.44L0.1709271013300.1390-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44L0.1709271013300.1390-100000@iolanthe.rowland.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Michel Hermier <michel.hermier@gmail.com>, Kostya Serebryany <kcc@google.com>, syzkaller <syzkaller@googlegroups.com>, Jiri Kosina <jikos@kernel.org>, USB list <linux-usb@vger.kernel.org>, Andrey Konovalov <andreyknvl@google.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Dmitry Vyukov <dvyukov@google.com>, linux-input@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

2017-09-27 23:29 GMT+09:00 Alan Stern <stern@rowland.harvard.edu>:
> On Wed, 27 Sep 2017, Michel Hermier wrote:
>
>> Le 27 sept. 2017 07:42, "Alan Stern" <stern@rowland.harvard.edu> a =C3=
=A9crit :
>
>> > -       for (n =3D 0; n < hdesc->bNumDescriptors; n++)
>> > +       num_descriptors =3D min_t(int, hdesc->bNumDescriptors,
>> > +                               (hdesc->bLength - 6) / 3);
>> > +       for (n =3D 0; n < num_descriptors; n++)
>> >                 if (hdesc->desc[n].bDescriptorType =3D=3D HID_DT_REPOR=
T)
>> >                         rsize =3D le16_to_cpu(hdesc->desc[n].
>> wDescriptorLength);
>>
>> Yes, this is a lot better.

OK.

>>
>>
>> Is it possible to explicit the magic number 6 and 3 in the code. Current=
ly,
>> it looks like it comes from no where.

I gree with you.

>
> Yes, it is possible.  The 6 is equal to
>
>         offsetof(struct hid_descriptor, desc)
>
> and the 3 is equal to
>
>         sizeof(struct hid_class_descriptor)
>
> (at least, I think it is -- the structure is marked as packed so its
> size should be 3).
>
> In this case I found the numbers to be more readable, but other people
> may have different opinions.

I will post V2 shortly.

>
>> I'm also wondering if this change will not affect some devices in the wi=
ld,
>> by rejecting hid descriptors with num descriptors =3D=3D 0 ?
>
> It's possible, but I doubt it.  If such devices do exist, they should
> never have worked in the first place.  Certainly they would generate
> warnings or errors during enumeration because of their invalid
> descriptors.
>
> Alan Stern
>

Jaejoong
