From: Ping Cheng <pinglinux@gmail.com>
Subject: Re: [PATCH 4/4 v3] Input: wacom - add SW_TOUCH to include/uapi/linux/input.h
Date: Fri, 15 Nov 2013 13:38:43 -0800
Message-ID: <CAF8JNhLk-ZH+w-EZi4yMpWqmG+ZeuSXhe9tQ_FOF5a0wE0A+-w@mail.gmail.com>
References: <1384545602-15549-1-git-send-email-pingc@wacom.com>
	<CAGzDe_ZsthR-QVHmut9eZue5ybOCKLRqh8-0V0y=rCRR=_pgeQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-lb0-f175.google.com ([209.85.217.175]:65357 "EHLO
	mail-lb0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751996Ab3KOVip (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 15 Nov 2013 16:38:45 -0500
Received: by mail-lb0-f175.google.com with SMTP id p9so3101460lbv.6
        for <linux-input@vger.kernel.org>; Fri, 15 Nov 2013 13:38:44 -0800 (PST)
In-Reply-To: <CAGzDe_ZsthR-QVHmut9eZue5ybOCKLRqh8-0V0y=rCRR=_pgeQ@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Chris Bagwell <chris@cnpbagwell.com>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jason Gerecke <killertofu@gmail.com>, Peter Hutterer <peter.hutterer@who-t.net>, Ping Cheng <pingc@wacom.com>

On Fri, Nov 15, 2013 at 1:33 PM, Chris Bagwell <chris@cnpbagwell.com> wrote:
> On Fri, Nov 15, 2013 at 2:00 PM, Ping Cheng <pinglinux@gmail.com> wrote:
>> New Intuos series models added a hardware switch to turn touch
>> data on/off. To report the state of the switch, SW_TOUCH
>> is added in include/uapi/linux/input.h.
>>
>
> Any status on your patch to add SW_TOUCH event?  Maybe you should
> resend since its been a while and this patch depends on it.

Which patch do we still need? Isn't this the one? Without the below
change, the driver would not compile.

> diff --git a/include/uapi/linux/input.h b/include/uapi/linux/input.h
> index a372627..fcddcb1 100644
> --- a/include/uapi/linux/input.h
> +++ b/include/uapi/linux/input.h
> @@ -856,6 +856,7 @@ struct input_keymap_entry {
>  #define SW_FRONT_PROXIMITY     0x0b  /* set = front proximity sensor active */
>  #define SW_ROTATE_LOCK         0x0c  /* set = rotate locked/disabled */
>  #define SW_LINEIN_INSERT       0x0d  /* set = inserted */
> +#define SW_TOUCH               0x0e  /* set = touch switch turned on (touch events off) */
>  #define SW_MAX                 0x0f
>  #define SW_CNT                 (SW_MAX+1)

Ping
