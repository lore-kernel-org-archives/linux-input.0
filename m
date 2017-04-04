From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: Re: [PATCH] HID: wacom: generic: sync pad events only for actual packets
Date: Tue, 4 Apr 2017 10:15:54 +0200
Message-ID: <CAN+gG=G5MTKGX7KmCO+tZRvRxQLNWP5=63KAnecZYqO2X9btzw@mail.gmail.com>
References: <1491267461-25416-1-git-send-email-ping.cheng@wacom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wr0-f196.google.com ([209.85.128.196]:32836 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752923AbdDDIP4 (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Tue, 4 Apr 2017 04:15:56 -0400
Received: by mail-wr0-f196.google.com with SMTP id u18so39939405wrc.0
        for <linux-input@vger.kernel.org>; Tue, 04 Apr 2017 01:15:56 -0700 (PDT)
In-Reply-To: <1491267461-25416-1-git-send-email-ping.cheng@wacom.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ping Cheng <pinglinux@gmail.com>
Cc: linux-input <linux-input@vger.kernel.org>, Jiri Kosina <jkosina@suse.cz>, Aaron Skomra <skomra@gmail.com>, Jason Gerecke <killertofu@gmail.com>, Ping Cheng <ping.cheng@wacom.com>

Hi Ping,

On Tue, Apr 4, 2017 at 2:57 AM, Ping Cheng <pinglinux@gmail.com> wrote:
> Commits d793ff8 and 4082da8 introduced two pad usages which do not
> actually send pad input events. To make sure we do not post empty
> pad packets, pad_input_event_flag is introduced. Turn on the flag
> for real pad input events so we can synchronize them properly.
>
> Signed-off-by: Ping Cheng <ping.cheng@wacom.com>
> ---
> Jiri: this patch is based on your for-4.12/wacom branch
> ---
>  drivers/hid/wacom_wac.c | 6 +++++-
>  drivers/hid/wacom_wac.h | 1 +
>  2 files changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
> index f136038..ffef32a 100644
> --- a/drivers/hid/wacom_wac.c
> +++ b/drivers/hid/wacom_wac.c
> @@ -1881,6 +1881,7 @@ static void wacom_wac_pad_event(struct hid_device *hdev, struct hid_field *field
>                  /* fall through*/
>         default:
>                 input_event(input, usage->type, usage->code, value);
> +               if (value) features->pad_input_event_flag = true;

Please have a line break after the if(value) statement

>                 break;
>         }
>  }
> @@ -1919,11 +1920,14 @@ static void wacom_wac_pad_report(struct hid_device *hdev,
>         struct wacom_wac *wacom_wac = &wacom->wacom_wac;
>         struct input_dev *input = wacom_wac->pad_input;
>         bool active = wacom_wac->hid_data.inrange_state != 0;
> +       struct wacom_features *features = &wacom_wac->features;
>
>         /* report prox for expresskey events */
> -       if (wacom_equivalent_usage(report->field[0]->physical) == HID_DG_TABLETFUNCTIONKEY) {
> +       if ((wacom_equivalent_usage(report->field[0]->physical) == HID_DG_TABLETFUNCTIONKEY) &&
> +           features->pad_input_event_flag) {
>                 input_event(input, EV_ABS, ABS_MISC, active ? PAD_DEVICE_ID : 0);
>                 input_sync(input);
> +               if (!active) features->pad_input_event_flag = false;

Same here, please add a line break.

>         }
>
>  }
> diff --git a/drivers/hid/wacom_wac.h b/drivers/hid/wacom_wac.h
> index 839bd4b..ff09609 100644
> --- a/drivers/hid/wacom_wac.h
> +++ b/drivers/hid/wacom_wac.h
> @@ -263,6 +263,7 @@ struct wacom_features {
>         int pktlen;
>         bool check_for_hid_type;
>         int hid_type;
> +       bool pad_input_event_flag;

I'd say this should go into struct hid_data. wacom_features is very
static now and describes the device itself. hid_data contains actual
data coming in from the device.

Cheers,
Benjamin

>  };
>
>  struct wacom_shared {
> --
> 2.7.4
>
