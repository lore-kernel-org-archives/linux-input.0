From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [git pull] Input updates for 2.6.34-rc6
Date: Thu, 13 May 2010 12:55:38 -0700 (PDT)
Message-ID: <alpine.LFD.2.00.1005131253310.3711@i5.linux-foundation.org>
References: <20100513075728.GF30110@core.coreip.homeip.net> <alpine.LFD.2.00.1005130724280.3711@i5.linux-foundation.org> <20100513160117.GB22238@core.coreip.homeip.net> <alpine.LFD.2.00.1005130943460.3711@i5.linux-foundation.org> <20100513171639.GA23708@core.coreip.homeip.net>
 <alpine.LFD.2.00.1005131017070.3711@i5.linux-foundation.org> <20100513181002.GB23708@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:48181 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756473Ab0EMT6S (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 13 May 2010 15:58:18 -0400
In-Reply-To: <20100513181002.GB23708@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-input@vger.kernel.org, Bastien Nocera <hadess@hadess.net>



On Thu, 13 May 2010, Dmitry Torokhov wrote:
> 
> Is there an interface a driver can use to query the style of boot used?

Maybe 'efi_enabled' will do. I haven't checked exact semantics of that 
flag. And right now we don't even know if Bastien even uses EFI, or boots 
a traditional kernel image through bootcamp.

		Linus
