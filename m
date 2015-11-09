From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: Re: [PATCH 5/6] HID: Add vendor specific usage pages for Logitech G920
Date: Mon, 9 Nov 2015 09:20:38 +0100
Message-ID: <CAN+gG=FTGXyV1heOpQb9Y=ZVRHhYP8=N-3jKgYq8OnqHgT=ikg@mail.gmail.com>
References: <1446912609-2573-1-git-send-email-simon@mungewell.org>
	<1446912609-2573-6-git-send-email-simon@mungewell.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wi0-f175.google.com ([209.85.212.175]:34214 "EHLO
	mail-wi0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751353AbbKIIUj (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 9 Nov 2015 03:20:39 -0500
In-Reply-To: <1446912609-2573-6-git-send-email-simon@mungewell.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Simon Wood <simon@mungewell.org>
Cc: linux-input <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Jiri Kosina <jkosina@suse.cz>, Edwin <Edwin@velds.nl>, =?UTF-8?B?TWljaGFsIE1hbMO9?= <madcatxster@devoid-pointer.net>, elias vanderstuyft <elias.vds@gmail.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>

On Sat, Nov 7, 2015 at 5:10 PM, Simon Wood <simon@mungewell.org> wrote:
> The Logitech G920 uses a couple of vendor specific usage pages,
> which results in incorrect number of axis/buttons being detected.
>
> This patch adds these pages to the 'ignore' list.
>
> Reported-by: Elias Vanderstuyft <elias.vds@gmail.com>
> Signed-off-by: Simon Wood <simon@mungewell.org>
> ---
>  drivers/hid/hid-input.c | 2 +-
>  include/linux/hid.h     | 2 ++
>  2 files changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
> index 53aeaf6..c120be5 100644
> --- a/drivers/hid/hid-input.c
> +++ b/drivers/hid/hid-input.c
> @@ -959,7 +959,7 @@ static void hidinput_configure_usage(struct hid_input *hidinput, struct hid_fiel
>                 set_bit(EV_REP, input->evbit);
>                 goto ignore;
>
> -       case HID_UP_LOGIVENDOR:
> +       case HID_UP_LOGIVENDOR: case HID_UP_LOGIVENDOR2: case HID_UP_LOGIVENDOR3:

One line per case, please. Also, IIRC it would be good to add /*
intentional fallback */ between each case to make sure we are not
ignoring usages that should not.

Cheers,
Benjamin

>                 goto ignore;
>
>         case HID_UP_PID:
> diff --git a/include/linux/hid.h b/include/linux/hid.h
> index f17980d..ce1d883 100644
> --- a/include/linux/hid.h
> +++ b/include/linux/hid.h
> @@ -168,6 +168,8 @@ struct hid_item {
>  #define HID_UP_MSVENDOR                0xff000000
>  #define HID_UP_CUSTOM          0x00ff0000
>  #define HID_UP_LOGIVENDOR      0xffbc0000
> +#define HID_UP_LOGIVENDOR2   0xff090000
> +#define HID_UP_LOGIVENDOR3   0xff430000
>  #define HID_UP_LNVENDOR                0xffa00000
>  #define HID_UP_SENSOR          0x00200000
>
> --
> 2.1.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
