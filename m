From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [git pull] Input updates for 2.6.34-rc6
Date: Thu, 13 May 2010 10:30:23 -0700 (PDT)
Message-ID: <alpine.LFD.2.00.1005131017070.3711@i5.linux-foundation.org>
References: <20100513075728.GF30110@core.coreip.homeip.net> <alpine.LFD.2.00.1005130724280.3711@i5.linux-foundation.org> <20100513160117.GB22238@core.coreip.homeip.net> <alpine.LFD.2.00.1005130943460.3711@i5.linux-foundation.org>
 <20100513171639.GA23708@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:36827 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754643Ab0EMRcg (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 13 May 2010 13:32:36 -0400
In-Reply-To: <20100513171639.GA23708@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-input@vger.kernel.org, Bastien Nocera <hadess@hadess.net>



On Thu, 13 May 2010, Dmitry Torokhov wrote:
> 
> I think on the newer hardware PNP (or rather ACPI mapped onto PNP) usually 
> matches the reality.

Dmitry, you're just making things up.

I have in front of me a Core i5-670. You can't get much newer than that. 
And yes, it has a PS/2 connector at the back. And lookie here:

	[    1.756777] PNP: No PS/2 controller found. Probing ports directly.
	[    1.760645] serio: i8042 KBD port at 0x60,0x64 irq 1
	[    1.762087] serio: i8042 AUX port at 0x60,0x64 irq 12
	[    1.763591] mice: PS/2 mouse device common for all mice

so let it go. You're wrong. PS/2 is a legacy device, and exactly like the 
legacy IO memory region in 0xa000-0xffff (or the motherboard IO port 
region 0x00-0xff) it may not be mentioned by the BIOS tables. But it's 
still there.

This is also why I think it _would_ be acceptable to say that if you boot 
from EFI, you have to find the PnP devices. The whole (and only, as far as 
I know) point of EFI was that "legacy-free" thing.

		Linus
