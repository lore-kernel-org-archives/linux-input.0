From: "Henrik Rydberg" <rydberg@euromail.se>
Subject: Re: [PATCH] input: Fix USB autosuspend on bcm5974
Date: Fri, 7 Oct 2011 20:13:10 +0200
Message-ID: <20111007181310.GA2762@polaris.bitmath.org>
References: <20111006223835.GA30738@core.coreip.homeip.net>
 <20111006231954.GA32029@srcf.ucam.org>
 <201110070837.46926.oliver@neukum.org>
 <20111007123653.GA7325@srcf.ucam.org>
 <20111007162027.GA25307@core.coreip.homeip.net>
 <20111007162756.GA12136@srcf.ucam.org>
 <20111007170612.GA2215@polaris.bitmath.org>
 <20111007171324.GC12879@srcf.ucam.org>
 <20111007174214.GA2746@polaris.bitmath.org>
 <20111007173937.GB13468@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtprelay-b11.telenor.se ([62.127.194.20]:41469 "EHLO
	smtprelay-b11.telenor.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751812Ab1JGSGx (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 7 Oct 2011 14:06:53 -0400
Received: from iph4.telenor.se (iph4.telenor.se [195.54.127.135])
	by smtprelay-b11.telenor.se (Postfix) with ESMTP id 1D1DDEA9E1
	for <linux-input@vger.kernel.org>; Fri,  7 Oct 2011 20:06:51 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20111007173937.GB13468@srcf.ucam.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Oliver Neukum <oliver@neukum.org>, linux-input@vger.kernel.org

On Fri, Oct 07, 2011 at 06:39:37PM +0100, Matthew Garrett wrote:
> On Fri, Oct 07, 2011 at 07:42:14PM +0200, Henrik Rydberg wrote:
> > On Fri, Oct 07, 2011 at 06:13:25PM +0100, Matthew Garrett wrote:
> > > I've seen the occasional error message on my 3,1, but I haven't seen any 
> > > looping suspend/resume.
> > 
> > You need to sprinkle some outputs in the actual autosuspend machinery to see it.
> 
> Can you describe exactly what you're seeing?

With a corrected version of your patch, which enables autosuspend
while the device file is open, I see the power layer repeatedly
suspending and resuming the usb device in question, even while
constantly moving a finger around on the pad. In conjunction with this
behavior, I see error messages indicating unknown/faulty packets
appearing in the bcm5974 interrupt handler.

For the next version of the patch, please add a) why you want to
change the current behavior, b) what the patch is supposed to do, and
c) what exact devices are known to work with the patch.

If there are any strange error messages appearing as a result of the
patch, mentioning them would be minimum. Better yet, an explanation of
why they appear, or how an improved patch makes them disappear would
be great.

Thanks,
Henrik
