From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH] HID: wiimote: Fix IR data parser
Date: Wed, 9 May 2012 11:41:12 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1205091141020.26736@pobox.suse.cz>
References: <1336488751-4809-1-git-send-email-dh.herrmann@googlemail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:54455 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752457Ab2EIJlP (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 9 May 2012 05:41:15 -0400
In-Reply-To: <1336488751-4809-1-git-send-email-dh.herrmann@googlemail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: David Herrmann <dh.herrmann@googlemail.com>
Cc: linux-input@vger.kernel.org, bukovsky.peter@gmail.com, stable@kernel.org

On Tue, 8 May 2012, David Herrmann wrote:

> We incorrectly parse incoming IR data. The extra byte contains the upper
> bits and not the lower bits of the x/y coordinates. User-space expects
> absolute position data from us so this patch does not break existing
> applications. On the contrary, it extends the virtual view and fixes
> garbage reports for margin areas of the virtual screen.
> 
> Cc: stable@kernel.org
> Reported-by: Peter Bukovsky <bukovsky.peter@gmail.com>
> Signed-off-by: David Herrmann <dh.herrmann@googlemail.com>
> ---
>  drivers/hid/hid-wiimote-core.c |   16 +++++-----------
>  1 file changed, 5 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/hid/hid-wiimote-core.c b/drivers/hid/hid-wiimote-core.c
> index cac3589..84e2fbe 100644
> --- a/drivers/hid/hid-wiimote-core.c
> +++ b/drivers/hid/hid-wiimote-core.c
> @@ -769,7 +769,7 @@ static void __ir_to_input(struct wiimote_data *wdata, const __u8 *ir,
>  
>  	/*
>  	 * Basic IR data is encoded into 3 bytes. The first two bytes are the
> -	 * upper 8 bit of the X/Y data, the 3rd byte contains the lower 2 bits
> +	 * lower 8 bit of the X/Y data, the 3rd byte contains the upper 2 bits
>  	 * of both.
>  	 * If data is packed, then the 3rd byte is put first and slightly
>  	 * reordered. This allows to interleave packed and non-packed data to
> @@ -778,17 +778,11 @@ static void __ir_to_input(struct wiimote_data *wdata, const __u8 *ir,
>  	 */
>  
>  	if (packed) {
> -		x = ir[1] << 2;
> -		y = ir[2] << 2;
> -
> -		x |= ir[0] & 0x3;
> -		y |= (ir[0] >> 2) & 0x3;
> +		x = ir[1] | ((ir[0] & 0x03) << 8);
> +		y = ir[2] | ((ir[0] & 0x0c) << 6);
>  	} else {
> -		x = ir[0] << 2;
> -		y = ir[1] << 2;
> -
> -		x |= (ir[2] >> 4) & 0x3;
> -		y |= (ir[2] >> 6) & 0x3;
> +		x = ir[0] | ((ir[2] & 0x30) << 4);
> +		y = ir[1] | ((ir[2] & 0xc0) << 2);

Applied, thanks David.

-- 
Jiri Kosina
SUSE Labs
