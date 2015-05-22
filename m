From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] tty: remove platform_sysrq_reset_seq
Date: Fri, 22 May 2015 21:58:56 +0200
Message-ID: <3075531.er6Vo6bmpE@wuerfel>
References: <2397446.P9RRJqoFo7@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.24]:55139 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757169AbbEVT7D (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 22 May 2015 15:59:03 -0400
In-Reply-To: <2397446.P9RRJqoFo7@wuerfel>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, mathieu.poirier@linaro.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, linux-input@vger.kernel.org

On Thursday 21 May 2015 11:11:28 Arnd Bergmann wrote:
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
> 

It turns out that the variable is now potentially unused, and we get a warning
when CONFIG_INPUT is disabled. I'll send a fixed v2 of this patch.

	Arnd
