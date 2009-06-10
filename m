From: Mark Butsch <mbutsch@syntech-fuelmaster.com>
Subject: How do you keep input from a USB Mag card reader from going to
 STDIN?
Date: Wed, 10 Jun 2009 15:40:37 -0400
Message-ID: <6C2434209962DC46B88345CA85C334A240E19D7CE2@Courier.syntech.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from exchsrvr.syntech-fuelmaster.com ([199.44.250.2]:32527 "EHLO
	courier.syntech-fuelmaster.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754620AbZFJTqF convert rfc822-to-8bit
	(ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 10 Jun 2009 15:46:05 -0400
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "'linux-input@vger.kernel.org'" <linux-input@vger.kernel.org>

Hello,

I hope this is the correct place to post this.

I have both a USB keyboard and a USB Mag card reader (that works like a USB keyboard) connected to my system.

I would like to make it so the real keyboard is the only device that feeds STDIN and the mag card reader is only readable by reading that device directly.

If I "cat /proc/bus/input/devices" it shows:

I: Bus=0003 Vendor=04da Product=117c Version=0001
N: Name="Panasonic Panasonic USB keyboard compliant Mag-CR"
P: Phys=usb-0000:00:1d.3-1/input0
S: Sysfs=/class/input/input37
H: Handlers=kbd event5
B: EV=120003
B: KEY=10000 7 ff80007a 7ff febeffdf ffefffff ffffffff fffffffe
B: LED=1f

I: Bus=0003 Vendor=413c Product=2105 Version=0352
N: Name="Dell Dell USB Keyboard"
P: Phys=usb-0000:00:1d.0-1/input0
S: Sysfs=/class/input/input38
H: Handlers=kbd event2
B: EV=120003
B: KEY=10000 7 ff87207a c14057ff febeffdf ffefffff ffffffff fffffffe
B: LED=7

How would I disconnect the "kbd" handler from the mag card reader (and the mag card reader from the "kbd" handler) or is that the wrong approach?

Thanks in advance.

Mark Butsch
