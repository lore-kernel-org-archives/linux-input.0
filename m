From: tsopdump <tsopdump@gmail.com>
Subject: Re: [PATCH] HID: sony: Add touchpad support for NSG-MR5U and NSG-MR7U remotes
Date: Thu, 15 Feb 2018 16:26:56 -0700
Message-ID: <CAOYTB1R_qo0+Qg=93PB4X=S9V=6T2H9S8c=RTVVd0Q1OqoFX5g@mail.gmail.com>
References: <20180201180904.x3gwrrtur7uioeoo@todd-HP-Compaq-Elite-8300-USDT> <CAEc3jaApfXDnq+691tWHmzGzVYOcp5J3OACuyQ0L9vM=oYwDAQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qt0-f194.google.com ([209.85.216.194]:41015 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1163785AbeBOX05 (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Thu, 15 Feb 2018 18:26:57 -0500
Received: by mail-qt0-f194.google.com with SMTP id a9so1816312qtj.8
        for <linux-input@vger.kernel.org>; Thu, 15 Feb 2018 15:26:57 -0800 (PST)
In-Reply-To: <CAEc3jaApfXDnq+691tWHmzGzVYOcp5J3OACuyQ0L9vM=oYwDAQ@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Roderick Colenbrander <thunderbird2k@gmail.com>
Cc: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-input <linux-input@vger.kernel.org>

On Tue, Feb 13, 2018 at 03:48:48PM -0800, Roderick Colenbrander wrote:
> On Thu, Feb 1, 2018 at 10:09 AM, Todd Kelner <tsopdump@gmail.com> wrote:
> > Sony's NSG-MR5U and NSG-MR7U remote controls have a full keyboard and a
> > touchpad.  The keyboard is already supported by the existing Linux
> > kernel and drivers but the touchpad is not recognized.  This patch adds
> > the coded needed to bring full functionality to the touchpad.
> >
> > Note that these remotes use the vendor code for SMK even though they are
> > Sony branded.
> >
> > Known limitations
> > - The built-in accelerometers are not supported by these changes
> > - When the Drag (Fn) key is used as a mouse button, the button is
> >   automatically released when the key begins repeating.  There are two
> >   workarounds for this 1) Use the button behind the touchpad instead of
> >   the Drag (Fn) key or 2) Disable the key repeat functionality or
> >   increase the key repeat delay.
> >
> > Signed-off-by: Todd Kelner <tsopdump@gmail.com>
> > ---
> >  drivers/hid/hid-core.c |   2 +
> >  drivers/hid/hid-ids.h  |   2 +
> >  drivers/hid/hid-sony.c | 118 +++++++++++++++++++++++++++++++++++++++++++++++--
> >  3 files changed, 119 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
> > index 0c3f608131cf..4b6be344466b 100644
> > --- a/drivers/hid/hid-core.c
> > +++ b/drivers/hid/hid-core.c
> > @@ -2301,6 +2301,8 @@ static const struct hid_device_id hid_have_special_driver[] = {
> >  #if IS_ENABLED(CONFIG_HID_SONY)
> >         { HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_LOGITECH_HARMONY_PS3) },
> >         { HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_SMK, USB_DEVICE_ID_SMK_PS3_BDREMOTE) },
> > +       { HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_SMK, USB_DEVICE_ID_SMK_NSG_MR5U_REMOTE) },
> > +       { HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_SMK, USB_DEVICE_ID_SMK_NSG_MR7U_REMOTE) },
> >         { HID_USB_DEVICE(USB_VENDOR_ID_SONY, USB_DEVICE_ID_SONY_BUZZ_CONTROLLER) },
> >         { HID_USB_DEVICE(USB_VENDOR_ID_SONY, USB_DEVICE_ID_SONY_WIRELESS_BUZZ_CONTROLLER) },
> >         { HID_USB_DEVICE(USB_VENDOR_ID_SONY, USB_DEVICE_ID_SONY_MOTION_CONTROLLER) },
> > diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
> > index 5da3d6256d25..793d80bdd301 100644
> > --- a/drivers/hid/hid-ids.h
> > +++ b/drivers/hid/hid-ids.h
> > @@ -954,6 +954,8 @@
> >
> >  #define USB_VENDOR_ID_SMK              0x0609
> >  #define USB_DEVICE_ID_SMK_PS3_BDREMOTE 0x0306
> > +#define USB_DEVICE_ID_SMK_NSG_MR5U_REMOTE      0x0368
> > +#define USB_DEVICE_ID_SMK_NSG_MR7U_REMOTE      0x0369
> >
> >  #define USB_VENDOR_ID_SONY                     0x054c
> >  #define USB_DEVICE_ID_SONY_VAIO_VGX_MOUSE      0x024b
> > diff --git a/drivers/hid/hid-sony.c b/drivers/hid/hid-sony.c
> > index b9dc3ac4d4aa..8504f4fae6af 100644
> > --- a/drivers/hid/hid-sony.c
> > +++ b/drivers/hid/hid-sony.c
> > @@ -9,6 +9,7 @@
> >   *  Copyright (c) 2006-2013 Jiri Kosina
> >   *  Copyright (c) 2013 Colin Leitner <colin.leitner@gmail.com>
> >   *  Copyright (c) 2014-2016 Frank Praznik <frank.praznik@gmail.com>
> > + *  Copyright (c) 2018 Todd Kelner
> >   */
> >
> >  /*
> > @@ -55,6 +56,8 @@
> >  #define NAVIGATION_CONTROLLER_BT  BIT(11)
> >  #define SINO_LITE_CONTROLLER      BIT(12)
> >  #define FUTUREMAX_DANCE_MAT       BIT(13)
> > +#define NSG_MR5U_REMOTE_BT        BIT(14)
> > +#define NSG_MR7U_REMOTE_BT        BIT(15)
> >
> >  #define SIXAXIS_CONTROLLER (SIXAXIS_CONTROLLER_USB | SIXAXIS_CONTROLLER_BT)
> >  #define MOTION_CONTROLLER (MOTION_CONTROLLER_USB | MOTION_CONTROLLER_BT)
> > @@ -72,8 +75,11 @@
> >                                 MOTION_CONTROLLER)
> >  #define SONY_BT_DEVICE (SIXAXIS_CONTROLLER_BT | DUALSHOCK4_CONTROLLER_BT |\
> >                         MOTION_CONTROLLER_BT | NAVIGATION_CONTROLLER_BT)
> > +#define NSG_MRXU_REMOTE (NSG_MR5U_REMOTE_BT | NSG_MR7U_REMOTE_BT)
> >
> >  #define MAX_LEDS 4
> > +#define NSG_MRXU_MAX_X 1667
> > +#define NSG_MRXU_MAX_Y 1868
> >
> >
> >  /* PS/3 Motion controller */
> > @@ -1072,6 +1078,75 @@ static void dualshock4_parse_report(struct sony_sc *sc, u8 *rd, int size)
> >         }
> >  }
> >
> > +static void nsg_mrxu_parse_report(struct sony_sc *sc, u8 *rd, int size)
> > +{
> > +       int n, offset;
> > +       u8 active;
> > +
> > +       /*
> > +        * The NSG-MRxU multi-touch trackpad data starts at offset 1 and
> > +        *   the touch-related data starts at offset 2.
> > +        * For the first byte, bit 0 is set when touchpad button is pressed.
> > +        * Bit 3 is set when a touch is active and the drag (Fn) key is pressed.
> > +        * This drag key is mapped to BTN_LEFT.
> > +        * Bit 4 is set when only the first touch point is active.
> > +        * Bit 6 is set when only the second touch point is active.
> > +        * Bits 5 and 7 are set when both touch points are active.
> > +        * The next 3 bytes are two 12 bit X/Y coordinates for the first touch.
> > +        * The following byte, offset 5, has the touch width and length.
> > +        *   Bits 0-4=X (width), bits 5-7=Y (length).
> > +        * A signed relative X coordinate is at offset 6.
> > +        * The bytes at offset 7-9 are the second touch X/Y coordinates.
> > +        * Offset 10 has the second touch width and length.
> > +        * Offset 11 has the relative Y coordinate.
> > +        */
> > +       offset = 1;
> > +
> > +       input_report_key(sc->touchpad, BTN_LEFT, rd[offset] & 0x0F);
> > +       active = (rd[offset] >> 4);
> > +
> > +       offset++;
> > +
> > +       for (n = 0; n < 2; n++) {
> > +               u16 x, y;
> > +               u8 contactx, contacty;
> > +               unsigned int rel_axis;
> > +
> > +               x = rd[offset] | ((rd[offset+1] & 0x0F) << 8);
> > +               y = ((rd[offset+1] & 0xF0) >> 4) | (rd[offset+2] << 4);
> > +
> > +               input_mt_slot(sc->touchpad, n);
> > +               input_mt_report_slot_state(sc->touchpad, MT_TOOL_FINGER, active & 0x03);
> > +
> > +               if (active & 0x03) {
> > +                       contactx = rd[offset+3] & 0x0F;
> > +                       contacty = rd[offset+3] >> 4;
> > +                       input_report_abs(sc->touchpad, ABS_MT_TOUCH_MAJOR,
> > +                               max(contactx, contacty));
> > +                       input_report_abs(sc->touchpad, ABS_MT_TOUCH_MINOR,
> > +                               max(contactx, contacty));
> > +                       input_report_abs(sc->touchpad, ABS_MT_ORIENTATION,
> > +                               (bool) (contactx > contacty));
> > +                       input_report_abs(sc->touchpad, ABS_MT_POSITION_X, x);
> > +                       input_report_abs(sc->touchpad, ABS_MT_POSITION_Y,
> > +                               NSG_MRXU_MAX_Y - y);
> > +                       if (n == 0)
> > +                               rel_axis = REL_X;
> > +                       else
> > +                               rel_axis = REL_Y;
> > +
> > +                       input_report_rel(sc->touchpad, rel_axis, rd[offset+4]);
> > +               }
> > +
> > +               offset += 5;
> > +               active >>= 2;
> > +       }
> > +
> > +       input_mt_sync_frame(sc->touchpad);
> > +
> > +       input_sync(sc->touchpad);
> > +}
> > +
> >  static int sony_raw_event(struct hid_device *hdev, struct hid_report *report,
> >                 u8 *rd, int size)
> >  {
> > @@ -1180,6 +1255,10 @@ static int sony_raw_event(struct hid_device *hdev, struct hid_report *report,
> >                 }
> >
> >                 dualshock4_parse_report(sc, rd, size);
> > +
> > +       } else if ((sc->quirks & NSG_MRXU_REMOTE) && rd[0] == 0x02) {
> > +               nsg_mrxu_parse_report(sc, rd, size);
> > +               return 1;
> >         }
> >
> >         if (sc->defer_initialization) {
> > @@ -1268,9 +1347,11 @@ static int sony_register_touchpad(struct sony_sc *sc, int touch_count,
> >         snprintf(name, name_sz, "%s" DS4_TOUCHPAD_SUFFIX, sc->hdev->name);
> >         sc->touchpad->name = name;
> >
> > -       ret = input_mt_init_slots(sc->touchpad, touch_count, INPUT_MT_POINTER);
> > -       if (ret < 0)
> > -               goto err;
> > +       if (!(sc->quirks & NSG_MRXU_REMOTE)) {
> > +               ret = input_mt_init_slots(sc->touchpad, touch_count, INPUT_MT_POINTER);
> > +               if (ret < 0)
> > +                       goto err;
> > +       }
>
> Why do you need to split input_mt_init_slots between non-NSG and NSG
> later? It looks like it is to set some parameters on the touchpad
> before input_mt_init_slots. I have no problem moving the general
> input_init_mt_slots until later, so we only need it once.
>
>
The call to input_mt_init_slots should occur after the __set_bit calls.
I avoided moving the general input_init_mt_slots because I'm not able to
test the change with a DS4 controller.  I'm willing to remove the first
call to input_mt_init_slots and have all devices use the second call to
input_mt_init_slots as long as you're OK with me not testing the change
on a DS4 controller.

> >         /* We map the button underneath the touchpad to BTN_LEFT. */
> >         __set_bit(EV_KEY, sc->touchpad->evbit);
> > @@ -1280,6 +1361,17 @@ static int sony_register_touchpad(struct sony_sc *sc, int touch_count,
> >         input_set_abs_params(sc->touchpad, ABS_MT_POSITION_X, 0, w, 0, 0);
> >         input_set_abs_params(sc->touchpad, ABS_MT_POSITION_Y, 0, h, 0, 0);
> >
> > +       if (sc->quirks & NSG_MRXU_REMOTE) {
> > +               __set_bit(EV_REL, sc->touchpad->evbit);
> > +               input_set_abs_params(sc->touchpad, ABS_MT_TOUCH_MAJOR, 0, 15, 0, 0);
> > +               input_set_abs_params(sc->touchpad, ABS_MT_TOUCH_MINOR, 0, 15, 0, 0);
> > +               input_set_abs_params(sc->touchpad, ABS_MT_ORIENTATION, 0, 1, 0, 0);
> > +
>
> I'm a little thorn on the NSG quirk check. On one hand
> sony_register_touchpad is a helper function, which receives width and
> height, but then there is this special logic.
>
> Maybe it would be best to introduce some new parameters (not sure
> which) to trigger this other mode, so we don't need special case.
>
I agree this needs to be changed.  Adding more parameters isn't ideal
but probably is the best/easiest option.  I'll make that change and
upload a new patch.

> > +               ret = input_mt_init_slots(sc->touchpad, touch_count, INPUT_MT_POINTER);
> > +               if (ret < 0)
> > +                       goto err;
> > +       }
> > +
> >         ret = input_register_device(sc->touchpad);
> >         if (ret < 0)
> >                 goto err;
> > @@ -2654,6 +2746,20 @@ static int sony_input_configured(struct hid_device *hdev,
> >                 }
> >
> >                 sony_init_output_report(sc, dualshock4_send_output_report);
> > +       } else if (sc->quirks & NSG_MRXU_REMOTE) {
> > +               /*
> > +                * The NSG-MRxU touchpad supports 2 touches and has a
> > +                * resolution of 1667x1868
> > +                */
> > +               ret = sony_register_touchpad(sc, 2,
> > +                       NSG_MRXU_MAX_X, NSG_MRXU_MAX_Y);
> > +               if (ret) {
> > +                       hid_err(sc->hdev,
> > +                       "Unable to initialize multi-touch slots: %d\n",
> > +                       ret);
> > +                       goto err_stop;
> > +               }
> > +
> >         } else if (sc->quirks & MOTION_CONTROLLER) {
> >                 sony_init_output_report(sc, motion_send_output_report);
> >         } else {
> > @@ -2892,6 +2998,12 @@ static const struct hid_device_id sony_devices[] = {
> >         /* Nyko Core Controller for PS3 */
> >         { HID_USB_DEVICE(USB_VENDOR_ID_SINO_LITE, USB_DEVICE_ID_SINO_LITE_CONTROLLER),
> >                 .driver_data = SIXAXIS_CONTROLLER_USB | SINO_LITE_CONTROLLER },
> > +       /* SMK-Link NSG-MR5U Remote Control */
> > +       { HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_SMK, USB_DEVICE_ID_SMK_NSG_MR5U_REMOTE),
> > +               .driver_data = NSG_MR5U_REMOTE_BT },
> > +       /* SMK-Link NSG-MR7U Remote Control */
> > +       { HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_SMK, USB_DEVICE_ID_SMK_NSG_MR7U_REMOTE),
> > +               .driver_data = NSG_MR7U_REMOTE_BT },
> >         { }
> >  };
> >  MODULE_DEVICE_TABLE(hid, sony_devices);
> > --
> > 2.14.1
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-input" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
