From: Nick Dyer <nick.dyer@itdev.co.uk>
Subject: Re: [PATCH v2 5/8] Input: synaptics-rmi4: Remove pointer to
 rmi_function in f12_data
Date: Tue, 5 Jul 2016 11:19:23 +0100
Message-ID: <f68379db-872b-7f74-ee22-c1365f2cf914@itdev.co.uk>
References: <1466813946-15940-1-git-send-email-aduggan@synaptics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from zencphosting06.zen.co.uk ([82.71.204.9]:50784 "EHLO
	zencphosting06.zen.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751598AbcGEKTm (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 5 Jul 2016 06:19:42 -0400
In-Reply-To: <1466813946-15940-1-git-send-email-aduggan@synaptics.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Andrew Duggan <aduggan@synaptics.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Vincent Huang <vincent.huang@tw.synaptics.com>

On 25/06/2016 01:19, Andrew Duggan wrote:
> The pointer to struct rmi_function in f12_data is never set and was never
> used. The fn pointer is also stored in rmi_2d_sensor which is a member of
> f12_data.
> 
> Signed-off-by: Andrew Duggan <aduggan@synaptics.com>

Reviewed-by: Nick Dyer <nick@shmanahar.org>

> ---
>  drivers/input/rmi4/rmi_f12.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/input/rmi4/rmi_f12.c b/drivers/input/rmi4/rmi_f12.c
> index 041a91d..7d66766 100644
> --- a/drivers/input/rmi4/rmi_f12.c
> +++ b/drivers/input/rmi4/rmi_f12.c
> @@ -27,7 +27,6 @@ enum rmi_f12_object_type {
>  };
>  
>  struct f12_data {
> -	struct rmi_function *fn;
>  	struct rmi_2d_sensor sensor;
>  	struct rmi_2d_sensor_platform_data sensor_pdata;
>  	bool has_dribble;
> 
