From: Elias Vanderstuyft <elias.vds@gmail.com>
Subject: Re: [PATCH] input: ff-memless: don't schedule already playing effect
 to play again
Date: Sun, 2 Mar 2014 14:17:58 +0100
Message-ID: <CADbOyBSMG_a=2qPmM0EU1LEd7y1ZxrpLuoz4MHroX6ri4-nJ3g@mail.gmail.com>
References: <1393760143-5986-1-git-send-email-felix.rueegg@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ve0-f181.google.com ([209.85.128.181]:50564 "EHLO
	mail-ve0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752251AbaCBNR7 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sun, 2 Mar 2014 08:17:59 -0500
In-Reply-To: <1393760143-5986-1-git-send-email-felix.rueegg@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?ISO-8859-1?Q?Michal_Mal=FD?= <madcatxster@prifuk.cz>
Cc: Felix Rueegg <felix.rueegg@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Sun, Mar 2, 2014 at 12:35 PM, Felix Rueegg <felix.rueegg@gmail.com> wrote:
> When an effect with zero replay length, zero replay delay
> and zero envelope attack length is uploaded, it is played and then scheduled to play
> again one timer tick later. This triggers a warning (URB submitted while
> active) in combination with the xpad driver.
>
> Skipping the rescheduling of this effect fixes the issue.
>
> Signed-off-by: Felix Rueegg <felix.rueegg@gmail.com>
> ---
>  drivers/input/ff-memless.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/input/ff-memless.c b/drivers/input/ff-memless.c
> index 74c0d8c..2e06948 100644
> --- a/drivers/input/ff-memless.c
> +++ b/drivers/input/ff-memless.c
> @@ -139,10 +139,13 @@ static void ml_schedule_timer(struct ml_device *ml)
>                 if (!test_bit(FF_EFFECT_STARTED, &state->flags))
>                         continue;
>
> -               if (test_bit(FF_EFFECT_PLAYING, &state->flags))
> +               if (test_bit(FF_EFFECT_PLAYING, &state->flags)) {
>                         next_at = calculate_next_time(state);
> -               else
> +                       if (next_at == now)
> +                               continue;
> +               } else {
>                         next_at = state->play_at;
> +               }
>
>                 if (time_before_eq(now, next_at) &&
>                     (++events == 1 || time_before(next_at, earliest)))
> --
> 1.9.0
>
> --

@Michal: Is ff-memless-next also affected by this problem?

Elias
