From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH v4 1/4] HID: logitech: Add MX Mice over Bluetooth
Date: Fri, 11 Oct 2019 10:54:16 +0200
Message-ID: <CAO-hwJK+V=CE8_NjqRszPA6dbGq1yNJAtOAm2qmqVjgK_XzEHw@mail.gmail.com>
References: <uBbIS3nFJ1jdYNLHcqjW5wxQAwmZv0kmYEoeoPrxNhfzi6cHwmCOY-ewdqe7S1hNEj-p4Hd9D0_Y3PymUTdh_6WFXuMmIYUkV2xaKCPMYz0=@protonmail.com>
 <403b3e7f6d276e47c447e6ea56a3370b03c3298c.camel@archlinux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <403b3e7f6d276e47c447e6ea56a3370b03c3298c.camel@archlinux.org>
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?Q?Filipe_La=C3=ADns?= <lains@archlinux.org>
Cc: Mazin Rezk <mnrzk@protonmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "jikos@kernel.org" <jikos@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

On Fri, Oct 11, 2019 at 10:49 AM Filipe La=C3=ADns <lains@archlinux.org> wr=
ote:
>
> On Fri, 2019-10-11 at 00:57 +0000, Mazin Rezk wrote:
> > On Saturday, October 5, 2019 9:04 PM, Mazin Rezk <
> > mnrzk@protonmail.com> wrote:
> >
> > > This patch adds support for several MX mice over Bluetooth. The
> > > device IDs
> > > have been copied from the libratbag device database and their
> > > features
> > > have been based on their DJ device counterparts.
> >
> > No changes have been made to this patch in v4. However, it should be
> > noted
> > that the only device that has been thoroughly tested in this patch is
> > the
> > MX Master (b01e). Further testing for the other devices may be
> > required.
> >
> > Signed-off-by: Mazin Rezk <mnrzk@protonmail.com>
> > ---
> >  drivers/hid/hid-logitech-hidpp.c | 18 ++++++++++++++++++
> >  1 file changed, 18 insertions(+)
> >
> > diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-
> > logitech-hidpp.c
> > index 0179f7ed77e5..85fd0c17cc2f 100644
> > --- a/drivers/hid/hid-logitech-hidpp.c
> > +++ b/drivers/hid/hid-logitech-hidpp.c
> > @@ -3773,6 +3773,24 @@ static const struct hid_device_id
> > hidpp_devices[] =3D {
> >       { /* MX5500 keyboard over Bluetooth */
> >         HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_LOGITECH, 0xb30b),
> >         .driver_data =3D HIDPP_QUIRK_HIDPP_CONSUMER_VENDOR_KEYS },
> > +     { /* MX Anywhere 2 mouse over Bluetooth */
> > +       HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_LOGITECH, 0xb013),
> > +       .driver_data =3D HIDPP_QUIRK_HI_RES_SCROLL_X2121 },
> > +     { HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_LOGITECH, 0xb018),
> > +       .driver_data =3D HIDPP_QUIRK_HI_RES_SCROLL_X2121 },
> > +     { /* MX Anywhere 2S mouse over Bluetooth */
> > +       HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_LOGITECH, 0xb01a),
> > +       .driver_data =3D HIDPP_QUIRK_HI_RES_SCROLL_X2121 },
> > +     { /* MX Master mouse over Bluetooth */
> > +       HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_LOGITECH, 0xb012),
> > +       .driver_data =3D HIDPP_QUIRK_HI_RES_SCROLL_X2121 },
> > +     { HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_LOGITECH, 0xb017),
> > +       .driver_data =3D HIDPP_QUIRK_HI_RES_SCROLL_X2121 },
> > +     { HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_LOGITECH, 0xb01e),
> > +       .driver_data =3D HIDPP_QUIRK_HI_RES_SCROLL_X2121 },
> > +     { /* MX Master 2S mouse over Bluetooth */
> > +       HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_LOGITECH, 0xb019),
> > +       .driver_data =3D HIDPP_QUIRK_HI_RES_SCROLL_X2121 },
> >       {}
> >  };
> >
> > --
> > 2.23.0
> >
>
> The series now looks great, thanks!
>
> Benjamin, I can confirm that up to now all BLE devices don't have short
> reports. I am not sure if you still want to only enable tested devices
> but from an architectural standpoint everything here should be fine.

Unfortunately yes, we need actual device tests:
- this series enable 0x2121 on all of those devices (is it correct?)
- we are not shielded from a FW error and something that goes wrong
when enabling one of those mice with hid-logitech-hidpp.c. All of
those mice works fine with hid-generic, and if we oversee one tiny
bit, we'll regress for no good reasons.

Cheers,
Benjamin

>
> Mazin, you can have my
>
> Reviewed-by: Filipe La=C3=ADns <lains@archlinux.org>
>
> for the series.
>
> Thank you,
> Filipe La=C3=ADns
