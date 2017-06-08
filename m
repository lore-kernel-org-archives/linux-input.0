From: Pali =?UTF-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
Subject: Re: [PATCH] Input: psmouse - reset device during probe
Date: Thu, 08 Jun 2017 21:32:52 +0200
Message-ID: <5939a665.4faa1c0a.ac8e9.69e4@mx.google.com>
References: <20170605202752.8061-1-drake@endlessm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8Bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:34082 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751439AbdFHTcz (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Thu, 8 Jun 2017 15:32:55 -0400
Received: by mail-wm0-f68.google.com with SMTP id 70so8815729wme.1
        for <linux-input@vger.kernel.org>; Thu, 08 Jun 2017 12:32:55 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Daniel Drake <drake@endlessm.com>, dmitry.torokhov@gmail.com, linux-input@vger.kernel.org

On Po 5. Jún 2017 22:27 Daniel Drake wrote:
> New Acer laptops (Aspire A315-31 and several others) have an EC which
> expects the PS/2 reset command to happen during boot.
> 
> On Linux, that means that currently the touchpad is unresponsive until
> suspend/resume, when psmouse_reconnect() resets the device.
> 
> We observe that Windows sends a PS/2 reset command during boot.
> Make Linux do the same here, making the touchpad usable on these
> new products.
> 
> Signed-off-by: Daniel Drake <drake@endlessm.com>
> ---
>  drivers/input/mouse/psmouse-base.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/input/mouse/psmouse-base.c
> b/drivers/input/mouse/psmouse-base.c index f73b47b8c578..8f3c903db7b9
> 100644 --- a/drivers/input/mouse/psmouse-base.c
> +++ b/drivers/input/mouse/psmouse-base.c
> @@ -1591,6 +1591,12 @@ static int psmouse_connect(struct serio *serio,
> struct serio_driver *drv)
>  psmouse->resync_time = parent ? 0 : psmouse_resync_time;
>  psmouse->smartscroll = psmouse_smartscroll;
>  
> +	/* Reset the device, even though we would ordinarily expect it to
> +	 * already be in the reset state. This matches Windows behaviour,
> +	 * which some ECs require.
> +	 */
> +	psmouse_reset(psmouse);
> +
>  psmouse_switch_protocol(psmouse, NULL);
>  
>  if (!psmouse->protocol->smbus_companion) {

This patch will slow down enumeration and initalization of *all* PS/2 mouses.

I guess if there are some problematic machines, it could be hooked...

-- 
Pali Rohár
pali.rohar@gmail.com
