From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] tty: remove platform_sysrq_reset_seq
Date: Fri, 22 May 2015 10:07:14 -0700
Message-ID: <20150522170714.GD40101@dtor-ws>
References: <2397446.P9RRJqoFo7@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ig0-f181.google.com ([209.85.213.181]:38222 "EHLO
	mail-ig0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757188AbbEVRHT (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 22 May 2015 13:07:19 -0400
Content-Disposition: inline
In-Reply-To: <2397446.P9RRJqoFo7@wuerfel>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>, mathieu.poirier@linaro.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

On Thu, May 21, 2015 at 11:11:28AM +0200, Arnd Bergmann wrote:
> The platform_sysrq_reset_seq code was intended as a way for an embedded
> platform to provide its own sysrq sequence at compile time. After over
> two years, nobody has started using it in an upstream kernel, and
> the platforms that were interested in it have moved on to devicetree,
> which can be used to configure the sequence without requiring kernel
> changes. The method is also incompatible with the way that most
> architectures build support for multiple platforms into a single
> kernel.
> 
> Now the code is producing warnings when built with gcc-5.1:
> 
> drivers/tty/sysrq.c: In function 'sysrq_init':
> drivers/tty/sysrq.c:959:33: warning: array subscript is above array bounds [-Warray-bounds]
>    key = platform_sysrq_reset_seq[i];
> 
> We could fix this, but it seems unlikely that it will ever be used,
> so let's just remove the code instead. We still have the option to
> pass the sequence either in DT, using the kernel command line,
> or using the /sys/module/sysrq/parameters/reset_seq file.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Fixes: 154b7a489a ("Input: sysrq - allow specifying alternate reset sequence")

Mathieu, are you OK with dropping this?

> 
> diff --git a/drivers/tty/sysrq.c b/drivers/tty/sysrq.c
> index 8ba52e56bb8b..9c5395db6a57 100644
> --- a/drivers/tty/sysrq.c
> +++ b/drivers/tty/sysrq.c
> @@ -55,8 +55,7 @@
>  static int __read_mostly sysrq_enabled = CONFIG_MAGIC_SYSRQ_DEFAULT_ENABLE;
>  static bool __read_mostly sysrq_always_enabled;
>  
> -unsigned short platform_sysrq_reset_seq[] __weak = { KEY_RESERVED };
> -int sysrq_reset_downtime_ms __weak;
> +static int sysrq_reset_downtime_ms;
>  
>  static bool sysrq_on(void)
>  {
> @@ -950,23 +949,8 @@ static bool sysrq_handler_registered;
>  
>  static inline void sysrq_register_handler(void)
>  {
> -	unsigned short key;
>  	int error;
> -	int i;
> -
> -	/* First check if a __weak interface was instantiated. */
> -	for (i = 0; i < ARRAY_SIZE(sysrq_reset_seq); i++) {
> -		key = platform_sysrq_reset_seq[i];
> -		if (key == KEY_RESERVED || key > KEY_MAX)
> -			break;
>  
> -		sysrq_reset_seq[sysrq_reset_seq_len++] = key;
> -	}
> -
> -	/*
> -	 * DT configuration takes precedence over anything that would
> -	 * have been defined via the __weak interface.
> -	 */
>  	sysrq_of_get_keyreset_config();
>  
>  	error = input_register_handler(&sysrq_handler);
> 

-- 
Dmitry
