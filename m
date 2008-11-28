From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: New Force Feedback device support - GreenAsia 0x12
Date: Fri, 28 Nov 2008 15:21:34 +0100 (CET)
Message-ID: <alpine.LNX.1.10.0811281514210.19853@jikos.suse.cz>
References: <200811262333.45245.lukasz@lubojanski.info> <alpine.LRH.1.10.0811271337320.26670@twin.jikos.cz> <200811280718.23274.lukasz@lubojanski.info>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="336216065-1040901422-1227881951=:19853"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from styx.suse.cz ([82.119.242.94]:48921 "EHLO mail.suse.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752279AbYK1OVf (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 28 Nov 2008 09:21:35 -0500
In-Reply-To: <200811280718.23274.lukasz@lubojanski.info>
Content-ID: <alpine.LNX.1.10.0811281519360.19853@jikos.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?ISO-8859-2?Q?=A3ukasz_Luboja=F1ski?= <lukasz@lubojanski.info>
Cc: linux-input@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--336216065-1040901422-1227881951=:19853
Content-Type: TEXT/PLAIN; CHARSET=ISO-8859-2
Content-Transfer-Encoding: 8BIT
Content-ID: <alpine.LNX.1.10.0811281519361.19853@jikos.suse.cz>

On Fri, 28 Nov 2008, £ukasz Lubojañski wrote:

> > Could you please rebase your patch on top of current state of Linus'
> > kernel tree for 2.6.28-rc? Then the code could be reviewed and I'll merge
> > it through my tree.
> > For inspiration, you can look into
> >
> > 	drivers/hid/hid-pl.c
> >
> > That driver even contains support for some Greenasia device ... (0x0003).
> I have rewriten the code for 2.6.28-rc6 and after testing and checking 
> it with checkpatch I will send it again.

Great, thanks.

> Anyway I know that pantherlord code is also supporting greenasia devices 
> (first code was also mostly taken from that) - and I'm still don't know 
> if I'm dooing right naming my part "greenasia" - because some people 
> could get confused. It could also happen that someone else will 
> implement other greenasia device and this will make another confusion.

The question is how much the protocol that is used by your device differs 
from the one that is already implemented in hid-pl.c? Would it make sense 
to have these two implementations in the same driver, or is the protocol 
just completely different?

> ps. Do I need to ask Manta and SpeedLink for permission of using they 
> company and product names in descriptions ?

I seriously hope you don't have to, we will all be violating this all the 
time. But I am not a lawyer, of course :)

Thanks,

-- 
Jiri Kosina
SUSE Labs
--336216065-1040901422-1227881951=:19853--
