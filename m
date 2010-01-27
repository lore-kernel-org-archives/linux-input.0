From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH] Input: add appleir USB driver
Date: Wed, 27 Jan 2010 16:40:03 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1001271631460.30977@pobox.suse.cz>
References: <1263997077.1735.2942.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:37025 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755115Ab0A0PkF (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 27 Jan 2010 10:40:05 -0500
In-Reply-To: <1263997077.1735.2942.camel@localhost.localdomain>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Bastien Nocera <hadess@hadess.net>
Cc: linux-input <linux-input@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>

On Wed, 20 Jan 2010, Bastien Nocera wrote:

> +First, you will need to disable the kernel driver for the receiver.
> +
> +This can be achieved by passing quirks to the usbhid driver.
> +The quirk line would be:
> +usbhid.quirks=0x05ac:0x8242:0x08
> +
> +With 0x05ac being the vendor ID (Apple, you shouldn't need to change this)
> +With 0x8242 being the product ID (check the output of lsusb for your hardware)
> +And 0x08 being "HID_CONNECT_HIDDEV"

I am afraid this is not true, 0x08 is HID_QUIRK_NOGET.

We currently don't have dynamic quirk for forcing HIDDEV creation from the 
module parameter.

> +	if (!memcmp(data, keydown, sizeof(keydown))) {
> +		/*If we already have a key down, take it up before marking */
> +		/*this one down */
> +		if (appleir->current_key)
> +			key_up(appleir, appleir->current_key);
> +		appleir->current_key = keymap[(data[4] >> 1) & MAX_KEYS_MASK];
> +
> +		key_down(appleir, appleir->current_key);
> +		/*remote doesn't do key up, either pull them up, in the test */
> +		/*above, or here set a timer which pulls them up after 1/8 s */

Could you please place spaces after the comment starters?

Thanks,

-- 
Jiri Kosina
SUSE Labs, Novell Inc.
