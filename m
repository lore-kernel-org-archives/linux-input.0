From: Ping Cheng <pinglinux@gmail.com>
Subject: Re: [PATCH input-wacom] HID: wacom: Bluetooth IRQ for Intuos Pro
 should handle prox/range
Date: Mon, 13 Feb 2017 11:00:49 -0800
Message-ID: <CAF8JNhKNKYmS8TvRj_egjFsFdbhBUap8UW2sjFpFZ+-YX5Fa9Q@mail.gmail.com>
References: <1486772047-7903-1-git-send-email-skomra@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ot0-f194.google.com ([74.125.82.194]:34503 "EHLO
        mail-ot0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752467AbdBMTBV (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Mon, 13 Feb 2017 14:01:21 -0500
Received: by mail-ot0-f194.google.com with SMTP id 73so13009915otj.1
        for <linux-input@vger.kernel.org>; Mon, 13 Feb 2017 11:01:20 -0800 (PST)
In-Reply-To: <1486772047-7903-1-git-send-email-skomra@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Aaron Armstrong Skomra <skomra@gmail.com>
Cc: linux-input <linux-input@vger.kernel.org>, Jiri Kosina <jkosina@suse.cz>, Jason Gerecke <killertofu@gmail.com>, Jason Gerecke <jason.gerecke@wacom.com>

On Fri, Feb 10, 2017 at 4:14 PM, Aaron Armstrong Skomra
<skomra@gmail.com> wrote:
> From: Jason Gerecke <killertofu@gmail.com>
>
> The prox/range bits included in the Bluetooth reports from the Intuos Pro
> were being ignored, leading to two issues. Firstly, the pen would never
> announce a BTN_TOOL_PEN event with value 0, leaving userspace to believe
> the pen was always active. Secondly, the driver would continue to send
> events for data while the packet's "prox" bit was clear. This can lead
> to sudden incorrect pointer jumps if the pen is slowly moved away from
> the tablet surface.
>
> Signed-off-by: Jason Gerecke <jason.gerecke@wacom.com>

Reviewed-by: Ping Cheng <ping.cheng@wacom.com>

Hi Jiri,

This patch needs to go into the same release as the last set, under
your for-4.11/wacom branch. It fixes a bug for that set.

Thanks,

Ping

> ---
>  drivers/hid/wacom_wac.c | 25 +++++++++++++++----------
>  1 file changed, 15 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
> index bb98ca8..63b2485 100644
> --- a/drivers/hid/wacom_wac.c
> +++ b/drivers/hid/wacom_wac.c
> @@ -1213,29 +1213,34 @@ static void wacom_intuos_pro2_bt_pen(struct wacom_wac *wacom)
>
>         for (i = 0; i < pen_frames; i++) {
>                 unsigned char *frame = &data[i*pen_frame_len + 1];
> +               bool valid = frame[0] & 0x80;
> +               bool prox = frame[0] & 0x40;
> +               bool range = frame[0] & 0x20;
>
> -               if (!(frame[0] & 0x80))
> +               if (!valid)
>                         continue;
>
> -               input_report_abs(pen_input, ABS_X, get_unaligned_le16(&frame[1]));
> -               input_report_abs(pen_input, ABS_Y, get_unaligned_le16(&frame[3]));
> +               if (range) {
> +                       input_report_abs(pen_input, ABS_X, get_unaligned_le16(&frame[1]));
> +                       input_report_abs(pen_input, ABS_Y, get_unaligned_le16(&frame[3]));
> +                       input_report_abs(pen_input, ABS_TILT_X, frame[7]);
> +                       input_report_abs(pen_input, ABS_TILT_Y, frame[8]);
> +                       input_report_abs(pen_input, ABS_Z, get_unaligned_le16(&frame[9]));
> +                       input_report_abs(pen_input, ABS_WHEEL, get_unaligned_le16(&frame[11]));
> +               }
>                 input_report_abs(pen_input, ABS_PRESSURE, get_unaligned_le16(&frame[5]));
> -               input_report_abs(pen_input, ABS_TILT_X, frame[7]);
> -               input_report_abs(pen_input, ABS_TILT_Y, frame[8]);
> -               input_report_abs(pen_input, ABS_Z, get_unaligned_le16(&frame[9]));
> -               input_report_abs(pen_input, ABS_WHEEL, get_unaligned_le16(&frame[11]));
> -               input_report_abs(pen_input, ABS_DISTANCE, frame[13]);
> +               input_report_abs(pen_input, ABS_DISTANCE, range ? frame[13] : wacom->features.distance_max);
>
>                 input_report_key(pen_input, BTN_TOUCH, frame[0] & 0x01);
>                 input_report_key(pen_input, BTN_STYLUS, frame[0] & 0x02);
>                 input_report_key(pen_input, BTN_STYLUS2, frame[0] & 0x04);
>
> -               input_report_key(pen_input, wacom->tool[0], 1);
> +               input_report_key(pen_input, wacom->tool[0], prox);
>                 input_event(pen_input, EV_MSC, MSC_SERIAL, wacom->serial[0]);
>                 input_report_abs(pen_input, ABS_MISC,
>                                  wacom_intuos_id_mangle(wacom->id[0])); /* report tool id */
>
> -               wacom->shared->stylus_in_proximity = frame[0] & 0x40;
> +               wacom->shared->stylus_in_proximity = prox;
>
>                 input_sync(pen_input);
>         }
> --
> 2.11.1
>
