From: Grant Grundler <grundler@parisc-linux.org>
Subject: Re: 2.6.28-rc2: USB/INPUT: slab error in
	cache_alloc_debugcheck_after(): double free?
Date: Sat, 1 Nov 2008 11:56:52 -0600
Message-ID: <20081101175652.GH13302@colo.lackof.org>
References: <200810310011.08618.deller@gmx.de> <20081031044553.50882e86@epia.jer-c2.orkz.net> <alpine.LRH.1.10.0810311254400.7585@twin.jikos.cz> <20081031161640.16f20fd1@epia.jer-c2.orkz.net> <alpine.LNX.1.10.0810311626160.31273@jikos.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from colo.lackof.org ([198.49.126.79]:47889 "EHLO colo.lackof.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752002AbYKAR5G (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sat, 1 Nov 2008 13:57:06 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LNX.1.10.0810311626160.31273@jikos.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Jeroen Roovers <jer@gentoo.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>

On Fri, Oct 31, 2008 at 04:27:48PM +0100, Jiri Kosina wrote:
> On Fri, 31 Oct 2008, Jeroen Roovers wrote:
> 
> > > Could you please provide your config? I am still not able to reproduce 
> > > it here. Thanks.
> > Added to the bug report[1]. The architecture is hppa (parisc).
> 
> Hmm, so we have just two reports of this corruption, and both of them come 
> from PA-RISC systems. Noone else has reported this, and I haven't been 
> able to reproduce it myself on x86.
> 
> On the other hand I don't seem to see any commit that went into 
> arch/parisc between .27 and 28-rc1 which could possibly cause this...

Maybe check drivers/parisc/?
Long shot but if it's easy to check...

Any chance this is a big endian vs little endian problem?
I've found at least one of those in the USB layer before.

grant
