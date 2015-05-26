From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input:mouse:synaptics_i2c - Use bool function return
 value
Date: Tue, 26 May 2015 14:44:06 -0700
Message-ID: <20150526214406.GC10343@dtor-ws>
References: <1432575184-3348-1-git-send-email-shailendra.capricorn@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ig0-f178.google.com ([209.85.213.178]:36946 "EHLO
	mail-ig0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751478AbbEZVoK (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 26 May 2015 17:44:10 -0400
Content-Disposition: inline
In-Reply-To: <1432575184-3348-1-git-send-email-shailendra.capricorn@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Shailendra Verma <shailendra.capricorn@gmail.com>
Cc: Jingoo Han <jg1.han@samsung.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, May 25, 2015 at 11:03:04PM +0530, Shailendra Verma wrote:
> The function synaptics_i2c_get_input() has bool return type.
> So use bool value flase instead of 0 to return.
> 
> Signed-off-by: Shailendra Verma <shailendra.capricorn@gmail.com>

Folded all 3 patches together and applied.

Thank you.

> ---
>  drivers/input/mouse/synaptics_i2c.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/input/mouse/synaptics_i2c.c b/drivers/input/mouse/synaptics_i2c.c
> index 2c87a93..ffceedc 100644
> --- a/drivers/input/mouse/synaptics_i2c.c
> +++ b/drivers/input/mouse/synaptics_i2c.c
> @@ -342,7 +342,7 @@ static bool synaptics_i2c_get_input(struct synaptics_i2c *touch)
>  
>  	/* Deal with spontaneous resets and errors */
>  	if (synaptics_i2c_check_error(touch->client))
> -		return 0;
> +		return false;
>  
>  	/* Get Gesture Bit */
>  	data = synaptics_i2c_reg_get(touch->client, DATA_REG0);
> -- 
> 1.7.9.5
> 

-- 
Dmitry
