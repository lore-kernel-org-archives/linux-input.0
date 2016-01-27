From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input: keyboard: cap11xx: Add missing of_node_put
Date: Wed, 27 Jan 2016 15:48:58 -0800
Message-ID: <20160127234858.GI28687@dtor-ws>
References: <20160125153121.GA21093@amitoj-Inspiron-3542>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f42.google.com ([209.85.220.42]:33684 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965083AbcA0XtC (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 27 Jan 2016 18:49:02 -0500
Content-Disposition: inline
In-Reply-To: <20160125153121.GA21093@amitoj-Inspiron-3542>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Amitoj Kaur Chawla <amitoj1606@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, julia.lawall@lip6.fr

On Mon, Jan 25, 2016 at 09:01:21PM +0530, Amitoj Kaur Chawla wrote:
> for_each_child_of_node performs an of_node_get on each iteration, so
> to break out of the loop an of_node_put is required.
> 
> Found using Coccinelle. The semantic patch used for this is as follows:
> 
> // <smpl>
> @@
> expression e;
> local idexpression n;
> @@
> 
>  for_each_child_of_node(..., n) {
>    ... when != of_node_put(n)
>        when != e = n
> (
>    return n;
> |
> +  of_node_put(n);
> ?  return ...;
> )
>    ...
>  }
> // </smpl
> 
> Signed-off-by: Amitoj Kaur Chawla <amitoj1606@gmail.com>
> ---
>  drivers/input/keyboard/cap11xx.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/input/keyboard/cap11xx.c b/drivers/input/keyboard/cap11xx.c
> index 378db10..27cd7df 100644
> --- a/drivers/input/keyboard/cap11xx.c
> +++ b/drivers/input/keyboard/cap11xx.c
> @@ -304,8 +304,10 @@ static int cap11xx_init_leds(struct device *dev,
>  		led->cdev.brightness = LED_OFF;
>  
>  		error = of_property_read_u32(child, "reg", &reg);
> -		if (error != 0 || reg >= num_leds)
> -			return -EINVAL;
> +		if (error != 0 || reg >= num_leds) {
> +			error = -EINVAL;
> +			goto putchild;

Instead of jumping to a label I added of_node_put here and also below
and applied, thank you.

I believe there is another input driver that returns from
for_each_child_of_node() without dropping reference.

Thanks.

-- 
Dmitry
