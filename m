From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input/arc_ps2: add HAS_IOMEM dependency
Date: Mon, 29 Jun 2015 12:14:03 -0700
Message-ID: <20150629191403.GA22166@dtor-ws>
References: <alpine.LFD.2.11.1506291120300.1709@denkbrett>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ie0-f180.google.com ([209.85.223.180]:33625 "EHLO
	mail-ie0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751706AbbF2TOI (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 29 Jun 2015 15:14:08 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.11.1506291120300.1709@denkbrett>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Sebastian Ott <sebott@linux.vnet.ibm.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, Jun 29, 2015 at 11:22:44AM +0200, Sebastian Ott wrote:
> Fix this compile error:
> 
> drivers/built-in.o: In function `arc_ps2_probe':
> /mnt/linux/drivers/input/serio/arc_ps2.c:206: undefined reference to `devm_ioremap_resource'
> 
> Signed-off-by: Sebastian Ott <sebott@linux.vnet.ibm.com>

Applied, thank you.

> ---
>  drivers/input/serio/Kconfig |    1 +
>  1 file changed, 1 insertion(+)
> 
> --- a/drivers/input/serio/Kconfig
> +++ b/drivers/input/serio/Kconfig
> @@ -244,6 +244,7 @@ config SERIO_PS2MULT
>  
>  config SERIO_ARC_PS2
>  	tristate "ARC PS/2 support"
> +	depends on HAS_IOMEM
>  	help
>  	  Say Y here if you have an ARC FPGA platform with a PS/2
>  	  controller in it.
> 

-- 
Dmitry
