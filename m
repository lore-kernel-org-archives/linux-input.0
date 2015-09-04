From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] MAINLINE: Input: elants_i2c: Extend the calibration
 timeout to 12 second.
Date: Thu, 3 Sep 2015 22:19:13 -0700
Message-ID: <20150904051913.GA22340@dtor-ws>
References: <1441337217-1351-1-git-send-email-james.chen@emc.com.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f52.google.com ([209.85.220.52]:33394 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756355AbbIDFTR (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 4 Sep 2015 01:19:17 -0400
Content-Disposition: inline
In-Reply-To: <1441337217-1351-1-git-send-email-james.chen@emc.com.tw>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "james.chen" <james.chen@emc.com.tw>
Cc: Herman Lin <herman.lin@emc.com.tw>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, Charlie Mooney <charliemooney@chromium.org>

Hi James,

On Fri, Sep 04, 2015 at 11:26:57AM +0800, james.chen wrote:
> From: "james.chen" <james.chen@emc.com.tw>
> 
> As the test result of chrome project buddy(23 inch),
> the calibration time is about 9.2~10.5 second.
> So, this patch extend the calibration timeout to 12 second.
> 
> BUG= none
> TEST= Build and test on buddy project.

When submitting patches for mainline you do not need to follow ChromeOS
format (i.e have MAINLINE/CHROMIUM prefix and have BUG/TEST tags).

I dropped them from the commit description and applied the patch.

Thanks!

> 
> Signed-off-by: James Chen <james.chen@emc.com.tw>
> ---
>  drivers/input/touchscreen/elants_i2c.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/input/touchscreen/elants_i2c.c b/drivers/input/touchscreen/elants_i2c.c
> index ddac134..17cc20e 100644
> --- a/drivers/input/touchscreen/elants_i2c.c
> +++ b/drivers/input/touchscreen/elants_i2c.c
> @@ -102,7 +102,7 @@
>  #define ELAN_FW_PAGESIZE	132
>  
>  /* calibration timeout definition */
> -#define ELAN_CALI_TIMEOUT_MSEC	10000
> +#define ELAN_CALI_TIMEOUT_MSEC	12000
>  
>  #define ELAN_POWERON_DELAY_USEC	500
>  #define ELAN_RESET_DELAY_MSEC	20
> -- 
> 1.8.3.2
> 

-- 
Dmitry
