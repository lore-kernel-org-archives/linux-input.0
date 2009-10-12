From: Jean Delvare <khali@linux-fr.org>
Subject: HID device names
Date: Mon, 12 Oct 2009 15:02:29 +0200
Message-ID: <20091012150229.78d8df88@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from bamako.nerim.net ([62.4.17.28]:54906 "EHLO bamako.nerim.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752173AbZJLNDS (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 12 Oct 2009 09:03:18 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: linux-input@vger.kernel.org

Hi Jiri,

Looking at hid-core.c, I see the following:

	dev_set_name(&hdev->dev, "%04X:%04X:%04X.%04X", hdev->bus,
	             hdev->vendor, hdev->product, atomic_inc_return(&id));

This looks plain wrong to me. The vendor and product IDs can be
attributes of the devices, but they should not be part of the device
name aka bus_id. The bus_id is about the address of the device, not
what the device is. Just look at how the PCI or USB subsystems do, or
virtually any other kernel subsystem, as I don't think any other
subsystem does what HID is doing right now.

On top of this, using an auto-incrementing device ID in the bus_id
looks wrong too. For one thing, it will cycle after 65536 requests, so
the above does not guarantee uniqueness over time. If anything, you
should used an idr instead. But even that would probably be wrong,
because this scheme itself doesn't guarantee stability of the bus_id
over disconnect/reconnect, reboot, etc. While I agree it's not always
possible to guarantee stability especially for externally pluggable
devices, we should try to keep names as stable as we can.

The above makes me wonder if handling hid as a bus is really the right
thing to do, as apparently your devices do not have an address you can
use to generate a good-looking bus_id. Shouldn't hid devices be class
devices instead?

-- 
Jean Delvare
