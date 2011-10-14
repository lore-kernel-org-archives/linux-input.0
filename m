From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH] hid: flesh out support for tivo slide remote
Date: Fri, 14 Oct 2011 19:43:34 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1110141942290.14768@pobox.suse.cz>
References: <1306259656-11391-1-git-send-email-jarod@redhat.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:50178 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750789Ab1JNRng (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 14 Oct 2011 13:43:36 -0400
In-Reply-To: <1306259656-11391-1-git-send-email-jarod@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jarod Wilson <jarod@redhat.com>
Cc: linux-input@vger.kernel.org

On Tue, 24 May 2011, Jarod Wilson wrote:

> This patch finishes off adding full support for the TiVo Slide remote,
> which is a mostly pure HID device from the perspective of the kernel.
> There are a few mappings that use a vendor-specific usage page, and a
> few keys in the consumer usage page that I think make sense to remap
> slightly, to better fit their key labels' intended use. Doing this in a
> stand-alone hid-tivo.c makes the modifications only matter for this
> specific device.
> 
> What's actually connected to the computer is a Broadcom-made usb dongle,
> which has an embedded hub, bluetooth adapter, mouse and keyboard
> devices. You pair with the dongle, then the remote sends data that its
> converted into HID on the keyboard interface (the mouse interface
> doesn't do anything interesting, so far as I can tell).
> 
> lsusb for this device:
> Bus 004 Device 005: ID 0a5c:2190 Broadcom Corp.
> Bus 004 Device 004: ID 0a5c:4503 Broadcom Corp.
> Bus 004 Device 003: ID 150a:1201
> Bus 004 Device 002: ID 0a5c:4500 Broadcom Corp. BCM2046B1 USB 2.0 Hub (part of BCM2046 Bluetooth)
> 
> Speaking of the keyboard interface, the remote actually does contain a
> keyboard as well. The top slides away, revealing a reasonably functional
> qwerty keyboard (not unlike many slide cell phones), thus the product
> name.
> 
> Applies cleanly to hid master, tested w/a 2.6.38.3-based Fedora kernel
> and a 2.6.32-based Red Hat Enterprise Linux 6 kernel.
> 
> CC: Jiri Kosina <jkosina@suse.cz>
> Signed-off-by: Jarod Wilson <jarod@redhat.com>
> ---
>  drivers/hid/Kconfig    |    6 +++
>  drivers/hid/Makefile   |    1 +
>  drivers/hid/hid-ids.h  |    3 ++
>  drivers/hid/hid-tivo.c |   89 ++++++++++++++++++++++++++++++++++++++++++++++++

The patch doesn't add the entry to hid_have_special_driver[] and thus the 
driver will not be automatically bound to the device. Could you please fix 
that up?

Thanks,

-- 
Jiri Kosina
SUSE Labs
