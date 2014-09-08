From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH 0/2] HID: usbhid: fix Elan touchscreen disconnects
Date: Mon, 8 Sep 2014 09:30:33 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1409080929270.5523@pobox.suse.cz>
References: <alpine.LNX.2.00.1408211337050.23162@pobox.suse.cz> <1409933328-7190-1-git-send-email-johan@kernel.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:49708 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751404AbaIHHah (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 8 Sep 2014 03:30:37 -0400
In-Reply-To: <1409933328-7190-1-git-send-email-johan@kernel.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Johan Hovold <johan@kernel.org>
Cc: Greg KH <gregkh@linuxfoundation.org>, Alan Stern <stern@rowland.harvard.edu>, =?ISO-8859-15?Q?Bj=F8rn_Mork?= <bjorn@mork.no>, Sarah Sharp <sarah.a.sharp@linux.intel.com>, Drew Von Spreecken <drewvs@gmail.com>, Mathias Nyman <mathias.nyman@intel.com>, linux-usb@vger.kernel.org, linux-input@vger.kernel.org, Oliver Neukum <oneukum@suse.de>

On Fri, 5 Sep 2014, Johan Hovold wrote:

> Here's the always-poll quirk that is needed to prevent the Elan
> touchscreen from disconnecting itself from the bus.
> 
> These patches are against v3.16.1, but applies fine to hid-next.
> 
> Note that this series is not dependent on the device-qualifier quirk
> [1], which is needed to get the same device to enumerate reliably, so
> these two quirks could in through the USB and HID tree, respectively.

Thanks for respinning this patchset. I have queued it for 3.18.

Oliver, could you please send me your patch for 0x093a / 0x2510 so that I 
could apply it on top of this?

Thanks,

-- 
Jiri Kosina
SUSE Labs
