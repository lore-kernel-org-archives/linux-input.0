From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: Force Feedback for Thrustmaster RGT Pro Clutch Pedal Edition
 racing wheel
Date: Sat, 20 Sep 2008 04:44:16 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0809200442010.27884@twin.jikos.cz>
References: <48CBD7B3.4070104@xs4all.be>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from twin.jikos.cz ([213.151.79.26]:42623 "EHLO twin.jikos.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752936AbYITCoY (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 19 Sep 2008 22:44:24 -0400
In-Reply-To: <48CBD7B3.4070104@xs4all.be>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Didier Moens <moensd@xs4all.be>
Cc: linux-input@vger.kernel.org, Zinx Verituse <zinx@epicsol.org>

On Sat, 13 Sep 2008, Didier Moens wrote:

> Sep 10 08:46:40 moewelstat1 kernel: input: Thrustmaster Thrustmaster force
> feedback wheel as /class/input/input13
> Sep 10 08:46:40 moewelstat1 kernel: drivers/hid/usbhid/hid-tmff.c: ignoring
> unknown output usage 000f0022
> Sep 10 08:46:40 moewelstat1 kernel: drivers/hid/usbhid/hid-tmff.c: ignoring
> unknown output usage 000f0050
> Sep 10 08:46:40 moewelstat1 kernel: drivers/hid/usbhid/hid-tmff.c: ignoring
> unknown output usage 000f0022
> Sep 10 08:46:40 moewelstat1 kernel: drivers/hid/usbhid/hid-tmff.c: ignoring
> unknown output usage 000f0060
> Sep 10 08:46:40 moewelstat1 kernel: drivers/hid/usbhid/hid-tmff.c: ignoring
> unknown output usage 000f0063
> Sep 10 08:46:40 moewelstat1 kernel: drivers/hid/usbhid/hid-tmff.c: ignoring
> unknown output usage 000f0022
> Sep 10 08:46:40 moewelstat1 kernel: drivers/hid/usbhid/hid-tmff.c: ignoring
> unknown output usage 000f0070
> Sep 10 08:46:40 moewelstat1 kernel: drivers/hid/usbhid/hid-tmff.c: ignoring
> unknown output usage 000f0022
> Sep 10 08:46:40 moewelstat1 kernel: drivers/hid/usbhid/hid-tmff.c: ignoring
> unknown output usage 000f0079
> Sep 10 08:46:40 moewelstat1 kernel: drivers/hid/usbhid/hid-tmff.c: ignoring
> unknown output usage 000f0097

Hi,

apparently, Thrustmaster has changed the report descriptor of the device a 
little bit. Probably also the protocol for this device is a little bit 
different. I have added Zinx to CC, as he wrote the original driver.

For start, running hd in debugging mode (CONFIG_HID_DEBUG and modprobing 
'hid' module with 'debug=2' parameter) and capturing output of a working 
session in windows might be good steps.

-- 
Jiri Kosina
SUSE Labs

