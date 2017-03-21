From: "Colenbrander, Roelof" <Roderick.Colenbrander@sony.com>
Subject: RE: [PATCH] HID: sony: Add touchpad support for Sony's NSG-MR5U and
 NSG-MR7U remotes
Date: Tue, 21 Mar 2017 23:56:04 +0000
Message-ID: <1DD62093774CEE42AFC16E785A10880489C9FF8A@USCULXMSG08.am.sony.com>
References: <20170211050004.GA3944@gmail.com>,<alpine.LSU.2.20.1703211506060.31814@cbobk.fhfr.pm>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-bn3nam01on0096.outbound.protection.outlook.com ([104.47.33.96]:4064
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1758543AbdCUX4e (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Tue, 21 Mar 2017 19:56:34 -0400
In-Reply-To: <alpine.LSU.2.20.1703211506060.31814@cbobk.fhfr.pm>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>, Todd Kelner <tsopdump@gmail.com>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Frank Praznik <frank.praznik@gmail.com>, Simon Wood <simon@mungewell.org>

Hi Jiri and Todd,=0A=
=0A=
I have added some feedback based on the code below. I'm not familiar with t=
he specifics of this device, so can't confirm whether the code dealing with=
 input reports is correct.=0A=
=0A=
Thanks,=0A=
Roderick=0A=
________________________________________=0A=
From: Jiri Kosina [jikos@kernel.org]=0A=
Sent: Tuesday, March 21, 2017 7:06 AM=0A=
To: Todd Kelner=0A=
Cc: Benjamin Tissoires; linux-input@vger.kernel.org; Frank Praznik; Colenbr=
ander, Roelof; Simon Wood=0A=
Subject: Re: [PATCH] HID: sony: Add touchpad support for Sony's NSG-MR5U an=
d NSG-MR7U remotes=0A=
=0A=
On Fri, 10 Feb 2017, Todd Kelner wrote:=0A=
=0A=
> Sony's NSG-MR5U and NSG-MR7U remote controls have a full keyboard and a=
=0A=
> touchpad.  The keyboard is already supported by the existing Linux kernel=
=0A=
> and drivers but the touchpad is not recognized.  This patch adds the code=
=0A=
> needed to bring full functionality to the touchpad.=0A=
>=0A=
> Note that these remotes use the vendor code for SMK even though they are=
=0A=
> Sony branded.=0A=
>=0A=
> Known Limitations:=0A=
> - The accelerometer is not supported by these changes=0A=
> - The microphone in the NSG-MR7U is not supported by these changes=0A=
> - When the Drag (Fn) key is used as a mouse button, the button is=0A=
>   automatically released when the key begins repeating. There are two=0A=
>   workarounds for this.  1) Use the button behind the touchpad instead of=
=0A=
>   using the Drag (Fn) key, or 2) Disable the key repeat functionality or=
=0A=
>   increase the key repeat delay.=0A=
=0A=
Adding Frank, Roderick and Simon to CC in case they have any comments.=0A=
=0A=
>=0A=
> Signed-off-by: Todd Kelner <tsopdump@gmail.com>=0A=
> ---=0A=
>  drivers/hid/hid-core.c |   2 +=0A=
>  drivers/hid/hid-ids.h  |   2 +=0A=
>  drivers/hid/hid-sony.c | 130 +++++++++++++++++++++++++++++++++++++++++++=
++----=0A=
>  3 files changed, 125 insertions(+), 9 deletions(-)=0A=
>=0A=
> diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c=0A=
> index cff060b..4dfef41 100644=0A=
> --- a/drivers/hid/hid-core.c=0A=
> +++ b/drivers/hid/hid-core.c=0A=
> @@ -2054,6 +2054,8 @@ static const struct hid_device_id hid_have_special_=
driver[] =3D {=0A=
>       { HID_USB_DEVICE(USB_VENDOR_ID_SAMSUNG, USB_DEVICE_ID_SAMSUNG_WIREL=
ESS_KBD_MOUSE) },=0A=
>       { HID_USB_DEVICE(USB_VENDOR_ID_SKYCABLE, USB_DEVICE_ID_SKYCABLE_WIR=
ELESS_PRESENTER) },=0A=
>       { HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_SMK, USB_DEVICE_ID_SMK_PS3_BDR=
EMOTE) },=0A=
> +     { HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_SMK, USB_DEVICE_ID_SMK_NSG_MR5=
U_REMOTE) },=0A=
> +     { HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_SMK, USB_DEVICE_ID_SMK_NSG_MR7=
U_REMOTE) },=0A=
>       { HID_USB_DEVICE(USB_VENDOR_ID_SONY, USB_DEVICE_ID_SONY_BUZZ_CONTRO=
LLER) },=0A=
>       { HID_USB_DEVICE(USB_VENDOR_ID_SONY, USB_DEVICE_ID_SONY_WIRELESS_BU=
ZZ_CONTROLLER) },=0A=
>       { HID_USB_DEVICE(USB_VENDOR_ID_SONY, USB_DEVICE_ID_SONY_MOTION_CONT=
ROLLER) },=0A=
> diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h=0A=
> index 54bd22d..864ec34 100644=0A=
> --- a/drivers/hid/hid-ids.h=0A=
> +++ b/drivers/hid/hid-ids.h=0A=
> @@ -904,6 +904,8 @@=0A=
>=0A=
>  #define USB_VENDOR_ID_SMK            0x0609=0A=
>  #define USB_DEVICE_ID_SMK_PS3_BDREMOTE       0x0306=0A=
> +#define USB_DEVICE_ID_SMK_NSG_MR5U_REMOTE    0x0368=0A=
> +#define USB_DEVICE_ID_SMK_NSG_MR7U_REMOTE    0x0369=0A=
>=0A=
>  #define USB_VENDOR_ID_SONY                   0x054c=0A=
>  #define USB_DEVICE_ID_SONY_VAIO_VGX_MOUSE    0x024b=0A=
> diff --git a/drivers/hid/hid-sony.c b/drivers/hid/hid-sony.c=0A=
> index f405b07..5bd4d61 100644=0A=
> --- a/drivers/hid/hid-sony.c=0A=
> +++ b/drivers/hid/hid-sony.c=0A=
> @@ -9,6 +9,7 @@=0A=
>   *  Copyright (c) 2006-2013 Jiri Kosina=0A=
>   *  Copyright (c) 2013 Colin Leitner <colin.leitner@gmail.com>=0A=
>   *  Copyright (c) 2014-2016 Frank Praznik <frank.praznik@gmail.com>=0A=
> + *  Copyright (c) 2017 Todd Kelner=0A=
>   */=0A=
>=0A=
>  /*=0A=
> @@ -54,6 +55,8 @@=0A=
>  #define NAVIGATION_CONTROLLER_BT  BIT(10)=0A=
>  #define SINO_LITE_CONTROLLER      BIT(11)=0A=
>  #define FUTUREMAX_DANCE_MAT       BIT(12)=0A=
> +#define NSG_MR5U_REMOTE_BT        BIT(13)=0A=
> +#define NSG_MR7U_REMOTE_BT        BIT(14)=0A=
=0A=
Minor thing, use bit 14 and 15 now as some other devices got added since th=
e patch.=0A=
=0A=
>=0A=
>  #define SIXAXIS_CONTROLLER (SIXAXIS_CONTROLLER_USB | SIXAXIS_CONTROLLER_=
BT)=0A=
>  #define MOTION_CONTROLLER (MOTION_CONTROLLER_USB | MOTION_CONTROLLER_BT)=
=0A=
> @@ -70,8 +73,11 @@=0A=
>                               MOTION_CONTROLLER)=0A=
>  #define SONY_BT_DEVICE (SIXAXIS_CONTROLLER_BT | DUALSHOCK4_CONTROLLER_BT=
 |\=0A=
>                       MOTION_CONTROLLER_BT | NAVIGATION_CONTROLLER_BT)=0A=
> +#define NSG_MRXU_REMOTE (NSG_MR5U_REMOTE_BT | NSG_MR7U_REMOTE_BT)=0A=
>=0A=
>  #define MAX_LEDS 4=0A=
> +#define NSG_MRXU_MAX_X 1667=0A=
> +#define NSG_MRXU_MAX_Y 1868=0A=
>=0A=
>  /*=0A=
>   * The Sixaxis reports both digital and analog values for each button on=
 the=0A=
> @@ -1063,7 +1069,7 @@ struct motion_output_report_02 {=0A=
>  #define DS4_INPUT_REPORT_BATTERY_OFFSET  30=0A=
>  #define DS4_INPUT_REPORT_TOUCHPAD_OFFSET 33=0A=
>=0A=
> -#define DS4_TOUCHPAD_SUFFIX " Touchpad"=0A=
> +#define TOUCHPAD_SUFFIX " Touchpad"=0A=
>=0A=
>  static DEFINE_SPINLOCK(sony_dev_list_lock);=0A=
>  static LIST_HEAD(sony_device_list);=0A=
> @@ -1383,6 +1389,75 @@ static void dualshock4_parse_report(struct sony_sc=
 *sc, u8 *rd, int size)=0A=
>       }=0A=
>  }=0A=
>=0A=
> +static void nsg_mrxu_parse_report(struct sony_sc *sc, u8 *rd, int size)=
=0A=
> +{=0A=
> +     int n, offset;=0A=
> +     u8 active;=0A=
> +=0A=
> +     /*=0A=
> +      * The NSG-MRxU multi-touch trackpad data starts at offset 1 and=0A=
> +      *   the touch-related data starts at offset 2.=0A=
> +      * For the first byte, bit 0 is set when touchpad button is pressed=
.=0A=
> +      * Bit 3 is set when a touch is active and the drag (Fn) key is pre=
ssed.=0A=
> +      * This drag key is mapped to BTN_LEFT.=0A=
> +      * Bit 4 is set when only the first touch point is active.=0A=
> +      * Bit 6 is set when only the second touch point is active.=0A=
> +      * Bits 5 and 7 are set when both touch points are active.=0A=
> +      * The next 3 bytes are two 12 bit X/Y coordinates for the first to=
uch.=0A=
> +      * The following byte, offset 5, has the touch width and length.=0A=
> +      *   Bits 0-4=3DX (width), bits 5-7=3DY (length).=0A=
> +      * A signed relative X coordinate is at offset 6.=0A=
> +      * The bytes at offset 7-9 are the second touch X/Y coordinates.=0A=
> +      * Offset 10 has the second touch width and length.=0A=
> +      * Offset 11 has the relative Y coordinate.=0A=
> +      */=0A=
> +     offset =3D 1;=0A=
> +=0A=
> +     input_report_key(sc->touchpad, BTN_LEFT, rd[offset] & 0x0F);=0A=
> +     active =3D (rd[offset] >> 4);=0A=
> +=0A=
> +     offset++;=0A=
> +=0A=
> +     for (n =3D 0; n < 2; n++) {=0A=
> +             u16 x, y;=0A=
> +             u8 contactx, contacty;=0A=
> +             unsigned int rel_axis;=0A=
> +=0A=
> +             x =3D rd[offset] | ((rd[offset+1] & 0x0F) << 8);=0A=
> +             y =3D ((rd[offset+1] & 0xF0) >> 4) | (rd[offset+2] << 4);=
=0A=
> +=0A=
> +             input_mt_slot(sc->touchpad, n);=0A=
> +             input_mt_report_slot_state(sc->touchpad, MT_TOOL_FINGER, ac=
tive & 0x03);=0A=
> +=0A=
> +             if (active & 0x03) {=0A=
> +                     contactx =3D rd[offset+3] & 0x0F;=0A=
> +                     contacty =3D rd[offset+3] >> 4;=0A=
> +                     input_report_abs(sc->touchpad, ABS_MT_TOUCH_MAJOR,=
=0A=
> +                             max(contactx, contacty));=0A=
> +                     input_report_abs(sc->touchpad, ABS_MT_TOUCH_MINOR,=
=0A=
> +                             max(contactx, contacty));=0A=
> +                     input_report_abs(sc->touchpad, ABS_MT_ORIENTATION,=
=0A=
> +                             (bool) (contactx > contacty));=0A=
> +                     input_report_abs(sc->touchpad, ABS_MT_POSITION_X, x=
);=0A=
> +                     input_report_abs(sc->touchpad, ABS_MT_POSITION_Y,=
=0A=
> +                             NSG_MRXU_MAX_Y - y);=0A=
> +                     if (n =3D=3D 0)=0A=
> +                             rel_axis =3D REL_X;=0A=
> +                     else=0A=
> +                             rel_axis =3D REL_Y;=0A=
> +=0A=
> +                     input_report_rel(sc->touchpad, rel_axis, rd[offset+=
4]);=0A=
> +             }=0A=
> +=0A=
> +             offset +=3D 5;=0A=
> +                active >>=3D 2;=0A=
> +     }=0A=
> +=0A=
> +     input_mt_sync_frame(sc->touchpad);=0A=
> +=0A=
> +     input_sync(sc->touchpad);=0A=
> +}=0A=
> +=0A=
>  static int sony_raw_event(struct hid_device *hdev, struct hid_report *re=
port,=0A=
>               u8 *rd, int size)=0A=
>  {=0A=
> @@ -1459,6 +1534,10 @@ static int sony_raw_event(struct hid_device *hdev,=
 struct hid_report *report,=0A=
>               }=0A=
>=0A=
>               dualshock4_parse_report(sc, rd, size);=0A=
> +=0A=
> +     } else if (sc->quirks & NSG_MRXU_REMOTE && rd[0] =3D=3D 0x02) {=0A=
> +             nsg_mrxu_parse_report(sc, rd, size);=0A=
> +             return 1;=0A=
>       }=0A=
>=0A=
>       if (sc->defer_initialization) {=0A=
> @@ -1529,30 +1608,43 @@ static int sony_register_touchpad(struct sony_sc =
*sc, int touch_count,=0A=
>       sc->touchpad->id.product =3D sc->hdev->product;=0A=
>       sc->touchpad->id.version =3D sc->hdev->version;=0A=
>=0A=
> -     /* Append a suffix to the controller name as there are various=0A=
> -      * DS4 compatible non-Sony devices with different names.=0A=
> -      */=0A=
> -     name_sz =3D strlen(sc->hdev->name) + sizeof(DS4_TOUCHPAD_SUFFIX);=
=0A=
> +     /* Append a suffix to the controller name to make it more unique */=
=0A=
> +     name_sz =3D strlen(sc->hdev->name) + sizeof(TOUCHPAD_SUFFIX);=0A=
>       name =3D kzalloc(name_sz, GFP_KERNEL);=0A=
>       if (!name) {=0A=
>               ret =3D -ENOMEM;=0A=
>               goto err;=0A=
>       }=0A=
> -     snprintf(name, name_sz, "%s" DS4_TOUCHPAD_SUFFIX, sc->hdev->name);=
=0A=
> +     snprintf(name, name_sz, "%s" TOUCHPAD_SUFFIX, sc->hdev->name);=0A=
>       sc->touchpad->name =3D name;=0A=
>=0A=
> -     ret =3D input_mt_init_slots(sc->touchpad, touch_count, 0);=0A=
> -     if (ret < 0)=0A=
> -             goto err;=0A=
> +     if (!(sc->quirks & NSG_MRXU_REMOTE)) {=0A=
> +             ret =3D input_mt_init_slots(sc->touchpad, touch_count, 0);=
=0A=
> +             if (ret < 0)=0A=
> +                     goto err;=0A=
> +     }=0A=
=0A=
Why are you skipping input_mt_init_slots? I think you should be able to han=
dle your device at this point now as well. Prior we didn't pass in INPUT_MT=
_POINTER for the DS4, but we are now as udev and other systems have heurist=
ic for determining device types and configuring appropriate permissions for=
 pointer devices.=0A=
=0A=
>=0A=
>       /* We map the button underneath the touchpad to BTN_LEFT. */=0A=
>       __set_bit(EV_KEY, sc->touchpad->evbit);=0A=
>       __set_bit(BTN_LEFT, sc->touchpad->keybit);=0A=
> +     __clear_bit(BTN_MIDDLE, sc->touchpad->keybit);=0A=
> +     __clear_bit(BTN_RIGHT, sc->touchpad->keybit);=0A=
=0A=
Why is there a need to clear these bits? They shouldn't have been set.=0A=
=0A=
>       __set_bit(INPUT_PROP_BUTTONPAD, sc->touchpad->propbit);=0A=
>=0A=
>       input_set_abs_params(sc->touchpad, ABS_MT_POSITION_X, 0, w, 0, 0);=
=0A=
>       input_set_abs_params(sc->touchpad, ABS_MT_POSITION_Y, 0, h, 0, 0);=
=0A=
>=0A=
> +     if (sc->quirks & NSG_MRXU_REMOTE) {=0A=
> +             __set_bit(EV_REL, sc->touchpad->evbit);=0A=
> +             input_set_abs_params(sc->touchpad, ABS_MT_TOUCH_MAJOR, 0, 1=
5, 0, 0);=0A=
> +             input_set_abs_params(sc->touchpad, ABS_MT_TOUCH_MINOR, 0, 1=
5, 0, 0);=0A=
> +             input_set_abs_params(sc->touchpad, ABS_MT_ORIENTATION, 0, 1=
, 0, 0);=0A=
> +=0A=
> +             ret =3D input_mt_init_slots(sc->touchpad, touch_count, INPU=
T_MT_POINTER);=0A=
> +             if (ret < 0)=0A=
> +                     goto err;=0A=
> +     }=0A=
> +=0A=
=0A=
Rmove input_mt_init_slots from here and the rest could stay within the quir=
k for this device.=0A=
=0A=
=0A=
>       ret =3D input_register_device(sc->touchpad);=0A=
>       if (ret < 0)=0A=
>               goto err;=0A=
> @@ -2586,6 +2678,20 @@ static int sony_input_configured(struct hid_device=
 *hdev,=0A=
>               }=0A=
>=0A=
>               sony_init_output_report(sc, dualshock4_send_output_report);=
=0A=
> +     } else if (sc->quirks & NSG_MRXU_REMOTE) {=0A=
> +             /*=0A=
> +              * The NSG-MRxU touchpad supports 2 touches and has a=0A=
> +              * resolution of 1667x1868=0A=
> +              */=0A=
> +             ret =3D sony_register_touchpad(sc, 2,=0A=
> +                     NSG_MRXU_MAX_X, NSG_MRXU_MAX_Y);=0A=
> +             if (ret) {=0A=
=0A=
I think it would be nicer to use 'if (ret < 0) {'. That said I didn't do th=
e same of the other code, which I probably should rectify at some point as =
well.=0A=
=0A=
> +                     hid_err(sc->hdev,=0A=
> +                     "Unable to initialize multi-touch slots: %d\n",=0A=
> +                     ret);=0A=
> +                     goto err_stop;=0A=
> +             }=0A=
> +=0A=
>       } else if (sc->quirks & MOTION_CONTROLLER) {=0A=
>               sony_init_output_report(sc, motion_send_output_report);=0A=
>       } else {=0A=
> @@ -2830,6 +2936,12 @@ static const struct hid_device_id sony_devices[] =
=3D {=0A=
>       /* Nyko Core Controller for PS3 */=0A=
>       { HID_USB_DEVICE(USB_VENDOR_ID_SINO_LITE, USB_DEVICE_ID_SINO_LITE_C=
ONTROLLER),=0A=
>               .driver_data =3D SIXAXIS_CONTROLLER_USB | SINO_LITE_CONTROL=
LER },=0A=
> +     /* SMK-Link NSG-MR5U Remote Control */=0A=
> +     { HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_SMK, USB_DEVICE_ID_SMK_NSG_MR5=
U_REMOTE),=0A=
> +             .driver_data =3D NSG_MR5U_REMOTE_BT },=0A=
> +     /* SMK-Link NSG-MR7U Remote Control */=0A=
> +     { HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_SMK, USB_DEVICE_ID_SMK_NSG_MR7=
U_REMOTE),=0A=
> +             .driver_data =3D NSG_MR7U_REMOTE_BT },=0A=
>       { }=0A=
>  };=0A=
>  MODULE_DEVICE_TABLE(hid, sony_devices);=0A=
> --=0A=
> 2.7.4=0A=
>=0A=
=0A=
--=0A=
Jiri Kosina=0A=
SUSE Labs=0A=
=0A=
=0A=
