From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 3/3] OLPC: touchpad driver (take 2)
Date: Thu, 11 Sep 2008 09:05:22 -0400
Message-ID: <20080911090103.ZZRA012@mailhub.coreip.homeip.net>
References: <20080813152459.4d6bb0cb@ephemeral> <20080815031435.GD9438@anvil.corenet.prv> <20080910175513.17d900bc@dev.queued.net> <20080911010124.79166d64@dev.queued.net> <20080911013209.3d7c70da@dev.queued.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gx0-f16.google.com ([209.85.217.16]:62875 "EHLO
	mail-gx0-f16.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750745AbYIKNF1 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 11 Sep 2008 09:05:27 -0400
Received: by gxk9 with SMTP id 9so16249530gxk.13
        for <linux-input@vger.kernel.org>; Thu, 11 Sep 2008 06:05:26 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20080911013209.3d7c70da@dev.queued.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Andres Salomon <dilinger@queued.net>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, Sep 11, 2008 at 01:32:09AM -0400, Andres Salomon wrote:
> 
> And here's the current touchpad driver after updating based upon your
> comments.
> 

Looks good. Care to respin it all thogether based on the attribute
change I requested so I can be sure I'm applying the latest version of
everything? Ummm....

> diff --git a/drivers/input/mouse/Kconfig b/drivers/input/mouse/Kconfig
> index 7bbea09..fff0253 100644
> --- a/drivers/input/mouse/Kconfig
> +++ b/drivers/input/mouse/Kconfig
> @@ -96,6 +96,16 @@ config MOUSE_PS2_TOUCHKIT
>  
>  	  If unsure, say N.
>  
> +config MOUSE_PS2_OLPC
> +	bool "OLPC PS/2 mouse protocol extension"
> +	depends on MOUSE_PS2 && OLPC

Are you sure it shoudl depend on OLPC? It looks like driver should
work on any box with PS/2 port. I understand that only OLPC has the
hardware installed but can this change?

Thanks!

-- 
Dmitry
