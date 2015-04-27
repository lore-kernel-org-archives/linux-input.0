From: Dario Righelli <drighelli@gmail.com>
Subject: Re: [Patch V2] Driver for Logitech M560
Date: Mon, 27 Apr 2015 22:42:27 +0200
Message-ID: <CAFUZzG5bXVm3kPB=qSNSRj5w380JqURE3G4avN55JQHcVm44Ug@mail.gmail.com>
References: <5404C6F4.1000800@inwind.it>
	<CAN+gG=HMUJBWQj65OKRfoPiyzzRPXLVveA6V2S_a1dSJXKJc3g@mail.gmail.com>
	<5409F740.9000706@inwind.it>
	<20150409144154.36fbce15dcdf4556544ee8a7@ao2.it>
	<CAN+gG=Hhp8AiUgnDAC3Nda-rdVgJHg7Rgs1e9HajAws-_-L+Cw@mail.gmail.com>
	<55281CEC.4040201@inwind.it>
	<CAN+gG=F2mVz6nmq69ZVf_TPzaJgSdUa6k-2GMogfOR4pap+2cg@mail.gmail.com>
	<552C09C5.4070807@inwind.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wi0-f180.google.com ([209.85.212.180]:33896 "EHLO
	mail-wi0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965009AbbD0Um2 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 27 Apr 2015 16:42:28 -0400
Received: by wicmx19 with SMTP id mx19so92997042wic.1
        for <linux-input@vger.kernel.org>; Mon, 27 Apr 2015 13:42:27 -0700 (PDT)
In-Reply-To: <552C09C5.4070807@inwind.it>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: kreijack@inwind.it
Cc: Benjamin Tissoires <benjamin.tissoires@gmail.com>, Antonio Ospite <ao2@ao2.it>, Nestor Lopez Casado <nlopezcasad@logitech.com>, HID CORE LAYER <linux-input@vger.kernel.org>

Hi Goffredo,

I've tested your patch for Logitech M560 mouse on kernel v3.19.3 with
xev and evtest commands, it works well.
In this mail I report the output of evtest command.

Bye,
Dario

>
> ----
>
> The Logitech M560 is is a mouse designed for windows 8.
> Comparing to a standard one, some buttons (the middle one and the
> two ones placed on the side) are bounded to a key combination
> instead of a classic "mouse" button.
>
> Think this mouse as a pair of mouse and keyboard. When the middle
> button is pressed the it sends a key (as keyboard)
> combination, the same for the other two side button.
> Instead the left/right/wheel work correctly.
> To complicate further the things, the middle button send a
> key combination the odd press, and another one for the even press;
> in the latter case it sends also a left click. But the worst thing
> is that no event is generated when the middle button is released.
>
> Moreover this device is a wireless mouse which uses the unifying
> receiver.
>
> I discovered that it is possible to re-configure the mouse
> sending a command (see function m560_send_config_command()).
> After this command the mouse sends some sequence when the
> buttons are pressed and/or released (see comments for
> an explanation of the mouse protocol).
>
> This patch update the file driver/hid/hid-logitech-hidpp.c (v3.19.3)
>
> Signed-off-by: Goffredo Baroncelli <kreijack@inwind.it>

Tested-by: Dario Righelli <drighelli@gmail.com>

$ sudo evtest
No device specified, trying to scan all of /dev/input/event*
Available devices:
/dev/input/event0:    Power Button
/dev/input/event1:    Power Button
/dev/input/event2:    USB USB Keyboard
/dev/input/event3:    USB USB Keyboard
/dev/input/event4:    Logitech USB Receiver
/dev/input/event5:    Logitech USB Receiver
/dev/input/event6:    Logitech M560
/dev/input/event7:    Logitech Wireless Mouse M560
Select the device event number [0-7]: 6
Input driver version is 1.0.1
Input device ID: bus 0x3 vendor 0x46d product 0x402d version 0x111
Input device name: "Logitech M560"
Supported events:
  Event type 0 (EV_SYN)
  Event type 1 (EV_KEY)
    Event code 272 (BTN_LEFT)
    Event code 273 (BTN_RIGHT)
    Event code 274 (BTN_MIDDLE)
    Event code 275 (BTN_SIDE)
    Event code 276 (BTN_EXTRA)
    Event code 277 (BTN_FORWARD)
    Event code 278 (BTN_BACK)
    Event code 279 (BTN_TASK)
    Event code 280 (?)
    Event code 281 (?)
    Event code 282 (?)
    Event code 283 (?)
    Event code 284 (?)
    Event code 285 (?)
    Event code 286 (?)
    Event code 287 (?)
  Event type 2 (EV_REL)
    Event code 0 (REL_X)
    Event code 1 (REL_Y)
    Event code 6 (REL_HWHEEL)
    Event code 8 (REL_WHEEL)
  Event type 4 (EV_MSC)
    Event code 4 (MSC_SCAN)

>
> Changelog:
> - v1 first issue
> - v2 accepted Benjamin Tissoires suggestions
>
> diff --git a/hid-logitech-hidpp.c b/hid-logitech-hidpp.c
> index a93cefe..805ecb6 100644
> --- a/hid-logitech-hidpp.c
> +++ b/hid-logitech-hidpp.c
> @@ -35,8 +35,9 @@ MODULE_AUTHOR("Nestor Lopez Casado <nlopezcasad@logitech.com>");
>  #define HIDPP_REPORT_LONG_LENGTH               20
>
>  #define HIDPP_QUIRK_CLASS_WTP                  BIT(0)
> +#define HIDPP_QUIRK_CLASS_M560                 BIT(1)
>
> -/* bits 1..20 are reserved for classes */
> +/* bits 2..20 are reserved for classes */
>  #define HIDPP_QUIRK_DELAYED_INIT               BIT(21)
>  #define HIDPP_QUIRK_WTP_PHYSICAL_BUTTONS       BIT(22)
>  #define HIDPP_QUIRK_MULTI_INPUT                        BIT(23)
> @@ -925,6 +926,177 @@ static void wtp_connect(struct hid_device *hdev, bool connected)
>  }
>
>  /* -------------------------------------------------------------------------- */
> +/* Logitech M560 devices                                                     */
> +/* -------------------------------------------------------------------------- */
> +
> +/*
> + * Logitech M560 protocol overview
> + *
> + * The Logitech M560 mouse, is designed for windows 8. When the middle and/or
> + * the sides buttons are pressed, it sends some keyboard keys events
> + * instead of buttons ones.
> + * To complicate further the things, the middle button keys sequence
> + * is different from the odd press and the even press.
> + *
> + * forward button -> Super_R
> + * backward button -> Super_L+'d' (press only)
> + * middle button -> 1st time: Alt_L+SuperL+XF86TouchpadOff (press only)
> + *                  2nd time: left-click (press only)
> + * NB: press-only means that when the button is pressed, the
> + * KeyPress/ButtonPress and KeyRelease/ButtonRelease events are generated
> + * together sequentially; instead when the button is released, no event is
> + * generated !
> + *
> + * With the command
> + *     10<xx>0a 3500af03 (where <xx> is the mouse id),
> + * the mouse reacts differently:
> + * - it never send a keyboard key event
> + * - for the three mouse button it sends:
> + *     middle button               press   11<xx>0a 3500af00...
> + *     side 1 button (forward)     press   11<xx>0a 3500b000...
> + *     side 2 button (backward)    press   11<xx>0a 3500ae00...
> + *     middle/side1/side2 button   release 11<xx>0a 35000000...
> + */
> +
> +static const u8 m560_config_parameter[] = {0x00, 0xaf, 0x03};
> +
> +struct m560_private_data {
> +       u8 prev_data[10];
> +       u8 button_pressed;
> +};
> +
> +/* how the button are mapped in the report */
> +#define M560_MOUSE_BTN_LEFT            0x01
> +#define M560_MOUSE_BTN_RIGHT           0x02
> +#define M560_MOUSE_BTN_MIDDLE          0x04
> +#define M560_MOUSE_BTN_WHEEL_LEFT      0x08
> +#define M560_MOUSE_BTN_WHEEL_RIGHT     0x10
> +#define M560_MOUSE_BTN_FORWARD         0x20
> +#define M560_MOUSE_BTN_BACKWARD                0x40
> +#define M560_SUB_ID                    0x0a
> +#define M560_BUTTON_MODE_REGISTER      0x35
> +
> +/*
> + * m560_send_config_command - send the config_command to the mouse
> + *
> + * @dev: hid device where the mouse belongs
> + *
> + * @return: 0 OK
> + */
> +static int m560_send_config_command(struct hid_device *hdev)
> +{
> +       struct hidpp_report response;
> +       struct hidpp_device *hidpp_dev = hid_get_drvdata(hdev);
> +       int ret;
> +
> +       ret = hidpp_send_rap_command_sync(
> +               hidpp_dev,
> +               REPORT_ID_HIDPP_SHORT,
> +               M560_SUB_ID,
> +               M560_BUTTON_MODE_REGISTER,
> +               (u8 *)m560_config_parameter,
> +               sizeof(m560_config_parameter),
> +               &response
> +       );
> +
> +       return ret;
> +}
> +
> +static int m560_allocate(struct hid_device *hdev)
> +{
> +       struct hidpp_device *hidpp = hid_get_drvdata(hdev);
> +       struct m560_private_data *d;
> +
> +       d = devm_kzalloc(&hdev->dev, sizeof(struct m560_private_data),
> +                       GFP_KERNEL);
> +       if (!d)
> +               return -ENOMEM;
> +
> +       hidpp->private_data = d;
> +
> +       return 0;
> +};
> +
> +static int m560_raw_event(struct hid_device *hdev, u8 *data, int size)
> +{
> +       struct hidpp_device *hidpp = hid_get_drvdata(hdev);
> +       struct m560_private_data *mydata = hidpp->private_data;
> +       u8 *btn_ptr = data+1;
> +       u8 *wheel_ptr = data+1+6;
> +
> +       /* check if the data is a mouse related report */
> +       if (data[0] != 0x02 && data[2] != M560_SUB_ID)
> +               return 1;
> +
> +       if (data[0] == REPORT_ID_HIDPP_LONG &&
> +           data[2] == M560_SUB_ID && data[06] == 0x00) {
> +               /*
> +                * m560 mouse button report
> +                *
> +                * data[0] = 0x11
> +                * data[1] = deviceid
> +                * data[2] = 0x0a
> +                * data[5] = button (0xaf->middle, 0xb0->forward,
> +                *                   0xaf ->backward, 0x00->release all)
> +                * data[6] = 0x00
> +                */
> +
> +               int btn, i, maxsize;
> +
> +               /* check if the event is a button */
> +               btn = data[5];
> +               if (btn != 0x00 && btn != 0xb0 && btn != 0xae && btn != 0xaf)
> +                       return 1;
> +
> +               if (btn == 0xaf)
> +                       mydata->button_pressed |= M560_MOUSE_BTN_MIDDLE;
> +               else if (btn == 0xb0)
> +                       mydata->button_pressed |= M560_MOUSE_BTN_FORWARD;
> +               else if (btn == 0xae)
> +                       mydata->button_pressed |= M560_MOUSE_BTN_BACKWARD;
> +               else if (btn == 0x00)
> +                       mydata->button_pressed &= ~(M560_MOUSE_BTN_BACKWARD|
> +                               M560_MOUSE_BTN_MIDDLE|M560_MOUSE_BTN_FORWARD);
> +
> +               /* replace the report with the old one */
> +               if (size > sizeof(mydata->prev_data))
> +                       maxsize = sizeof(mydata->prev_data);
> +               else
> +                       maxsize = size;
> +               for (i = 0 ; i < maxsize ; i++)
> +                       data[i] = mydata->prev_data[i];
> +
> +       } else if (data[0] == 0x02) {
> +               /*
> +                * standard mouse report
> +                *
> +                * data[0] = type (0x02)
> +                * data[1..2] = buttons
> +                * data[3..5] = xy
> +                * data[6] = wheel
> +                * data[7] = horizontal wheel
> +                */
> +
> +               /* horizontal wheel handling */
> +               if (*btn_ptr & M560_MOUSE_BTN_WHEEL_LEFT)
> +                       *wheel_ptr = -1;
> +               if (*btn_ptr & M560_MOUSE_BTN_WHEEL_RIGHT)
> +                       *wheel_ptr =  1;
> +
> +               *btn_ptr &= ~(M560_MOUSE_BTN_WHEEL_LEFT|
> +                               M560_MOUSE_BTN_WHEEL_RIGHT);
> +
> +               /* copy the type and buttons status */
> +               memcpy(mydata->prev_data, data, 3);
> +       }
> +
> +       /* add the extra buttons */
> +       *btn_ptr |= mydata->button_pressed;
> +
> +       return 1;
> +}
> +
> +/* -------------------------------------------------------------------------- */
>  /* Generic HID++ devices                                                      */
>  /* -------------------------------------------------------------------------- */
>
> @@ -936,6 +1108,9 @@ static int hidpp_input_mapping(struct hid_device *hdev, struct hid_input *hi,
>
>         if (hidpp->quirks & HIDPP_QUIRK_CLASS_WTP)
>                 return wtp_input_mapping(hdev, hi, field, usage, bit, max);
> +       else if (hidpp->quirks & HIDPP_QUIRK_CLASS_M560 &&
> +                field->application != HID_GD_MOUSE)
> +                       return -1;
>
>         return 0;
>  }
> @@ -998,6 +1173,8 @@ static int hidpp_raw_hidpp_event(struct hidpp_device *hidpp, u8 *data,
>
>         if (hidpp->quirks & HIDPP_QUIRK_CLASS_WTP)
>                 return wtp_raw_event(hidpp->hid_dev, data, size);
> +       else if (hidpp->quirks & HIDPP_QUIRK_CLASS_M560)
> +               return m560_raw_event(hidpp->hid_dev, data, size);
>
>         return 0;
>  }
> @@ -1026,7 +1203,8 @@ static int hidpp_raw_event(struct hid_device *hdev, struct hid_report *report,
>
>         if (hidpp->quirks & HIDPP_QUIRK_CLASS_WTP)
>                 return wtp_raw_event(hdev, data, size);
> -
> +       else if (hidpp->quirks & HIDPP_QUIRK_CLASS_M560)
> +               return m560_raw_event(hidpp->hid_dev, data, size);
>         return 0;
>  }
>
> @@ -1100,6 +1278,8 @@ static void hidpp_connect_event(struct hidpp_device *hidpp)
>
>         if (hidpp->quirks & HIDPP_QUIRK_CLASS_WTP)
>                 wtp_connect(hdev, connected);
> +       if ((hidpp->quirks & HIDPP_QUIRK_CLASS_M560) && connected)
> +               m560_send_config_command(hdev);
>
>         if (!connected || hidpp->delayed_input)
>                 return;
> @@ -1162,7 +1342,12 @@ static int hidpp_probe(struct hid_device *hdev, const struct hid_device_id *id)
>         if (hidpp->quirks & HIDPP_QUIRK_CLASS_WTP) {
>                 ret = wtp_allocate(hdev, id);
>                 if (ret)
> -                       goto wtp_allocate_fail;
> +                       goto allocate_fail;
> +       }
> +       if (hidpp->quirks & HIDPP_QUIRK_CLASS_M560) {
> +               ret = m560_allocate(hdev);
> +               if (ret)
> +                       goto allocate_fail;
>         }
>
>         INIT_WORK(&hidpp->work, delayed_work_cb);
> @@ -1228,7 +1413,7 @@ hid_hw_start_fail:
>  hid_parse_fail:
>         cancel_work_sync(&hidpp->work);
>         mutex_destroy(&hidpp->send_mutex);
> -wtp_allocate_fail:
> +allocate_fail:
>         hid_set_drvdata(hdev, NULL);
>         return ret;
>  }
> @@ -1261,6 +1446,12 @@ static const struct hid_device_id hidpp_devices[] = {
>                 USB_VENDOR_ID_LOGITECH, 0x4102),
>           .driver_data = HIDPP_QUIRK_DELAYED_INIT | HIDPP_QUIRK_MULTI_INPUT |
>                          HIDPP_QUIRK_CLASS_WTP },
> +       { /* Mouse logitech M560 */
> +         HID_DEVICE(BUS_USB, HID_GROUP_LOGITECH_DJ_DEVICE,
> +               USB_VENDOR_ID_LOGITECH, 0x402d),
> +         .driver_data = HIDPP_QUIRK_CLASS_M560 | HIDPP_QUIRK_DELAYED_INIT |
> +                        HIDPP_QUIRK_MULTI_INPUT
> +       },
>
>         { HID_DEVICE(BUS_USB, HID_GROUP_LOGITECH_DJ_DEVICE,
>                 USB_VENDOR_ID_LOGITECH, HID_ANY_ID)},
>
