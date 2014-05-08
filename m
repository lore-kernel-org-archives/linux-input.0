From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 1/2] input: fix ps2/serio module dependency
Date: Thu, 8 May 2014 08:59:31 -0700
Message-ID: <20140508155931.GA11672@core.coreip.homeip.net>
References: <1399560433-1402630-1-git-send-email-arnd@arndb.de>
 <1399560990-1402858-1-git-send-email-arnd@arndb.de>
 <1399560990-1402858-15-git-send-email-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pd0-f171.google.com ([209.85.192.171]:51471 "EHLO
	mail-pd0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754399AbaEHP7g (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 8 May 2014 11:59:36 -0400
Content-Disposition: inline
In-Reply-To: <1399560990-1402858-15-git-send-email-arnd@arndb.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

Hi Arnd,

On Thu, May 08, 2014 at 04:56:26PM +0200, Arnd Bergmann wrote:
> @@ -71,7 +71,7 @@ config KEYBOARD_ATKBD
>  	default y
>  	select SERIO
>  	select SERIO_LIBPS2
> -	select SERIO_I8042 if X86
> +	select SERIO_I8042 if X86 || ARCH_MIGHT_HAVE_PC_SERIO

x86 also selects ARCH_MIGHT_HAVE_PC_SERIO so shouldn't this be

	select SERIO_I8042 if ARCH_MIGHT_HAVE_PC_SERIO

?

I can fix it up on my side if you agree.

Thanks.

-- 
Dmitry
