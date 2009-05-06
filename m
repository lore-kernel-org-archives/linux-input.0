From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH] HID: Fix dropped device-specific quirks
Date: Wed, 6 May 2009 16:35:18 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.0905061634170.22532@wotan.suse.de>
References: <49FF1E93.7010704@freemail.hu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:49847 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752355AbZEFOfV (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 6 May 2009 10:35:21 -0400
In-Reply-To: <49FF1E93.7010704@freemail.hu>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Zoltan Karcagi <zkr@freemail.hu>
Cc: linux-input@vger.kernel.org

On Mon, 4 May 2009, Zoltan Karcagi wrote:

> Device-specific quirks are set up correctly in their respective 
> vendor-specific driver, then get overwritten in usbhid_parse(). Found on 
> a Microsoft Wireless Optical Desktop 3.0 [045e:009d].

Good catch, thanks. Fortunately this affects only a few devices out there, 
for which specialized drivers set hdrv->quirks specifically (mostly NOGET 
quirk only).

> Signed-off-by: Zoltan Karcagi <zkr@freemail.hu>
> 
> diff -r -U 5 linux-2.6.30-rc4/drivers/hid/usbhid/hid-core.c
> linux-2.6.30-rc4-fixed/drivers/hid/usbhid/hid-core.c
> --- linux-2.6.30-rc4/drivers/hid/usbhid/hid-core.c    2009-05-01
> 12:06:18.000000000 +0200
> +++ linux-2.6.30-rc4-fixed/drivers/hid/usbhid/hid-core.c    2009-05-03
> 14:43:47.000000000 +0200
> @@ -896,11 +896,11 @@
> if (ret) {
>     dbg_hid("parsing report descriptor failed\n");
>     goto err;
> }
> 
> -    hid->quirks = quirks;
> +    hid->quirks |= quirks;
> 
> return 0;
> err:
> return ret;
> }

The patch has been whitespace damaged, please fix this for your further 
submissions.

I have fixed it manually and applied.

Thanks,

-- 
Jiri Kosina
SUSE Labs
