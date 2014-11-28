From: Aniroop Mathur <aniroop.mathur@gmail.com>
Subject: Re: [PATCH] Input: Initialize input_no by -1
Date: Fri, 28 Nov 2014 21:40:49 +0530
Message-ID: <CADYu30-cJzdk4-xdc3rTaQh0SdDpMsmp2qFi_GYz5ma++FsMpA@mail.gmail.com>
References: <1416931715-2902-1-git-send-email-aniroop.mathur@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-la0-f46.google.com ([209.85.215.46]:59219 "EHLO
	mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751156AbaK1QKu (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 28 Nov 2014 11:10:50 -0500
Received: by mail-la0-f46.google.com with SMTP id q1so1009426lam.33
        for <linux-input@vger.kernel.org>; Fri, 28 Nov 2014 08:10:49 -0800 (PST)
In-Reply-To: <1416931715-2902-1-git-send-email-aniroop.mathur@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, dtor@mail.ru

Dear Mr. Torokhov and Linux Input Community,
Greetings of the day !!

Kindly update about below patch.
I have corrected the spaces and sent it on Tue, Nov 25, 2014.

Thanks,
Aniroop Mathur

On Tue, Nov 25, 2014 at 9:38 PM, Aniroop Mathur
<aniroop.mathur@gmail.com> wrote:
>
> This patch initializes input_no by -1 in order to avoid extra subtraction
> operation performed everytime for allocation of an input device.
>
> Signed-off-by: Aniroop Mathur <aniroop.mathur@gmail.com>
> ---
>  drivers/input/input.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/input/input.c b/drivers/input/input.c
> index 29ca0bb..01fe49e 100644
> --- a/drivers/input/input.c
> +++ b/drivers/input/input.c
> @@ -1774,7 +1774,7 @@ EXPORT_SYMBOL_GPL(input_class);
>   */
>  struct input_dev *input_allocate_device(void)
>  {
> -       static atomic_t input_no = ATOMIC_INIT(0);
> +       static atomic_t input_no = ATOMIC_INIT(-1);
>         struct input_dev *dev;
>
>         dev = kzalloc(sizeof(struct input_dev), GFP_KERNEL);
> @@ -1789,7 +1789,7 @@ struct input_dev *input_allocate_device(void)
>                 INIT_LIST_HEAD(&dev->node);
>
>                 dev_set_name(&dev->dev, "input%ld",
> -                            (unsigned long) atomic_inc_return(&input_no) - 1);
> +                            (unsigned long) atomic_inc_return(&input_no));
>
>                 __module_get(THIS_MODULE);
>         }
> --
> 1.9.1
>
