From: Nestor Lopez Casado <nlopezcasad@logitech.com>
Subject: Re: [PATCH 3/3] Add logitech m560 driver
Date: Mon, 25 Aug 2014 10:38:06 +0200
Message-ID: <CAE7qMrpgPULMq95wZhLgsLWXJ+=DiVoe9XzxZB5poU0ZmqFiXg@mail.gmail.com>
References: <1408797629-3474-1-git-send-email-kreijack@inwind.it> <1408797629-3474-4-git-send-email-kreijack@inwind.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from na3sys009aog107.obsmtp.com ([74.125.149.197]:46410 "EHLO
	na3sys009aog107.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751409AbaHYIqO (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 25 Aug 2014 04:46:14 -0400
Received: by mail-vc0-f178.google.com with SMTP id la4so15070258vcb.9
        for <linux-input@vger.kernel.org>; Mon, 25 Aug 2014 01:46:13 -0700 (PDT)
In-Reply-To: <1408797629-3474-4-git-send-email-kreijack@inwind.it>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Goffredo Baroncelli <kreijack@gmail.com>
Cc: "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, Goffredo Baroncelli <kreijack@inwind.it>

Hi,

If you want to have a special driver for a specific Unifying device
you should put in place the right structure to have a separate driver
for it.

hid-logitech-dj is a "bus" driver for the Unifying *receiver*, not a
driver for any specific Unifying device.

Benjamin Tisssoires (github bentiss) has uploaded a few patches to his
github account to finish the infrastructure for specific Unifying
devices drivers. Look for the more complete branch 'for-whot' See how
he created a hid-logitech-wtp driver for the Different wireless
touchpads.

This would be the right approach to what you are trying to do.

Cheers,
-nestor


On Sat, Aug 23, 2014 at 2:40 PM, Goffredo Baroncelli <kreijack@gmail.com> wrote:
> Add logitech m560 support. In the init phase the driver
> send a sequence which avoid some unnecessary key sending
> from the mouse.
>
> The mouse appears as a couple of mouse and keyboard. Some buttons
> emit a key event instead of the "mouse button" event. However
> some event (like the middle button release) aren't generated.
> Fortunately, the device generates an additional event to
> track it. The event type is 0x0a.
>
> Signed-off-by: Goffredo Baroncelli <kreijack@inwind.it>
> ---
>  drivers/hid/hid-logitech-dj.c | 92 +++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 92 insertions(+)
>
> diff --git a/drivers/hid/hid-logitech-dj.c b/drivers/hid/hid-logitech-dj.c
> index feddd3d..40c5ea1 100644
> --- a/drivers/hid/hid-logitech-dj.c
> +++ b/drivers/hid/hid-logitech-dj.c
> @@ -222,7 +222,99 @@ static inline void call_destroy(struct dj_device *djdev)
>         djdev->methods->destroy(djdev);
>  }
>
> +/*
> + * Send the sequence 10xx0a35 00af03
> + * to the mouse id xx. It disables the key sending by the central button.
> + */
> +
> +static int lg_m560_init_device(struct dj_device *dj_device)
> +{
> +       struct dj_report *dj_report;
> +       int retval;
> +       static u8 reset_data[] = {0x35, 0x00, 0xaf, 0x03};
> +
> +       dj_report = kzalloc(sizeof(struct dj_report), GFP_KERNEL);
> +       if (!dj_report)
> +               return -ENOMEM;
> +
> +       dj_device->userdata = dj_report;
> +
> +       dj_report->report_id = REPORT_ID_RECV_SHORT;
> +       dj_report->device_index = dj_device->device_index;
> +       dj_report->report_type = 0x0a;
> +
> +       memcpy(dj_report->report_params, reset_data, sizeof(reset_data));
> +
> +       retval = hid_hw_raw_request(dj_device->dj_receiver_dev->hdev,
> +               dj_report->report_id,
> +               (void *)dj_report, REPORT_ID_RECV_SHORT_LENGTH,
> +               HID_OUTPUT_REPORT, HID_REQ_SET_REPORT);
> +
> +       memset(dj_report, 0, sizeof(struct dj_report));
> +
> +       return retval;
> +}
> +
> +static int lg_m560_parse_raw_event(struct dj_device *dj_device,
> +                                       struct dj_report *dj_report)
> +{
> +       u8 *m506_last_mouse_report = dj_device->userdata;
> +
> +       BUG_ON(!dj_device);
> +
> +       /* don't pass keys when the mouse is a m560 */
> +       if (dj_report->report_type == REPORT_TYPE_KEYBOARD)
> +               return true;
> +
> +       if (dj_report->report_id == 0x11 && dj_report->report_type == 0x0a) {
> +               int btn;
> +
> +               /* check if the event is a button */
> +               btn = dj_report->report_params[2];
> +               if (btn != 0x00 && btn != 0xb0 && btn != 0xae && btn != 0xaf)
> +                       return true;
> +
> +               if (btn == 0xaf)
> +                       m506_last_mouse_report[1] |= 4;
> +               if (btn == 0xae)
> +                       m506_last_mouse_report[2] |= 2;
> +               if (btn == 0xb0)
> +                       m506_last_mouse_report[2] |= 4;
> +               if (btn == 0x00) {
> +                       m506_last_mouse_report[1] &= ~4;
> +                       m506_last_mouse_report[2] &= ~(4|2);
> +               }
> +
> +               if (hid_input_report(dj_device->hdev, HID_INPUT_REPORT,
> +                                       m506_last_mouse_report, 8, 1)) {
> +                               dbg_hid("hid_input_report error\n");
> +               }
> +               return true;
> +       }
> +
> +       /* copy the button status */
> +       if (dj_report->report_type == REPORT_TYPE_MOUSE) {
> +               /* copy only the first 3 bytes: type, btn0..7, btn8..16 */
> +               memcpy(dj_device->userdata,
> +                       &dj_report->report_type, 3);
> +       }
> +
> +       /* continue with the standard handler */
> +       return false;
> +}
> +
> +static void lg_m560_destroy(struct dj_device *dev)
> +{
> +       kfree(dev->userdata);
> +}
> +
>  static struct dj_device_method dj_device_method[] = {
> +       {       /* logitech M560 */
> +               .device_names = (char *[]){ "M560", NULL },
> +               .init_device = lg_m560_init_device,
> +               .parse_raw_event = lg_m560_parse_raw_event,
> +               .destroy = lg_m560_destroy
> +       },
>
>         /* last element */
>         { NULL, }
> --
> 1.9.3
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
