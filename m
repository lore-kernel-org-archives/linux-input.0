From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: How do you keep input from a USB Mag card reader from going to
 STDIN?
Date: Tue, 23 Jun 2009 16:02:17 +0200 (CEST)
Message-ID: <alpine.LRH.2.00.0906231600510.31685@twin.jikos.cz>
References: <6C2434209962DC46B88345CA85C334A240E19D7CE2@Courier.syntech.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:44557 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754225AbZFWOCP (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 23 Jun 2009 10:02:15 -0400
In-Reply-To: <6C2434209962DC46B88345CA85C334A240E19D7CE2@Courier.syntech.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mark Butsch <mbutsch@syntech-fuelmaster.com>
Cc: "'linux-input@vger.kernel.org'" <linux-input@vger.kernel.org>

On Wed, 10 Jun 2009, Mark Butsch wrote:

> I would like to make it so the real keyboard is the only device that 
> feeds STDIN and the mag card reader is only readable by reading that 
> device directly.
> 
> If I "cat /proc/bus/input/devices" it shows:
> 
> I: Bus=0003 Vendor=04da Product=117c Version=0001
> N: Name="Panasonic Panasonic USB keyboard compliant Mag-CR"
> P: Phys=usb-0000:00:1d.3-1/input0
> S: Sysfs=/class/input/input37
> H: Handlers=kbd event5
> B: EV=120003
> B: KEY=10000 7 ff80007a 7ff febeffdf ffefffff ffffffff fffffffe
> B: LED=1f
> 
> I: Bus=0003 Vendor=413c Product=2105 Version=0352
> N: Name="Dell Dell USB Keyboard"
> P: Phys=usb-0000:00:1d.0-1/input0
> S: Sysfs=/class/input/input38
> H: Handlers=kbd event2
> B: EV=120003
> B: KEY=10000 7 ff87207a c14057ff febeffdf ffefffff ffffffff fffffffe
> B: LED=7
> 
> How would I disconnect the "kbd" handler from the mag card reader (and 
> the mag card reader from the "kbd" handler) or is that the wrong 
> approach?

You can either unbind HID driver from the device completely, and write 
your own userspace driver using libusb.

Or you can patch the HID driver not to attach this device to inpu 
subsystem, and only trigger creation of /dev/hidraw (or /dev/hiddev 
respectively), and write user-space application that will process the HID 
events from these device nodes, and process them in your application as 
needed.

-- 
Jiri Kosina
SUSE Labs

