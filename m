From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: evdev: correct handling of memory allocation
 failure of evdev_client
Date: Wed, 27 Jan 2016 15:42:09 -0800
Message-ID: <20160127234209.GF28687@dtor-ws>
References: <1453744205-868-1-git-send-email-a.mathur@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f48.google.com ([209.85.220.48]:36402 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932516AbcA0XmM (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 27 Jan 2016 18:42:12 -0500
Content-Disposition: inline
In-Reply-To: <1453744205-868-1-git-send-email-a.mathur@samsung.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Aniroop Mathur <a.mathur@samsung.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, aniroop.mathur@gmail.com

Hi Aniroop,

On Mon, Jan 25, 2016 at 11:20:05PM +0530, Aniroop Mathur wrote:
> Lets fix twice checking of memory allocation failure of evdev_client
> structure when allocated successfully.

I think compiler will take care of optimizing away the 2nd check, so I'd
leave the code as is.

Thanks.

> 
> Signed-off-by: Aniroop Mathur <a.mathur@samsung.com>
> ---
>  drivers/input/evdev.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/input/evdev.c b/drivers/input/evdev.c
> index e9ae3d5..102b5d9 100644
> --- a/drivers/input/evdev.c
> +++ b/drivers/input/evdev.c
> @@ -503,10 +503,11 @@ static int evdev_open(struct inode *inode, struct file *file)
>  	int error;
>  
>  	client = kzalloc(size, GFP_KERNEL | __GFP_NOWARN);
> -	if (!client)
> +	if (!client) {
>  		client = vzalloc(size);
> -	if (!client)
> -		return -ENOMEM;
> +		if (!client)
> +			return -ENOMEM;
> +	}
>  
>  	client->bufsize = bufsize;
>  	spin_lock_init(&client->buffer_lock);
> -- 
> 2.6.2
> 

-- 
Dmitry
