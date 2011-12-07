From: Randy Dunlap <rdunlap@xenotime.net>
Subject: Re: [PATCH] HID: wiimote: Select INPUT_FF_MEMLESS
Date: Wed, 07 Dec 2011 13:51:48 -0800
Message-ID: <4EDFDFF4.1090307@xenotime.net>
References: <4EDFD23D.4030703@xenotime.net> <1323290039-28073-1-git-send-email-dh.herrmann@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1250
Content-Transfer-Encoding: 7bit
Return-path: <linux-next-owner@vger.kernel.org>
In-Reply-To: <1323290039-28073-1-git-send-email-dh.herrmann@googlemail.com>
Sender: linux-next-owner@vger.kernel.org
To: David Herrmann <dh.herrmann@googlemail.com>
Cc: linux-input@vger.kernel.org, linux-next@vger.kernel.org, jkosina@suse.cz, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On 12/07/2011 12:33 PM, David Herrmann wrote:
> We depend on memless force-feedback support, therefore correctly select the
> related config options.
> 
> Reported-by: Randy Dunlap <rdunlap@xenotime.net>
> Signed-off-by: David Herrmann <dh.herrmann@googlemail.com>

Acked-by: Randy Dunlap <rdunlap@xenotime.net>

Thanks.

> ---
> Hi Randy
> 
> Thanks for reporting this. This patch should fix this. I don't know whether such
> fixes belong to stable tree, if they do, Jiri could you CC stable when applying
> it?
> 
> Cheers
> David
> 
>  drivers/hid/Kconfig |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
> index edf2b2b..dae04a0 100644
> --- a/drivers/hid/Kconfig
> +++ b/drivers/hid/Kconfig
> @@ -591,6 +591,7 @@ config HID_WIIMOTE
>  	depends on BT_HIDP
>  	depends on LEDS_CLASS
>  	select POWER_SUPPLY
> +	select INPUT_FF_MEMLESS
>  	---help---
>  	Support for the Nintendo Wii Remote bluetooth device.
>  


-- 
~Randy
*** Remember to use Documentation/SubmitChecklist when testing your code ***
