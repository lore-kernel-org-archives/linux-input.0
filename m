From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH] HID: add driver for Roccat Kone gaming mouse 2nd
 Attempt
Date: Mon, 22 Mar 2010 09:41:20 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1003220936270.18642@pobox.suse.cz>
References: <1268926981.11269.3.camel@localhost>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:43355 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752840Ab0CVIlW (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 22 Mar 2010 04:41:22 -0400
In-Reply-To: <1268926981.11269.3.camel@localhost>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Stefan Achatz <erazor_de@users.sourceforge.net>
Cc: Randy Dunlap <rdunlap@xenotime.net>, Stephane Chatty <chatty@enac.fr>, Jussi Kivilinna <jussi.kivilinna@mbnet.fi>, wylda@volny.cz, Michael Poole <mdpoole@troilus.org>, simon.windows@gmail.com, Sean Hildebrand <silverwraithii@gmail.com>, Sid Boyce <sboyce@blueyonder.co.uk>, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-input@vger.kernel.org

On Thu, 18 Mar 2010, Stefan Achatz wrote:

> --- a/drivers/hid/hid-ids.h
> +++ b/drivers/hid/hid-ids.h
> @@ -399,6 +399,9 @@
>  #define USB_VENDOR_ID_PRODIGE		0x05af
>  #define USB_DEVICE_ID_PRODIGE_CORDLESS	0x3062
>  
> +#define USB_VENDOR_ID_ROCCAT		0x1e7d
> +#define USB_DEVICE_ID_ROCCAT_KONE	0x2ced
> +

Hi Stefan,

I guess you also need hid_blacklist[] entry for these device IDs, so that 
generic HID driver doesn't grab the device before your driver gets to it, 
right?

> +static struct hid_driver kone_driver = { .name = "kone",
> +		.id_table = kone_devices, .probe = kone_probe,
> +		.remove = kone_remove, .raw_event = kone_raw_event, };

Could you please put each filed that is being initialized on a separate 
line?

Other than that, the patch looks quite fine to me.

Thanks,

-- 
Jiri Kosina
SUSE Labs, Novell Inc.
