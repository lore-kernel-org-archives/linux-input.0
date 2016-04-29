From: Marek Vasut <marex@denx.de>
Subject: Re: [PATCH 3/3] input: touchscreen: mxs-lradc: Add support for touchscreen
Date: Fri, 29 Apr 2016 15:22:36 +0200
Message-ID: <5723601C.8030900@denx.de>
References: <cover.1461930102.git.ksenija.stanojevic@gmail.com> <61fe1da2e8d82921f3222ec939047b6823f695e1.1461930102.git.ksenija.stanojevic@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.9]:44547 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753038AbcD2NXH (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 29 Apr 2016 09:23:07 -0400
In-Reply-To: <61fe1da2e8d82921f3222ec939047b6823f695e1.1461930102.git.ksenija.stanojevic@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ksenija Stanojevic <ksenija.stanojevic@gmail.com>, linux-kernel@vger.kernel.org
Cc: lee.jones@linaro.org, dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net, linux-iio@vger.kernel.org, harald@ccbib.org

On 04/29/2016 01:49 PM, Ksenija Stanojevic wrote:
> Add mxs-lradc touchscreen driver.
> 
> Signed-off-by: Ksenija Stanojevic <ksenija.stanojevic@gmail.com>
> ---
>  drivers/input/touchscreen/Kconfig        |  14 +-
>  drivers/input/touchscreen/Makefile       |   1 +
>  drivers/input/touchscreen/mxs-lradc-ts.c | 729 +++++++++++++++++++++++++++++++
>  3 files changed, 742 insertions(+), 2 deletions(-)
>  create mode 100644 drivers/input/touchscreen/mxs-lradc-ts.c
> 
> diff --git a/drivers/input/touchscreen/Kconfig b/drivers/input/touchscreen/Kconfig
> index 8ecdc38..d614d248 100644
> --- a/drivers/input/touchscreen/Kconfig
> +++ b/drivers/input/touchscreen/Kconfig
> @@ -566,7 +566,7 @@ config TOUCHSCREEN_HP600
>  	depends on SH_HP6XX && SH_ADC
>  	help
>  	  Say Y here if you have a HP Jornada 620/660/680/690 and want to
> -          support the built-in touchscreen.
> +	  support the built-in touchscreen.

Grumble.

This patch looks good otherwise, thanks!

-- 
Best regards,
Marek Vasut
