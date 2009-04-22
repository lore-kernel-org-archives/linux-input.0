From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: "soft" USB keyboard and mouse driver
Date: Wed, 22 Apr 2009 13:22:17 +0200 (CEST)
Message-ID: <alpine.LRH.2.00.0904221319520.18261@twin.jikos.cz>
References: <49ED8857.9010809@manoweb.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:38914 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751511AbZDVLWT (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 22 Apr 2009 07:22:19 -0400
In-Reply-To: <49ED8857.9010809@manoweb.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Alessio Sangalli <alesan@manoweb.com>
Cc: linux-input@vger.kernel.org

On Tue, 21 Apr 2009, Alessio Sangalli wrote:

> Hi I would need a hint what is best to do; I have an embedded device 
> that can do a "soft" implementation of USB for embedded applications. 
> The aim is to be compatible with low-speed HID USB devices.
> 
> The fact is, it does not implement a full USB stack but only 
> point-to-point communication with the aforementioned devices. I know it 
> sounds weird but it's more like a "PS/2" port than a USB thing.
> 
> Now, I have a generic character device driver that can read keyboard and
> mouse data. Of course I get what a USB device would send when you press
> keys etc.
> 
> How do you think it would be the best way to integrate it with the input
> subsystem?

I am not really sure I understand very well. So you have the device the 
provides some "crippled" implementation of USB and provides some HID 
devices on top of it, and you would like to have this compliant with the 
kernel Input/HID infrastructure?

If the devices are really HID (i.e. the protocol on the wire is proper HID 
as defined by HID specification), you'd only need to implement a 
specialized "transport" HID code for this transport protocol, and let the 
HID core do the rest.

Currently there are implementations for USB and Bluetooth which you can 
look at.

Or maybe I just misunderstood your situation completely?

-- 
Jiri Kosina
SUSE Labs

