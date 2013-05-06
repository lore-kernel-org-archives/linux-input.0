From: Thomas Chou <thomas@wytron.com.tw>
Subject: Re: [PATCH 1/3] Input: altera_ps2 - Remove redundant platform_set_drvdata()
Date: Mon, 06 May 2013 09:38:55 +0800
Message-ID: <518709AF.3040302@wytron.com.tw>
References: <1367577400-9527-1-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from www.wytron.com.tw ([211.75.82.101]:47460 "EHLO
	www.wytron.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752394Ab3EFBsU (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sun, 5 May 2013 21:48:20 -0400
Received: from localhost (localhost [127.0.0.1])
	by www.wytron.com.tw (Postfix) with SMTP id 536DAB00EB4
	for <linux-input@vger.kernel.org>; Mon,  6 May 2013 09:38:57 +0800 (CST)
In-Reply-To: <1367577400-9527-1-git-send-email-sachin.kamat@linaro.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Sachin Kamat <sachin.kamat@linaro.org>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com

Hi Sachin,

On 05/03/2013 06:36 PM, Sachin Kamat wrote:
> Commit 0998d06310 (device-core: Ensure drvdata = NULL when no
> driver is bound) removes the need to set driver data field to
> NULL.
>
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
> Cc: Thomas Chou <thomas@wytron.com.tw>
> ---
>   drivers/input/serio/altera_ps2.c |    1 -
>   1 file changed, 1 deletion(-)
>
> diff --git a/drivers/input/serio/altera_ps2.c b/drivers/input/serio/altera_ps2.c
> index 479ce5f..a0a2657 100644
> --- a/drivers/input/serio/altera_ps2.c
> +++ b/drivers/input/serio/altera_ps2.c
> @@ -163,7 +163,6 @@ static int altera_ps2_remove(struct platform_device *pdev)
>   {
>   	struct ps2if *ps2if = platform_get_drvdata(pdev);
>
> -	platform_set_drvdata(pdev, NULL);
>   	serio_unregister_port(ps2if->io);
>   	free_irq(ps2if->irq, ps2if);
>   	iounmap(ps2if->base);
>

Acked-by: Thomas Chou <thomas@wytron.com.tw>

Thanks.
- Thomas


