From: Russell King - ARM Linux <linux@armlinux.org.uk>
Subject: Re: [PATCH 01/10 v4] Input: ep93xx_keypad: Fix platform_get_irq's
 error checking
Date: Mon, 20 Nov 2017 16:29:42 +0000
Message-ID: <20171120162941.GD31757@n2100.armlinux.org.uk>
References: <987ac156e9590cbe2f667f9782b56515d7a991a4.1511194239.git.arvind.yadav.cs@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from pandora.armlinux.org.uk ([78.32.30.218]:57930 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751664AbdKTQ3z (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Mon, 20 Nov 2017 11:29:55 -0500
Content-Disposition: inline
In-Reply-To: <987ac156e9590cbe2f667f9782b56515d7a991a4.1511194239.git.arvind.yadav.cs@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Arvind Yadav <arvind.yadav.cs@gmail.com>
Cc: dmitry.torokhov@gmail.com, maxime.ripard@free-electrons.com, wens@csie.org, mcuos.com@gmail.com, linux@roeck-us.net, lee.jones@linaro.org, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Mon, Nov 20, 2017 at 09:56:21PM +0530, Arvind Yadav wrote:
> The platform_get_irq() function returns negative if an error occurs.
> zero or positive number on success. platform_get_irq() error checking
> for zero is not correct.
> 
> Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
> ---
> changes in v2 :
>               Return keypad->irq insted of -ENXIO.
> changes in v3 :
>               Add failure case '<= 0' instead of '< 0'. IRQ0 is not valid.
> changes ib v4 :
>               Return -ENXIO insted of keypad->irq. Which was not correct in v3.
> 
>  drivers/input/keyboard/ep93xx_keypad.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/input/keyboard/ep93xx_keypad.c b/drivers/input/keyboard/ep93xx_keypad.c
> index f77b295..c6eb31a 100644
> --- a/drivers/input/keyboard/ep93xx_keypad.c
> +++ b/drivers/input/keyboard/ep93xx_keypad.c
> @@ -257,7 +257,7 @@ static int ep93xx_keypad_probe(struct platform_device *pdev)
>  	}
>  
>  	keypad->irq = platform_get_irq(pdev, 0);
> -	if (!keypad->irq) {
> +	if (keypad->irq <= 0) {
>  		err = -ENXIO;

Still not right.

		err = keypad->irq < 0 ? keypad->irq : -ENXIO;

would have the right effect.

However, I disagree with the idea of making platform_get_irq() return
an error if there is a zero irq specified as suggested in a previous
review - zero means "not present" and that is not necessarily an error -
it's up to the driver to decide whether it can proceed without an
interrupt, or whether it should error out on the probe function.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
