From: "Peter Ma" <PeterMa@zeugmasystems.com>
Subject: UCB1400 Touchscreen IRQ
Date: Sun, 24 Feb 2008 22:24:11 -0800
Message-ID: <DDFD17CC94A9BD49A82147DDF7D545C5694711@exchange.ZeugmaSystems.local>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.zeugmasystems.com ([192.139.122.66]:23465 "EHLO
	zeugmasystems.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752833AbYBYGkZ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 25 Feb 2008 01:40:25 -0500
Content-class: urn:content-classes:message
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

I apologize for contacting you directly.  I believe you are the
maintainer of the Linux input drivers.
If there is a forum I ought to be checking, please point me in that
direction.

The UCB1400 touchscreen driver (input/touchscreen/ucb1400_ts.c)
currently uses an interrupt autoprobe to self-discover its interrupt.
The probe_irq_on/off functions indicate interrupts using a 32-bit field.
I am using a SoC (Atmel AVR32), in which the available external
interrupts are enumerated starting from 64, which cannot be represented
in a 32-bit field.  Thus interrupt autoprobing always fails.

I believe the solution is to somehow pass a IRQ down from the driver
instantiation, and modify ucb1400_ts_probe() to check for the IRQ number
before attempting to autoprobe.

In a couple of board setups I have seen (e.g.
arch/arm/mach-pca/cm-x270.c), ucb1400_ts is instantiated as a
"platform_device", eventhough the driver is written as a regular
"device".  Normally, something board-specific like an IRQ assignment is
passed in platform_device->resource, but I do not see how ucb1400_ts
device would be able to fetch that.

I see there is a device.platform_data, and I see a platform_device.dev.
I attempted to pass a pointer through
platform_device->dev.platform_data, but it did not appear to make it
through to device.platform_data down in the driver.

Is there a correct method for passing information (like IRQ assignment)
into a "device" driver, like ucb1400_ts?

I am quite new to linux drivers, so any guidance you can provide would
be greatly appreciated.

Thanks & Regards,
________________________________________________________________
Peter W.W. Ma                | email:  peterma@zeugmasystems.com
Principal Engineer           | tel:    +1 604 247-3269
Zeugma Systems               | fax:    +1 604 247-3251
Suite 250, 13571 Commerce Parkway, Richmond, BC, Canada, V6V 2R2
 
