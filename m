From: Darren Hart <dvhart@infradead.org>
Subject: Re: [ibm-acpi-devel] [PATCH 1/7] thinkpad_acpi: Remember adaptive
 kbd presence
Date: Fri, 6 Mar 2015 10:09:34 -0800
Message-ID: <20150306180934.GE19001@vmdeb7>
References: <1424443450.22910.13.camel@hadess.net>
 <20150226061814.GC7331@fury.dvhart.com>
 <1425035130.1995042.233191101.57145444@webmail.messagingengine.com>
 <1425035779.2000837.233193809.65561A3E@webmail.messagingengine.com>
 <20150303165225.GD83894@vmdeb7>
 <1425407994.1004750.235001957.08166EE5@webmail.messagingengine.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:54327 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752614AbbCFSJ4 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 6 Mar 2015 13:09:56 -0500
Content-Disposition: inline
In-Reply-To: <1425407994.1004750.235001957.08166EE5@webmail.messagingengine.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: Bastien Nocera <hadess@hadess.net>, Jiri Kosina <jkosina@suse.cz>, linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org, ibm-acpi-devel@lists.sourceforge.net, linux-input@vger.kernel.org

On Tue, Mar 03, 2015 at 03:39:54PM -0300, Henrique de Moraes Holschuh wrote:
> On Tue, Mar 3, 2015, at 13:52, Darren Hart wrote:
> > Henrique, I believe I may have overstepped with thinkpad-acpi and dealt
> > with it like the other drivers in platform/drivers/x86, when instead I should
> > have been leaving it to you. My apologies, it was not intentional.
> 
> No harm done!  And I did appreciate the extra help :-)
> 
> > Do you typically send pull-requests for the thinkpad-acpi driver directly to Linus?
> 
> thinkpad-acpi is part of the platform-x86 subsystem, so IMHO it should
> continue to be merged through your tree if you are okay with that.
> 
> I'd really appreciate if the typical patch approval flux would go
> through me first.  However, I certainly don't mind if you merge patches
> directly should I be unresponsible for some reason, or when they are
> part of the usual tree-wide spot fixes for some pattern/anti-pattern,
> etc.
> 
> > I would be more than happy to basically ignore anything to thinkpad-acpi until
> > after you have provided a review. I can also roll up pull requests from
> > you if you prefer to integrate into the platform-drivers-x86 tree as the path to
> > Linus.
> 
> Well, if it is fine with you, I'd suggest we continue with the process
> used in this patchset, where I will reply to patches in this ML with a
> reviewed-by or acked-by before you merge them.
> 
> If you want to change that at some point, just drop me a note and I will
> start pushing patches to you either through this ML or through signed
> pull requests, whichever you prefer.

Great. Things are documented correctly in MAINTAINERS then and we can continue
as before, only I will be more diligent making sure you are Cc'd and have
responded to any thinkpad-acpi.c changes. I assume two weeks is sufficient, but
may nag you after a week.

Thanks!

-- 
Darren Hart
Intel Open Source Technology Center
