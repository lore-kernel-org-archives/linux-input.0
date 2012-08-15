From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH 1/2] input: usb: hid: Bump maximum global item tag report
 size to 128 bytes
Date: Wed, 15 Aug 2012 10:33:18 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1208151032340.7026@pobox.suse.cz>
References: <1344203835-8308-1-git-send-email-marex@denx.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:33547 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752138Ab2HOId0 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 15 Aug 2012 04:33:26 -0400
In-Reply-To: <1344203835-8308-1-git-send-email-marex@denx.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Marek Vasut <marex@denx.de>
Cc: linux-input@vger.kernel.org, linux-usb@vger.kernel.org, Chen Peter <B29397@freescale.com>, Greg KH <greg@kroah.com>

On Sun, 5 Aug 2012, Marek Vasut wrote:

> The Freescale i.MX28 BootROM USB recovery mode implements the USB HID
> protocol, yet the global item tag report size is 128. Linux checks if
> this is 96 as of now, see [1]. This causes Linux to refuse to communicate
> with this device, making it impossible to use the recovery mode.
> 
> This is not a standard HID device per se, but rather a software emulation
> implemented within the BootROM code and realized through USB OTG-capable
> port switched to device mode present on the device.
> 
> Previous attempt to discuss this issue dates back to 2011, see [2]. There
> has been not much response. Also noteworthy is the [3], where there seems
> to be a pointing device that has issue similar to this one.
> 
> The tool making use of the USB recovery mode is available at [4].
> 
> [1] http://comments.gmane.org/gmane.linux.kernel.input/22328
> [2] http://www.spinics.net/lists/linux-usb/msg43463.html
> [3] https://bbs.archlinux.org/viewtopic.php?pid=1141340
> [4] http://git.bfuser.eu/?p=marex/mxsldr.git;a=summary
> 
> Signed-off-by: Marek Vasut <marex@denx.de>
> Cc: Chen Peter <B29397@freescale.com>
> Cc: Greg KH <greg@kroah.com>
> Cc: Jiri Kosina <jkosina@suse.cz>

I have not admit I don't remember where the original limit came from -- 
the spec doesn't mandate it as far as I can tell.

I am queueing this patch now for next merge window. Thanks.

> ---
>  drivers/hid/hid-core.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
> index 60ea284..2b9dd76 100644
> --- a/drivers/hid/hid-core.c
> +++ b/drivers/hid/hid-core.c
> @@ -374,7 +374,7 @@ static int hid_parser_global(struct hid_parser *parser, struct hid_item *item)
>  
>  	case HID_GLOBAL_ITEM_TAG_REPORT_SIZE:
>  		parser->global.report_size = item_udata(item);
> -		if (parser->global.report_size > 96) {
> +		if (parser->global.report_size > 128) {
>  			hid_err(parser->device, "invalid report_size %d\n",
>  					parser->global.report_size);
>  			return -1;
> -- 
> 1.7.10.4
> 

-- 
Jiri Kosina
SUSE Labs
