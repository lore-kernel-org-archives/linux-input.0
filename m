From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: Initialize input_no by -1
Date: Tue, 25 Nov 2014 00:40:49 -0800
Message-ID: <20141125084049.GB14519@dtor-ws>
References: <CADYu30-dyHvidn6z6NW0w8hEwFd6Nctf8_5Yb5LKU4MFKvwLHw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ig0-f174.google.com ([209.85.213.174]:39145 "EHLO
	mail-ig0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750802AbaKYIky (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 25 Nov 2014 03:40:54 -0500
Received: by mail-ig0-f174.google.com with SMTP id hn15so4615308igb.13
        for <linux-input@vger.kernel.org>; Tue, 25 Nov 2014 00:40:53 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CADYu30-dyHvidn6z6NW0w8hEwFd6Nctf8_5Yb5LKU4MFKvwLHw@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Aniroop Mathur <aniroop.mathur@gmail.com>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

Hi Aniroop,

On Sat, Nov 22, 2014 at 12:18:39AM +0530, Aniroop Mathur wrote:
> This patch initializes input_no by -1 in order to avoid extra subtraction
> operation performed everytime for allocation of an input device.
> 
> Signed-off-by: Aniroop Mathur <aniroop.mathur@gmail.com>

It looks like you rmail client converted all tabs to spaces so the patch
can't be applied as is. Could you please fix and resend.

Thanks.

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

-- 
Dmitry
