From: Jiri Kosina <jkosina@suse.cz>
Subject: RE: [PATCH] hid: usbhid: New hid quirks for Panasonic Elite Panaboard
 T-780 and T-880
Date: Tue, 23 Nov 2010 14:28:15 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1011231427090.18801@pobox.suse.cz>
References: <1288169825-15422-1-git-send-email-Anton.Chikin@dataart.com> <alpine.LNX.2.00.1010291453460.6879@pobox.suse.cz> <3BF066A8BAB61C43B779966CEE6D7FA018BC9E19F2@e6.universe.dart.spb> <alpine.LNX.2.00.1011011522120.15851@pobox.suse.cz>
 <3BF066A8BAB61C43B779966CEE6D7FA018BC9E1A45@e6.universe.dart.spb> <alpine.LNX.2.00.1011030925310.15851@pobox.suse.cz> <3BF066A8BAB61C43B779966CEE6D7FA018BC9E1C10@e6.universe.dart.spb>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:52645 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751568Ab0KWN2V (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 23 Nov 2010 08:28:21 -0500
In-Reply-To: <3BF066A8BAB61C43B779966CEE6D7FA018BC9E1C10@e6.universe.dart.spb>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Anton Chikin <Anton.Chikin@dataart.com>
Cc: "chatty@enac.fr" <chatty@enac.fr>, "spbnick@gmail.com" <spbnick@gmail.com>, "anisse@astier.eu" <anisse@astier.eu>, "cascardo@holoscopio.com" <cascardo@holoscopio.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, Gregory Burmistrov <grig@dataart.com>

On Thu, 18 Nov 2010, Anton Chikin wrote:

> Actually our driver is implemented as the fork of usbhid driver. I'm now 
> trying to move to HID bus. I think I need some help with this. I've 
> copied /drivers/hid/hid-cando.c source code, changed device IDs in 
> hid_driver structure, added my device IDs to /drivers/hid/hid-core.c 
> hid_blacklist[] array, but my probe() method still never get called. 
> Could you please help me with this?
> 
> My driver code and Makefile are in attachment.

Hi,

that's a bit strange. If you modprobe the module manually, does it get 
bound to the device and works properly?

Could you please send me the complete diff, including the changes to 
drivers/hid/hid-core.c?

Thanks,

-- 
Jiri Kosina
SUSE Labs, Novell Inc.
