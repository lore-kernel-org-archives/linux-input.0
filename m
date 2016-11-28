From: Aniroop Mathur <a.mathur@samsung.com>
Subject: Re: [PATCH] Input: Change msleep to usleep_range for small msecs
Date: Mon, 28 Nov 2016 22:05:36 +0530
Message-ID: <CAOXgUe0eq4vy3gZi2gyVTU47Ps1HpCFcRqfAWNri3-_4=JkBpA@mail.gmail.com>
References: <1480003383-1716-1-git-send-email-a.mathur@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-oi0-f68.google.com ([209.85.218.68]:36769 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933033AbcK1Qfh (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Mon, 28 Nov 2016 11:35:37 -0500
In-Reply-To: <1480003383-1716-1-git-send-email-a.mathur@samsung.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: xu.zhang@bosch-sensortec.com, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Aniroop Mathur <aniroop.mathur@gmail.com>, s.samuel@samsung.com, r.mahale@samsung.com, Aniroop Mathur <a.mathur@samsung.com>

Hello Mr. Albert Zhang,

I am Aniroop Mathur from Samsung R&D Institute, India.

I have submitted one patch as below for review to Linux Open Source.
The problem is that we do not have the hardware available with us to
test it and we would like to test it before actually applying it.
As you are the author of this driver, so I would like to request
you if you could help to test this patch or provide us the contact points
of individuals who could support to get this patch tested?

Thank you!

BR,
Aniroop Mathur


On Thu, Nov 24, 2016 at 9:33 PM, Aniroop Mathur <a.mathur@samsung.com> wrote:
> msleep(1~20) may not do what the caller intends, and will often sleep longer.
> (~20 ms actual sleep for any value given in the 1~20ms range)
> This is not the desired behaviour for many cases like device resume time,
> device suspend time, device enable time, etc.
> Thus, change msleep to usleep_range for precise wakeups.
>
> Signed-off-by: Aniroop Mathur <a.mathur@samsung.com>
> ---
>  drivers/input/misc/bma150.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/input/misc/bma150.c b/drivers/input/misc/bma150.c
> index 2124390..1fa8537 100644
> --- a/drivers/input/misc/bma150.c
> +++ b/drivers/input/misc/bma150.c
> @@ -207,7 +207,7 @@ static int bma150_set_mode(struct bma150_data *bma150, u8 mode)
>                 return error;
>
>         if (mode == BMA150_MODE_NORMAL)
> -               msleep(2);
> +               usleep_range(2000, 2100);
>
>         bma150->mode = mode;
>         return 0;
> @@ -222,7 +222,7 @@ static int bma150_soft_reset(struct bma150_data *bma150)
>         if (error)
>                 return error;
>
> -       msleep(2);
> +       usleep_range(2000, 2100);
>         return 0;
>  }
>
> --
> 2.6.2
>
