From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH v4 1/4] HID: logitech: Add MX Mice over Bluetooth
Date: Fri, 11 Oct 2019 10:19:47 +0200
Message-ID: <CAO-hwJK7gaL7pcTji3buN-wdp4HJw497Zi0S47Xr21FRHffLXQ@mail.gmail.com>
References: <uBbIS3nFJ1jdYNLHcqjW5wxQAwmZv0kmYEoeoPrxNhfzi6cHwmCOY-ewdqe7S1hNEj-p4Hd9D0_Y3PymUTdh_6WFXuMmIYUkV2xaKCPMYz0=@protonmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <uBbIS3nFJ1jdYNLHcqjW5wxQAwmZv0kmYEoeoPrxNhfzi6cHwmCOY-ewdqe7S1hNEj-p4Hd9D0_Y3PymUTdh_6WFXuMmIYUkV2xaKCPMYz0=@protonmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mazin Rezk <mnrzk@protonmail.com>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "jikos@kernel.org" <jikos@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, =?UTF-8?Q?Filipe_La=C3=ADns?= <lains@archlinux.org>
List-Id: linux-input@vger.kernel.org

Hi Mazin,

On Fri, Oct 11, 2019 at 2:57 AM Mazin Rezk <mnrzk@protonmail.com> wrote:
>
> On Saturday, October 5, 2019 9:04 PM, Mazin Rezk <mnrzk@protonmail.com> w=
rote:
>
> > This patch adds support for several MX mice over Bluetooth. The device =
IDs
> > have been copied from the libratbag device database and their features
> > have been based on their DJ device counterparts.
>
> No changes have been made to this patch in v4. However, it should be note=
d
> that the only device that has been thoroughly tested in this patch is the
> MX Master (b01e). Further testing for the other devices may be required.

Thanks a lot for the series, but please amend your format-patch process:
- The commit message should not contain the leading `>` characters,
and checkpath.pl then complains about Possible unwrapped commit
description (prefer a maximum 75 chars per line)
- this description of the changes is very useful, but it should go
after the first `---` so that we do not pull it while applying the
patch.

Also, this patch introduces a breakage in the bisectability of the
devices it adds. If we were to bisect a breakage in one of those
devices, the device will fail to work, and we could not detect where
the error comes from.

So please squash this patch with the next one.

Last, if we need "Further testing for the other devices may be
required", then I'd rather enable those device one by one when ewe get
the confirmation they are working. Adding a new device costs, but not
as much than breaking an existing one, especially when it gets
detected later, when the kernel gets shipped in distributions.
Note that I have the MX Master 0xB012, so you can safely keep that one
on the list, I'll test it myself.

Cheers,
Benjamin


>
> Signed-off-by: Mazin Rezk <mnrzk@protonmail.com>
> ---
>  drivers/hid/hid-logitech-hidpp.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
>
> diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-=
hidpp.c
> index 0179f7ed77e5..85fd0c17cc2f 100644
> --- a/drivers/hid/hid-logitech-hidpp.c
> +++ b/drivers/hid/hid-logitech-hidpp.c
> @@ -3773,6 +3773,24 @@ static const struct hid_device_id hidpp_devices[] =
=3D {
>         { /* MX5500 keyboard over Bluetooth */
>           HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_LOGITECH, 0xb30b),
>           .driver_data =3D HIDPP_QUIRK_HIDPP_CONSUMER_VENDOR_KEYS },
> +       { /* MX Anywhere 2 mouse over Bluetooth */
> +         HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_LOGITECH, 0xb013),
> +         .driver_data =3D HIDPP_QUIRK_HI_RES_SCROLL_X2121 },
> +       { HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_LOGITECH, 0xb018),
> +         .driver_data =3D HIDPP_QUIRK_HI_RES_SCROLL_X2121 },
> +       { /* MX Anywhere 2S mouse over Bluetooth */
> +         HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_LOGITECH, 0xb01a),
> +         .driver_data =3D HIDPP_QUIRK_HI_RES_SCROLL_X2121 },
> +       { /* MX Master mouse over Bluetooth */
> +         HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_LOGITECH, 0xb012),
> +         .driver_data =3D HIDPP_QUIRK_HI_RES_SCROLL_X2121 },
> +       { HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_LOGITECH, 0xb017),
> +         .driver_data =3D HIDPP_QUIRK_HI_RES_SCROLL_X2121 },
> +       { HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_LOGITECH, 0xb01e),
> +         .driver_data =3D HIDPP_QUIRK_HI_RES_SCROLL_X2121 },
> +       { /* MX Master 2S mouse over Bluetooth */
> +         HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_LOGITECH, 0xb019),
> +         .driver_data =3D HIDPP_QUIRK_HI_RES_SCROLL_X2121 },
>         {}
>  };
>
> --
> 2.23.0
>
