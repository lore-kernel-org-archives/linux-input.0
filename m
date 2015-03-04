From: Bastien Nocera <hadess@hadess.net>
Subject: Re: [PATCH 1/2] input: goodix: Add device tree support
Date: Wed, 04 Mar 2015 10:21:26 +0100
Message-ID: <1425460886.9384.4.camel@hadess.net>
References: <1425457930-4481-1-git-send-email-mamlinav@gmail.com>
	 <1425458028-4521-1-git-send-email-mamlinav@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:57545 "EHLO
	relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759495AbbCDJVe (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 4 Mar 2015 04:21:34 -0500
In-Reply-To: <1425458028-4521-1-git-send-email-mamlinav@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Aleksei Mamlin <mamlinav@gmail.com>
Cc: linux-input@vger.kernel.org, devicetree@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>

On Wed, 2015-03-04 at 11:33 +0300, Aleksei Mamlin wrote:
> This patch adds device tree support for Goodix GT9xx series 
> touchscreen controller.

<snip>
> diff --git a/drivers/input/touchscreen/Kconfig 
> b/drivers/input/touchscreen/Kconfig
> index 5891752..7a6ab8c 100644
> --- a/drivers/input/touchscreen/Kconfig
> +++ b/drivers/input/touchscreen/Kconfig
> @@ -297,7 +297,7 @@ config TOUCHSCREEN_FUJITSU
>  
>  config TOUCHSCREEN_GOODIX
>         tristate "Goodix I2C touchscreen"
> -       depends on I2C && ACPI
> +       depends on I2C

Any way to say depends on I2C && (ACPI || OF) ?

>         help
>                         Say Y here if you have the Goodix 
> touchscreen (such as one
>                         installed in Onda v975w tablets) connected 
> to your

Can you update the description to add the newly supported devices to 
the list?

Cheers
