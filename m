From: Daniel Mack <daniel@caiaq.de>
Subject: Re: [PATCH] Input: rotary_encoder cleanup
Date: Wed, 1 Jul 2009 20:33:47 +0200
Message-ID: <20090701183347.GB9464@buzzloop.caiaq.de>
References: <BD79186B4FD85F4B8E60E381CAEE1909019683A5@mi8nycmail19.Mi8.com> <20090623162126.GL29236@buzzloop.caiaq.de> <20090630023211.GC10652@dtor-d630.eng.vmware.com> <BD79186B4FD85F4B8E60E381CAEE190901A1346C@mi8nycmail19.Mi8.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from buzzloop.caiaq.de ([212.112.241.133]:42836 "EHLO
	buzzloop.caiaq.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755574AbZGASdr (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 1 Jul 2009 14:33:47 -0400
Content-Disposition: inline
In-Reply-To: <BD79186B4FD85F4B8E60E381CAEE190901A1346C@mi8nycmail19.Mi8.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: H Hartley Sweeten <hartleys@visionengravers.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org

On Tue, Jun 30, 2009 at 11:56:36AM -0400, H Hartley Sweeten wrote:
> On Monday, June 29, 2009 7:32 PM, Dmitry Torokhov wrote:
> > Do we know how many encoders we need to have in the system to start
> > seeing the benefits (given that all these conversions increase text
> > size)?
> 
> Hmm.. Didn't think about that. How do you determine the text size?

'objdump -h'?

> I am trying to work out a clean way to pass an array of encoders from
> the platform init file so that multiple devices can be handled by the
> driver.  That was what prompted the change.

Hmm, and then report them all via the very same input device? Or
register one for each encoder? The latter could easily be done by
registering multiple platform_devices with different platform_data,
right?

Daniel
