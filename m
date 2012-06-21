From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input: edt-ft5x06 - Touchscreen driver for FT5x06 based
 EDT displays
Date: Thu, 21 Jun 2012 01:39:40 -0700
Message-ID: <20120621083940.GA2193@core.coreip.homeip.net>
References: <1339671707-24662-1-git-send-email-olivier@sobrie.be>
 <20120620184015.GA5390@polaris.bitmath.org>
 <4FE24024.9010807@kernelconcepts.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:44600 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758824Ab2FUIjr (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 21 Jun 2012 04:39:47 -0400
Received: by dady13 with SMTP id y13so567778dad.19
        for <linux-input@vger.kernel.org>; Thu, 21 Jun 2012 01:39:47 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4FE24024.9010807@kernelconcepts.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Simon Budig <simon.budig@kernelconcepts.de>
Cc: Henrik Rydberg <rydberg@euromail.se>, Olivier Sobrie <olivier@sobrie.be>, linux-input@vger.kernel.org, Jan Paesmans <jan.paesmans@gmail.com>, Anatolij Gustshin <agust@denx.de>, Ilya Yanok <yanok@emcraft.com>

On Wed, Jun 20, 2012 at 11:27:00PM +0200, Simon Budig wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Hi Henrik
> 
> On 06/20/2012 08:40 PM, Henrik Rydberg wrote:
> >> +/* + * Part of this code is inspired from a first version of a 
> >> driver for + * this chip sent by Simon Budig to the linux-input 
> >> mailing list + */
> > 
> > Replacing the above with the standard GPL header with both of your
> >  names ought to resolve any eventual issues, no?
> 
> Not sure. Olivier looked at an ancient version of my code, missing
> multiple review spins and tests I did in the meantime with Dmitry and
> Anatolij.
> 
> I obviously would prefer to see my driver in the kernel. Of course I
> am open to improvement suggestions, but I am not really enthusiastic
> about reviewing a driver that basically ditches most of my work.
> 
> >> +ft5x06_setting(threshold, W_REGISTER_THRESHOLD, 20, 80); 
> >> +ft5x06_setting(gain, W_REGISTER_GAIN, 0, 31); 
> >> +ft5x06_setting(offset, W_REGISTER_OFFSET, 0, 31);
> > 
> > Question: will the driver work without fiddling with these 
> > settings? If so, are they really necessary? Maybe some part could 
> > be moved to debugfs instead?
> 
> Well, these are there in my driver as well (plus the "report rate"
> setting of the sensor).
> 
> There are some parameters (gain/threshold/offset) which need tweaking
> depending on the panel glass thickness and other device-specific
> things. At least in the development phase it is necessary to tweak
> with these to figure out good settings.
> 
> Dunno if sysfs is the best place for this, but I suspect that this is
> a parameter that needs to be available at runtime as well, moving it
> e.g. to platform data might not cut it.
> 
> Anyway. I have reviewed the changes Dmitry suggested and will test
> them on real hardware tomorrow.

That would be great as I already reviewed your version. If there is
something missing from your version that is present in Olivier, I woudl
prefer getting an incremental patch.

Thanks.

-- 
Dmitry
