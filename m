From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH v4 2/4] HID: logitech: Support HID++ devices without short reports
Date: Fri, 11 Oct 2019 10:25:24 +0200
Message-ID: <CAO-hwJ+feL2mJ5Wh_0JXP0iTCf3aGExzhZ4t8JsB2aTxnmcEdw@mail.gmail.com>
References: <qPLpNssAeDjlNqTurULLEjShNNHh8DtKSdK-hP2cuq217O3Pc6ZodDDwqqOk8QERJM-jbTqs4Q_iPOcdXCQta_mYX9vgmDK0tDmWmCFRrHo=@protonmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <qPLpNssAeDjlNqTurULLEjShNNHh8DtKSdK-hP2cuq217O3Pc6ZodDDwqqOk8QERJM-jbTqs4Q_iPOcdXCQta_mYX9vgmDK0tDmWmCFRrHo=@protonmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mazin Rezk <mnrzk@protonmail.com>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "jikos@kernel.org" <jikos@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, =?UTF-8?Q?Filipe_La=C3=ADns?= <lains@archlinux.org>
List-Id: linux-input@vger.kernel.org

On Fri, Oct 11, 2019 at 2:57 AM Mazin Rezk <mnrzk@protonmail.com> wrote:
>
> On Saturday, October 5, 2019 9:04 PM, Mazin Rezk <mnrzk@protonmail.com> w=
rote:
>
> > This patch allows the hid-logitech-hidpp module to support devices that=
 do
> > not have support for Short HID++ reports. So far, it seems that Bluetoo=
th
> > HID++ 2.0 devices are missing short reports.
>
> > This has been tested and confirmed with the MX Master and MX Master 2S =
and
> > is therefore likely the case with the other Bluetooth devices.
>
> No changes have been made to this patch in v4.
>
> Signed-off-by: Mazin Rezk <mnrzk@protonmail.com>
> ---
>  drivers/hid/hid-logitech-hidpp.c | 37 ++++++++++++++++++++++++++------
>  1 file changed, 30 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-=
hidpp.c
> index 85fd0c17cc2f..a0efa8a43213 100644
> --- a/drivers/hid/hid-logitech-hidpp.c
> +++ b/drivers/hid/hid-logitech-hidpp.c
> @@ -71,6 +71,7 @@ MODULE_PARM_DESC(disable_tap_to_click,
>  #define HIDPP_QUIRK_HIDPP_WHEELS               BIT(29)
>  #define HIDPP_QUIRK_HIDPP_EXTRA_MOUSE_BTNS     BIT(30)
>  #define HIDPP_QUIRK_HIDPP_CONSUMER_VENDOR_KEYS BIT(31)
> +#define HIDPP_QUIRK_CLASS_BLUETOOTH            BIT(5)

Quirks should be kept in order.

>
>  /* These are just aliases for now */
>  #define HIDPP_QUIRK_KBD_SCROLL_WHEEL HIDPP_QUIRK_HIDPP_WHEELS
> @@ -81,6 +82,9 @@ MODULE_PARM_DESC(disable_tap_to_click,
>                                          HIDPP_QUIRK_HI_RES_SCROLL_X2120 =
| \
>                                          HIDPP_QUIRK_HI_RES_SCROLL_X2121)
>
> +/* Just an alias for now, may possibly be a catch-all in the future */
> +#define HIDPP_QUIRK_MISSING_SHORT_REPORTS      HIDPP_QUIRK_CLASS_BLUETOO=
TH

I would rather have the other way around: define
HIDPP_QUIRK_MISSING_SHORT_REPORTS as BIT(20) (change the comment while
defining it), and have a class definition that aliases
HIDPP_QUIRK_MISSING_SHORT_REPORTS instead. This way, we can add an
other quirk like you do in one of the next patches without
conflicting.

> +
>  #define HIDPP_QUIRK_DELAYED_INIT               HIDPP_QUIRK_NO_HIDINPUT
>
>  #define HIDPP_CAPABILITY_HIDPP10_BATTERY       BIT(0)
> @@ -340,6 +344,12 @@ static int hidpp_send_rap_command_sync(struct hidpp_=
device *hidpp_dev,
>         struct hidpp_report *message;
>         int ret, max_count;
>
> +       /* Force long reports on devices that do not support short report=
s */
> +       if (hidpp_dev->quirks & HIDPP_QUIRK_MISSING_SHORT_REPORTS &&
> +           report_id =3D=3D REPORT_ID_HIDPP_SHORT)
> +               report_id =3D REPORT_ID_HIDPP_LONG;
> +
> +

nitpick: one extra carriage return.

>         switch (report_id) {
>         case REPORT_ID_HIDPP_SHORT:
>                 max_count =3D HIDPP_REPORT_SHORT_LENGTH - 4;
> @@ -3482,6 +3492,12 @@ static bool hidpp_validate_report(struct hid_devic=
e *hdev, int id,
>
>  static bool hidpp_validate_device(struct hid_device *hdev)
>  {
> +       struct hidpp_device *hidpp =3D hid_get_drvdata(hdev);

nitpick: empty line missing.

> +       /* Skip the short report check if the device does not support it =
*/
> +       if (hidpp->quirks & HIDPP_QUIRK_MISSING_SHORT_REPORTS)
> +               return hidpp_validate_report(hdev, REPORT_ID_HIDPP_LONG,
> +                                            HIDPP_REPORT_LONG_LENGTH, fa=
lse);
> +
>         return hidpp_validate_report(hdev, REPORT_ID_HIDPP_SHORT,
>                                      HIDPP_REPORT_SHORT_LENGTH, false) &&
>                hidpp_validate_report(hdev, REPORT_ID_HIDPP_LONG,
> @@ -3775,22 +3791,29 @@ static const struct hid_device_id hidpp_devices[]=
 =3D {
>           .driver_data =3D HIDPP_QUIRK_HIDPP_CONSUMER_VENDOR_KEYS },
>         { /* MX Anywhere 2 mouse over Bluetooth */
>           HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_LOGITECH, 0xb013),
> -         .driver_data =3D HIDPP_QUIRK_HI_RES_SCROLL_X2121 },
> +         .driver_data =3D HIDPP_QUIRK_HI_RES_SCROLL_X2121 |
> +                        HIDPP_QUIRK_CLASS_BLUETOOTH },

As mentioned in 1/4:
- please only add devices you know have been tested
- squash the previous one into this one to preserve bisectability.

Cheers,
Benjamin

>         { HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_LOGITECH, 0xb018),
> -         .driver_data =3D HIDPP_QUIRK_HI_RES_SCROLL_X2121 },
> +         .driver_data =3D HIDPP_QUIRK_HI_RES_SCROLL_X2121 |
> +                        HIDPP_QUIRK_CLASS_BLUETOOTH },
>         { /* MX Anywhere 2S mouse over Bluetooth */
>           HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_LOGITECH, 0xb01a),
> -         .driver_data =3D HIDPP_QUIRK_HI_RES_SCROLL_X2121 },
> +         .driver_data =3D HIDPP_QUIRK_HI_RES_SCROLL_X2121 |
> +                        HIDPP_QUIRK_CLASS_BLUETOOTH },
>         { /* MX Master mouse over Bluetooth */
>           HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_LOGITECH, 0xb012),
> -         .driver_data =3D HIDPP_QUIRK_HI_RES_SCROLL_X2121 },
> +         .driver_data =3D HIDPP_QUIRK_HI_RES_SCROLL_X2121 |
> +                        HIDPP_QUIRK_CLASS_BLUETOOTH },
>         { HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_LOGITECH, 0xb017),
> -         .driver_data =3D HIDPP_QUIRK_HI_RES_SCROLL_X2121 },
> +         .driver_data =3D HIDPP_QUIRK_HI_RES_SCROLL_X2121 |
> +                        HIDPP_QUIRK_CLASS_BLUETOOTH },
>         { HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_LOGITECH, 0xb01e),
> -         .driver_data =3D HIDPP_QUIRK_HI_RES_SCROLL_X2121 },
> +         .driver_data =3D HIDPP_QUIRK_HI_RES_SCROLL_X2121 |
> +                        HIDPP_QUIRK_CLASS_BLUETOOTH },
>         { /* MX Master 2S mouse over Bluetooth */
>           HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_LOGITECH, 0xb019),
> -         .driver_data =3D HIDPP_QUIRK_HI_RES_SCROLL_X2121 },
> +         .driver_data =3D HIDPP_QUIRK_HI_RES_SCROLL_X2121 |
> +                        HIDPP_QUIRK_CLASS_BLUETOOTH },
>         {}
>  };
>
> --
> 2.23.0
