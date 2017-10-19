From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 4.14 REGRESSION fix] Input: axp20x-pek - Fix module not
 auto-loading for axp221 pek
Date: Thu, 19 Oct 2017 15:39:03 -0700
Message-ID: <20171019223903.mlwiibjsgyz2c4ck@dtor-ws>
References: <20171016133422.14327-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-it0-f68.google.com ([209.85.214.68]:51834 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752342AbdJSWjH (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Thu, 19 Oct 2017 18:39:07 -0400
Received: by mail-it0-f68.google.com with SMTP id o135so11554392itb.0
        for <linux-input@vger.kernel.org>; Thu, 19 Oct 2017 15:39:06 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20171016133422.14327-1-hdegoede@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-input@vger.kernel.org, Quentin Schulz <quentin.schulz@free-electrons.com>

On Mon, Oct 16, 2017 at 03:34:22PM +0200, Hans de Goede wrote:
> Now that we have a platform_device_id table and multiple supported ids
> we should be using MODULE_DEVICE_TABLE instead of MODULE_ALIAS.
> 
> This fixes a regression on Bay and Cherry Trail devices, where the power
> button is now enumerated as an "axp221-pek" and it was impossible to
> wakeup these devices from suspend since the module did not load.
> 
> Cc: Quentin Schulz <quentin.schulz@free-electrons.com>
> Fixes: c3cc94470bd3 ("Input: axp20x-pek - add support for AXP221 PEK")
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Applied, thank you.

> ---
>  drivers/input/misc/axp20x-pek.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/input/misc/axp20x-pek.c b/drivers/input/misc/axp20x-pek.c
> index 6cee5adc3b5c..debeeaeb8812 100644
> --- a/drivers/input/misc/axp20x-pek.c
> +++ b/drivers/input/misc/axp20x-pek.c
> @@ -403,6 +403,7 @@ static const struct platform_device_id axp_pek_id_match[] = {
>  	},
>  	{ /* sentinel */ }
>  };
> +MODULE_DEVICE_TABLE(platform, axp_pek_id_match);
>  
>  static struct platform_driver axp20x_pek_driver = {
>  	.probe		= axp20x_pek_probe,
> @@ -417,4 +418,3 @@ module_platform_driver(axp20x_pek_driver);
>  MODULE_DESCRIPTION("axp20x Power Button");
>  MODULE_AUTHOR("Carlo Caione <carlo@caione.org>");
>  MODULE_LICENSE("GPL");
> -MODULE_ALIAS("platform:axp20x-pek");
> -- 
> 2.14.2
> 

-- 
Dmitry
