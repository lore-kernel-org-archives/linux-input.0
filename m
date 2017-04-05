From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: Re: [PATCH v2] HID: wacom: generic: sync pad events only for actual packets
Date: Wed, 5 Apr 2017 11:01:16 +0200
Message-ID: <CAN+gG=FDioBhnywELHx53Qf4jSp_OkE_xrf_Pb++q2NYUBtiKg@mail.gmail.com>
References: <1491334267-6442-1-git-send-email-ping.cheng@wacom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35811 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752946AbdDEJBS (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Wed, 5 Apr 2017 05:01:18 -0400
Received: by mail-wm0-f65.google.com with SMTP id z133so1504767wmb.2
        for <linux-input@vger.kernel.org>; Wed, 05 Apr 2017 02:01:17 -0700 (PDT)
In-Reply-To: <1491334267-6442-1-git-send-email-ping.cheng@wacom.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ping Cheng <pinglinux@gmail.com>
Cc: linux-input <linux-input@vger.kernel.org>, Jiri Kosina <jikos@kernel.org>, Ping Cheng <ping.cheng@wacom.com>

On Tue, Apr 4, 2017 at 9:31 PM, Ping Cheng <pinglinux@gmail.com> wrote:
> Commits d793ff8 and 4082da8 introduced two pad usages which do not
> actually send pad input events. To make sure we do not post empty
> pad packets, pad_input_event_flag is introduced. Turn on the flag
> for real pad input events so we can synchronize them properly.
>
> Signed-off-by: Ping Cheng <ping.cheng@wacom.com>
> ---
> v2: updated as Benjamin suggested
>
> The patch is based on for-4.12/wacom

Looks good to me:
Reviewed-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

Cheers,
Benjamin

> ---
>  drivers/hid/wacom_wac.c | 7 ++++++-
>  drivers/hid/wacom_wac.h | 1 +
>  2 files changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
> index f136038..037a996 100644
> --- a/drivers/hid/wacom_wac.c
> +++ b/drivers/hid/wacom_wac.c
> @@ -1881,6 +1881,8 @@ static void wacom_wac_pad_event(struct hid_device *hdev, struct hid_field *field
>                  /* fall through*/
>         default:
>                 input_event(input, usage->type, usage->code, value);
> +               if (value)
> +                       wacom_wac->hid_data.pad_input_event_flag = true;
>                 break;
>         }
>  }
> @@ -1921,9 +1923,12 @@ static void wacom_wac_pad_report(struct hid_device *hdev,
>         bool active = wacom_wac->hid_data.inrange_state != 0;
>
>         /* report prox for expresskey events */
> -       if (wacom_equivalent_usage(report->field[0]->physical) == HID_DG_TABLETFUNCTIONKEY) {
> +       if ((wacom_equivalent_usage(report->field[0]->physical) == HID_DG_TABLETFUNCTIONKEY) &&
> +           wacom_wac->hid_data.pad_input_event_flag) {
>                 input_event(input, EV_ABS, ABS_MISC, active ? PAD_DEVICE_ID : 0);
>                 input_sync(input);
> +               if (!active)
> +                       wacom_wac->hid_data.pad_input_event_flag = false;
>         }
>
>  }
> diff --git a/drivers/hid/wacom_wac.h b/drivers/hid/wacom_wac.h
> index 839bd4b..570d295 100644
> --- a/drivers/hid/wacom_wac.h
> +++ b/drivers/hid/wacom_wac.h
> @@ -301,6 +301,7 @@ struct hid_data {
>         int bat_charging;
>         int bat_connected;
>         int ps_connected;
> +       bool pad_input_event_flag;
>  };
>
>  struct wacom_remote_data {
> --
> 1.8.3.1
>
