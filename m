From: Daniel Mack <daniel@caiaq.de>
Subject: Re: [PATCH] Input: rotary_encoder cleanup
Date: Wed, 1 Jul 2009 20:49:59 +0200
Message-ID: <20090701184959.GC9464@buzzloop.caiaq.de>
References: <BD79186B4FD85F4B8E60E381CAEE1909019683A5@mi8nycmail19.Mi8.com> <20090623162126.GL29236@buzzloop.caiaq.de> <20090630023211.GC10652@dtor-d630.eng.vmware.com> <BD79186B4FD85F4B8E60E381CAEE190901A1346C@mi8nycmail19.Mi8.com> <20090701183347.GB9464@buzzloop.caiaq.de> <BD79186B4FD85F4B8E60E381CAEE190901A13867@mi8nycmail19.Mi8.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from buzzloop.caiaq.de ([212.112.241.133]:40179 "EHLO
	buzzloop.caiaq.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752456AbZGASuA (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 1 Jul 2009 14:50:00 -0400
Content-Disposition: inline
In-Reply-To: <BD79186B4FD85F4B8E60E381CAEE190901A13867@mi8nycmail19.Mi8.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: H Hartley Sweeten <hartleys@visionengravers.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org

On Wed, Jul 01, 2009 at 02:45:58PM -0400, H Hartley Sweeten wrote:
> > Hmm, and then report them all via the very same input device? Or
> > register one for each encoder? The latter could easily be done by
> > registering multiple platform_devices with different platform_data,
> > right?
> 
> I suppose each encoder could be registered individually.  Then each would
> report as a unique input device.  This should work with the driver as it
> is now.  Then drawback is if there are a number of encoders and a
> userspace app is opening all of them and doing a EVIOCGRAB it makes the
> app a bit messy.
>
> I was thinking more or passing an array of encoders to the driver and then
> having it report all of them as one input device.  That ends up being a
> lot cleaner.

I'd be fine with such a change. Just curious: how many encoders do you
have on your board?

Daniel
