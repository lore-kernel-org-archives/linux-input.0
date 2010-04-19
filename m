From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH] Add HID_QUIRK_HIDDEV_FORCE and HID_QUIRK_NO_IGNORE
Date: Mon, 19 Apr 2010 13:14:17 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1004191313590.7579@pobox.suse.cz>
References: <1271434790.2045.4.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:45228 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754533Ab0DSLOS (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 19 Apr 2010 07:14:18 -0400
In-Reply-To: <1271434790.2045.4.camel@localhost.localdomain>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Bastien Nocera <hadess@hadess.net>
Cc: linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>

On Fri, 16 Apr 2010, Bastien Nocera wrote:

> Add two quirks to make it possible for usbhid module options to
> override whether a device is ignored (HID_QUIRK_NO_IGNORE) and
> whether to connect a hiddev device (HID_QUIRK_HIDDEV_FORCE).
> 
> Passing HID_QUIRK_NO_IGNORE for your device means that it will
> not be ignored by the HID layer, even if present in a blacklist.
> 
> HID_QUIRK_HIDDEV_FORCE will force the creation of a hiddev for that
> device, making it accessible from user-space.
> 
> Tested with an Apple IR Receiver, switching it from using appleir
> to using lirc's macmini driver.

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs, Novell Inc.
