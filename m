From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 01/15] Input: synaptics-rmi4 - fix checkpatch.pl, sparse and GCC warnings
Date: Thu, 13 Feb 2014 11:10:29 -0800
Message-ID: <2278620.abrl2TfnmQ@dtor-d630.eng.vmware.com>
References: <1390521623-6491-1-git-send-email-courtney.cavin@sonymobile.com> <20140213063611.GB15260@core.coreip.homeip.net> <52FD1559.2040101@synaptics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pd0-f182.google.com ([209.85.192.182]:39744 "EHLO
	mail-pd0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751065AbaBMTKd (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 13 Feb 2014 14:10:33 -0500
Received: by mail-pd0-f182.google.com with SMTP id v10so10837844pde.41
        for <linux-input@vger.kernel.org>; Thu, 13 Feb 2014 11:10:33 -0800 (PST)
In-Reply-To: <52FD1559.2040101@synaptics.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Christopher Heiny <cheiny@synaptics.com>
Cc: Courtney Cavin <courtney.cavin@sonymobile.com>, linux-input@vger.kernel.org

On Thursday, February 13, 2014 10:56:25 AM Christopher Heiny wrote:
> On 02/12/2014 10:36 PM, Dmitry Torokhov wrote:
> > On Wed, Feb 05, 2014 at 05:36:09PM -0800, Christopher Heiny wrote:
> >> >On 02/05/2014 05:09 PM, Dmitry Torokhov wrote:
> >>> > >On Tue, Feb 04, 2014 at 03:08:12PM -0800, Christopher Heiny wrote:
> >>>>> > >>>On 01/23/2014 04:00 PM, Courtney Cavin wrote:
> >>>>>>> > >>>> >Cc: Christopher Heiny<cheiny@synaptics.com>
> >>>>>>> > >>>> >Cc: Dmitry Torokhov<dmitry.torokhov@gmail.com>
> >>>>>>> > >>>> >Signed-off-by: Courtney Cavin<courtney.cavin@sonymobile.com>
> >>>>>>> > >>>> >---
> >>>>>>> > >>>> >
> >>>>>>> > >>>> >  drivers/input/rmi4/rmi_bus.c    |  4 ++--
> >>>>>>> > >>>> >  drivers/input/rmi4/rmi_bus.h    |  2 +-
> >>>>>>> > >>>> >  drivers/input/rmi4/rmi_driver.c | 17 ++++++++++++-----
> >>>>>>> > >>>> >  drivers/input/rmi4/rmi_f11.c    |  4 +++-
> >>>>>>> > >>>> >  4 files changed, 18 insertions(+), 9 deletions(-)
> >>>>>>> > >>>> >
> >>>>>>> > >>>> >diff --git a/drivers/input/rmi4/rmi_bus.c
> >>>>>>> > >>>> >b/drivers/input/rmi4/rmi_bus.c
> >>>>>>> > >>>> >index 96a76e7..8a939f3 100644
> >>>>>>> > >>>> >--- a/drivers/input/rmi4/rmi_bus.c
> >>>>>>> > >>>> >+++ b/drivers/input/rmi4/rmi_bus.c
> >>>>>>> > >>>> >@@ -37,7 +37,7 @@ static void rmi_release_device(struct
> >>>>>>> > >>>> >device *dev)
> >>>>>>> > >>>> >
> >>>>>>> > >>>> >  	kfree(rmi_dev);
> >>>>>>> > >>>> >  
> >>>>>>> > >>>> >  }
> >>>>>>> > >>>> >
> >>>>>>> > >>>> >-struct device_type rmi_device_type = {
> >>>>>>> > >>>> >+static struct device_type rmi_device_type = {
> >>>>>>> > >>>> >
> >>>>>>> > >>>> >  	.name		= "rmi_sensor",
> >>>>>>> > >>>> >  	.release	= rmi_release_device,
> >>>>>>> > >>>> >  
> >>>>>>> > >>>> >  };
> >>>>> > >>>
> >>>>> > >>>This struct is used by diagnostic modules to identify sensor
> >>>>> > >>>devices, so it cannot be static.
> >>> > >
> >>> > >Then we need to declare it somewhere or provide an accessor function.
> >> >
> >> >Currently it's in a header not included in the patches.  We'll move
> >> >it to rmi_bus.h.
> > 
> > Hmm, we do have rmi_is_physical_device() to identify whether it is a
> > sensor or a function, so I believe we should mark all structures static
> > to avoid anyone poking at them.
> 
> I was poking around in the dependent code late last night and came to
> the same conclusion.  I'll send a micropatch later today to get it out
> of the way.

No need, I untangled relevant bits from the one Courtney sent.

Thanks.

-- 
Dmitry
