From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: Microsoft Surface Pro 3 Type Cover keyboard
Date: Mon, 3 Nov 2014 14:33:06 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1411031431150.19451@pobox.suse.cz>
References: <54492559.8000205@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:50954 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750869AbaKCNdI (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 3 Nov 2014 08:33:08 -0500
In-Reply-To: <54492559.8000205@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jarrad Whitaker <jarrad.whitaker@gmail.com>
Cc: linux-input@vger.kernel.org, Alan Wu <alan.c.wu@gmail.com>

On Fri, 24 Oct 2014, Jarrad Whitaker wrote:

> The keyboard on the Surface Pro 3 type cover does not function without
> some patching, similar to what was apparently required for the SP2
> type/touch covers.
> 
> A working patch against 3.16 attached, it's an amalgamation of "some
> dude posted this on the ubuntu/arch forums and it seems to work" so
> I'm making no claims that it's kernel-quality! Just trying to give a
> better indication of what needs to be added. My C is rudimentary and
> my knowledge of the kernel limited to 'fakeroot debian/rules
> updateconfigs', sorry. :)
> Happy to test any improved version, but note I only have a type, not a
> touch cover.
> 
> Patch source is
> http://winaero.com/blog/how-to-install-linux-on-surface-pro-3/, which
> in turn sources a Russian site.

Hi,

thanks. Adding Alan Wu to CC, who sent me a slightly different patch for 
this issue -- see the archives of linux-input list from a few days back.

Your patch is missing at least Signed-off-by: line, and also seems to lack 
the update to hid_have_special_driver[].

Could you two guys please cooperate and send me a patch that should be 
applied? I don't have the device so can't really test properly myself.

Thanks,

-- 
Jiri Kosina
SUSE Labs
