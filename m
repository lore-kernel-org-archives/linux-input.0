From: Jiri Kosina <jkosina@suse.cz>
Subject: RE: [PATCH] HID: driver for BTC "Emprex 3009URF III Vista MCE Remote"
 quirky remote
Date: Mon, 15 Mar 2010 17:03:03 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1003151701380.18642@pobox.suse.cz>
References: <4B8902C5.5000508@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:52389 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965235Ab0COQDE (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 15 Mar 2010 12:03:04 -0400
In-Reply-To: <4B8902C5.5000508@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ben Hardill <b.hardill@gmail.com>
Cc: linux-input@vger.kernel.org, Wayne Thomas <waynethomas69@gmail.com>

On Sat, 27 Feb 2010, Ben Hardill wrote:

> I've tried to follow the instructions in the README.keymap but when I 
> run /lib/udev/keymap -i input/eventX against both of the event devices I 
> get nothing out, not even the "unknown" message mentioned in the doc.
> 
> I'm not totally up to speed with this yet, but I think i may be down to the
> "e0x0ffbc0000 HID usage page" that Wayne mentioned earlier not being read by
> the input layer and passed to the udev layer. If this is the case then before
> udev can be used to make hardware like this work the input layer will need to
> add support for this page.

Could you guys please send me output from debugfs files for this 
particular device?

Namely /sys/kernel/debug/hid/<device>/rdesc 
/syse/kernel/debug/hid/<device>/events from the time the non-working 
buttons are pressed?

Thanks,

-- 
Jiri Kosina
SUSE Labs, Novell Inc.
