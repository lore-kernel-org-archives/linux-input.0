From: =?UTF-8?B?Sm/Do28gTW9yZW5v?= <mail@joaomoreno.com>
Subject: Re: [PATCH] HID: apple: Fix stuck function keys when using FN
Date: Sun, 30 Jun 2019 22:15:33 +0200
Message-ID: <CAHxFc3QC147B6j4pBztjK7stLgCveeYhJWojai_SbKNbnpC9yw@mail.gmail.com>
References: <20190610213106.19342-1-mail@joaomoreno.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190610213106.19342-1-mail@joaomoreno.com>
Sender: linux-kernel-owner@vger.kernel.org
Cc: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Hi Jiri & Benjamin,

Let me know if you need something else to get this patch moving forward. This
fixes an issue I hit daily, it would be great to get it fixed.

Thanks.

On Mon, 10 Jun 2019 at 23:31, Joao Moreno <mail@joaomoreno.com> wrote:
>
> This fixes an issue in which key down events for function keys would be
> repeatedly emitted even after the user has raised the physical key. For
> example, the driver fails to emit the F5 key up event when going through
> the following steps:
> - fnmode=1: hold FN, hold F5, release FN, release F5
> - fnmode=2: hold F5, hold FN, release F5, release FN
>
> The repeated F5 key down events can be easily verified using xev.
>
> Signed-off-by: Joao Moreno <mail@joaomoreno.com>
> ---
>  drivers/hid/hid-apple.c | 21 +++++++++++----------
>  1 file changed, 11 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/hid/hid-apple.c b/drivers/hid/hid-apple.c
> index 1cb41992aaa1..81867a6fa047 100644
> --- a/drivers/hid/hid-apple.c
> +++ b/drivers/hid/hid-apple.c
> @@ -205,20 +205,21 @@ static int hidinput_apple_event(struct hid_device *hid, struct input_dev *input,
>                 trans = apple_find_translation (table, usage->code);
>
>                 if (trans) {
> -                       if (test_bit(usage->code, asc->pressed_fn))
> -                               do_translate = 1;
> -                       else if (trans->flags & APPLE_FLAG_FKEY)
> -                               do_translate = (fnmode == 2 && asc->fn_on) ||
> -                                       (fnmode == 1 && !asc->fn_on);
> +                       int fn_on = value ? asc->fn_on :
> +                               test_bit(usage->code, asc->pressed_fn);
> +
> +                       if (!value)
> +                               clear_bit(usage->code, asc->pressed_fn);
> +                       else if (asc->fn_on)
> +                               set_bit(usage->code, asc->pressed_fn);
> +
> +                       if (trans->flags & APPLE_FLAG_FKEY)
> +                               do_translate = (fnmode == 2 && fn_on) ||
> +                                       (fnmode == 1 && !fn_on);
>                         else
>                                 do_translate = asc->fn_on;
>
>                         if (do_translate) {
> -                               if (value)
> -                                       set_bit(usage->code, asc->pressed_fn);
> -                               else
> -                                       clear_bit(usage->code, asc->pressed_fn);
> -
>                                 input_event(input, usage->type, trans->to,
>                                                 value);
>
> --
> 2.19.1
>
