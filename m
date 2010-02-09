From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH] Fixed bug in single-touch emulation on the Stantum
 panel
Date: Tue, 9 Feb 2010 11:27:01 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1002091125490.30967@pobox.suse.cz>
References: <20100206141912.71BA89520A@smtp.lii-enac.fr>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:41060 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751911Ab0BIK1C (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 9 Feb 2010 05:27:02 -0500
In-Reply-To: <20100206141912.71BA89520A@smtp.lii-enac.fr>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Stephane Chatty <chatty@lii-enac.fr>
Cc: linux-input@vger.kernel.org, chatty@enac.fr

On Sat, 6 Feb 2010, Stephane Chatty wrote:

> Fixed bug in touchscreen emulation for the Stantum multitouch panel

Hi Stephane,

could you please perhaps provide a little bit more detailed information 
about the nature of the bug this is fixing? It might be useful for people 
looking through changelog.

> Signed-off-by: Stephane Chatty <chatty@enac.fr>
> 
> diff -rupN a/drivers/hid/hid-stantum.c b/drivers/hid/hid-stantum.c
> --- a/drivers/hid/hid-stantum.c	2010-02-06 14:59:57.000000000 +0100
> +++ b/drivers/hid/hid-stantum.c	2010-02-06 15:00:36.000000000 +0100
> @@ -16,7 +16,7 @@
>  #include <linux/hid.h>
>  #include <linux/module.h>
>  
> -MODULE_VERSION("1.00");
> +MODULE_VERSION("1.01");

Are you planning to maintain this numbering, btw? Usually people forget to 
update it :)

>  MODULE_AUTHOR("Stephane Chatty <chatty@enac.fr>");
>  MODULE_DESCRIPTION("Stantum HID multitouch panels");
>  MODULE_LICENSE("GPL");
> @@ -147,7 +147,6 @@ static void stantum_filter_event(struct 
>  
>  	input_mt_sync(input);
>  	sd->valid = false;
> -	sd->first = false;
>  
>  	/* touchscreen emulation */
>  	if (sd->first) {
> @@ -158,6 +157,7 @@ static void stantum_filter_event(struct 
>  		input_event(input, EV_ABS, ABS_X, sd->x);
>  		input_event(input, EV_ABS, ABS_Y, sd->y);
>  	}
> +	sd->first = false;
>  }
>  

Thanks,

-- 
Jiri Kosina
SUSE Labs, Novell Inc.
