From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [regression] 2.6.30 leaking keys on console switch
Date: Tue, 7 Jul 2009 10:50:01 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.0907071048210.4994@wotan.suse.de>
References: <87eiss7uhb.fsf@basil.nowhere.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:40700 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754313AbZGGIt6 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 7 Jul 2009 04:49:58 -0400
In-Reply-To: <87eiss7uhb.fsf@basil.nowhere.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Andi Kleen <andi@firstfloor.org>
Cc: rjw@sisk.pl, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>


[added Dmitry to CC]

On Tue, 7 Jul 2009, Andi Kleen wrote:

> One new issue I see in 2.6.30 (I think I saw it in some rc*s) too is 
> that console switch often leaks the Fkey of the console switch into the 
> target console.
> 
> The symptome is that e.g. firefox if it was active and you're switching
> into X displays its help screen (F1 = help). It happens on non X 
> consoles too, but of course the symptoms are different here.
> 
> That's a regression against 2.6.29; I don't remember it in .29
> 
> Haven't investigated code.

Are you seeing with a specific keyboard type(s), or is this a general 
problem? Could you confirm whether it is specific either 
to PS2 or USB keyboards only, or it does happen for both?

Thanks,

-- 
Jiri Kosina
SUSE Labs
