From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: Re: [PATCH v2 2/3] HID: wacom: Initialize MT slots for generic
 devices at post_parse_hid
Date: Fri, 5 Dec 2014 17:00:43 -0500
Message-ID: <CAN+gG=E5EfxzKgOBf9wAXrzwq=i8XKNk9d8oSWeQbVGVMojjJQ@mail.gmail.com>
References: <1417815453-10618-1-git-send-email-killertofu@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qa0-f43.google.com ([209.85.216.43]:55834 "EHLO
	mail-qa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751588AbaLEWAo (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 5 Dec 2014 17:00:44 -0500
Received: by mail-qa0-f43.google.com with SMTP id bm13so1094784qab.30
        for <linux-input@vger.kernel.org>; Fri, 05 Dec 2014 14:00:43 -0800 (PST)
In-Reply-To: <1417815453-10618-1-git-send-email-killertofu@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jason Gerecke <killertofu@gmail.com>
Cc: Jiri Kosina <jkosina@suse.cz>, linux-input <linux-input@vger.kernel.org>, Ping Cheng <pinglinux@gmail.com>

On Fri, Dec 5, 2014 at 4:37 PM, Jason Gerecke <killertofu@gmail.com> wrote:
> If a HID descriptor places HID_DG_CONTACTID before HID_DG_X and HID_DG_Y then
> the ABS_X and ABS_Y will not be automatically initialized by the call to
> input_mt_init_slots. To ensure that this is not a problem, we relocate that
> call to occur after HID parsing has been completed and we've initalized all
> the multitouch axes.
>
> Signed-off-by: Jason Gerecke <killertofu@gmail.com>
> ---

This one is
Reviewed-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

Thanks for the v2 Jason!

Cheers,
Benjamin

> Changes from v1:
>  * Patch renamed from "HID: wacom: Manually declare ABS_{X,Y} for pointer emulation"
>  * Patch moves call to input_mt_init_slots rather than manually declare ABS_{X,Y}
>
>  drivers/hid/wacom_sys.c | 18 ++++++++++++++++++
>  drivers/hid/wacom_wac.c |  3 ---
>  2 files changed, 18 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
> index eb55316..872aa0b 100644
> --- a/drivers/hid/wacom_sys.c
> +++ b/drivers/hid/wacom_sys.c
> @@ -13,6 +13,7 @@
>
>  #include "wacom_wac.h"
>  #include "wacom.h"
> +#include <linux/input/mt.h>
>
>  #define WAC_MSG_RETRIES                5
>
> @@ -236,6 +237,21 @@ static void wacom_usage_mapping(struct hid_device *hdev,
>                 wacom_wac_usage_mapping(hdev, field, usage);
>  }
>
> +static void wacom_post_parse_hid(struct hid_device *hdev,
> +                                struct wacom_features *features)
> +{
> +       struct wacom *wacom = hid_get_drvdata(hdev);
> +       struct wacom_wac *wacom_wac = &wacom->wacom_wac;
> +
> +       if (features->type == HID_GENERIC) {
> +               /* Any last-minute generic device setup */
> +               if (features->touch_max > 1) {
> +                       input_mt_init_slots(wacom_wac->input, wacom_wac->features.touch_max,
> +                                   INPUT_MT_DIRECT);
> +               }
> +       }
> +}
> +
>  static void wacom_parse_hid(struct hid_device *hdev,
>                            struct wacom_features *features)
>  {
> @@ -270,6 +286,8 @@ static void wacom_parse_hid(struct hid_device *hdev,
>                                 wacom_usage_mapping(hdev, hreport->field[i],
>                                                 hreport->field[i]->usage + j);
>         }
> +
> +       wacom_post_parse_hid(hdev, features);
>  }
>
>  static int wacom_hid_set_device_mode(struct hid_device *hdev)
> diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
> index a8a19a5..c33f889 100644
> --- a/drivers/hid/wacom_wac.c
> +++ b/drivers/hid/wacom_wac.c
> @@ -1381,7 +1381,6 @@ static void wacom_wac_finger_usage_mapping(struct hid_device *hdev,
>  {
>         struct wacom *wacom = hid_get_drvdata(hdev);
>         struct wacom_wac *wacom_wac = &wacom->wacom_wac;
> -       struct input_dev *input = wacom_wac->input;
>         unsigned touch_max = wacom_wac->features.touch_max;
>
>         switch (usage->hid) {
> @@ -1400,8 +1399,6 @@ static void wacom_wac_finger_usage_mapping(struct hid_device *hdev,
>                                         ABS_MT_POSITION_Y, 4);
>                 break;
>         case HID_DG_CONTACTID:
> -               input_mt_init_slots(input, wacom_wac->features.touch_max,
> -                       INPUT_MT_DIRECT);
>                 break;
>         case HID_DG_INRANGE:
>                 break;
> --
> 2.1.3
>
