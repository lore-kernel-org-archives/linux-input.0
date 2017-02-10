From: Jason Gerecke <killertofu@gmail.com>
Subject: Re: [PATCH] HID: wacom: generic: Wacom mouse is only provided for
 opaque tablets
Date: Fri, 10 Feb 2017 15:12:20 -0800
Message-ID: <CANRwn3TTJ+ccK62csy6JK67TjHM70R7RROJye67adOEHUoyKeQ@mail.gmail.com>
References: <1486509851-2977-1-git-send-email-pingc@wacom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-vk0-f67.google.com ([209.85.213.67]:34679 "EHLO
        mail-vk0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751066AbdBJXND (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Fri, 10 Feb 2017 18:13:03 -0500
Received: by mail-vk0-f67.google.com with SMTP id r136so3798822vke.1
        for <linux-input@vger.kernel.org>; Fri, 10 Feb 2017 15:12:21 -0800 (PST)
In-Reply-To: <1486509851-2977-1-git-send-email-pingc@wacom.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ping Cheng <pinglinux@gmail.com>
Cc: Linux Input <linux-input@vger.kernel.org>, Jiri Kosina <jkosina@suse.cz>, Ping Cheng <pingc@wacom.com>, Ping Cheng <ping.cheng@wacom.com>

On Tue, Feb 7, 2017 at 3:24 PM, Ping Cheng <pinglinux@gmail.com> wrote:
> So, don't add mouse and lens cursor tools.
>
> Signed-off-by: Ping Cheng <ping.cheng@wacom.com>
> ---

Looks good to me!

Reviewed-by: Jason Gerecke <jason.gerecke@wacom.com>

Jason
---
Now instead of four in the eights place /
you=E2=80=99ve got three, =E2=80=98Cause you added one  /
(That is to say, eight) to the two,     /
But you can=E2=80=99t take seven from three,    /
So you look at the sixty-fours....

>  drivers/hid/wacom_wac.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
> index d51daf5..b51aa27 100644
> --- a/drivers/hid/wacom_wac.c
> +++ b/drivers/hid/wacom_wac.c
> @@ -1952,8 +1952,10 @@ static void wacom_wac_pen_usage_mapping(struct hid=
_device *hdev,
>                 input_set_capability(input, EV_KEY, BTN_TOOL_BRUSH);
>                 input_set_capability(input, EV_KEY, BTN_TOOL_PENCIL);
>                 input_set_capability(input, EV_KEY, BTN_TOOL_AIRBRUSH);
> -               input_set_capability(input, EV_KEY, BTN_TOOL_MOUSE);
> -               input_set_capability(input, EV_KEY, BTN_TOOL_LENS);
> +               if (!(features->device_type & WACOM_DEVICETYPE_DIRECT)) {
> +                       input_set_capability(input, EV_KEY, BTN_TOOL_MOUS=
E);
> +                       input_set_capability(input, EV_KEY, BTN_TOOL_LENS=
);
> +               }
>                 break;
>         case WACOM_HID_WD_FINGERWHEEL:
>                 wacom_map_usage(input, usage, field, EV_ABS, ABS_WHEEL, 0=
);
> --
> 2.7.4
>
