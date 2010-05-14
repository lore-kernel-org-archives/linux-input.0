From: david@lang.hm
Subject: Re: [git pull] Input updates for 2.6.34-rc6
Date: Fri, 14 May 2010 12:05:26 -0700 (PDT)
Message-ID: <alpine.DEB.2.01.1005141156310.8603@asgard.lang.hm>
References: <20100513075728.GF30110@core.coreip.homeip.net> <alpine.LFD.2.00.1005130724280.3711@i5.linux-foundation.org> <20100514145539.GA5598@srcf.ucam.org> <alpine.LFD.2.00.1005140814380.3711@i5.linux-foundation.org> <alpine.DEB.2.01.1005141144250.8603@asgard.lang.hm>
 <20100514184931.GA10113@srcf.ucam.org> <alpine.DEB.2.01.1005141151570.8603@asgard.lang.hm>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.lang.hm ([64.81.33.126]:33351 "EHLO bifrost.lang.hm"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755455Ab0ENTFg (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 14 May 2010 15:05:36 -0400
In-Reply-To: <alpine.DEB.2.01.1005141151570.8603@asgard.lang.hm>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-input@vger.kernel.org, Bastien Nocera <hadess@hadess.net>

On Fri, 14 May 2010, david@lang.hm wrote:

> On Fri, 14 May 2010, Matthew Garrett wrote:
>
>> On Fri, May 14, 2010 at 11:47:43AM -0700, david@lang.hm wrote:
>> 
>>> yes, everything has USB ports, so they could use USB keyboards, but it's
>>> actually pretty common to still use PS/2 keyboards (and while the systems
>>> all support USB, it's not uncommon to have KVM systems, including pretty
>>> expensive 'enterprise' KVM systems that still require PS/2 keyboards be
>>> used to plug into the KVM, so those are the keyboards that are in the
>>> datacenter that someone will grab to plug into a problem machine)
>> 
>> The server hardware I've looked at will all declare the ports regardless
>> of whether or not there's something plugged in.
>
> remember that many people use systems in datacenters that are not 'server 
> hardware'.
>
> when a desktop PC can have 4-6 cores with 8G+ of ram and a couple TB of 
> storage, a lot of people will end up using those systems for production.
>
> As they grow into bigger companies they will shift to 'server class' 
> hardware, but startups tend to use whatever they can scrounge (or buy 
> _really_ cheap)

By the way, for what it's worth I think it's a very bad idea to hot-plug 
PS/2 keyboards. The hardware may be better nowadays, but back when I was a 
PC repair tech I made very good money replacing the fuses on motherboards 
that would blow because someone hot-plugged the keyboard.

That said, there are times when it happens, and many people don't see any 
problem with it.

David Lang
