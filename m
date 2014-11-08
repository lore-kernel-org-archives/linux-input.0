From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 3/5] Input: elantech - report the middle button of the
 touchpad
Date: Sat, 8 Nov 2014 00:23:57 -0800
Message-ID: <20141108082357.GC21475@dtor-ws>
References: <1409407846-15449-1-git-send-email-ulrik.debie-os@e2big.org>
 <1409407846-15449-4-git-send-email-ulrik.debie-os@e2big.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ig0-f169.google.com ([209.85.213.169]:58269 "EHLO
	mail-ig0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753359AbaKHIYC (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sat, 8 Nov 2014 03:24:02 -0500
Received: by mail-ig0-f169.google.com with SMTP id hn18so13296614igb.4
        for <linux-input@vger.kernel.org>; Sat, 08 Nov 2014 00:24:01 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1409407846-15449-4-git-send-email-ulrik.debie-os@e2big.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ulrik De Bie <ulrik.debie-os@e2big.org>
Cc: linux-input@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>, David Herrmann <dh.herrmann@gmail.com>

On Sat, Aug 30, 2014 at 04:10:44PM +0200, Ulrik De Bie wrote:
> In the past, no elantech was known with 3 touchpad mouse buttons.
> Fujitsu H730 is the first known elantech with a middle button. This commit
> enables this middle button.
> 
> Reported-by: Stefan Valouch <stefan@valouch.com>
> Tested-by: Stefan Valouch <stefan@valouch.com>
> Tested-by: Alfredo Gemma <alfredo.gemma@gmail.com>
> Signed-off-by: Ulrik De Bie <ulrik.debie-os@e2big.org>
> ---
>  drivers/input/mouse/elantech.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/input/mouse/elantech.c b/drivers/input/mouse/elantech.c
> index 67d56c0..e86bbd7 100644
> --- a/drivers/input/mouse/elantech.c
> +++ b/drivers/input/mouse/elantech.c
> @@ -563,6 +563,7 @@ static void elantech_input_sync_v4(struct psmouse *psmouse)
>  	} else {
>  		input_report_key(dev, BTN_LEFT, packet[0] & 0x01);
>  		input_report_key(dev, BTN_RIGHT, packet[0] & 0x02);
> +		input_report_key(dev, BTN_MIDDLE, packet[0] & 0x04);
>  	}
>  
>  	input_mt_report_pointer_emulation(dev, true);
> @@ -1150,6 +1151,7 @@ static int elantech_set_input_params(struct psmouse *psmouse)
>  	__clear_bit(EV_REL, dev->evbit);
>  
>  	__set_bit(BTN_LEFT, dev->keybit);
> +	__set_bit(BTN_MIDDLE, dev->keybit);

No, we should not advertise presence of middle button unconditionally. I
guess we need another DMI, at least for now.

>  	__set_bit(BTN_RIGHT, dev->keybit);
>  
>  	__set_bit(BTN_TOUCH, dev->keybit);
> -- 
> 2.1.0
> 

Thanks.

-- 
Dmitry
