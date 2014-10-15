From: =?UTF-8?B?Q2h1bmctWWloIFdhbmcgKOeOi+W0h+aHvyk=?=
	<cywang@chromium.org>
Subject: Re: [PATCH] input: fix BTN_TOUCH reporting in input_mt_report_pointer_emulation
 for hovering finger
Date: Wed, 15 Oct 2014 19:02:31 +0800
Message-ID: <CAM2ehZa2OUH14_hQ5nbmzGfXGaRrd5bN43wBnriuL_zJUjv2MA@mail.gmail.com>
References: <1412861506-21732-1-git-send-email-cywang@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-vc0-f180.google.com ([209.85.220.180]:37743 "EHLO
	mail-vc0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750953AbaJOLCw (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 15 Oct 2014 07:02:52 -0400
Received: by mail-vc0-f180.google.com with SMTP id le20so713618vcb.39
        for <linux-input@vger.kernel.org>; Wed, 15 Oct 2014 04:02:51 -0700 (PDT)
In-Reply-To: <1412861506-21732-1-git-send-email-cywang@chromium.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Linux Input <linux-input@vger.kernel.org>
Cc: Henrik Rydberg <rydberg@euromail.se>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Benjamin Tissoires <benjamin.tissoires@gmail.com>, Chung-yih Wang <cywang@chromium.org>

any comment for this patch?

On Thu, Oct 9, 2014 at 9:31 PM, Chung-yih Wang <cywang@chromium.org> wrote:
>   From the definition of BTN_TOUCH, BTN_TOOL_<name> and BTN_TOUCH codes are
> orthogonal. BTN_TOUCH should be zero if there is no physical contact, e.g.
> hovering finger, happened on device. The patch uses touch_count and finger_count
> to get the final reporting code for BTN_TOUCH and BTN_TOOL_<name>,
> respectively. In addition, as there are some hard-coded pressure thresholds
> defined in touch device's driver classes, 'touch_threshold' is introduced into
> struct input_dev in order to tell if a finger is considered as a touch one in
> input_mt_report_pointer_emulation().
>
> ---
>  drivers/input/input-mt.c | 15 ++++++++++-----
>  include/linux/input.h    |  2 ++
>  2 files changed, 12 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/input/input-mt.c b/drivers/input/input-mt.c
> index fbe29fc..47e41d6 100644
> --- a/drivers/input/input-mt.c
> +++ b/drivers/input/input-mt.c
> @@ -192,18 +192,21 @@ void input_mt_report_pointer_emulation(struct input_dev *dev, bool use_count)
>  {
>         struct input_mt *mt = dev->mt;
>         struct input_mt_slot *oldest;
> -       int oldid, count, i;
> +       int oldid, i;
> +       int touch_count, finger_count;
>
>         if (!mt)
>                 return;
>
>         oldest = NULL;
>         oldid = mt->trkid;
> -       count = 0;
> +       touch_count = 0;
> +       finger_count = 0;
>
>         for (i = 0; i < mt->num_slots; ++i) {
>                 struct input_mt_slot *ps = &mt->slots[i];
>                 int id = input_mt_get_value(ps, ABS_MT_TRACKING_ID);
> +               int pressure = input_mt_get_value(ps, ABS_MT_PRESSURE);
>
>                 if (id < 0)
>                         continue;
> @@ -211,12 +214,14 @@ void input_mt_report_pointer_emulation(struct input_dev *dev, bool use_count)
>                         oldest = ps;
>                         oldid = id;
>                 }
> -               count++;
> +               finger_count++;
> +               if (pressure > dev->touch_threshold)
> +                       touch_count++;
>         }
>
> -       input_event(dev, EV_KEY, BTN_TOUCH, count > 0);
> +       input_event(dev, EV_KEY, BTN_TOUCH, touch_count > 0);
>         if (use_count)
> -               input_mt_report_finger_count(dev, count);
> +               input_mt_report_finger_count(dev, finger_count);
>
>         if (oldest) {
>                 int x = input_mt_get_value(oldest, ABS_MT_POSITION_X);
> diff --git a/include/linux/input.h b/include/linux/input.h
> index 82ce323..5b2739d 100644
> --- a/include/linux/input.h
> +++ b/include/linux/input.h
> @@ -187,6 +187,8 @@ struct input_dev {
>         struct input_value *vals;
>
>         bool devres_managed;
> +
> +       unsigned int touch_threshold;
>  };
>  #define to_input_dev(d) container_of(d, struct input_dev, dev)
>
> --
> 2.0.0.526.g5318336
>
