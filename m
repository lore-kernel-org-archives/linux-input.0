From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: Do not add SYN_REPORT in between a single packet data
Date: Wed, 9 Mar 2016 11:07:53 -0800
Message-ID: <CAKdAkRQT0R6peS8iO8PhQ4YoPMowt6voZJez4EubK7R0ZV_m4Q@mail.gmail.com>
References: <1457372672-884-1-git-send-email-a.mathur@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-vk0-f46.google.com ([209.85.213.46]:33055 "EHLO
	mail-vk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933895AbcCITHz (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 9 Mar 2016 14:07:55 -0500
In-Reply-To: <1457372672-884-1-git-send-email-a.mathur@samsung.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Aniroop Mathur <a.mathur@samsung.com>, Henrik Rydberg <rydberg@bitmath.org>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>, Aniroop Mathur <aniroop.mathur@gmail.com>

On Mon, Mar 7, 2016 at 9:44 AM, Aniroop Mathur <a.mathur@samsung.com> wrote:
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
>  drivers/input/input.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/input/input.c b/drivers/input/input.c
> index 8806059..262ef77 100644
> --- a/drivers/input/input.c
> +++ b/drivers/input/input.c
> @@ -401,8 +401,7 @@ static void input_handle_event(struct input_dev *dev,
>                 if (dev->num_vals >= 2)
>                         input_pass_values(dev, dev->vals, dev->num_vals);
>                 dev->num_vals = 0;
> -       } else if (dev->num_vals >= dev->max_vals - 2) {
> -               dev->vals[dev->num_vals++] = input_value_sync;
> +       } else if (dev->num_vals >= dev->max_vals - 1) {
>                 input_pass_values(dev, dev->vals, dev->num_vals);
>                 dev->num_vals = 0;
>         }

This makes sense to me. Henrik?

-- 
Dmitry
