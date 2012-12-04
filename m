From: Jean Delvare <khali@linux-fr.org>
Subject: Re: [PATCH 03/14] HID: i2c-hid: enhance Kconfig
Date: Tue, 4 Dec 2012 22:43:02 +0100
Message-ID: <20121204224302.2846b007@endymion.delvare>
References: <1354634875-5182-1-git-send-email-benjamin.tissoires@gmail.com>
	<1354634875-5182-4-git-send-email-benjamin.tissoires@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from zoneX.GCU-Squad.org ([194.213.125.0]:39433 "EHLO
	services.gcu-squad.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752037Ab2LDVnI (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 4 Dec 2012 16:43:08 -0500
In-Reply-To: <1354634875-5182-4-git-send-email-benjamin.tissoires@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Cc: Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue,  4 Dec 2012 16:27:44 +0100, Benjamin Tissoires wrote:
> The "comment" part can never be displayed, so we can remove it.
> 
> Signed-off-by: Benjamin Tissoires <benjamin.tissoires@gmail.com>
> ---
>  drivers/hid/i2c-hid/Kconfig | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/hid/i2c-hid/Kconfig b/drivers/hid/i2c-hid/Kconfig
> index 5b7d4d8..64ce108 100644
> --- a/drivers/hid/i2c-hid/Kconfig
> +++ b/drivers/hid/i2c-hid/Kconfig
> @@ -7,15 +7,12 @@ config I2C_HID
>  	depends on I2C && INPUT
>  	select HID
>  	---help---
> -	  Say Y here if you want to use the HID over i2c protocol
> -	  implementation.
> +	  Say Y here if you use a keyboard, a touchpad, a touchscreen, or any
> +	  other HID based devices which is connected to your computer via I2C.
>  
>  	  If unsure, say N.
>  
>  	  This support is also available as a module.  If so, the module
>  	  will be called i2c-hid.
>  
> -comment "Input core support is needed for HID over I2C input layer"
> -	depends on I2C_HID && INPUT=n
> -
>  endmenu

Reviewed-by: Jean Delvare <khali@linux-fr.org>

-- 
Jean Delvare
