From: "Henrik Rydberg" <rydberg@euromail.se>
Subject: Re: [PATCH 3.0-rc1] Input: omap-keypad: add missing input_sync()
Date: Sat, 4 Jun 2011 14:35:30 +0200
Message-ID: <20110604123530.GA1530@polaris.bitmath.org>
References: <201106032226.44976.jkrzyszt@tis.icnet.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtprelay-b22.telenor.se ([195.54.99.213]:46875 "EHLO
	smtprelay-b22.telenor.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755047Ab1FDM3T (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sat, 4 Jun 2011 08:29:19 -0400
Received: from ipb3.telenor.se (ipb3.telenor.se [195.54.127.166])
	by smtprelay-b22.telenor.se (Postfix) with ESMTP id 1392FE9C19
	for <linux-input@vger.kernel.org>; Sat,  4 Jun 2011 14:29:17 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <201106032226.44976.jkrzyszt@tis.icnet.pl>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Cc: linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>

Hi Janusz,

> Otherwise the updated evdev driver (commit 
> cdda911c34006f1089f3c87b1a1f31ab3a4722f2, "Input: evdev - only signal 
> polls on full packets") no longer works on top of omap-keypad.
> 
> Tested on Amstrad Delta.
> 
> Signed-off-by: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
> ---
>  drivers/input/keyboard/omap-keypad.c |    4 ++++
>  1 file changed, 4 insertions(+)
> 
> --- git/drivers/input/keyboard/omap-keypad.c.orig	2011-05-30 22:16:50.000000000 +0200
> +++ git/drivers/input/keyboard/omap-keypad.c	2011-06-03 22:22:18.000000000 +0200
> @@ -169,6 +169,7 @@ static void omap_kp_tasklet(unsigned lon
>  	unsigned char new_state[8], changed, key_down = 0;
>  	int col, row;
>  	int spurious = 0;
> +	bool need_sync = false;

No need for a special variable here - the input core already does the same thing.

>  
>  	/* check for any changes */
>  	omap_kp_scan_keypad(omap_kp_data, new_state);
> @@ -206,9 +207,12 @@ static void omap_kp_tasklet(unsigned lon
>  			kp_cur_group = key & GROUP_MASK;
>  			input_report_key(omap_kp_data->input, key & ~GROUP_MASK,
>  					 new_state[col] & (1 << row));
> +			need_sync = true;
>  #endif
>  		}
>  	}
> +	if (need_sync)
> +		input_sync(omap_kp_data->input);
>  	memcpy(keypad_state, new_state, sizeof(keypad_state));
>  
>  	if (key_down) {
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

Thanks,
Henrik
