From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: HID bus
Date: Wed, 16 Apr 2008 15:31:35 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0804161529270.12972@jikos.suse.cz>
References: <1207341357-17792-1-git-send-email-jirislaby@gmail.com>
 <1207341357-17792-8-git-send-email-jirislaby@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from styx.suse.cz ([82.119.242.94]:38957 "EHLO mail.suse.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750937AbYDPNbg (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 16 Apr 2008 09:31:36 -0400
In-Reply-To: <1207341357-17792-8-git-send-email-jirislaby@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Slaby <jirislaby@gmail.com>
Cc: linux-input@vger.kernel.org, marcel@holtmann.org, dmitry.torokhov@gmail.com, Jiri Slaby <jslaby@suse.cz>

On Fri, 4 Apr 2008, Jiri Slaby wrote:

> +menu "Special HID drivers"
> +	depends on HID
> +
> +config HID_LOGITECH
> +	tristate "Logitech"
> +	depends on USB_HID
> +	---help---
> +	Support for some Logitech devices which breaks less or more
> +	HID specification.

Hi Jiri,

I think that we want to make this default to y if USB_HID is selected, 
right?

>  
> +config HID_APPLE
> +	tristate "Apple"
> +	depends on (USB_HID || BT_HIDP)
> +	---help---
> +	Support for some Apple devices which less or more break
> +	HID specification.
> +

and the same here.

Otherwise default kernel configuration might make the hardware that worked 
properly in previous versions not to work with new kernel.

Thanks,

-- 
Jiri Kosina
