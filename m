From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: Re: [PATCH] Input: Fix typo in MT documentation
Date: Thu, 17 Sep 2015 16:31:36 -0400
Message-ID: <CAN+gG=HXTi8JHnRBMOpK4ZPmuG0inKRz9jh9SXFZ3uhZMo+Qkw@mail.gmail.com>
References: <1442502100-21039-1-git-send-email-daniel.martin@secunet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wi0-f181.google.com ([209.85.212.181]:35868 "EHLO
	mail-wi0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751558AbbIQUbh (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 17 Sep 2015 16:31:37 -0400
Received: by wicgb1 with SMTP id gb1so6441282wic.1
        for <linux-input@vger.kernel.org>; Thu, 17 Sep 2015 13:31:36 -0700 (PDT)
In-Reply-To: <1442502100-21039-1-git-send-email-daniel.martin@secunet.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Daniel Martin <daniel.martin@secunet.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input <linux-input@vger.kernel.org>, Daniel Martin <consume.noise@gmail.com>

On Thu, Sep 17, 2015 at 11:01 AM, Daniel Martin
<daniel.martin@secunet.com> wrote:
> Section "Event Computation" had this:
>     ...
>     ABS_MT_TOOL_X := C_X
>     ABS_MT_TOOL_X := C_Y
>
> Replace the second ABS_MT_TOOL_X with ABS_MT_TOOL_Y.
>
> Signed-off-by: Daniel Martin <consume.noise@gmail.com>
> ---

Acked-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

>  Documentation/input/multi-touch-protocol.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/input/multi-touch-protocol.txt b/Documentation/input/multi-touch-protocol.txt
> index b85d000..c51f114 100644
> --- a/Documentation/input/multi-touch-protocol.txt
> +++ b/Documentation/input/multi-touch-protocol.txt
> @@ -361,7 +361,7 @@ For win8 devices with both T and C coordinates, the position mapping is
>     ABS_MT_POSITION_X := T_X
>     ABS_MT_POSITION_Y := T_Y
>     ABS_MT_TOOL_X := C_X
> -   ABS_MT_TOOL_X := C_Y
> +   ABS_MT_TOOL_Y := C_Y
>
>  Unfortunately, there is not enough information to specify both the touching
>  ellipse and the tool ellipse, so one has to resort to approximations.  One
> --
> 2.1.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
