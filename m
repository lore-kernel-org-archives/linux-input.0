From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH] HID: usbhid: add Chicony/Pixart usb optical mouse that
 needs QUIRK_ALWAYS_POLL
Date: Mon, 25 May 2015 13:51:36 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1505251351130.13817@pobox.suse.cz>
References: <1432231455-4172-1-git-send-email-herton@redhat.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:51028 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752205AbbEYLvi (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 25 May 2015 07:51:38 -0400
In-Reply-To: <1432231455-4172-1-git-send-email-herton@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "Herton R. Krzesinski" <herton@redhat.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org

On Thu, 21 May 2015, Herton R. Krzesinski wrote:

> I received a report from an user of following mouse which needs this quirk:
> 
> usb 1-1.6: USB disconnect, device number 58
> usb 1-1.6: new low speed USB device number 59 using ehci_hcd
> usb 1-1.6: New USB device found, idVendor=04f2, idProduct=1053
> usb 1-1.6: New USB device strings: Mfr=1, Product=2, SerialNumber=0
> usb 1-1.6: Product: USB Optical Mouse
> usb 1-1.6: Manufacturer: PixArt
> usb 1-1.6: configuration #1 chosen from 1 choice
> input: PixArt USB Optical Mouse as /devices/pci0000:00/0000:00:1a.0/usb1/1-1/1-1.6/1-1.6:1.0/input/input5887
> generic-usb 0003:04F2:1053.16FE: input,hidraw2: USB HID v1.11 Mouse [PixArt USB Optical Mouse] on usb-0000:00:1a.0-1.6/input0
> 
> The quirk was tested by the reporter and it fixed the frequent disconnections etc.
> 
> Signed-off-by: Herton R. Krzesinski <herton@redhat.com>

Applied (with Benjamin's nit taken into account). Thanks,

-- 
Jiri Kosina
SUSE Labs
