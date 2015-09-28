From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: omap-keypad: fix memory leak
Date: Mon, 28 Sep 2015 16:04:43 -0700
Message-ID: <20150928230443.GA32307@dtor-ws>
References: <1442575480-336-1-git-send-email-sudipm.mukherjee@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f54.google.com ([209.85.220.54]:36006 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752226AbbI1XEq (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 28 Sep 2015 19:04:46 -0400
Content-Disposition: inline
In-Reply-To: <1442575480-336-1-git-send-email-sudipm.mukherjee@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

On Fri, Sep 18, 2015 at 04:54:40PM +0530, Sudip Mukherjee wrote:
> If omap4_keypad_parse_dt() fails we returned the error code but we
> missed releasing keypad_data.
> 
> Signed-off-by: Sudip Mukherjee <sudip@vectorindia.org>

Applied, thank you.

> ---
>  drivers/input/keyboard/omap4-keypad.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/input/keyboard/omap4-keypad.c b/drivers/input/keyboard/omap4-keypad.c
> index b052afe..6639b2b 100644
> --- a/drivers/input/keyboard/omap4-keypad.c
> +++ b/drivers/input/keyboard/omap4-keypad.c
> @@ -266,7 +266,7 @@ static int omap4_keypad_probe(struct platform_device *pdev)
>  
>  	error = omap4_keypad_parse_dt(&pdev->dev, keypad_data);
>  	if (error)
> -		return error;
> +		goto err_free_keypad;
>  
>  	res = request_mem_region(res->start, resource_size(res), pdev->name);
>  	if (!res) {
> -- 
> 1.9.1
> 

-- 
Dmitry
