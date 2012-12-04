From: Jean Delvare <khali@linux-fr.org>
Subject: Re: [PATCH 04/14] HID: i2c-hid: fix checkpatch.pl warning
Date: Tue, 4 Dec 2012 22:43:49 +0100
Message-ID: <20121204224349.2cefa121@endymion.delvare>
References: <1354634875-5182-1-git-send-email-benjamin.tissoires@gmail.com>
	<1354634875-5182-5-git-send-email-benjamin.tissoires@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from zoneX.GCU-Squad.org ([194.213.125.0]:43701 "EHLO
	services.gcu-squad.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753180Ab2LDVn6 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 4 Dec 2012 16:43:58 -0500
In-Reply-To: <1354634875-5182-5-git-send-email-benjamin.tissoires@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Cc: Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue,  4 Dec 2012 16:27:45 +0100, Benjamin Tissoires wrote:
> We should not initialize to 0 static declarations.
> 
> Signed-off-by: Benjamin Tissoires <benjamin.tissoires@gmail.com>
> ---
>  drivers/hid/i2c-hid/i2c-hid.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/hid/i2c-hid/i2c-hid.c b/drivers/hid/i2c-hid/i2c-hid.c
> index ad771a7..9ee6555 100644
> --- a/drivers/hid/i2c-hid/i2c-hid.c
> +++ b/drivers/hid/i2c-hid/i2c-hid.c
> @@ -46,7 +46,7 @@
>  #define I2C_HID_PWR_SLEEP	0x01
>  
>  /* debug option */
> -static bool debug = false;
> +static bool debug;
>  module_param(debug, bool, 0444);
>  MODULE_PARM_DESC(debug, "print a lot of debug information");
>  

Reviewed-by: Jean Delvare <khali@linux-fr.org>

-- 
Jean Delvare
