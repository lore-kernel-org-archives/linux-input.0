From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH] Remove duplicate Kconfig entry for HID_PANTHERLORD
Date: Thu, 17 Sep 2009 15:27:13 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.0909171526360.17028@wotan.suse.de>
References: <1253191090-23675-1-git-send-email-ag@alessandroguido.name>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:54744 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752867AbZIQN1M (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 17 Sep 2009 09:27:12 -0400
In-Reply-To: <1253191090-23675-1-git-send-email-ag@alessandroguido.name>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Alessandro Guido <ag@alessandroguido.name>
Cc: linux-input@vger.kernel.org

On Thu, 17 Sep 2009, Alessandro Guido wrote:

> ---
>  drivers/hid/Kconfig |    7 -------
>  1 files changed, 0 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
> index 111afbe..24d90ea 100644
> --- a/drivers/hid/Kconfig
> +++ b/drivers/hid/Kconfig
> @@ -205,13 +205,6 @@ config HID_NTRIG
>  	Support for N-Trig touch screen.
>  
>  config HID_PANTHERLORD
> -	tristate "Pantherlord devices support" if EMBEDDED
> -	depends on USB_HID
> -	default !EMBEDDED
> -	---help---
> -	Support for PantherLord/GreenAsia based device support.
> -
> -config HID_PANTHERLORD
>  	tristate "Pantherlord support" if EMBEDDED
>  	depends on USB_HID
>  	default !EMBEDDED

Good catch, thanks. Could you please send it also together with proper 
Signed-off-by: line?

-- 
Jiri Kosina
SUSE Labs, Novell Inc.
