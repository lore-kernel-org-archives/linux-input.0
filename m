From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] generic driver for rotary encoders on GPIOs
Date: Tue, 3 Mar 2009 01:03:29 -0800
Message-ID: <20090303090317.GA14246@dtor-d630.eng.vmware.com>
References: <20090227064314.GB32470@buzzloop.caiaq.de> <1235757652-16514-1-git-send-email-daniel@caiaq.de> <BD79186B4FD85F4B8E60E381CAEE190901349198@mi8nycmail19.Mi8.com> <20090227183449.GD8855@buzzloop.caiaq.de> <BD79186B4FD85F4B8E60E381CAEE190901349253@mi8nycmail19.Mi8.com> <20090302144308.GB11072@buzzloop.caiaq.de> <20090303085200.GA13793@dtor-d630.eng.vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from qw-out-2122.google.com ([74.125.92.24]:54714 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755011AbZCCJDk (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 3 Mar 2009 04:03:40 -0500
Received: by qw-out-2122.google.com with SMTP id 5so4066725qwi.37
        for <linux-input@vger.kernel.org>; Tue, 03 Mar 2009 01:03:37 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20090303085200.GA13793@dtor-d630.eng.vmware.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Daniel Mack <daniel@caiaq.de>
Cc: linux-input@vger.kernel.org

On Tue, Mar 03, 2009 at 12:52:00AM -0800, Dmitry Torokhov wrote:
> Hi Daniel,
> 
> On Mon, Mar 02, 2009 at 03:43:08PM +0100, Daniel Mack wrote:
> > On Fri, Feb 27, 2009 at 03:15:23PM -0500, hartleys wrote:
> > > Not sure if it matters but you can add my Tested-by if you like.
> > > 
> > > Tested-by: H Hartley Sweeten <hsweeten@visionengravers.com>
> > > 
> > > >> I have a minor patch to it that allows the platform init to
> > > >> configure the absolute/relative axis to report the encoder on.
> > > >> If you would like to see it I can put together a patch.
> > > >
> > > > Yes, and probably just post it as follow-up as soon as this one
> > > > has been commited. I'm new to this list, so I don't know who
> > > > can/will/wants to do this?
> > > 
> > > Dmitry Torokhov is listed as the maintainer of the input drivers.  I
> > > think he needs to Ack the driver in order for it to be accepted and then
> > > committed to the kernel.
> > 
> > Dmitry, are you willing to take this patch? Just wanted to make sure
> > it's not getting lost :)
> > 
> 
> I am willing, however I would like you to change it so you call
> input_unregister_device() instead of input_free_device() in cases
> when input device was successfully registered with the input core.
> When input_register_device() fails (or if it wasn't invoked) then
> you should call input_free_device().
> 
> Thanks!
> 

BTW, you should probably make the axis configurable via platform data
instead of hardcoding it to ABS_X.

-- 
Dmitry
