From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [appleir] BUG: unable to handle kernel NULL pointer
 dereference
Date: Fri, 22 Nov 2013 13:39:47 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1311221339110.22082@pobox.suse.cz>
References: <20131029145139.GA2788@hercules> <alpine.LNX.2.00.1311061635160.835@pobox.suse.cz> <CALcaVO=jOEqCwLCMUgEkFJMcc4H6bMLU4yvjo1fJ7DeXgkZH6A@mail.gmail.com> <527BB695.9040209@redhat.com> <alpine.LNX.2.00.1311191533200.6657@pobox.suse.cz>
 <CALcaVOmCAV8XeURJ5UpWfaFXoj+bz6DZ1NgAt7Xiv5pfEynRFQ@mail.gmail.com> <alpine.LNX.2.00.1311210959170.22082@pobox.suse.cz> <20131121101316.GA3394@hercules.my.domain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:40413 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752132Ab3KVMjv (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 22 Nov 2013 07:39:51 -0500
In-Reply-To: <20131121101316.GA3394@hercules.my.domain>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Luis Henriques <luis.henriques@canonical.com>
Cc: James Henstridge <james.henstridge@canonical.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, =?ISO-8859-15?Q?Fabien_Andr=E9?= <fabien.andre@gmail.com>, Bastien Nocera <hadess@hadess.net>

On Thu, 21 Nov 2013, Luis Henriques wrote:

> > > Sorry for the delays in testing out the patch.  I have tried a kernel
> > > with the patch applied, and can no longer reproduce the oops.  The
> > > hid-appleir driver appears to be working correctly, generating key
> > > press events in response to the remote, and LIRC functions correctly
> > > via hiddev.
> > > 
> > > Thanks for the everyone's help with this.
> > 
> > Applied, thanks.
> 
> Hi Jiri,
> 
> Since this fixes an issue in a 3.11 kernel, could you please tag this
> commit for stable>=3.11?  If its too late, I can send the request to
> stable@ once this patch is merged.

Thanks for noticing. It's too late to add the tag, so if you submit it to 
-stable once it's in Linus' tree, I'll appreciate it; otherwise I'll try 
to remember to do that myself.

-- 
Jiri Kosina
SUSE Labs
