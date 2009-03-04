From: Arjan Opmeer <arjan@opmeer.net>
Subject: Re: [patch 19/22] input: elantech touchpad driver miss-recognising
	logitech mice
Date: Wed, 4 Mar 2009 21:24:35 +0100
Message-ID: <20090304202435.GA16259@adopmeer.homeip.net>
References: <200903041959.n24Jx9cY028481@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp-out0.tiscali.nl ([195.241.79.175]:60216 "EHLO
	smtp-out0.tiscali.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756107AbZCDUlh (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 4 Mar 2009 15:41:37 -0500
Content-Disposition: inline
In-Reply-To: <200903041959.n24Jx9cY028481@imap1.linux-foundation.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: akpm@linux-foundation.org
Cc: dtor@mail.ru, linux-input@vger.kernel.org, apw@shadowen.org


On Wed, Mar 04, 2009 at 11:59:09AM -0800, akpm@linux-foundation.org wrote:
> From: Arjan Opmeer <arjan@opmeer.net>
> 
> Some Logitech mice react to the magic knock like an Elantech touchpad
> would. This leads to those mice being misdetected as Elantech touchpads.
> Add a version query to elantech_detect() to distinguish the two.

Andrew, I am confused. To what should this patch apply? Notice the version
query result debug print that gets removed and added. The test for a real
touchpad that now exists twice.

> Signed-off-by: Arjan Opmeer <arjan@opmeer.net>
> Cc: Andy Whitcroft <apw@shadowen.org>
> Cc: Dmitry Torokhov <dtor@mail.ru>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> ---
> 
>  drivers/input/mouse/elantech.c |   19 ++++++++++++++++---
>  1 file changed, 16 insertions(+), 3 deletions(-)
> 
> diff -puN drivers/input/mouse/elantech.c~input-elantech-touchpad-driver-miss-recognising-logitech-mice drivers/input/mouse/elantech.c
> --- a/drivers/input/mouse/elantech.c~input-elantech-touchpad-driver-miss-recognising-logitech-mice
> +++ a/drivers/input/mouse/elantech.c
> @@ -567,14 +567,27 @@ int elantech_detect(struct psmouse *psmo
>  		return -1;
>  	}
>  
> -	pr_debug("elantech.c: Elantech version query result 0x%02x, 0x%02x, 0x%02x.\n",
> -		 param[0], param[1], param[2]);
> -
>  	if (param[0] == 0 || param[1] != 0) {
>  		pr_debug("elantech.c: Probably not a real Elantech touchpad. Aborting.\n");
>  		return -1;
>  	}
>  
> +	/*
> +	 * There are Logitech mice that react to the magic knock exactly
> +	 * like an Elantech touchpad would, so do a version query here to
> +	 * try to distinguish the two
> +	 */
> +	if (synaptics_send_cmd(psmouse, ETP_FW_VERSION_QUERY, param)) {
> +		pr_err("elantech.c: failed to query firmware version.\n");
> +		return -1;
> +	}
> +	pr_info("elantech.c: Elantech version query result 0x%02x, 0x%02x, 0x%02x.\n",
> +		param[0], param[1], param[2]);
> +	if (param[0] == 0 || param[1] != 0) {
> +		pr_info("elantech.c: Probably not a real Elantech touchpad. Aborting.\n");
> +		return -1;
> +	}
> +
>  	if (set_properties) {
>  		psmouse->vendor = "Elantech";
>  		psmouse->name = "Touchpad";
> _
