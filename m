From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: Re: [PATCH] Input: drivers/joystick: use parallel port device model
Date: Wed, 5 Aug 2015 11:57:08 +0530
Message-ID: <20150805062708.GE4958@sudip-pc>
References: <1438265194-20366-1-git-send-email-sudipm.mukherjee@gmail.com>
 <20150730165323.GC13165@dtor-ws>
 <20150731101525.GA7811@sudip-pc>
 <20150731165427.GB5613@dtor-ws>
 <20150731173426.GA23126@sudip-pc>
 <20150731203618.GA24494@kroah.com>
 <20150731204306.GM5613@dtor-ws>
 <20150803150220.GA6221@sudip-pc>
 <20150804184128.GC37185@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f41.google.com ([209.85.220.41]:35214 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751174AbbHEG1P (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 5 Aug 2015 02:27:15 -0400
Content-Disposition: inline
In-Reply-To: <20150804184128.GC37185@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Greg KH <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

On Tue, Aug 04, 2015 at 11:41:28AM -0700, Dmitry Torokhov wrote:
> On Mon, Aug 03, 2015 at 08:32:20PM +0530, Sudip Mukherjee wrote:
> > On Fri, Jul 31, 2015 at 01:43:06PM -0700, Dmitry Torokhov wrote:
> > > > 
> > > > Converting to the "new" api is the end goal here, no need to keep the
> > > > old one around anymore.
> > > 
> > > OK, then I guess we can do the conversion right (dropping db9_base
> > > module-global) and see if anyone screams at us.
> > Hi Dmitry,
<snip>	
> > NULL, but the code will get unnecessary complicated. And these are not
> > just hypothetical situtation I got them while testing.
> > I am ready to make the changes, just want your confirmation if it is
> > worth complicatng the code and taking risk just for removing one global
> > variable.
> 
> Hmm, it is quite unexpected that detach() is called even if attach() did
> not actually attach anything.
But that is the way original parallel port used to work. And this adding
the device model code was mainly done keeping the original behaviour of
the code. In the original code the register_driver did:
list_for_each_entry(port, &portlist, list)
	drv->attach(port);
list_add(&drv->list, &drivers);

And the unregister_driver did:
list_for_each_entry(port, &portlist, list)
	drv->detach(port);

So, the original code never checked if attach succeded or not, and used
to call detach whenever driver used to unregister even if attach failed.
It was on the driver to check for and maintain the status.

> Maybe it is not too late if attach() would return a pointer to:
But that will change the way the parallel port client drivers used to
work. Maybe, for now we should stick to the old existing behaviour until
all the conversion is complete (hopefully without any regression). And
after we have fully converted to device model then we can plan to improve
it.

regards
sudip
