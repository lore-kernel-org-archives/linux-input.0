From: =?UTF-8?Q?Cl=C3=A9ment_VUCHENER?= <clement.vuchener@gmail.com>
Subject: Re: [PATCH v3 7/8] HID: logitech: Enable high-resolution scrolling on
 Logitech mice
Date: Wed, 19 Dec 2018 11:57:05 +0100
Message-ID: <CAM4jgCqj5gs-q7VKLm90p0a01k_tYAqxA=zxsmShxv4PSGBJ4A@mail.gmail.com>
References: <20181205004228.10714-1-peter.hutterer@who-t.net>
 <20181205004228.10714-8-peter.hutterer@who-t.net> <CAM4jgCqAh9Pck-9i8F5tO4-Kzpu+SjH-mQnGYThadSf-3b1ikw@mail.gmail.com>
 <CA+jURcuhBRYiqFYHDgK8dDycrPgvzkujTRZfnmYraiHvwE+e6w@mail.gmail.com> <CAM4jgCo483upCJWUnpP45zh2LzQWqAZmQREf2622p49a1vbnnA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAM4jgCo483upCJWUnpP45zh2LzQWqAZmQREf2622p49a1vbnnA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Harry Cutts <hcutts@chromium.org>
Cc: Peter Hutterer <peter.hutterer@who-t.net>, linux-input <linux-input@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jikos@kernel.org>, torvalds@linux-foundation.org, Nestor Lopez Casado <nlopezcasad@logitech.com>, lkml <linux-kernel@vger.kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>
List-Id: linux-input@vger.kernel.org

Le sam. 15 d=C3=A9c. 2018 =C3=A0 15:45, Cl=C3=A9ment VUCHENER
<clement.vuchener@gmail.com> a =C3=A9crit :
>
> Le ven. 14 d=C3=A9c. 2018 =C3=A0 19:37, Harry Cutts <hcutts@chromium.org>=
 a =C3=A9crit :
> >
> > Hi Clement,
> >
> > On Fri, 14 Dec 2018 at 05:47, Cl=C3=A9ment VUCHENER
> > <clement.vuchener@gmail.com> wrote:
> > > Hi, The G500s (and the G500 too, I think) does support the "scrolling
> > > acceleration" bit. If I set it, I get around 8 events for each wheel
> > > "click", this is what this driver expects, right? If I understood
> > > correctly, I should try this patch with the
> > > HIDPP_QUIRK_HI_RES_SCROLL_1P0 quirk set for my mouse.
> >
> > Thanks for the info! Yes, that should work.
>
> Well, it is not that simple. I get "Device not connected" errors for
> both interfaces of the mouse.

I suspect the device is not responding because the hid device is not
started. When is hid_hw_start supposed to be called? It is called
early for HID_QUIRK_CLASS_G920 but later for other device. So the
device is not started when hidpp_is_connected is called. Is this
because most of the device in this driver are not real HID devices but
DJ devices? How should non-DJ devices be treated?
