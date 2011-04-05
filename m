From: Shubhrajyoti <shubhrajyoti@ti.com>
Subject: Re: [PATCH] Prevent the NULL dereferencing
Date: Tue, 05 Apr 2011 15:55:38 +0530
Message-ID: <4D9AEE22.3050602@ti.com>
References: <1301997495-20876-1-git-send-email-shubhrajyoti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from na3sys009aog109.obsmtp.com ([74.125.149.201]:44879 "EHLO
	na3sys009aog109.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751682Ab1DEKZp (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 5 Apr 2011 06:25:45 -0400
Received: by gwj16 with SMTP id 16so86337gwj.23
        for <linux-input@vger.kernel.org>; Tue, 05 Apr 2011 03:25:44 -0700 (PDT)
In-Reply-To: <1301997495-20876-1-git-send-email-shubhrajyoti@ti.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: axel.lin@gmail.com, Shubhrajyoti D <a0393217@india.ti.com>

On Tuesday 05 April 2011 03:28 PM, shubhrajyoti@ti.com wrote:
> From: Shubhrajyoti D<a0393217@india.ti.com>
>
>
> Signed-off-by: Shubhrajyoti D<a0393217@india.ti.com>
Axel's patch added changes to prevent NULL access if pdata is NULL 
adding a check for keymap_data.
> ---
>   drivers/input/keyboard/twl4030_keypad.c |    2 +-
>   1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/drivers/input/keyboard/twl4030_keypad.c b/drivers/input/keyboard/twl4030_keypad.c
> index 09bef79..cc06c4b 100644
> --- a/drivers/input/keyboard/twl4030_keypad.c
> +++ b/drivers/input/keyboard/twl4030_keypad.c
> @@ -338,7 +338,7 @@ static int __devinit twl4030_kp_probe(struct platform_device *pdev)
>   	u8 reg;
>   	int error;
>
> -	if (!pdata || !pdata->rows || !pdata->cols ||
> +	if (!pdata || !pdata->rows || !pdata->cols || !pdata->keymap_data ||
>   	    pdata->rows>  TWL4030_MAX_ROWS || pdata->cols>  TWL4030_MAX_COLS) {
>   		dev_err(&pdev->dev, "Invalid platform_data\n");
>   		return -EINVAL;

