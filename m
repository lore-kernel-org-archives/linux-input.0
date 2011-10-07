From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH] input: Fix USB autosuspend on bcm5974
Date: Fri, 7 Oct 2011 18:39:37 +0100
Message-ID: <20111007173937.GB13468@srcf.ucam.org>
References: <1317936997-20438-1-git-send-email-mjg@redhat.com>
 <20111006223835.GA30738@core.coreip.homeip.net>
 <20111006231954.GA32029@srcf.ucam.org>
 <201110070837.46926.oliver@neukum.org>
 <20111007123653.GA7325@srcf.ucam.org>
 <20111007162027.GA25307@core.coreip.homeip.net>
 <20111007162756.GA12136@srcf.ucam.org>
 <20111007170612.GA2215@polaris.bitmath.org>
 <20111007171324.GC12879@srcf.ucam.org>
 <20111007174214.GA2746@polaris.bitmath.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:52772 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753713Ab1JGRjl (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 7 Oct 2011 13:39:41 -0400
Content-Disposition: inline
In-Reply-To: <20111007174214.GA2746@polaris.bitmath.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Oliver Neukum <oliver@neukum.org>, linux-input@vger.kernel.org

On Fri, Oct 07, 2011 at 07:42:14PM +0200, Henrik Rydberg wrote:
> On Fri, Oct 07, 2011 at 06:13:25PM +0100, Matthew Garrett wrote:
> > I've seen the occasional error message on my 3,1, but I haven't seen any 
> > looping suspend/resume.
> 
> You need to sprinkle some outputs in the actual autosuspend machinery to see it.

Can you describe exactly what you're seeing?

-- 
Matthew Garrett | mjg59@srcf.ucam.org
