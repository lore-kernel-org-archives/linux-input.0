From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: Re: [PATCH] Add driver for mouse logitech M560
Date: Wed, 29 Apr 2015 15:31:03 -0400
Message-ID: <55413177.7020909@gmail.com>
References: <1430331854-11206-1-git-send-email-kreijack@libero.it> <1430331854-11206-2-git-send-email-kreijack@libero.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-vn0-f53.google.com ([209.85.216.53]:37775 "EHLO
	mail-vn0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752369AbbD2TbF (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 29 Apr 2015 15:31:05 -0400
Received: by vnbg129 with SMTP id g129so4650700vnb.4
        for <linux-input@vger.kernel.org>; Wed, 29 Apr 2015 12:31:04 -0700 (PDT)
In-Reply-To: <1430331854-11206-2-git-send-email-kreijack@libero.it>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Goffredo Baroncelli <kreijack@libero.it>
Cc: linux-input <linux-input@vger.kernel.org>, Antonio Ospite <ao2@ao2.it>, Nestor Lopez Casado <nlopezcasad@logitech.com>, Dario Righelli <drighelli@gmail.com>, Goffredo Baroncelli <kreijack@inwind.it>

Hi Goffredo,

On Wed, Apr 29, 2015 at 2:24 PM, Goffredo Baroncelli <kreijack@libero.it> wrote:
> From: Goffredo Baroncelli <kreijack@inwind.it>
>
> The Logitech M560 is a wireless mouse designed for windows 8 which uses
> the unifying receiver.
> Compared to a standard one, some buttons (the middle one and the
> two ones placed on the side) are bound to a key combination
> instead of a classic "mouse" button.
>
> The device shows up as a mouse and keyboard combination: when the middle
> button is pressed it sends a key (as keyboard) combination, the same happens
> for the two side button. The left/right/wheel work  as expected from a
> mouse. To complicate things further, the middle button sends different keys
> combinations between odd and even presses.
> In the "even" press it also sends a left click. But the worst thing
> is that no event is generated when the middle button is released.
>
> It is possible to re-configure the mouse sending a command (see function
> m560_send_config_command()). After this command the mouse sends some
> useful data when the buttons are pressed and/or released
>
> Signed-off-by: Goffredo Baroncelli <kreijack@inwind.it>
> ---

Thanks for this new version. I have a few nitpicks which should not take too long to apply:

>  drivers/hid/hid-logitech-hidpp.c | 243 ++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 240 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
> index b3cf6fd..d7e33c8 100644
> --- a/drivers/hid/hid-logitech-hidpp.c
> +++ b/drivers/hid/hid-logitech-hidpp.c
> @@ -40,8 +40,9 @@ MODULE_PARM_DESC(disable_raw_mode,
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
> @@ -942,6 +943,223 @@ static int wtp_connect(struct hid_device *hdev, bool connected)
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
> +       struct input_dev *input;
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
> +
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
> +/*
> + * m560_allocate - allocate the M560 mouse private data, and link it
> + *                 to the hidpp_device struct
> + *
> + * @hdev: hidpp device where the mouse belongs
> + *
> + * @return: 0 OK
> + */
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
> +/*
> + * m560_raw_event - process raw event
> + */
> +static int m560_raw_event(struct hid_device *hdev, u8 *data, int size)
> +{
> +       struct hidpp_device *hidpp = hid_get_drvdata(hdev);
> +       struct m560_private_data *mydata = hidpp->private_data;
> +
> +       /* check if the data is a mouse related report */
> +       if (data[0] != 0x02 && data[2] != M560_SUB_ID)
> +               return 0;
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
> +               int btn;
> +
> +               /* check if the event is a button */
> +               btn = data[5];
> +               if (btn != 0x00 && btn != 0xb0 && btn != 0xae && btn != 0xaf)
> +                       return 1;
> +
> +               if (btn == 0xaf) {
> +                       input_report_key(mydata->input, BTN_MIDDLE, 1);
> +               } else if (btn == 0xb0) {
> +                       input_report_key(mydata->input, BTN_FORWARD, 1);
> +               } else if (btn == 0xae) {
> +                       input_report_key(mydata->input, BTN_BACK, 1);
> +               } else if (btn == 0x00) {
> +                       input_report_key(mydata->input, BTN_BACK, 0);
> +                       input_report_key(mydata->input, BTN_FORWARD, 0);
> +                       input_report_key(mydata->input, BTN_MIDDLE, 0);
> +               }
> +
> +               input_sync(mydata->input);
> +
> +       } else if (data[0] == 0x02) {
> +               /*
> +                * Logitech M560 mouse report
> +                *
> +                * data[0] = type (0x02)
> +                * data[1..2] = buttons
> +                * data[3..5] = xy
> +                * data[6] = wheel
> +                */
> +
> +               int v;
> +               int btn = data[1];
> +
> +               input_report_key(mydata->input, BTN_LEFT,
> +                       !!(btn & M560_MOUSE_BTN_LEFT));
> +               input_report_key(mydata->input, BTN_RIGHT,
> +                       !!(btn & M560_MOUSE_BTN_RIGHT));
> +
> +               if (btn & M560_MOUSE_BTN_WHEEL_LEFT)
> +                       input_report_rel(mydata->input, REL_HWHEEL, -1);
> +               else if (btn & M560_MOUSE_BTN_WHEEL_RIGHT)
> +                       input_report_rel(mydata->input, REL_HWHEEL, 1);
> +
> +               v = (int)data[3] | (int)((data[4] & 0x0f) << 8);
> +               if (v & (1<<11))
> +                       v = ~0xfff | v;
> +               input_report_rel(mydata->input, REL_X, v);
> +               v = (int)(data[4] >> 4) | (int)(data[5] << 4);
> +               if (v & (1<<11))
> +                       v = ~0xfff | v;
> +               input_report_rel(mydata->input, REL_Y, v);
> +               v = (int)data[6];
> +               if (v & (1<<7))
> +                       v = ~0xff | v;
> +               input_report_rel(mydata->input, REL_WHEEL, v);

This looks messy to me.

How about you copy the extract() function from hid-core here as such (note
the hid_snto32 at the end which is not in the original function):

/* duplicated from hid-core.c */
static int hidpp_extract(struct hid_device *hdev, u8 *report, unsigned offset,
		unsigned n)
{
	u64 x;

	if (n > 32)
		hid_warn(hdev, "hidpp_extract() called with n (%d) > 32!\n", n);

	report += offset >> 3;  /* adjust byte index */
	offset &= 7;            /* now only need bit offset into one byte */
	x = get_unaligned_le64(report);
	x = (x >> offset) & ((1ULL << n) - 1);  /* extract bit field */
	return hid_snto32(x, n);
}

and then you can have:
x = hidpp_extract(hdev, &data[3], 0, 12);
y = hidpp_extract(hdev, &data[3], 12, 12);
wheel = hid_snto32(data[6], 8);

> +
> +               input_sync(mydata->input);
> +       }
> +
> +       return 0;
> +}
> +
> +/*
> + * config the input device
> + */
> +static void m560_populate_input(struct hidpp_device *hidpp,
> +               struct input_dev *input_dev, bool origin_is_hid_core)
> +{
> +       struct m560_private_data *mydata = hidpp->private_data;
> +
> +       if ((hidpp->quirks & HIDPP_QUIRK_MULTI_INPUT) && origin_is_hid_core)

Do you really intend to use HIDPP_QUIRK_MULTI_INPUT with this particular mouse?
If not, we can drop the test.

> +               /* this is the generic hid-input call */
> +               return;
> +
> +       mydata->input = input_dev;
> +
> +       __set_bit(EV_KEY, mydata->input->evbit);
> +       __set_bit(BTN_MIDDLE, mydata->input->keybit);
> +       __set_bit(BTN_RIGHT, mydata->input->keybit);
> +       __set_bit(BTN_LEFT, mydata->input->keybit);
> +       __set_bit(BTN_BACK, mydata->input->keybit);
> +       __set_bit(BTN_FORWARD, mydata->input->keybit);
> +
> +       __set_bit(EV_REL, mydata->input->evbit);
> +       __set_bit(REL_X, mydata->input->relbit);
> +       __set_bit(REL_Y, mydata->input->relbit);
> +       __set_bit(REL_WHEEL, mydata->input->relbit);
> +       __set_bit(REL_HWHEEL, mydata->input->relbit);
> +
> +}
> +
> +/* -------------------------------------------------------------------------- */
>  /* Generic HID++ devices                                                      */
>  /* -------------------------------------------------------------------------- */
>
> @@ -953,6 +1171,9 @@ static int hidpp_input_mapping(struct hid_device *hdev, struct hid_input *hi,
>
>         if (hidpp->quirks & HIDPP_QUIRK_CLASS_WTP)
>                 return wtp_input_mapping(hdev, hi, field, usage, bit, max);
> +       else if (hidpp->quirks & HIDPP_QUIRK_CLASS_M560 &&
> +                field->application != HID_GD_MOUSE)
> +                       return -1;

I know it will be a one line function, but I'd rather having a separate
m560_input_mapping() function for that. Otherwise we may end up adding other
generic behavior below and it will interfere with the current code.

>
>         return 0;
>  }
> @@ -962,6 +1183,8 @@ static void hidpp_populate_input(struct hidpp_device *hidpp,
>  {
>         if (hidpp->quirks & HIDPP_QUIRK_CLASS_WTP)
>                 wtp_populate_input(hidpp, input, origin_is_hid_core);
> +       if (hidpp->quirks & HIDPP_QUIRK_CLASS_M560)

else if

> +               m560_populate_input(hidpp, input, origin_is_hid_core);
>  }
>
>  static void hidpp_input_configured(struct hid_device *hdev,
> @@ -1049,6 +1272,8 @@ static int hidpp_raw_event(struct hid_device *hdev, struct hid_report *report,
>
>         if (hidpp->quirks & HIDPP_QUIRK_CLASS_WTP)
>                 return wtp_raw_event(hdev, data, size);
> +       else if (hidpp->quirks & HIDPP_QUIRK_CLASS_M560)
> +               return m560_raw_event(hidpp->hid_dev, data, size);
>
>         return 0;
>  }
> @@ -1126,6 +1351,8 @@ static void hidpp_connect_event(struct hidpp_device *hidpp)
>                 ret = wtp_connect(hdev, connected);
>                 if (ret)
>                         return;
> +       } else if ((hidpp->quirks & HIDPP_QUIRK_CLASS_M560) && connected) {
> +               m560_send_config_command(hdev);
>         }
>
>         if (!connected || hidpp->delayed_input)
> @@ -1201,7 +1428,12 @@ static int hidpp_probe(struct hid_device *hdev, const struct hid_device_id *id)
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
> @@ -1268,7 +1500,7 @@ hid_hw_start_fail:
>  hid_parse_fail:
>         cancel_work_sync(&hidpp->work);
>         mutex_destroy(&hidpp->send_mutex);
> -wtp_allocate_fail:
> +allocate_fail:
>         hid_set_drvdata(hdev, NULL);
>         return ret;
>  }
> @@ -1301,6 +1533,11 @@ static const struct hid_device_id hidpp_devices[] = {
>                 USB_VENDOR_ID_LOGITECH, 0x4102),
>           .driver_data = HIDPP_QUIRK_DELAYED_INIT | HIDPP_QUIRK_MULTI_INPUT |
>                          HIDPP_QUIRK_CLASS_WTP },
> +       { /* Mouse logitech M560 */
> +         HID_DEVICE(BUS_USB, HID_GROUP_LOGITECH_DJ_DEVICE,
> +               USB_VENDOR_ID_LOGITECH, 0x402d),
> +         .driver_data = HIDPP_QUIRK_DELAYED_INIT  |
> +                        HIDPP_QUIRK_CLASS_M560 },
>
>         { HID_DEVICE(BUS_USB, HID_GROUP_LOGITECH_DJ_DEVICE,
>                 USB_VENDOR_ID_LOGITECH, HID_ANY_ID)},
> --
> 2.1.4
>

The rest looks good to me.

Thanks for the hard work!

Cheers,
Benjamin
