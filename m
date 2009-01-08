From: Marek Vasut <marek.vasut@gmail.com>
Subject: Re: [RFC] mfd/ucb1400: don't depend on gpiolib
Date: Thu, 8 Jan 2009 13:25:53 +0100
Message-ID: <200901081325.53589.marek.vasut@gmail.com>
References: <20090108110612.GA24243@www.tglx.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.173]:48060 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752669AbZAHMZu (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 8 Jan 2009 07:25:50 -0500
Received: by ug-out-1314.google.com with SMTP id 39so1692714ugf.37
        for <linux-input@vger.kernel.org>; Thu, 08 Jan 2009 04:25:49 -0800 (PST)
In-Reply-To: <20090108110612.GA24243@www.tglx.de>
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-input@vger.kernel.org, akpm@linux-foundation.org

On Thursday 08 of January 2009 12:06:12 Sebastian Andrzej Siewior wrote:
> it didn't in the past and I can't see how it does.
>
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
> I use ucb1400 with its ts capabilities without *gpiolib* on a ppc system.
>
>  drivers/mfd/Kconfig |    1 -
>  1 files changed, 0 insertions(+), 1 deletions(-)
>
> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> index 2572773..8bcd600 100644
> --- a/drivers/mfd/Kconfig
> +++ b/drivers/mfd/Kconfig
> @@ -53,7 +53,6 @@ config HTC_PASIC3
>  config UCB1400_CORE
>  	tristate "Philips UCB1400 Core driver"
>  	depends on AC97_BUS
> -	depends on GPIOLIB
>  	help
>  	  This enables support for the Philips UCB1400 core functions.
>  	  The UCB1400 is an AC97 audio codec.

That dependency was added there later, I got email from Andrew Morton from 
22.9.2008 23:44 adding that there, go ask him about it. CCed.
