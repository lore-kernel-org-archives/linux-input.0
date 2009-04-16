From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] add REL_* axes support to the rotary encoder driver
Date: Wed, 15 Apr 2009 19:33:06 -0700
Message-ID: <200904151933.06721.dmitry.torokhov@gmail.com>
References: <20090303090317.GA14246@dtor-d630.eng.vmware.com> <20090416020836.GB2413@dtor-d630.eng.vmware.com> <BD79186B4FD85F4B8E60E381CAEE1909015F8DFD@mi8nycmail19.Mi8.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.236]:52083 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751080AbZDPCdO (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 15 Apr 2009 22:33:14 -0400
Received: by rv-out-0506.google.com with SMTP id f9so188470rvb.1
        for <linux-input@vger.kernel.org>; Wed, 15 Apr 2009 19:33:12 -0700 (PDT)
In-Reply-To: <BD79186B4FD85F4B8E60E381CAEE1909015F8DFD@mi8nycmail19.Mi8.com>
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: H Hartley Sweeten <hartleys@visionengravers.com>
Cc: Daniel Mack <daniel@caiaq.de>, linux-input@vger.kernel.org

On Wednesday 15 April 2009 19:24:58 H Hartley Sweeten wrote:
> On Wednesday, April 15, 2009 7:09 PM, Dmitry Torokhov wrote:
> > Hi,
> >
> > On Monday 13 April 2009 16:06:24 H Hartley Sweeten wrote:
> >> +
> >> +	unsigned int	axis;
> >> +	unsigned int	pos;
> >> +
> >> +	unsigned int	irq_a;
> >> +	unsigned int	irq_b;
> >> +
> >> +	unsigned int	abs:1;
> >> +	unsigned int	dir:1;
> >> +	unsigned int	armed:1;
> >
> > Doing it this way makes us go from simple store to read/modify/write
> > cycle in the interrupt handler.
>
> Didn't think of that. Good catch.
>
> >> +#define ROTARY_ENCODER_REL	(0<<31)
> >> +#define ROTARY_ENCODER_ABS	(1<<31)
> >
> > Meh... How about below instead?
>
> Your changes look good to me.
>
> The only issue I can see is that absolute axis encoders wrap.
>
> If you have an encoder of something like ABS_VOLUME you would probably
> want the "pos" to go from 0 to "steps" and then clamp. The encoder
> could actually rotate multiple times depending on it's actual line
> count, but the effect would be correct.

I see. Care to prepare a patch? Thanks!

-- 
Dmitry
