From: Javier Martinez Canillas <martinez.javier@gmail.com>
Subject: Re: [PATCH v7 0/3] Input: Cypress TTSP device driver
Date: Tue, 8 Nov 2011 09:38:22 +0100
Message-ID: <CAAwP0s2gHxjTpwPs5KQY-fDQw8JrUuFQqF4Shr+s9DqvMbK83w@mail.gmail.com>
References: <1319396024-28558-1-git-send-email-martinez.javier@gmail.com>
 <CAAwP0s0g8pu8zz8J+wEeD6iqH8XN8bqzT-rOQwPYA9jyw8RL7g@mail.gmail.com>
 <20111101152015.GA2183@polaris.bitmath.org> <CAAwP0s3qfTKFngj3bXgZdOHVqDPEuqNB2MxezkCp7+WTaiEwLw@mail.gmail.com>
 <CAAwP0s0H5-cpGGn-x9+5praGs2+7kTyG==k36Y7zB_-d8SHO7Q@mail.gmail.com> <20111108081701.GC1837@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:34523 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751298Ab1KHIio convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 8 Nov 2011 03:38:44 -0500
Received: by ggnb2 with SMTP id b2so297270ggn.19
        for <linux-input@vger.kernel.org>; Tue, 08 Nov 2011 00:38:43 -0800 (PST)
In-Reply-To: <20111108081701.GC1837@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Henrik Rydberg <rydberg@euromail.se>, Mohan Pallaka <mpallaka@codeaurora.org>, Kevin McNeely <kev@cypress.com>, Shubhrajyoti Datta <omaplinuxkernel@gmail.com>, linux-input@vger.kernel.org

On Tue, Nov 8, 2011 at 9:17 AM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> Hi Javier,
>
> On Mon, Nov 07, 2011 at 09:17:57AM +0100, Javier Martinez Canillas wr=
ote:
>
>> Hello Dmitry,
>>
>> Do you have any comments on this issue?
>>
>
> Sorry for the delay and I promise your driver is next on my list.
>
> The driver seems in much better shape than it was last time I looked =
at
> it. Below are 2 tiny patches I still have from last time I tried
> going over the code.
>

Thank you Dmitry, I'm glad to ear that the driver is getting good shape=
=2E

>
>
> Input: cyttsp - fix use-after-free in syttsp_release
>
> From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
>
> Once input_unregister_device() is called we may not assume that
> ts->input contains valid pointer. Besides, input core takes care of
> freeing MT slot memory.
>
> Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
> ---
>
> =C2=A0drivers/input/touchscreen/cyttsp/cyttsp_core.c | =C2=A0 =C2=A01=
 -
> =C2=A01 files changed, 0 insertions(+), 1 deletions(-)
>
>
> diff --git a/drivers/input/touchscreen/cyttsp/cyttsp_core.c b/drivers=
/input/touchscreen/cyttsp/cyttsp_core.c
> index 103ac39..240998d 100644
> --- a/drivers/input/touchscreen/cyttsp/cyttsp_core.c
> +++ b/drivers/input/touchscreen/cyttsp/cyttsp_core.c
> @@ -660,7 +660,6 @@ void cyttsp_core_release(void *handle)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0input_unregist=
er_device(ts->input);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (ts->platfo=
rm_data->exit)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0ts->platform_data->exit();
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 input_mt_destroy_s=
lots(ts->input);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0kfree(ts);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0}
> =C2=A0}
>
>
>
> Input: cyttsp - remove ext() method from bus ops
>
> From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
>
> It is not used anywhere and so is not needed
>
> Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
> ---
>
> =C2=A0drivers/input/touchscreen/cyttsp/cyttsp_core.h | =C2=A0 =C2=A01=
 -
> =C2=A01 files changed, 0 insertions(+), 1 deletions(-)
>
>
> diff --git a/drivers/input/touchscreen/cyttsp/cyttsp_core.h b/drivers=
/input/touchscreen/cyttsp/cyttsp_core.h
> index efefdb9..c4c7d9e 100644
> --- a/drivers/input/touchscreen/cyttsp/cyttsp_core.h
> +++ b/drivers/input/touchscreen/cyttsp/cyttsp_core.h
> @@ -44,7 +44,6 @@
> =C2=A0struct cyttsp_bus_ops {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0s32 (*write)(void *handle, u8 addr, u8 len=
gth, const void *values);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0s32 (*read)(void *handle, u8 addr, u8 leng=
th, void *values);
> - =C2=A0 =C2=A0 =C2=A0 s32 (*ext)(void *handle, void *values);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0struct device *dev;
> =C2=A0};
>
>

Perfect, I'll keep this two as part of the patch-set and wait for your =
comments.

Thanks a lot and best regards,

--=20
Javier Mart=C3=ADnez Canillas
(+34) 682 39 81 69
Barcelona, Spain
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
