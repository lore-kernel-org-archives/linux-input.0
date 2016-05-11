From: Aniroop Mathur <aniroop.mathur@gmail.com>
Subject: Re: [PATCH] Input: Do not add SYN_REPORT in between a single packet data
Date: Wed, 11 May 2016 19:40:18 +0530
Message-ID: <CADYu30_21fFCswd3dCsaqUUg1fEVKBxazMPpSOURzNBA10UnSQ@mail.gmail.com>
References: <1462376571-4280-1-git-send-email-a.mathur@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:33028 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932723AbcEKOKT (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 11 May 2016 10:10:19 -0400
Received: by mail-wm0-f66.google.com with SMTP id r12so9703226wme.0
        for <linux-input@vger.kernel.org>; Wed, 11 May 2016 07:10:19 -0700 (PDT)
In-Reply-To: <1462376571-4280-1-git-send-email-a.mathur@samsung.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Aniroop Mathur <a.mathur@samsung.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

Hello Mr. Torokhov,

Would you please provide update for this patch?
As you can notice it is really pending for a long time,
I'll be grateful if you could update and conclude it quickly.

Thank you.

BR,
Aniroop Mathur


On Wed, May 4, 2016 at 9:12 PM, Aniroop Mathur <a.mathur@samsung.com> wrote:
> As mentioned in documentation, SYN_REPORT should be used to separate two packets
> and should not be inserted in between a single packet as otherwise with multiple
> SYN_REPORT in a single packet, input reader would not be able to know when the
> packet ended really.
>
> Documentation snippet:
> * SYN_REPORT:
>   - Used to synchronize and separate events into packets of input data changes
>     occurring at the same moment in time. For example, motion of a mouse may set
>     the REL_X and REL_Y values for one motion, then emit a SYN_REPORT. The next
>     motion will emit more REL_X and REL_Y values and send another SYN_REPORT.
>
> Signed-off-by: Aniroop Mathur <a.mathur@samsung.com>
> ---
>  drivers/input/input.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/input/input.c b/drivers/input/input.c
> index 8806059..5b0b1ae 100644
> --- a/drivers/input/input.c
> +++ b/drivers/input/input.c
> @@ -401,12 +401,14 @@ static void input_handle_event(struct input_dev *dev,
>                 if (dev->num_vals >= 2)
>                         input_pass_values(dev, dev->vals, dev->num_vals);
>                 dev->num_vals = 0;
> -       } else if (dev->num_vals >= dev->max_vals - 2) {
> -               dev->vals[dev->num_vals++] = input_value_sync;
> -               input_pass_values(dev, dev->vals, dev->num_vals);
> -               dev->num_vals = 0;
> +       } else if (dev->num_vals >= dev->max_vals - 1) {
> +               /* Pass all events except the newest event in order to
> +                * not suppress the immediate EV_SYN/SYN_REPORT event.
> +                */
> +               input_pass_values(dev, dev->vals, dev->num_vals - 1);
> +               dev->vals[0] = dev->vals[dev->num_vals - 1];
> +               dev->num_vals = 1;
>         }
> -
>  }
>
>  /**
> --
> 2.6.2
>
