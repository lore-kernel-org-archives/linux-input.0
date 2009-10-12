From: Jean Delvare <khali@linux-fr.org>
Subject: Re: HID device names
Date: Mon, 12 Oct 2009 16:49:10 +0200
Message-ID: <20091012164910.0c2e3999@hyperion.delvare>
References: <20091012150229.78d8df88@hyperion.delvare>
	<alpine.LSU.2.00.0910121550370.19284@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from poutre.nerim.net ([62.4.16.124]:56293 "EHLO poutre.nerim.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932363AbZJLOtu (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 12 Oct 2009 10:49:50 -0400
In-Reply-To: <alpine.LSU.2.00.0910121550370.19284@wotan.suse.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Jiri Slaby <jirislaby@gmail.com>, linux-input@vger.kernel.org

Hi Jiri(s),

On Mon, 12 Oct 2009 16:01:08 +0200 (CEST), Jiri Kosina wrote:
> 
> [ adding Jiri Slaby, who actually implemented HID bus ]
> 
> On Mon, 12 Oct 2009, Jean Delvare wrote:
> 
> > Looking at hid-core.c, I see the following:
> > 
> > 	dev_set_name(&hdev->dev, "%04X:%04X:%04X.%04X", hdev->bus,
> > 	             hdev->vendor, hdev->product, atomic_inc_return(&id));
> > 
> > This looks plain wrong to me. The vendor and product IDs can be
> > attributes of the devices, but they should not be part of the device
> > name aka bus_id. The bus_id is about the address of the device, not
> > what the device is. 
> 
> yeah, I am aware of this. 
> 
> The problem is, that the HID bus is designed to be used by devices that 
> can be physically completely different from each other (currently we use 
> it for Bluetooth and USB, and it is likely that there will be more 
> low-level transports protocols appearing later, which will use HID as the 
> on-wire protocol). This means that it might not be possible to find 
> "unified addressing scheme".
> 
> > Just look at how the PCI or USB subsystems do, or virtually any other 
> > kernel subsystem, as I don't think any other subsystem does what HID is 
> > doing right now.
> 
> You have chosen examples which have relatively good 1:1 mapping to the 
> physical, low-level devices that are uniquely addressed.
> 
> But there are examples also of very similar approach to what we have in 
> HID -- look at for example how 'serio' bus does this (serio_init_port()). 
> What we have there is exactly what we do in HID core (including the 

Right... but I'd argue that serio should be a class and not a bus, too.
The "serio%ld" name itself does look like class device names, doesn't
it?

> atomic_t counter), even omitting vendor/product ID.

Omitting vendor and product IDs make a lot of sense, as they aren't
part of the device name uniqueness. Back to the hid naming scheme, the
vendor and product IDs make the name longer with no benefit that I can
see. And as you pointed out yourself, different underlying protocols
(USB, bluetooth, etc.) will have different conventions for these IDs,
so it can even get confusing. Isn't it exactly the purpose of class
devices to abstract devices with different underlying low-level
hardware details based on their common functionality?

> > On top of this, using an auto-incrementing device ID in the bus_id looks 
> > wrong too. For one thing, it will cycle after 65536 requests, so the 
> > above does not guarantee uniqueness over time. If anything, you should 
> > used an idr instead. 
> 
> Sorry, I don't get this. Why should it overflow after 65536 requests? It 
> overflows as soon as atomic_t overflows on given architecture, doesn't it?

Forget about this, I was severely mistaken when writing this. For some
reason I thought %04x would truncate the number to 4 digits. Which it
definitely does not, and I am perfectly aware that it doesn't. That's
one of these moments when you read a random post, say "who is the idiot
who wrote this", then "oh, that would be me" ;)

> > But even that would probably be wrong, because this scheme itself 
> > doesn't guarantee stability of the bus_id over disconnect/reconnect, 
> > reboot, etc. While I agree it's not always possible to guarantee 
> > stability especially for externally pluggable devices, we should try to 
> > keep names as stable as we can.
> 
> Do you have any real problem/breakage caused by this, that needs to be 
> fixed? Or is it this is against your feeling and perception of how things 
> should be done?

Originally I looked into it because we have our first hardware
monitoring device which is a HID device, and libsensors needs to be
taught how to (uniquely) name it. So I had to look into the naming
strategy on the kernel side, and was surprised by the length and format.

As far as libsensors is concerned, I have decided to skip the vendor
and product IDs, just keeping the bus number (whatever it is) and the
incremental ID. This fits well (while it did _not_ fit with the vendor
and product IDs - we never expected to require 64 bits to uniquely
identify a device in the system.) So the problem is solved, except that
the code will break the day you change the naming in the kernel, which
is why I'd rather see it happen sooner than later if it is bound to
happen.

Other than that, yes I feel that it's wrong, but no it is not causing
too much problems to me.

Thanks,
-- 
Jean Delvare
