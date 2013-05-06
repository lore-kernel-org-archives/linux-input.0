From: Marek Vasut <marex@denx.de>
Subject: Re: [PATCH 09/20] Input: matrix_keypad - Remove redundant platform_set_drvdata()
Date: Mon, 6 May 2013 14:08:01 +0200
Message-ID: <201305061408.01553.marex@denx.de>
References: <1367814240-8959-1-git-send-email-sachin.kamat@linaro.org> <1367814240-8959-9-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.10]:38988 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751845Ab3EFMIE (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 6 May 2013 08:08:04 -0400
In-Reply-To: <1367814240-8959-9-git-send-email-sachin.kamat@linaro.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Sachin Kamat <sachin.kamat@linaro.org>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com

Dear Sachin Kamat,

> Commit 0998d06310 (device-core: Ensure drvdata = NULL when no
> driver is bound) removes the need to set driver data field to
> NULL.
> 
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
> Cc: Marek Vasut <marek.vasut@gmail.com>

It does make sense.

btw. if you're up to cleaning this up, you can also introduce some 
devm_input_device_allocate() and switch kzalloc() to devm_kzalloc etc.

> ---
>  drivers/input/keyboard/matrix_keypad.c |    2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/input/keyboard/matrix_keypad.c
> b/drivers/input/keyboard/matrix_keypad.c index 71d7719..90ff73a 100644
> --- a/drivers/input/keyboard/matrix_keypad.c
> +++ b/drivers/input/keyboard/matrix_keypad.c
> @@ -549,8 +549,6 @@ static int matrix_keypad_remove(struct platform_device
> *pdev) input_unregister_device(keypad->input_dev);
>  	kfree(keypad);
> 
> -	platform_set_drvdata(pdev, NULL);
> -
>  	return 0;
>  }

Best regards,
Marek Vasut
