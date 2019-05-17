From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH 1/2] HID: wacom: Don't set tool type until we're in range
Date: Fri, 17 May 2019 16:27:17 +0200
Message-ID: <CAO-hwJJY=uzATrHic2F+LHOB7TMvzLJyCw2jxYcEVK1_m74B_A@mail.gmail.com>
References: <20190424221258.19992-1-jason.gerecke@wacom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20190424221258.19992-1-jason.gerecke@wacom.com>
Sender: stable-owner@vger.kernel.org
To: "Gerecke, Jason" <killertofu@gmail.com>
Cc: "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, Ping Cheng <pinglinux@gmail.com>, Aaron Armstrong Skomra <skomra@gmail.com>, Jason Gerecke <jason.gerecke@wacom.com>, "3.8+" <stable@vger.kernel.org>, Aaron Armstrong Skomra <aaron.skomra@wacom.com>
List-Id: linux-input@vger.kernel.org

On Thu, Apr 25, 2019 at 12:13 AM Gerecke, Jason <killertofu@gmail.com> wrote:
>
> From: Jason Gerecke <jason.gerecke@wacom.com>
>
> The serial number and tool type information that is reported by the tablet
> while a pen is merely "in prox" instead of fully "in range" can be stale
> and cause us to report incorrect tool information. Serial number, tool
> type, and other information is only valid once the pen comes fully in range
> so we should be careful to not use this information until that point.
>
> In particular, this issue may cause the driver to incorectly report
> BTN_TOOL_RUBBER after switching from the eraser tool back to the pen.
>
> Fixes: a48324de6d ("HID: wacom: Bluetooth IRQ for Intuos Pro should handle prox/range")
> Cc: <stable@vger.kernel.org> # 4.11+
> Signed-off-by: Jason Gerecke <jason.gerecke@wacom.com>
> Reviewed-by: Aaron Armstrong Skomra <aaron.skomra@wacom.com>
> ---

Series applied to for-5.2/fixes

Sorry for the delay

Cheers,
Benjamin

>  drivers/hid/wacom_wac.c | 17 ++++++++++++++++-
>  1 file changed, 16 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
> index 747730d32ab6..4c1bc239207e 100644
> --- a/drivers/hid/wacom_wac.c
> +++ b/drivers/hid/wacom_wac.c
> @@ -1236,13 +1236,13 @@ static void wacom_intuos_pro2_bt_pen(struct wacom_wac *wacom)
>                 /* Add back in missing bits of ID for non-USI pens */
>                 wacom->id[0] |= (wacom->serial[0] >> 32) & 0xFFFFF;
>         }
> -       wacom->tool[0]   = wacom_intuos_get_tool_type(wacom_intuos_id_mangle(wacom->id[0]));
>
>         for (i = 0; i < pen_frames; i++) {
>                 unsigned char *frame = &data[i*pen_frame_len + 1];
>                 bool valid = frame[0] & 0x80;
>                 bool prox = frame[0] & 0x40;
>                 bool range = frame[0] & 0x20;
> +               bool invert = frame[0] & 0x10;
>
>                 if (!valid)
>                         continue;
> @@ -1251,9 +1251,24 @@ static void wacom_intuos_pro2_bt_pen(struct wacom_wac *wacom)
>                         wacom->shared->stylus_in_proximity = false;
>                         wacom_exit_report(wacom);
>                         input_sync(pen_input);
> +
> +                       wacom->tool[0] = 0;
> +                       wacom->id[0] = 0;
> +                       wacom->serial[0] = 0;
>                         return;
>                 }
> +
>                 if (range) {
> +                       if (!wacom->tool[0]) { /* first in range */
> +                               /* Going into range select tool */
> +                               if (invert)
> +                                       wacom->tool[0] = BTN_TOOL_RUBBER;
> +                               else if (wacom->id[0])
> +                                       wacom->tool[0] = wacom_intuos_get_tool_type(wacom->id[0]);
> +                               else
> +                                       wacom->tool[0] = BTN_TOOL_PEN;
> +                       }
> +
>                         input_report_abs(pen_input, ABS_X, get_unaligned_le16(&frame[1]));
>                         input_report_abs(pen_input, ABS_Y, get_unaligned_le16(&frame[3]));
>
> --
> 2.21.0
>
