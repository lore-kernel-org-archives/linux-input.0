From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: Re: [PATCH 2/5] hid: huion: Invert in-range on specific product
Date: Wed, 23 Jul 2014 10:34:31 -0400
Message-ID: <CAN+gG=F3ddT4kgHPMhvMgOFNf0Z29utAPJWsnVWuB98xbZ0gKA@mail.gmail.com>
References: <1406119378-24551-1-git-send-email-spbnick@gmail.com>
	<1406119378-24551-3-git-send-email-spbnick@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-la0-f41.google.com ([209.85.215.41]:64134 "EHLO
	mail-la0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757804AbaGWOec (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 23 Jul 2014 10:34:32 -0400
Received: by mail-la0-f41.google.com with SMTP id s18so1008719lam.28
        for <linux-input@vger.kernel.org>; Wed, 23 Jul 2014 07:34:31 -0700 (PDT)
In-Reply-To: <1406119378-24551-3-git-send-email-spbnick@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Nikolai Kondrashov <spbnick@gmail.com>
Cc: Jiri Kosina <jkosina@suse.cz>, linux-input <linux-input@vger.kernel.org>, DIGImend-devel <DIGImend-devel@lists.sourceforge.net>

On Wed, Jul 23, 2014 at 8:42 AM, Nikolai Kondrashov <spbnick@gmail.com> wrote:
> Limit inverting the in-range bit in raw reports to tablet product ID
> only. This will make adding handling of other, non-tablet products,
> easier.
>
> Signed-off-by: Nikolai Kondrashov <spbnick@gmail.com>
> ---

I am not particularly a big fan of this one. You are here adding a
test which will be called at each raw_event but currently only tablet
products are bound to hid-huion. Even in the rest of the series, you
add another VID/PID, but it still has the same PID.

So I would say that this will be nice to have when we really have the
problem, not now.

But if you tell me that you already have the need for it, I am fine
with it. It's just that this commit message + the rest of the patch
series makes me feel like this is just a superflous test.

So, in its current state:
NACK

Cheers,
Benjamin

>  drivers/hid/hid-huion.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/hid/hid-huion.c b/drivers/hid/hid-huion.c
> index 25d01cd..db24472 100644
> --- a/drivers/hid/hid-huion.c
> +++ b/drivers/hid/hid-huion.c
> @@ -151,9 +151,15 @@ err:
>  static int huion_raw_event(struct hid_device *hdev, struct hid_report *report,
>                         u8 *data, int size)
>  {
> -       /* If this is a pen input report then invert the in-range bit */
> -       if (report->type == HID_INPUT_REPORT && report->id == 0x07 && size >= 2)
> -               data[1] ^= 0x40;
> +       switch (hdev->product) {
> +       case USB_DEVICE_ID_HUION_TABLET:
> +               /* If this is a pen input report */
> +               if (report->type == HID_INPUT_REPORT &&
> +                   report->id == 0x07 && size >= 2)
> +                       /* Invert the in-range bit */
> +                       data[1] ^= 0x40;
> +               break;
> +       }
>
>         return 0;
>  }
> --
> 2.0.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
