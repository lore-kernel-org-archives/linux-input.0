From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: Issues detecting i8042 AUX port
Date: Mon, 2 Nov 2009 15:33:02 +0100 (CET)
Message-ID: <alpine.LSU.2.00.0911021532090.4203@wotan.suse.de>
References: <4ACB533A.7080001@urbanec.net> <alpine.LRH.2.00.0910082315070.12171@twin.jikos.cz> <4AE989D0.1070302@urbanec.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:41744 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755128AbZKBOdB (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 2 Nov 2009 09:33:01 -0500
In-Reply-To: <4AE989D0.1070302@urbanec.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Peter Urbanec <vger.kernel.org.input@urbanec.net>
Cc: linux-input@vger.kernel.org

On Thu, 29 Oct 2009, Peter Urbanec wrote:

> > On Wed, 7 Oct 2009, Peter Urbanec wrote:
> > > In a nutshell, I can run the same kernel on the same hardware and on
> > > some boots the AUX port will not be detected and on other boots it will
> > > come up fine.
> > 
> > Does booting with 'i8042.noloop' improve the situation?
> 
> Jirko,
> 
> Thanks for the suggestion. I have been testing the i8042.noloop workaround for
> a few weeks now. So far I have not not experienced any problems when booting
> with that option. I would say that the workaround can be declared as being
> effective.
> 
> I also applied Dmitry's patch to log the timeout condition when detecting the
> AUX port. Without the i8042.noloop option, the AUX port detection fails
> intermittently, but when it does, it causes an aux irq test timeout, which
> coincides with uhci_hcd USB hub initialisation. Perhaps the USB code somehow
> causes the loss of this interrupt.
> 
> Adding the DMI info for the machine to the i8042_dmi_noloop_table is perhaps
> not the most correct fix for the underlying problem, but it does get results.
> 
> Here is the relevant dmidecode data for the laptop:

Thanks for providing the data.

Does 2.6.32 work out of the box without any modifications? Dmitry added 
generic blacklist entry for all notebook chasis types, so 2.6.32 should 
have solved it for you.

Thanks,

-- 
Jiri Kosina
SUSE Labs, Novell Inc.
