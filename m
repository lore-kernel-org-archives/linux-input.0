From: =?UTF-8?Q?Cl=C3=A9ment_VUCHENER?= <clement.vuchener@gmail.com>
Subject: Re: [PATCH v3 7/8] HID: logitech: Enable high-resolution scrolling on
 Logitech mice
Date: Wed, 24 Apr 2019 17:34:41 +0200
Message-ID: <CAM4jgCrYBr+M+F2iAn8-pPFjiZQ-nPT_H16WcyPKp2PFCM=qhQ@mail.gmail.com>
References: <20181205004228.10714-1-peter.hutterer@who-t.net>
 <20181205004228.10714-8-peter.hutterer@who-t.net> <CAM4jgCqAh9Pck-9i8F5tO4-Kzpu+SjH-mQnGYThadSf-3b1ikw@mail.gmail.com>
 <CA+jURcuhBRYiqFYHDgK8dDycrPgvzkujTRZfnmYraiHvwE+e6w@mail.gmail.com>
 <CAM4jgCo483upCJWUnpP45zh2LzQWqAZmQREf2622p49a1vbnnA@mail.gmail.com>
 <CAM4jgCqj5gs-q7VKLm90p0a01k_tYAqxA=zxsmShxv4PSGBJ4A@mail.gmail.com> <CAO-hwJK7pFvuYZJTKgwkj794=xinekDgN_eLBSViw3v_dWAecw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAO-hwJK7pFvuYZJTKgwkj794=xinekDgN_eLBSViw3v_dWAecw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Harry Cutts <hcutts@chromium.org>, Peter Hutterer <peter.hutterer@who-t.net>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jikos@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Nestor Lopez Casado <nlopezcasad@logitech.com>, lkml <linux-kernel@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

Hi Benjamin,

I tried again to add hi-res wheel support for the G500 with Hans de
Goede's latest patch series you've just merged in for-5.2/logitech, it
is much better but there is still some issues.

The first one is the device index, I need to use device index 0
instead 0xff. I added a quick and dirty quirk (stealing in the
QUIRK_CLASS range since the normal quirk range looks full) to change
the device index assigned in __hidpp_send_report. After that the
device is correctly initialized and the wheel multiplier is set.

The second issue is that wheel values are not actually scaled
according to the multiplier. I get 7/8 full scroll event for each
wheel step. I think it happens because the mouse is split in two
devices. The first device has the wheel events, and the second device
has the HID++ reports. The wheel multiplier is only set on the second
device (where the hi-res mode is enabled) and does not affect the
wheel events from the first one.

Le mer. 19 d=C3=A9c. 2018 =C3=A0 21:35, Benjamin Tissoires
<benjamin.tissoires@redhat.com> a =C3=A9crit :
>
> On Wed, Dec 19, 2018 at 11:57 AM Cl=C3=A9ment VUCHENER
> <clement.vuchener@gmail.com> wrote:
> >
> > Le sam. 15 d=C3=A9c. 2018 =C3=A0 15:45, Cl=C3=A9ment VUCHENER
> > <clement.vuchener@gmail.com> a =C3=A9crit :
> > >
> > > Le ven. 14 d=C3=A9c. 2018 =C3=A0 19:37, Harry Cutts <hcutts@chromium.=
org> a =C3=A9crit :
> > > >
> > > > Hi Clement,
> > > >
> > > > On Fri, 14 Dec 2018 at 05:47, Cl=C3=A9ment VUCHENER
> > > > <clement.vuchener@gmail.com> wrote:
> > > > > Hi, The G500s (and the G500 too, I think) does support the "scrol=
ling
> > > > > acceleration" bit. If I set it, I get around 8 events for each wh=
eel
> > > > > "click", this is what this driver expects, right? If I understood
> > > > > correctly, I should try this patch with the
> > > > > HIDPP_QUIRK_HI_RES_SCROLL_1P0 quirk set for my mouse.
> > > >
> > > > Thanks for the info! Yes, that should work.
> > >
> > > Well, it is not that simple. I get "Device not connected" errors for
> > > both interfaces of the mouse.
> >
> > I suspect the device is not responding because the hid device is not
> > started. When is hid_hw_start supposed to be called? It is called
> > early for HID_QUIRK_CLASS_G920 but later for other device. So the
> > device is not started when hidpp_is_connected is called. Is this
> > because most of the device in this driver are not real HID devices but
> > DJ devices? How should non-DJ devices be treated?
>
> Hi Clement,
>
> I have a series I sent last September that allows to support non DJ
> devices on logitech-hidpp
> (https://patchwork.kernel.org/project/linux-input/list/?series=3D16359).
>
> In its current form, with the latest upstream kernel, the series will
> oops during the .event() callback, which is easy enough to fix.
> However, I am currently trying to make it better as a second or third
> reading made me realized that there was a bunch of non-sense in it and
> a proper support would require slightly more work for the non unifying
> receiver case.
>
> I hope I'll be able to send out something by the end of the week.
>
> Cheers,
> Benjamin
