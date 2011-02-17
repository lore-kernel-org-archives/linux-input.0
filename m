From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [RESEND PATCH]: Add support for Intellimouse Mode in ALPS
 touchpad on Dell E2 series Laptops
Date: Thu, 17 Feb 2011 13:16:31 -0800
Message-ID: <20110217211631.GC21932@core.coreip.homeip.net>
References: <1290543314-1114-1-git-send-email-Rezwanul_Kabir@dell.com>
 <alpine.LRH.2.00.1102171604310.9644@twin.jikos.cz>
 <20110217172424.GB21932@core.coreip.homeip.net>
 <alpine.LNX.2.00.1102172206360.2160@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:33254 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758058Ab1BQVQn (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 17 Feb 2011 16:16:43 -0500
Received: by pva4 with SMTP id 4so432702pva.19
        for <linux-input@vger.kernel.org>; Thu, 17 Feb 2011 13:16:42 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <alpine.LNX.2.00.1102172206360.2160@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Rezwanul Kabir <Rezwanul_Kabir@dell.com>, linux-input@vger.kernel.org

On Thu, Feb 17, 2011 at 10:07:17PM +0100, Jiri Kosina wrote:
> On Thu, 17 Feb 2011, Dmitry Torokhov wrote:
> 
> > > > Resending modified patch to fix suspend/resume issues and restricting the
> > > > quirks to Dell portables only.
> > > > 
> > > > Dell E2 series laptops ( M4500, E6510, E6410 etc.) have ALPS touchpads
> > > > which are enabled by default as 3-byte generic PS/2 mouse mode. This
> > > > patch enables the 4-byte "Intellimouse Mode" ( e.g scrolling support).
> > > > 
> > > > Signed-off-by: Rezwanul_Kabir <Rezwanul_Kabir@dell.com>
> > > 
> > > This seems to have never been merged. Adding Dmitry to CC -- Dmitry, do 
> > > you see any issues with the patch, or has it just slipped through cracks?
> > 
> > Jiri,
> > 
> > I do not want to merge this patch into mainline - it is a crutch that
> > only works on Dell boxes whereas these touchpads are in abundance
> > everywhere and we even have initialization sequence captured. So I am
> > hoping someone who has hardware would spend some time and write proper
> > support.
> 
> Good, thanks for letting me know. I'll try to get some hardware myself and 
> work on it (so far I have been only getting reports that it doesn't work 
> :) ).
> 

Great, and if you need testers - look here ;)

https://bugzilla.kernel.org/show_bug.cgi?id=14660

-- 
Dmitry
