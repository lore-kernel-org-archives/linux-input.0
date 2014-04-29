From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v2] input: gpio-beeper: Simplify GPIO handling
Date: Mon, 28 Apr 2014 19:21:04 -0700
Message-ID: <20140429022104.GA7672@core.coreip.homeip.net>
References: <1398491214-14936-1-git-send-email-shc_work@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:41259 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751330AbaD2CVI (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 28 Apr 2014 22:21:08 -0400
Received: by mail-pb0-f46.google.com with SMTP id ma3so2688931pbc.19
        for <linux-input@vger.kernel.org>; Mon, 28 Apr 2014 19:21:08 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1398491214-14936-1-git-send-email-shc_work@mail.ru>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Alexander Shiyan <shc_work@mail.ru>
Cc: linux-input@vger.kernel.org

Hi Alexander,

On Sat, Apr 26, 2014 at 09:46:54AM +0400, Alexander Shiyan wrote:
> +	beep->desc = devm_gpiod_get(&pdev->dev, NULL);
> +	if (!beep->desc)
> +		return -EINVAL;

As far as I can see devm_gpiod_get() never returns NULL, but either a
valid pointer or ERR_PTR-encoded error. Why do we check for NULL?

I can drop the check myself, no need to resubmit.

>  
> -static struct of_device_id gpio_beeper_of_match[] = {
> +static struct of_device_id __maybe_unused gpio_beeper_of_match[] = {
>  	{ .compatible = BEEPER_MODNAME, },
>  	{ }
>  };

Instead of marking it as __maybe_unused we should wrap it in
#ifdef CONFIG_OF. I'll do it as well.

Thanks.

-- 
Dmitry
