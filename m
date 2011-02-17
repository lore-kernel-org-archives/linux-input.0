From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [RESEND PATCH]: Add support for Intellimouse Mode in ALPS
 touchpad on Dell E2 series Laptops
Date: Thu, 17 Feb 2011 09:24:25 -0800
Message-ID: <20110217172424.GB21932@core.coreip.homeip.net>
References: <1290543314-1114-1-git-send-email-Rezwanul_Kabir@dell.com>
 <alpine.LRH.2.00.1102171604310.9644@twin.jikos.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:65035 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754632Ab1BQRYg (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 17 Feb 2011 12:24:36 -0500
Received: by gxk9 with SMTP id 9so1109452gxk.19
        for <linux-input@vger.kernel.org>; Thu, 17 Feb 2011 09:24:36 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <alpine.LRH.2.00.1102171604310.9644@twin.jikos.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Rezwanul Kabir <Rezwanul_Kabir@dell.com>, linux-input@vger.kernel.org

On Thu, Feb 17, 2011 at 04:05:34PM +0100, Jiri Kosina wrote:
> On Tue, 23 Nov 2010, Rezwanul Kabir wrote:
> 
> > Resending modified patch to fix suspend/resume issues and restricting the
> > quirks to Dell portables only.
> > 
> > Dell E2 series laptops ( M4500, E6510, E6410 etc.) have ALPS touchpads
> > which are enabled by default as 3-byte generic PS/2 mouse mode. This
> > patch enables the 4-byte "Intellimouse Mode" ( e.g scrolling support).
> > 
> > Signed-off-by: Rezwanul_Kabir <Rezwanul_Kabir@dell.com>
> 
> This seems to have never been merged. Adding Dmitry to CC -- Dmitry, do 
> you see any issues with the patch, or has it just slipped through cracks?

Jiri,

I do not want to merge this patch into mainline - it is a crutch that
only works on Dell boxes whereas these touchpads are in abundance
everywhere and we even have initialization sequence captured. So I am
hoping someone who has hardware would spend some time and write proper
support.

Thanks.

-- 
Dmitry
