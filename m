From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: rotary_encoder cleanup
Date: Wed, 8 Jul 2009 21:17:51 -0700
Message-ID: <20090709041751.GA10415@dtor-d630.eng.vmware.com>
References: <BD79186B4FD85F4B8E60E381CAEE1909019683A5@mi8nycmail19.Mi8.com> <20090623162126.GL29236@buzzloop.caiaq.de> <20090630023211.GC10652@dtor-d630.eng.vmware.com> <BD79186B4FD85F4B8E60E381CAEE190901A1346C@mi8nycmail19.Mi8.com> <20090701183347.GB9464@buzzloop.caiaq.de> <BD79186B4FD85F4B8E60E381CAEE190901A13867@mi8nycmail19.Mi8.com> <20090708065650.GG3309@dtor-d630.eng.vmware.com> <BD79186B4FD85F4B8E60E381CAEE190901A689B9@mi8nycmail19.Mi8.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.236]:46573 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750825AbZGIER6 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 9 Jul 2009 00:17:58 -0400
Received: by rv-out-0506.google.com with SMTP id k40so1314635rvb.5
        for <linux-input@vger.kernel.org>; Wed, 08 Jul 2009 21:17:57 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <BD79186B4FD85F4B8E60E381CAEE190901A689B9@mi8nycmail19.Mi8.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: H Hartley Sweeten <hartleys@visionengravers.com>
Cc: Daniel Mack <daniel@caiaq.de>, linux-input@vger.kernel.org

On Wed, Jul 08, 2009 at 05:47:07PM -0400, H Hartley Sweeten wrote:
> On Tuesday, July 07, 2009 11:57 PM, Dmitry Torokhov wrote:
> > On Wed, Jul 01, 2009 at 02:45:58PM -0400, H Hartley Sweeten wrote:
> >> On Wednesday, July 01, 2009 11:34 AM, Daniel Mack wrote:
> >>> On Tue, Jun 30, 2009 at 11:56:36AM -0400, H Hartley Sweeten wrote:
> >>>> On Monday, June 29, 2009 7:32 PM, Dmitry Torokhov wrote:
> >>>>> Do we know how many encoders we need to have in the system to start
> >>>>> seeing the benefits (given that all these conversions increase text
> >>>>> size)?
> >>>> 
> >>>> Hmm.. Didn't think about that. How do you determine the text size?
> >>> 
> >>> 'objdump -h'?
> >> 
> >> Thanks.
> >> 
> >>>> I am trying to work out a clean way to pass an array of encoders
> >>>> from the platform init file so that multiple devices can be handled
> >>>> by the driver.  That was what prompted the change.
> >>> 
> >>> Hmm, and then report them all via the very same input device? Or
> >>> register one for each encoder? The latter could easily be done by
> >>> registering multiple platform_devices with different platform_data,
> >>> right?
> >> 
> >> I suppose each encoder could be registered individually.  Then each
> >> would report as a unique input device.  This should work with the
> >> driver as it is now.  Then drawback is if there are a number of
> >> encoders and a userspace app is opening all of them and doing a
> >> EVIOCGRAB it makes the app a bit messy.
> >> 
> >> I was thinking more or passing an array of encoders to the driver and
> >> then having it report all of them as one input device.  That ends up
> >> being a lot cleaner.
> >>
> >
> > Hmm, what axis will they be reporting though? Seems like very
> > specialized [ab]use if they all share the same input device...
> 
> Each encoder reports as a unique axis.  They just all share one input
> device.
> 

Well, if they truly represent X and Y axes then sharing the same input
device is proper. However if you are using single input just to simplify
userspace application and events reported do not really represent
movement for the axis specified - that would be bad.

-- 
Dmitry
