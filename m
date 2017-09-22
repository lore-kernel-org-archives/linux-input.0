From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] HID: hid-input: Add eraser usage to hidinput_configure_usage
Date: Fri, 22 Sep 2017 09:56:41 -0700
Message-ID: <CAKdAkRTgag2OcLVHDzdYD6zLxHuzg-TitWb+EjTVS1fojfZ02w@mail.gmail.com>
References: <20170921223706.3289-1-ping.cheng@wacom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ua0-f194.google.com ([209.85.217.194]:35065 "EHLO
        mail-ua0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752270AbdIVQ4m (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Fri, 22 Sep 2017 12:56:42 -0400
Received: by mail-ua0-f194.google.com with SMTP id 97so506012uai.2
        for <linux-input@vger.kernel.org>; Fri, 22 Sep 2017 09:56:42 -0700 (PDT)
In-Reply-To: <20170921223706.3289-1-ping.cheng@wacom.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ping Cheng <pinglinux@gmail.com>
Cc: Jiri Kosina <jikos@kernel.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "Takeuchi, Toshiki" <toshiki.takeuchi@wacom.com>, Jason Gerecke <killertofu@gmail.com>, Ping Cheng <ping.cheng@wacom.com>

On Thu, Sep 21, 2017 at 3:37 PM, Ping Cheng <pinglinux@gmail.com> wrote:
> Some tablets report eraser usage to indicate the eraser tool. But,
> hidinput_configure_usage doesn't support it, which led the usage
> falls into default as ABS_MISC.
>
> Signed-off-by: Ping Cheng <ping.cheng@wacom.com>
> ---
>  drivers/hid/hid-input.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
> index 199f6a01fc62..4d36b08494fd 100644
> --- a/drivers/hid/hid-input.c
> +++ b/drivers/hid/hid-input.c
> @@ -797,6 +797,10 @@ static void hidinput_configure_usage(struct hid_input *hidinput, struct hid_fiel
>                         map_key_clear(BTN_STYLUS);
>                         break;
>
> +               case 0x45: /* ERASER */
> +                       map_key_clear(BTN_TOUCH);

Surely you mean BTN_TOOL_RUBBER?

Thanks.

-- 
Dmitry
