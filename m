From: Aniroop Mathur <aniroop.mathur@gmail.com>
Subject: Re: [PATCH] Input: keyboard: lm8323 - Change msleep to usleep_range
 for small msecs
Date: Sat, 3 Dec 2016 22:28:26 +0530
Message-ID: <CADYu309FXYKH_iccfJajn0Brf1oxd-ZWij0aGsGCgGZ3gEr6Qg@mail.gmail.com>
References: <1480353009-1483-1-git-send-email-a.mathur@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:36294 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751352AbcLCQ62 (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Sat, 3 Dec 2016 11:58:28 -0500
Received: by mail-wm0-f66.google.com with SMTP id m203so7223679wma.3
        for <linux-input@vger.kernel.org>; Sat, 03 Dec 2016 08:58:28 -0800 (PST)
In-Reply-To: <1480353009-1483-1-git-send-email-a.mathur@samsung.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: daniel.stone@nokia.com
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, SAMUEL SEQUEIRA <s.samuel@samsung.com>, Rahul Mahale <r.mahale@samsung.com>

Dear Mr. Daniel Stone,
Greetings!

I am Aniroop Mathur from Samsung R&D Institute, India.

I have submitted one patch as below for review to Linux Open Source.
The problem is that we do not have the hardware available with us to
test it and we would like to test it before actually applying it.

Here currently, we are using msleep(1) which is worse as it sleeps for
minimum two jiffies i.e 20 ms on a system with HZ = 100.

As you are the author of this driver, I am contacting you to request you
provide your feedback upon this patch.

Also if you have the hardware available, could you please help to
test this patch on your hardware? or could you provide contact points
of individuals who could support to test it?

Thank you!

BR,
Aniroop Mathur

On Mon, Nov 28, 2016 at 10:40 PM, Aniroop Mathur <a.mathur@samsung.com> wrote:
> msleep(1~20) may not do what the caller intends, and will often sleep longer.
> (~20 ms actual sleep for any value given in the 1~20ms range)
> This is not the desired behaviour for many cases like device resume time,
> device suspend time, device enable time, retry logic, etc.
> Thus, change msleep to usleep_range for precise wakeups.
>
> Signed-off-by: Aniroop Mathur <a.mathur@samsung.com>
> ---
>  drivers/input/keyboard/lm8323.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/input/keyboard/lm8323.c b/drivers/input/keyboard/lm8323.c
> index 21bea52..14679e9 100644
> --- a/drivers/input/keyboard/lm8323.c
> +++ b/drivers/input/keyboard/lm8323.c
> @@ -689,7 +689,7 @@ static int lm8323_probe(struct i2c_client *client,
>                         break;
>                 }
>
> -               msleep(1);
> +               usleep_range(1000, 1100);
>         }
>
>         lm8323_configure(lm);
> --
> 2.6.2
>
