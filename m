From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] blackfin: convert pinmux request API into empty static
 inline functions for bf609 and bf548
Date: Fri, 6 Feb 2015 15:30:50 -0800
Message-ID: <20150206233050.GD29225@dtor-ws>
References: <1423215699-11153-1-git-send-email-sonic.adi@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ie0-f173.google.com ([209.85.223.173]:42933 "EHLO
	mail-ie0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752687AbbBFXaz (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 6 Feb 2015 18:30:55 -0500
Received: by iecrd18 with SMTP id rd18so5106879iec.9
        for <linux-input@vger.kernel.org>; Fri, 06 Feb 2015 15:30:54 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1423215699-11153-1-git-send-email-sonic.adi@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Sonic Zhang <sonic.adi@gmail.com>
Cc: Steven Miao <realmz6@gmail.com>, adi-buildroot-devel@lists.sourceforge.net, linux-input@vger.kernel.org, Sonic Zhang <sonic.zhang@analog.com>

On Fri, Feb 06, 2015 at 05:41:39PM +0800, Sonic Zhang wrote:
> From: Sonic Zhang <sonic.zhang@analog.com>
> 
> Signed-off-by: Sonic Zhang <sonic.zhang@analog.com>

Reviewed-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

I do not think arch changes shoudl go through my tree though...

> ---
>  arch/blackfin/include/asm/portmux.h |   15 +++++++++++----
>  1 file changed, 11 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/blackfin/include/asm/portmux.h b/arch/blackfin/include/asm/portmux.h
> index ccb96ca..2f6893e 100644
> --- a/arch/blackfin/include/asm/portmux.h
> +++ b/arch/blackfin/include/asm/portmux.h
> @@ -23,10 +23,17 @@ int bfin_internal_set_wake(unsigned int irq, unsigned int state);
>  #define gpio_pint_regs bfin_pint_regs
>  #define adi_internal_set_wake bfin_internal_set_wake
>  
> -#define peripheral_request(per, label) (0)
> -#define peripheral_free(per)
> -#define peripheral_request_list(per, label) (0)
> -#define peripheral_free_list(per)
> +static inline int peripheral_request(unsigned short per, const char *label)
> +{
> +	return 0;
> +}
> +static inline void peripheral_free(unsigned short per) {}
> +static inline int peripheral_request_list(const unsigned short per[],
> +					  const char *label)
> +{
> +	return 0;
> +}
> +static inline void peripheral_free_list(const unsigned short per[]) {}
>  int pinmux_request(unsigned short per, const char *label);
>  void pinmux_free(unsigned short per);
>  int pinmux_request_list(const unsigned short per[], const char *label);
> -- 
> 1.7.9.5
> 

-- 
Dmitry
