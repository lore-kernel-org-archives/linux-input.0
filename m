From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH v3 0/6] hid: Introduce device groups
Date: Wed, 2 May 2012 10:45:14 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1205021044240.14613@pobox.suse.cz>
References: <1335175627-2270-1-git-send-email-rydberg@euromail.se> <alpine.LNX.2.00.1205011300540.1856@pobox.suse.cz> <CAN+gG=GGVFDgf_PkovS+_OX26LH0Q19_FwwkGP2pSwnoX4d_Ug@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:33575 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754329Ab2EBIpR (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 2 May 2012 04:45:17 -0400
In-Reply-To: <CAN+gG=GGVFDgf_PkovS+_OX26LH0Q19_FwwkGP2pSwnoX4d_Ug@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Cc: Henrik Rydberg <rydberg@euromail.se>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Stephane Chatty <chatty@enac.fr>

On Wed, 2 May 2012, Benjamin Tissoires wrote:

> > It's currently in a shape I would be okay to pushing out for -next and
> > scheduling for next merge window, and I will do so tomorrow if nothing
> > else pops up during testing or reviews.
> 
> Hi Jiri,
> 
> Well, I'm back in my lab this morning, and I'm testing your branch
> against the different devices we have here. I'm observing a strange
> problem: when connecting some devices, the first touch is always at
> 0,0. If I rmmod and insmod hid_multitouch it seems to work after....
> 
> I'm investigating this bug now. I'll tell you when I'm done. I still
> don't now if it's related to Henrik's changes or 3.4-rc4.

I see, thanks a lot for the heads-up, I will be waiting for your analysis 
of this.

I have already renamed the branch to 'device-groups' and merged it into 
branch that goes into next, so please send me any followup patches on top 
of that queue now.

Thanks,

-- 
Jiri Kosina
SUSE Labs
