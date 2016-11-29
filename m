From: Aniroop Mathur <a.mathur@samsung.com>
Subject: Re: [PATCH] Input: touchscreen: zylonite_wm97xx - change msleep to
 usleep_range for small msecs
Date: Wed, 30 Nov 2016 02:29:56 +0530
Message-ID: <CAOXgUe0qZmuQCOE4JeDjqqU+NpVDW3eZoHcTZo+iYRyhDnen-w@mail.gmail.com>
References: <1480358695-3024-1-git-send-email-a.mathur@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-io0-f196.google.com ([209.85.223.196]:32854 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751917AbcK2VAt (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Tue, 29 Nov 2016 16:00:49 -0500
In-Reply-To: <1480358695-3024-1-git-send-email-a.mathur@samsung.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: broonie@opensource.wolfsonmicro.com, pyro@f2s.com, zap parello <zap@homelink.ru>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, s.samuel@samsung.com, r.mahale@samsung.com, Aniroop Mathur <aniroop.mathur@gmail.com>, Aniroop Mathur <a.mathur@samsung.com>

Dear Mark Brown / Ian Molton / Andrew Zabolotny,

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

On Tue, Nov 29, 2016 at 12:14 AM, Aniroop Mathur <a.mathur@samsung.com> wrote:
> msleep(1~20) may not do what the caller intends, and will often sleep longer.
> (~20 ms actual sleep for any value given in the 1~20ms range)
> This is not the desired behaviour for many cases like device resume time,
> device suspend time, device enable time, retry logic, etc.
> Thus, change msleep to usleep_range for precise wakeups.
>
> Signed-off-by: Aniroop Mathur <a.mathur@samsung.com>
> ---
>  drivers/input/touchscreen/zylonite-wm97xx.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/input/touchscreen/zylonite-wm97xx.c b/drivers/input/touchscreen/zylonite-wm97xx.c
> index e2ccd68..cebd3a8 100644
> --- a/drivers/input/touchscreen/zylonite-wm97xx.c
> +++ b/drivers/input/touchscreen/zylonite-wm97xx.c
> @@ -81,7 +81,7 @@ static void wm97xx_acc_pen_up(struct wm97xx *wm)
>  {
>         int i;
>
> -       msleep(1);
> +       usleep_range(1000, 1100);
>
>         for (i = 0; i < 16; i++)
>                 MODR;
> @@ -98,7 +98,7 @@ static int wm97xx_acc_pen_down(struct wm97xx *wm)
>          * for samples.  The controller can't have a suitably low
>          * threshold set to use the notifications it gives.
>          */
> -       msleep(1);
> +       usleep_range(1000, 1100);
>
>         if (tries > 5) {
>                 tries = 0;
> --
> 2.6.2
>
