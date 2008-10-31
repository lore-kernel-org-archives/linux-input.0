From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: 2.6.28-rc2: USB/INPUT: slab error in cache_alloc_debugcheck_after():
 double free?
Date: Fri, 31 Oct 2008 16:27:48 +0100 (CET)
Message-ID: <alpine.LNX.1.10.0810311626160.31273@jikos.suse.cz>
References: <200810310011.08618.deller@gmx.de> <20081031044553.50882e86@epia.jer-c2.orkz.net> <alpine.LRH.1.10.0810311254400.7585@twin.jikos.cz> <20081031161640.16f20fd1@epia.jer-c2.orkz.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from styx.suse.cz ([82.119.242.94]:49910 "EHLO mail.suse.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751267AbYJaP1u (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 31 Oct 2008 11:27:50 -0400
In-Reply-To: <20081031161640.16f20fd1@epia.jer-c2.orkz.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jeroen Roovers <jer@gentoo.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>

On Fri, 31 Oct 2008, Jeroen Roovers wrote:

> > Could you please provide your config? I am still not able to reproduce 
> > it here. Thanks.
> Added to the bug report[1]. The architecture is hppa (parisc).

Hmm, so we have just two reports of this corruption, and both of them come 
from PA-RISC systems. Noone else has reported this, and I haven't been 
able to reproduce it myself on x86.

On the other hand I don't seem to see any commit that went into 
arch/parisc between .27 and 28-rc1 which could possibly cause this...

-- 
Jiri Kosina
SUSE Labs
