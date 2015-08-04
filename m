From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: drivers/joystick: use parallel port device model
Date: Tue, 4 Aug 2015 11:41:28 -0700
Message-ID: <20150804184128.GC37185@dtor-ws>
References: <1438265194-20366-1-git-send-email-sudipm.mukherjee@gmail.com>
 <20150730165323.GC13165@dtor-ws>
 <20150731101525.GA7811@sudip-pc>
 <20150731165427.GB5613@dtor-ws>
 <20150731173426.GA23126@sudip-pc>
 <20150731203618.GA24494@kroah.com>
 <20150731204306.GM5613@dtor-ws>
 <20150803150220.GA6221@sudip-pc>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f50.google.com ([209.85.220.50]:34306 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752370AbbHDSlb (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 4 Aug 2015 14:41:31 -0400
Content-Disposition: inline
In-Reply-To: <20150803150220.GA6221@sudip-pc>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc: Greg KH <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

On Mon, Aug 03, 2015 at 08:32:20PM +0530, Sudip Mukherjee wrote:
> On Fri, Jul 31, 2015 at 01:43:06PM -0700, Dmitry Torokhov wrote:
> > > 
> > > Converting to the "new" api is the end goal here, no need to keep the
> > > old one around anymore.
> > 
> > OK, then I guess we can do the conversion right (dropping db9_base
> > module-global) and see if anyone screams at us.
> Hi Dmitry,
> It might become a scream-able condition if we put the pointer to db9 in
> the private of pardevice. I was doing par_dev->private = db9;
> and while in detach I was doing
> struct db9 *db9 = port->physport->devices->private;
> 
> Now consider these three situtaions:
> 1) We have two parallel ports. db9 is attached and registered with
> parport0. Now parport1 is removed. So the removal of parport1 will be
> announced to all the drivers which are registered with parallel port
> bus. And so our detach callback is called with parport1 as the argument.
> Now the detach function should check if it is using that port but db9
> has the portnumber data and we have stored db9 in the private so we
> try to do: struct db9 *db9 = port->physport->devices->private; and BANG
> (we have not used parport1).
> 
> 2) Again we have two parallel ports. we are connected to parport1 and
> parport0 is empty. We try to remove db9 module.
> parport_unregister_driver() will call the detach callback with all the
> ports available with the parallel port bus. So db9_detach() is called
> with parport0 and we try to do:
> struct db9 *db9 = port->physport->devices->private; and OOPS, no device
> is using parport0 and so physport->devices is still NULL.
> 
> 3) We have one parallel port and lp is already loaded. We try to load
> db9 and the driver is loaded but it is not able to register the device.
> So we try to rmmod the module and the detach is called with the
> parport0. But we still have not registred with parport0 and since we
> donot have db9_base with us we have no way of knowing that we are
> registered or not.
> 
> If you still want to remove db9_base we can do by checking the device
> name in the detach function and by testing port->physport->devices for
> NULL, but the code will get unnecessary complicated. And these are not
> just hypothetical situtation I got them while testing.
> I am ready to make the changes, just want your confirmation if it is
> worth complicatng the code and taking risk just for removing one global
> variable.

Hmm, it is quite unexpected that detach() is called even if attach() did
not actually attach anything. Maybe it is not too late if attach() would
return a pointer to:

	struct pp_client {
		struct parport_driver *driver;
		struct list_head node;
	}

that drivers can embed into their structure.

Or maybe do something similar to input core with input_handle tying
input device with one or several input handlers.

Thanks.

-- 
Dmitry
