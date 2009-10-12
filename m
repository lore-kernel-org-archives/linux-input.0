From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: HID device names
Date: Mon, 12 Oct 2009 16:01:08 +0200 (CEST)
Message-ID: <alpine.LSU.2.00.0910121550370.19284@wotan.suse.de>
References: <20091012150229.78d8df88@hyperion.delvare>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:50203 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932155AbZJLOBp (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 12 Oct 2009 10:01:45 -0400
In-Reply-To: <20091012150229.78d8df88@hyperion.delvare>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jean Delvare <khali@linux-fr.org>, Jiri Slaby <jirislaby@gmail.com>
Cc: linux-input@vger.kernel.org


[ adding Jiri Slaby, who actually implemented HID bus ]

On Mon, 12 Oct 2009, Jean Delvare wrote:

> Looking at hid-core.c, I see the following:
> 
> 	dev_set_name(&hdev->dev, "%04X:%04X:%04X.%04X", hdev->bus,
> 	             hdev->vendor, hdev->product, atomic_inc_return(&id));
> 
> This looks plain wrong to me. The vendor and product IDs can be
> attributes of the devices, but they should not be part of the device
> name aka bus_id. The bus_id is about the address of the device, not
> what the device is. 

Hi Jean,

yeah, I am aware of this. 

The problem is, that the HID bus is designed to be used by devices that 
can be physically completely different from each other (currently we use 
it for Bluetooth and USB, and it is likely that there will be more 
low-level transports protocols appearing later, which will use HID as the 
on-wire protocol). This means that it might not be possible to find 
"unified addressing scheme".

> Just look at how the PCI or USB subsystems do, or virtually any other 
> kernel subsystem, as I don't think any other subsystem does what HID is 
> doing right now.

You have chosen examples which have relatively good 1:1 mapping to the 
physical, low-level devices that are uniquely addressed.

But there are examples also of very similar approach to what we have in 
HID -- look at for example how 'serio' bus does this (serio_init_port()). 
What we have there is exactly what we do in HID core (including the 
atomic_t counter), even omitting vendor/product ID.

> On top of this, using an auto-incrementing device ID in the bus_id looks 
> wrong too. For one thing, it will cycle after 65536 requests, so the 
> above does not guarantee uniqueness over time. If anything, you should 
> used an idr instead. 

Sorry, I don't get this. Why should it overflow after 65536 requests? It 
overflows as soon as atomic_t overflows on given architecture, doesn't it?

> But even that would probably be wrong, because this scheme itself 
> doesn't guarantee stability of the bus_id over disconnect/reconnect, 
> reboot, etc. While I agree it's not always possible to guarantee 
> stability especially for externally pluggable devices, we should try to 
> keep names as stable as we can.

Do you have any real problem/breakage caused by this, that needs to be 
fixed? Or is it this is against your feeling and perception of how things 
should be done?

Thanks,

-- 
Jiri Kosina
SUSE Labs, Novell Inc.
