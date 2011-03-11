From: Oliver Neukum <oneukum@suse.de>
Subject: which handlers should bind to a device
Date: Fri, 11 Mar 2011 16:24:50 +0100
Message-ID: <201103111624.50552.oneukum@suse.de>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:43215 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755563Ab1CKPYj (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 11 Mar 2011 10:24:39 -0500
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.221.2])
	by mx2.suse.de (Postfix) with ESMTP id 149AE89B67
	for <linux-input@vger.kernel.org>; Fri, 11 Mar 2011 16:24:38 +0100 (CET)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Hi,

I have a set of USB speakers which also implement HID:

bDescriptorType        34 Report
          wDescriptorLength      59
          Report Descriptor: (length is 59)
            Item(Global): Usage Page, data= [ 0x0c ] 12
                            Consumer
            Item(Local ): Usage, data= [ 0x01 ] 1
                            Consumer Control
            Item(Main  ): Collection, data= [ 0x01 ] 1
                            Application
            Item(Global): Usage Page, data= [ 0x0c ] 12
                            Consumer
            Item(Local ): Usage, data= [ 0xe9 ] 233
                            Volume Increment
            Item(Global): Usage Page, data= [ 0x0c ] 12
                            Consumer
            Item(Local ): Usage, data= [ 0xea ] 234
                            Volume Decrement
            Item(Global): Usage Page, data= [ 0x0c ] 12
                            Consumer
            Item(Local ): Usage, data= [ 0xe2 ] 226
                            Mute
            Item(Global): Logical Minimum, data= [ 0x00 ] 0
            Item(Global): Logical Maximum, data= [ 0x01 ] 1
            Item(Global): Report Count, data= [ 0x03 ] 3
            Item(Global): Report Size, data= [ 0x01 ] 1
            Item(Main  ): Input, data= [ 0x42 ] 66
                            Data Variable Absolute No_Wrap Linear
                            Preferred_State Null_State Non_Volatile Bitfield
            Item(Global): Report Count, data= [ 0x01 ] 1
            Item(Global): Report Size, data= [ 0x05 ] 5
            Item(Main  ): Input, data= [ 0x01 ] 1
                            Constant Array Absolute No_Wrap Linear
                            Preferred_State No_Null_Position Non_Volatile Bitfield
            Item(Global): Usage Page, data= [ 0x0c ] 12
                            Consumer
            Item(Local ): Usage, data= [ 0x00 ] 0
                            Unassigned
            Item(Global): Usage Page, data= [ 0x0c ] 12
                            Consumer
            Item(Local ): Usage, data= [ 0x00 ] 0
                            Unassigned
            Item(Global): Logical Minimum, data= [ 0x00 ] 0
            Item(Global): Logical Maximum, data= [ 0x01 ] 1
            Item(Global): Report Count, data= [ 0x02 ] 2
            Item(Global): Report Size, data= [ 0x01 ] 1
            Item(Main  ): Output, data= [ 0x06 ] 6
                            Data Variable Relative No_Wrap Linear
                            Preferred_State No_Null_Position Non_Volatile Bitfield
            Item(Global): Report Count, data= [ 0x01 ] 1
            Item(Global): Report Size, data= [ 0x06 ] 6
            Item(Main  ): Output, data= [ 0x03 ] 3
                            Constant Variable Absolute No_Wrap Linear
                            Preferred_State No_Null_Position Non_Volatile Bitfield
            Item(Main  ): End Collection, data=none

According to the Usage Page the device is not a keyboard, yet the keyboard handler
binds. Is this really sensible?
I: Bus=0003 Vendor=0471 Product=0104 Version=0100
N: Name="Philips Electronics Philips USB Digital Speaker System"
P: Phys=usb-0000:00:1d.0-1/input2
S: Sysfs=/devices/pci0000:00/0000:00:1d.0/usb6/6-1/6-1:1.2/input/input15
U: Uniq=
H: Handlers=kbd event11 
B: PROP=0
B: EV=13
B: KEY=e000000000000 0
B: MSC=10

	Regards
		Oliver

