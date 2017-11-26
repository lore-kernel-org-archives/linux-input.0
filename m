From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: elantech - add new icbody type 15
Date: Sat, 25 Nov 2017 16:49:06 -0800
Message-ID: <20171126004906.u4eebk6bdfzygu66@dtor-ws>
References: <20171119145647.4327-1-aaron.ma@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-io0-f193.google.com ([209.85.223.193]:41956 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751377AbdKZAtK (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Sat, 25 Nov 2017 19:49:10 -0500
Content-Disposition: inline
In-Reply-To: <20171119145647.4327-1-aaron.ma@canonical.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Aaron Ma <aaron.ma@canonical.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Sun, Nov 19, 2017 at 10:56:47PM +0800, Aaron Ma wrote:
> The touchpad of Lenovo Thinkpad L480 reports it's version as 15.
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Aaron Ma <aaron.ma@canonical.com>

Applied, thank you.

> ---
>  drivers/input/mouse/elantech.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/input/mouse/elantech.c b/drivers/input/mouse/elantech.c
> index b84cd978fce2..a4aaa748e987 100644
> --- a/drivers/input/mouse/elantech.c
> +++ b/drivers/input/mouse/elantech.c
> @@ -1613,7 +1613,7 @@ static int elantech_set_properties(struct elantech_data *etd)
>  		case 5:
>  			etd->hw_version = 3;
>  			break;
> -		case 6 ... 14:
> +		case 6 ... 15:
>  			etd->hw_version = 4;
>  			break;
>  		default:
> -- 
> 2.13.6
> 

-- 
Dmitry
