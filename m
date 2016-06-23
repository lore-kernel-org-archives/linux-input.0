From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: apanel - spelling mistake: "skiping" -> "skipping"
Date: Thu, 23 Jun 2016 10:05:10 -0700
Message-ID: <20160623170510.GD32561@dtor-ws>
References: <1466701060-7896-1-git-send-email-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f67.google.com ([209.85.220.67]:36190 "EHLO
	mail-pa0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750809AbcFWRFO (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 23 Jun 2016 13:05:14 -0400
Content-Disposition: inline
In-Reply-To: <1466701060-7896-1-git-send-email-colin.king@canonical.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Colin King <colin.king@canonical.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, Jun 23, 2016 at 05:57:40PM +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> trivial fix to spelling mistake in pr_notice message
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Applied, thank you.

> ---
>  drivers/input/misc/apanel.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/input/misc/apanel.c b/drivers/input/misc/apanel.c
> index a8d2b8d..53630af 100644
> --- a/drivers/input/misc/apanel.c
> +++ b/drivers/input/misc/apanel.c
> @@ -297,7 +297,7 @@ static int __init apanel_init(void)
>  
>  		if (slave != i2c_addr) {
>  			pr_notice(APANEL ": only one SMBus slave "
> -				  "address supported, skiping device...\n");
> +				  "address supported, skipping device...\n");
>  			continue;
>  		}
>  
> -- 
> 2.8.1
> 

-- 
Dmitry
