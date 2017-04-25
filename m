From: Ping Cheng <pinglinux@gmail.com>
Subject: Re: [PATCH] HID: wacom: Have wacom_tpc_irq guard against possible
 NULL dereference
Date: Tue, 25 Apr 2017 13:56:58 -0700
Message-ID: <CAF8JNh+31UjTFzAEDGHACw7DhFMrTBGxgm=_ZoxP-8UAiq18vg@mail.gmail.com>
References: <20170412203123.GA3915@mwanda> <20170425182956.15406-1-killertofu@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-oi0-f65.google.com ([209.85.218.65]:34021 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1954577AbdDYU5T (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Tue, 25 Apr 2017 16:57:19 -0400
Received: by mail-oi0-f65.google.com with SMTP id y11so37334485oie.1
        for <linux-input@vger.kernel.org>; Tue, 25 Apr 2017 13:57:19 -0700 (PDT)
In-Reply-To: <20170425182956.15406-1-killertofu@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jason Gerecke <killertofu@gmail.com>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Jiri Kosina <jkosina@suse.cz>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Aaron Skomra <skomra@gmail.com>, Jason Gerecke <jason.gerecke@wacom.com>

On Tuesday, April 25, 2017, Jason Gerecke <killertofu@gmail.com> wrote:
>
> The following Smatch complaint was generated in response to commit
> 2a6cdbd ("HID: wacom: Introduce new 'touch_input' device"):
>
>     drivers/hid/wacom_wac.c:1586 wacom_tpc_irq()
>              error: we previously assumed 'wacom->touch_input' could be null (see line 1577)
>
> The 'touch_input' and 'pen_input' variables point to the 'struct input_dev'
> used for relaying touch and pen events to userspace, respectively. If a
> device does not have a touch interface or pen interface, the associated
> input variable is NULL. The 'wacom_tpc_irq()' function is responsible for
> forwarding input reports to a more-specific IRQ handler function. An
> unknown report could theoretically be mistaken as e.g. a touch report
> on a device which does not have a touch interface. This can be prevented
> by only calling the pen/touch functions are called when the pen/touch
> pointers are valid.
>
> Signed-off-by: Jason Gerecke <jason.gerecke@wacom.com>

Reviewed-by: Ping Cheng <ping.cheng@wacom.com>

Looks good to me.

Cheers,
Ping

>
> ---
>  drivers/hid/wacom_wac.c | 45 +++++++++++++++++++++++----------------------
>  1 file changed, 23 insertions(+), 22 deletions(-)
>
> diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
> index 6b8f6b816195..b963499e3351 100644
> --- a/drivers/hid/wacom_wac.c
> +++ b/drivers/hid/wacom_wac.c
> @@ -1571,37 +1571,38 @@ static int wacom_tpc_irq(struct wacom_wac *wacom, size_t len)
>  {
>         unsigned char *data = wacom->data;
>
> -       if (wacom->pen_input)
> +       if (wacom->pen_input) {
>                 dev_dbg(wacom->pen_input->dev.parent,
>                         "%s: received report #%d\n", __func__, data[0]);
> -       else if (wacom->touch_input)
> +
> +               if (len == WACOM_PKGLEN_PENABLED ||
> +                   data[0] == WACOM_REPORT_PENABLED)
> +                       return wacom_tpc_pen(wacom);
> +       }
> +       else if (wacom->touch_input) {
>                 dev_dbg(wacom->touch_input->dev.parent,
>                         "%s: received report #%d\n", __func__, data[0]);
>
> -       switch (len) {
> -       case WACOM_PKGLEN_TPC1FG:
> -               return wacom_tpc_single_touch(wacom, len);
> +               switch (len) {
> +               case WACOM_PKGLEN_TPC1FG:
> +                       return wacom_tpc_single_touch(wacom, len);
>
> -       case WACOM_PKGLEN_TPC2FG:
> -               return wacom_tpc_mt_touch(wacom);
> +               case WACOM_PKGLEN_TPC2FG:
> +                       return wacom_tpc_mt_touch(wacom);
>
> -       case WACOM_PKGLEN_PENABLED:
> -               return wacom_tpc_pen(wacom);
> +               default:
> +                       switch (data[0]) {
> +                       case WACOM_REPORT_TPC1FG:
> +                       case WACOM_REPORT_TPCHID:
> +                       case WACOM_REPORT_TPCST:
> +                       case WACOM_REPORT_TPC1FGE:
> +                               return wacom_tpc_single_touch(wacom, len);
>
> -       default:
> -               switch (data[0]) {
> -               case WACOM_REPORT_TPC1FG:
> -               case WACOM_REPORT_TPCHID:
> -               case WACOM_REPORT_TPCST:
> -               case WACOM_REPORT_TPC1FGE:
> -                       return wacom_tpc_single_touch(wacom, len);
> -
> -               case WACOM_REPORT_TPCMT:
> -               case WACOM_REPORT_TPCMT2:
> -                       return wacom_mt_touch(wacom);
> +                       case WACOM_REPORT_TPCMT:
> +                       case WACOM_REPORT_TPCMT2:
> +                               return wacom_mt_touch(wacom);
>
> -               case WACOM_REPORT_PENABLED:
> -                       return wacom_tpc_pen(wacom);
> +                       }
>                 }
>         }
>
> --
> 2.12.2
>
