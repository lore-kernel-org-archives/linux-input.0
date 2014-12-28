From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: Avoid kernel panic during device unregistration
Date: Sun, 28 Dec 2014 12:21:49 -0800
Message-ID: <20141228202149.GA21544@dtor-ws>
References: <1419790325-4004-1-git-send-email-aniroop.mathur@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:44676 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751767AbaL1UVy (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 28 Dec 2014 15:21:54 -0500
Received: by mail-ie0-f174.google.com with SMTP id at20so11492117iec.19
        for <linux-input@vger.kernel.org>; Sun, 28 Dec 2014 12:21:53 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1419790325-4004-1-git-send-email-aniroop.mathur@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Aniroop Mathur <aniroop.mathur@gmail.com>
Cc: linux-input@vger.kernel.org, a.mathur@samsung.com

Hi Aniroop,

On Sun, Dec 28, 2014 at 11:42:05PM +0530, Aniroop Mathur wrote:
> This patch adds null check before actually unregistering the input device
> to avoid null pointer exception which leads to kernel panic.
> 
> So now, input device drivers won't have to worry about or add null case
> condition before calling input_unregister_device() in shutdown and
> remove functions.

input_unregister_device() should be called only if
input_register_device() succeeded, which it would not with input device
being NULL.

Unlike input_free_device() which does handle NULL argument, similar to
many other "free" APIs I do not believe that input_unregister_device
should be handling such cases.

> 
> Signed-off-by: Aniroop Mathur <a.mathur@samsung.com>
> ---
>  drivers/input/input.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/input/input.c b/drivers/input/input.c
> index 01fe49e..575219d 100644
> --- a/drivers/input/input.c
> +++ b/drivers/input/input.c
> @@ -2170,6 +2170,9 @@ EXPORT_SYMBOL(input_register_device);
>   */
>  void input_unregister_device(struct input_dev *dev)
>  {
> +	if (!dev)
> +		return;
> +
>  	if (dev->devres_managed) {
>  		WARN_ON(devres_destroy(dev->dev.parent,
>  					devm_input_device_unregister,
> -- 
> 1.9.1
> 

Thanks.

-- 
Dmitry
