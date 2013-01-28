From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH 4/4] USB: HID: SRW-S1 Add support controlling all LEDs
 simultaneously
Date: Mon, 28 Jan 2013 16:02:10 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1301281601370.23853@pobox.suse.cz>
References: <1359095687-13398-1-git-send-email-simon@mungewell.org> <1359095687-13398-4-git-send-email-simon@mungewell.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:39979 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750751Ab3A1PCR (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 28 Jan 2013 10:02:17 -0500
In-Reply-To: <1359095687-13398-4-git-send-email-simon@mungewell.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Simon Wood <simon@mungewell.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, rosegardener@freeode.co.uk

On Thu, 24 Jan 2013, Simon Wood wrote:

> From: simon <simon@simon-virtual-machine.(none)>
> 
> This patch to the SRW-S1 driver adds the ability to control all
> LEDs simultaneously as testing showed that it was slow (noticably!!)
> when seting or clearing all the LEDs in turn.
> 
> It adds a 'RPMALL' LED, whose behavoir is asserted to all the LEDs in
> the bar graph, individual LEDs can subsequently be turned on/off
> individually.
> 
> Signed-off-by: Simon Wood <simon@mungewell.org>
> tested-by: John Murphy <rosegardener@freeode.co.uk>
[ ... snip ... ]

> @@ -219,13 +255,34 @@ static int srws1_probe(struct hid_device *hdev,
>  
>  	/* register led subsystem */
>  	drv_data->led_state = 0;
> -	for (i = 0; i < SRWS1_NUMBER_LEDS; i++)
> +	for (i = 0; i < SRWS1_NUMBER_LEDS + 1; i++)
>  		drv_data->led[i] = NULL;
>  
>  	srws1_set_leds(hdev, 0);
>  
> -	name_sz = strlen(hdev->uniq) + 15;
> +	name_sz = strlen(hdev->uniq) + 16;
> +
> +	/* 'ALL', for setting all LEDs simultaneously */
> +	led = kzalloc(sizeof(struct led_classdev)+name_sz, GFP_KERNEL);

Is this memory ever freed?

-- 
Jiri Kosina
SUSE Labs
