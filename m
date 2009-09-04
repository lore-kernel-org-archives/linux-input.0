From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [kmemcheck] WARNING: kmemcheck: Caught 32-bit read from
 uninitialized memory, in  hid_output_report
Date: Fri, 4 Sep 2009 15:04:03 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.0909041501440.23856@wotan.suse.de>
References: <4A9833D3.3040202@code.wastedcycles.net> <4A9AF15A.5080402@code.wastedcycles.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:42727 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754209AbZIDNED (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 4 Sep 2009 09:04:03 -0400
In-Reply-To: <4A9AF15A.5080402@code.wastedcycles.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jeff Smith <lkml.sepix@code.wastedcycles.net>
Cc: linux-input@vger.kernel.org, Vegard Nossum <vegardno@ifi.uio.no>

On Sun, 30 Aug 2009, Jeff Smith wrote:

> A patch follows. It corrects a typo in the comment, changes the function 
> name "implement" to "set_into_le_bitstream", changes the parameter name 
> "n" to "bitfield_size", printk's unsigned using %u not %d, and only does 
> a 32-bit read-modify-write when a 64-bit one is not necessary.
> 
> A patch that writes only the bytes that need to be changed, rather than 
> 32 or 64-bit quantities that potentially access irrelevant memory 
> locations -- and that therefore require more complicated verification 
> logic -- would be a better approach. However, as we are at -rc8 already 
> and I don't fully understand the structures that are being changed, or 
> the reasons the code is as it is, I didn't feel confident about 
> presenting such a restructuring here.

Hi Jeff,

thanks for the patch, it looks correct on a quick glance. I would however 
prefer the other approach you proposed. 

We probably don't have to be nervous about being currently at -rc8, as 
this will probably be fixed only in .32-rc1 anyway (as the unitialized 
data is not used in any way, and therefore it doesn't require emergency 
fix just to silence the kmemcheck warning).

Thanks,

-- 
Jiri Kosina
SUSE Labs
