From: "Henrik Rydberg" <rydberg@euromail.se>
Subject: Re: [PATCH] hid: Remove QUANTA from special drivers list
Date: Thu, 23 Aug 2012 18:48:59 +0200
Message-ID: <20120823164859.GB611@polaris.bitmath.org>
References: <1345630637-7142-1-git-send-email-simon.farnsworth@onelan.co.uk>
 <alpine.LNX.2.00.1208221648130.32304@pobox.suse.cz>
 <20120822170052.GA6158@polaris.bitmath.org>
 <1458729.LvjituALLn@f17simon>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtprelay-b12.telenor.se ([62.127.194.21]:56990 "EHLO
	smtprelay-b12.telenor.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751767Ab2HWQoE (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 23 Aug 2012 12:44:04 -0400
Received: from ipb2.telenor.se (ipb2.telenor.se [195.54.127.165])
	by smtprelay-b12.telenor.se (Postfix) with ESMTP id C225CD977
	for <linux-input@vger.kernel.org>; Thu, 23 Aug 2012 18:44:02 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1458729.LvjituALLn@f17simon>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Simon Farnsworth <simon.farnsworth@onelan.co.uk>
Cc: Henrik Rydberg <rydberg@bitmath.se>, Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org, Benjamin Tissoires <benjamin.tissoires@gmail.com>, Benjamin Tissoires <benjamin.tissoires@enac.fr>

> I'll send a follow-on patch to remove the PIXART_IMAGING identifier. I tried
> removing the HID_QURIK_NOGET quirk, but it appears to be needed: without it,
> I get:
> 
> [    1.472269] usb 6-1: New USB device found, idVendor=0408, idProduct=3001
> [    1.472275] usb 6-1: New USB device strings: Mfr=1, Product=2, SerialNumber=0
> [    1.472279] usb 6-1: Product: Optical Touch Screen
> [    1.472284] usb 6-1: Manufacturer: QUANTA
> <snip>
> [   15.884252] hid-multitouch 0003:0408:3001.0001: usb_submit_urb(ctrl) failed: -1
> [   15.884337] hid-multitouch 0003:0408:3001.0001: timeout initializing reports
> [   15.884584] input: QUANTA Optical Touch Screen as /devices/pci0000:00/0000:00:1d.1/usb6/6-1/6-1:1.0/input/input10
> [   15.884783] hid-multitouch 0003:0408:3001.0001: input,hidraw0: USB HID v1.10 Device [QUANTA Optical Touch Screen] on usb-0000:00:1d.1-1/input0
> 
> If I leave the quirk in place, I don't get the 14 second delay, suggesting 
> that the quirk is needed on this hardware.

It makes sense, the same applies to 0x3008. Thanks for checking.

Henrik
