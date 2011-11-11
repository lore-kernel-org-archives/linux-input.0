From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH] HID: hid-lg4ff: Casting (void *) value returned by
 kmalloc is useless
Date: Fri, 11 Nov 2011 15:10:07 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1111111509580.3923@pobox.suse.cz>
References: <1320779660.8062.141.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:57980 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751352Ab1KKOKI (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 11 Nov 2011 09:10:08 -0500
In-Reply-To: <1320779660.8062.141.camel@localhost.localdomain>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Thomas Meyer <thomas@m3y3r.de>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, 8 Nov 2011, Thomas Meyer wrote:

> From: Thomas Meyer <thomas@m3y3r.de>
> 
>  Casting (void *) value returned by kmalloc is useless
>  as mentioned in Documentation/CodingStyle, Chap 14.
> 
>  The semantic patch that makes this change is available
>  in scripts/coccinelle/api/alloc/drop_kmalloc_cast.cocci.
> 
>  More information about semantic patching is available at
>  http://coccinelle.lip6.fr/
> 
> Signed-off-by: Thomas Meyer <thomas@m3y3r.de>
> ---
> 
> diff -u -p a/drivers/hid/hid-lg4ff.c b/drivers/hid/hid-lg4ff.c
> --- a/drivers/hid/hid-lg4ff.c 2011-11-07 19:37:44.816570939 +0100
> +++ b/drivers/hid/hid-lg4ff.c 2011-11-08 09:03:29.394045138 +0100
> @@ -430,7 +430,7 @@ int lg4ff_init(struct hid_device *hid)
>  	}
>  
>  	/* Add the device to device_list */
> -	entry = (struct lg4ff_device_entry *)kzalloc(sizeof(struct lg4ff_device_entry), GFP_KERNEL);
> +	entry = kzalloc(sizeof(struct lg4ff_device_entry), GFP_KERNEL);
>  	if (!entry) {
>  		hid_err(hid, "Cannot add device, insufficient memory.\n");
>  		return -ENOMEM;

Applied, thanks Thomas.

-- 
Jiri Kosina
SUSE Labs
