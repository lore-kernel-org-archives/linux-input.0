From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [RESEND PATCH]: Add support for Intellimouse Mode in ALPS touchpad
 on Dell E2 series Laptops
Date: Thu, 17 Feb 2011 22:07:17 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1102172206360.2160@pobox.suse.cz>
References: <1290543314-1114-1-git-send-email-Rezwanul_Kabir@dell.com> <alpine.LRH.2.00.1102171604310.9644@twin.jikos.cz> <20110217172424.GB21932@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:35693 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753282Ab1BQVHT (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 17 Feb 2011 16:07:19 -0500
In-Reply-To: <20110217172424.GB21932@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Rezwanul Kabir <Rezwanul_Kabir@dell.com>, linux-input@vger.kernel.org

On Thu, 17 Feb 2011, Dmitry Torokhov wrote:

> > > Resending modified patch to fix suspend/resume issues and restricting the
> > > quirks to Dell portables only.
> > > 
> > > Dell E2 series laptops ( M4500, E6510, E6410 etc.) have ALPS touchpads
> > > which are enabled by default as 3-byte generic PS/2 mouse mode. This
> > > patch enables the 4-byte "Intellimouse Mode" ( e.g scrolling support).
> > > 
> > > Signed-off-by: Rezwanul_Kabir <Rezwanul_Kabir@dell.com>
> > 
> > This seems to have never been merged. Adding Dmitry to CC -- Dmitry, do 
> > you see any issues with the patch, or has it just slipped through cracks?
> 
> Jiri,
> 
> I do not want to merge this patch into mainline - it is a crutch that
> only works on Dell boxes whereas these touchpads are in abundance
> everywhere and we even have initialization sequence captured. So I am
> hoping someone who has hardware would spend some time and write proper
> support.

Good, thanks for letting me know. I'll try to get some hardware myself and 
work on it (so far I have been only getting reports that it doesn't work 
:) ).

Thanks,

-- 
Jiri Kosina
SUSE Labs, Novell Inc.
