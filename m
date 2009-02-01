From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH] blacklist Powercom USB UPS in hid
Date: Sun, 1 Feb 2009 16:13:42 +0100 (CET)
Message-ID: <alpine.LRH.1.10.0902011611480.22097@twin.jikos.cz>
References: <1233398239.117942.6436.nullmailer@msgid.corpit.ru>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from twin.jikos.cz ([213.151.79.26]:46967 "EHLO twin.jikos.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751710AbZBAPNs (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sun, 1 Feb 2009 10:13:48 -0500
In-Reply-To: <1233398239.117942.6436.nullmailer@msgid.corpit.ru>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: Linux INPUT list <linux-input@vger.kernel.org>

On Sat, 31 Jan 2009, Michael Tokarev wrote:

> This is my second attempt to fix the thing. Now completely tested and 
> appears to work as expected, finally (I hope anyway).

General remark -- when submitting patches for certain kernel subsystem, 
it's always good idead to CC the corresponding maitainer, to avoid having 
the patches lost.

> +/* Powercom UPS which is not HID but Serial<=>USB converter (cypress_m8 module) */
> +#define USB_VENDOR_ID_POWERCOM		0x0d9f
> +#define USB_DEVICE_ID_POWERCOM_UPS	0x0002
> +

I have removed this comment, as we don't have it for any other entries in 
that file either. The changelog should be always enought to provide the 
information for those curious.

Applied, thanks Michael.

-- 
Jiri Kosina
SUSE Labs

