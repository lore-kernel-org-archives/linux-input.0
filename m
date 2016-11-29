From: Aniroop Mathur <a.mathur@samsung.com>
Subject: Re: [PATCH] Input: mouse: pxa930_trkball - change msleep to
 usleep_range for small msecs
Date: Wed, 30 Nov 2016 02:19:03 +0530
Message-ID: <CAOXgUe2a4-snRyj9uAmybQW2i+S4fi3G58ujQTEwDE3UOQVoQw@mail.gmail.com>
References: <1480354163-1957-1-git-send-email-a.mathur@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-io0-f196.google.com ([209.85.223.196]:32808 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753196AbcK2UtF (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Tue, 29 Nov 2016 15:49:05 -0500
In-Reply-To: <1480354163-1957-1-git-send-email-a.mathur@samsung.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: yaoyong@marvell.com
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, s.samuel@samsung.com, r.mahale@samsung.com, Aniroop Mathur <aniroop.mathur@gmail.com>, Aniroop Mathur <a.mathur@samsung.com>

Dear Yong Yao,
Greetings!

I am Aniroop Mathur from Samsung R&D Institute, India.

I have submitted one patch as below for review to Linux Open Source.
The problem is that we do not have the hardware available with us to
test it and we would like to test it before actually applying it.
As you are the author of this driver, I am contacting you to request you
provide your feedback upon this patch.

Also if you have the hardware available, could you please help to
test this patch on your hardware? or could you provide contact points
of individuals who could support to test it?

Thank you!

BR,
Aniroop Mathur

On Mon, Nov 28, 2016 at 10:59 PM, Aniroop Mathur <a.mathur@samsung.com> wrote:
> msleep(1~20) may not do what the caller intends, and will often sleep longer.
> (~20 ms actual sleep for any value given in the 1~20ms range)
> This is not the desired behaviour for many cases like device resume time,
> device suspend time, device enable time, retry logic, etc.
> Thus, change msleep to usleep_range for precise wakeups.
>
> Signed-off-by: Aniroop Mathur <a.mathur@samsung.com>
> ---
>  drivers/input/mouse/pxa930_trkball.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/input/mouse/pxa930_trkball.c b/drivers/input/mouse/pxa930_trkball.c
> index 9b4d9a5..d8ac9f9 100644
> --- a/drivers/input/mouse/pxa930_trkball.c
> +++ b/drivers/input/mouse/pxa930_trkball.c
> @@ -85,7 +85,7 @@ static int write_tbcr(struct pxa930_trkball *trkball, int v)
>         while (--i) {
>                 if (__raw_readl(trkball->mmio_base + TBCR) == v)
>                         break;
> -               msleep(1);
> +               usleep_range(1000, 1100);
>         }
>
>         if (i == 0) {
> --
> 2.6.2
>
