From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: select INPUT_MATRIXKMAP for lpc32xx-keys
Date: Tue, 30 Oct 2012 22:55:49 -0700
Message-ID: <20121031055549.GE31983@core.coreip.homeip.net>
References: <1351323648-18645-1-git-send-email-stigge@antcom.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:63911 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752712Ab2JaFzx (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 31 Oct 2012 01:55:53 -0400
Content-Disposition: inline
In-Reply-To: <1351323648-18645-1-git-send-email-stigge@antcom.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Roland Stigge <stigge@antcom.de>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, grant.likely@secretlab.ca

On Sat, Oct 27, 2012 at 09:40:48AM +0200, Roland Stigge wrote:
> This patch adds a "select" dependency of KEYBOARD_LPC32XX on INPUT_MATRIXKMAP,
> as the other drivers are doing in this regard. This fixes the following compile
> error if KEYBOARD_LPC32XX is enabled but INPUT_MATRIXKMAP is not:
> 
> drivers/input/keyboard/lpc32xx-keys.c:230: undefined reference to
> `matrix_keypad_build_keymap'
> 
> Signed-off-by: Roland Stigge <stigge@antcom.de>

Applied, thank you Roland.

> 
> ---
>  drivers/input/keyboard/Kconfig |    1 +
>  1 file changed, 1 insertion(+)
> 
> --- linux-2.6.orig/drivers/input/keyboard/Kconfig
> +++ linux-2.6/drivers/input/keyboard/Kconfig
> @@ -335,6 +335,7 @@ config KEYBOARD_LOCOMO
>  config KEYBOARD_LPC32XX
>  	tristate "LPC32XX matrix key scanner support"
>  	depends on ARCH_LPC32XX && OF
> +	select INPUT_MATRIXKMAP
>  	help
>  	  Say Y here if you want to use NXP LPC32XX SoC key scanner interface,
>  	  connected to a key matrix.

-- 
Dmitry
