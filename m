From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] booboo[ADD] 1.support new ic type for version 4.
Date: Thu, 8 Jan 2015 13:26:44 -0800
Message-ID: <20150108212644.GB23256@dtor-ws>
References: <1420708423-19272-1-git-send-email-sam.hung@emc.com.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ig0-f171.google.com ([209.85.213.171]:65253 "EHLO
	mail-ig0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755038AbbAHV0s (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 8 Jan 2015 16:26:48 -0500
Received: by mail-ig0-f171.google.com with SMTP id z20so4966650igj.4
        for <linux-input@vger.kernel.org>; Thu, 08 Jan 2015 13:26:48 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1420708423-19272-1-git-send-email-sam.hung@emc.com.tw>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Sam hung <sam.hung@emc.com.tw>
Cc: linux-input@vger.kernel.org, dusonlin@emc.com.tw

On Thu, Jan 08, 2015 at 05:13:43PM +0800, Sam hung wrote:
> Signed-off-by: Yi ju Hong <sam.hung@emc.com.tw>

Applied, thank you.

> ---
>  drivers/input/mouse/elantech.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/input/mouse/elantech.c b/drivers/input/mouse/elantech.c
> index f2b9780..77ecf6d 100644
> --- a/drivers/input/mouse/elantech.c
> +++ b/drivers/input/mouse/elantech.c
> @@ -1520,6 +1520,8 @@ static int elantech_set_properties(struct elantech_data *etd)
>  		case 7:
>  		case 8:
>  		case 9:
> +		case 10:
> +		case 13:
>  			etd->hw_version = 4;
>  			break;
>  		default:
> -- 
> 1.8.3.2
> 

-- 
Dmitry
