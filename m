From: "Henrik Rydberg" <rydberg@euromail.se>
Subject: Re: [PATCH 3.0-rc1 v2] Input: omap-keypad: add missing input_sync()
Date: Sat, 4 Jun 2011 23:49:54 +0200
Message-ID: <20110604214954.GA3914@polaris.bitmath.org>
References: <201106032226.44976.jkrzyszt@tis.icnet.pl>
 <20110604123530.GA1530@polaris.bitmath.org>
 <201106041700.44677.jkrzyszt@tis.icnet.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtprelay-h21.telenor.se ([195.54.99.196]:43165 "EHLO
	smtprelay-h21.telenor.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752863Ab1FDVno (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sat, 4 Jun 2011 17:43:44 -0400
Received: from ipb2.telenor.se (ipb2.telenor.se [195.54.127.165])
	by smtprelay-h21.telenor.se (Postfix) with ESMTP id 0F3A3E9E95
	for <linux-input@vger.kernel.org>; Sat,  4 Jun 2011 23:43:42 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <201106041700.44677.jkrzyszt@tis.icnet.pl>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Cc: linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>

On Sat, Jun 04, 2011 at 05:00:41PM +0200, Janusz Krzysztofik wrote:
> Otherwise the updated evdev driver (commit cdda911c34006f1089f3c87b1a1f, 
> "Input: evdev - only signal polls on full packets") no longer works on 
> top of omap-keypad.
> 
> Tested on Amstrad Delta.
> 
> Signed-off-by: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
> ---
> v1 -> v2 change, suggested by Henrik Rydberg (thanks!):
> - no need for a special variable tracing if input_sync is required - 
>   the input core already does the same thing.
> 
>  drivers/input/keyboard/omap-keypad.c |    1 +
>  1 file changed, 1 insertion(+)
> 
> --- git/drivers/input/keyboard/omap-keypad.c.orig	2011-06-04 16:18:37.000000000 +0200
> +++ git/drivers/input/keyboard/omap-keypad.c	2011-06-04 16:46:23.000000000 +0200
> @@ -209,6 +209,7 @@ static void omap_kp_tasklet(unsigned lon
>  #endif
>  		}
>  	}
> +	input_sync(omap_kp_data->input);
>  	memcpy(keypad_state, new_state, sizeof(keypad_state));
>  
>  	if (key_down) {

    Reviewed-by: Henrik Rydberg <rydberg@euromail.se>

Thanks,
Henrik
