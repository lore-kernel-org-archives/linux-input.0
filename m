From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH] hid: wellspring device quirks
Date: Tue, 22 Jul 2008 15:08:52 +0200 (CEST)
Message-ID: <alpine.LNX.1.10.0807221504380.3037@jikos.suse.cz>
References: <1215963466.12757.0.camel@alnilam>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from styx.suse.cz ([82.119.242.94]:33585 "EHLO mail.suse.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751023AbYGVNIx (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 22 Jul 2008 09:08:53 -0400
In-Reply-To: <1215963466.12757.0.camel@alnilam>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, robfitz@273k.net, akpm@osdl.org, Vojtech Pavlik <vojtech@suse.cz>, dmonakhov@openvz.org

On Sun, 13 Jul 2008, Henrik Rydberg wrote:

> This patch adds the HID_QUIRK_IGNORE_MOUSE quirk for the Apple USB
> multitouch devices based on BCM5974, aka Wellspring. These devices
> will instead be picked up by the new bcm5974 driver.

Hi Henrik,

is the mouse not working at all with standard HID driver?

I'd prefer to postpone merging this patch until bcm5974 hits mainline if 
the device works in a limited way with standard HID driver, so that we 
don't introduce regression.

If the device doesn't work with HID driver at all though, it is probably 
perfectly fine to merge it right away. Please let me know, I have no 
knowledge about this particular device.

Thanks a lot,

-- 
Jiri Kosina
SUSE Labs
