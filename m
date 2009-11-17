From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [Bug #14626] oops on boot starting udev
Date: Mon, 16 Nov 2009 18:04:52 -0800
Message-ID: <20091117020451.GA27967@core.coreip.homeip.net>
References: <GUZt44bIwCE.A.vLF.pSdALB@chimera> <xXQGFmujPl.A.fpF.zSdALB@chimera> <20091117011455.GA7977@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-px0-f180.google.com ([209.85.216.180]:46295 "EHLO
	mail-px0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755442AbZKQCEy (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 16 Nov 2009 21:04:54 -0500
Content-Disposition: inline
In-Reply-To: <20091117011455.GA7977@kroah.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Greg KH <greg@kroah.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, linux-input@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Kernel Testers List <kernel-testers@vger.kernel.org>, Soeren Sonnenburg <sonne@debian.org>

On Mon, Nov 16, 2009 at 05:14:55PM -0800, Greg KH wrote:
> On Mon, Nov 16, 2009 at 11:37:48PM +0100, Rafael J. Wysocki wrote:
> > This message has been generated automatically as a part of a report
> > of recent regressions.
> > 
> > The following bug entry is on the current list of known regressions
> > from 2.6.31.  Please verify if it still should be listed and let me know
> > (either way).
> > 
> > 
> > Bug-Entry	: http://bugzilla.kernel.org/show_bug.cgi?id=14626
> > Subject		: oops on boot starting udev
> > Submitter	: Soeren Sonnenburg <sonne@debian.org>
> > Date		: 2009-11-14 10:16 (3 days old)
> > References	: http://marc.info/?l=linux-kernel&m=125819380206800&w=4
> 
> This looks like an input core problem, as the evdev module was just
> loaded and died.
> 
> Any input developers have any ideas?
> 


Hmm, evdev does:

	dev_set_name(&evdev->dev, "event%d", minor);

Not sure how it can go wrong...

-- 
Dmitry
