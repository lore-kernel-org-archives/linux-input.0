From: David Herrmann <dh.herrmann@gmail.com>
Subject: Re: [PATCH] HID: add new gamepad LED constants
Date: Mon, 15 Sep 2014 07:07:08 +0200
Message-ID: <CANq1E4RY8cF1de4_rdS3Whjrf0bboYMtii4_nYNM2mEJuAKMfQ@mail.gmail.com>
References: <1410750811-11156-1-git-send-email-michaelwr@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ie0-f172.google.com ([209.85.223.172]:50427 "EHLO
	mail-ie0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751163AbaIOFHJ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 15 Sep 2014 01:07:09 -0400
Received: by mail-ie0-f172.google.com with SMTP id tr6so3962506ieb.3
        for <linux-input@vger.kernel.org>; Sun, 14 Sep 2014 22:07:08 -0700 (PDT)
In-Reply-To: <1410750811-11156-1-git-send-email-michaelwr@google.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Michael Wright <michaelwr@android.com>
Cc: "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, Michael Wright <michaelwr@google.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jkosina@suse.cz>

Hi

On Mon, Sep 15, 2014 at 5:13 AM, Michael Wright <michaelwr@android.com> wrote:
> Improve gamepad support by introducing new LED constants for player
> LEDs and the mappings from their corresponding HID usages introduced
> in HUTTR47: http://www.usb.org/developers/hidpage/HUTRR47.pdf

Why not introduce all 8 player LEDs as described in the document? You
should be safe increasing LED_MAX to 0x1f.

Otherwise, looks good to me. But please don't forgot to put maintainers on CC.

Thanks
David

> Change-Id: If25d8a8e2570dfab3a35f9be5b1d03ab662f6b1c
> Signed-off-by: Michael Wright <michaelwr@google.com>
> ---
>  drivers/hid/hid-input.c    | 4 ++++
>  include/uapi/linux/input.h | 4 ++++
>  2 files changed, 8 insertions(+)
>
> diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
> index 2619f7f..a1cb3bf 100644
> --- a/drivers/hid/hid-input.c
> +++ b/drivers/hid/hid-input.c
> @@ -633,6 +633,10 @@ static void hidinput_configure_usage(struct hid_input *hidinput, struct hid_fiel
>                 case 0x4b:  map_led (LED_MISC);     break;    /*   "Generic Indicator"        */
>                 case 0x19:  map_led (LED_MAIL);     break;    /*   "Message Waiting"          */
>                 case 0x4d:  map_led (LED_CHARGING); break;    /*   "External Power Connected" */
> +               case 0x4f:  map_led (LED_PLAYER_1); break;    /*   "Player 1" */
> +               case 0x50:  map_led (LED_PLAYER_2); break;    /*   "Player 2" */
> +               case 0x51:  map_led (LED_PLAYER_3); break;    /*   "Player 3" */
> +               case 0x52:  map_led (LED_PLAYER_4); break;    /*   "Player 4" */
>
>                 default: goto ignore;
>                 }
> diff --git a/include/uapi/linux/input.h b/include/uapi/linux/input.h
> index 1874ebe..bb43f20 100644
> --- a/include/uapi/linux/input.h
> +++ b/include/uapi/linux/input.h
> @@ -908,6 +908,10 @@ struct input_keymap_entry {
>  #define LED_MISC               0x08
>  #define LED_MAIL               0x09
>  #define LED_CHARGING           0x0a
> +#define LED_PLAYER_1           0x0b
> +#define LED_PLAYER_2           0x0c
> +#define LED_PLAYER_3           0x0d
> +#define LED_PLAYER_4           0x0e
>  #define LED_MAX                        0x0f
>  #define LED_CNT                        (LED_MAX+1)
>
> --
> 2.1.0.rc2.206.gedb03e5
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
