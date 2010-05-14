From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [git pull] Input updates for 2.6.34-rc6
Date: Fri, 14 May 2010 15:55:39 +0100
Message-ID: <20100514145539.GA5598@srcf.ucam.org>
References: <20100513075728.GF30110@core.coreip.homeip.net> <alpine.LFD.2.00.1005130724280.3711@i5.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:51838 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753578Ab0ENOz4 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 14 May 2010 10:55:56 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.1005130724280.3711@i5.linux-foundation.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-input@vger.kernel.org, Bastien Nocera <hadess@hadess.net>

I've done some experimentation under qemu. On ACPI systems, Windows will 
*only* touch the keyboard controller if there's a device with an 
appropriate PNP HID or CID and if _STA evaluates to 0x0b or 0x0f. 
Otherwise it'll simply ignore the hardware entirely. By the looks of it 
their keyboard probing is also somewhat different to ours, but that's 
probably another story.

However, I did find a couple of device IDs that machines may produce 
which we don't currently check for. I'll send a patch.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
