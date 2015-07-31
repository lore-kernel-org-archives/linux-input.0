From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: drivers/joystick: use parallel port device model
Date: Fri, 31 Jul 2015 09:54:27 -0700
Message-ID: <20150731165427.GB5613@dtor-ws>
References: <1438265194-20366-1-git-send-email-sudipm.mukherjee@gmail.com>
 <20150730165323.GC13165@dtor-ws>
 <20150731101525.GA7811@sudip-pc>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pd0-f177.google.com ([209.85.192.177]:35776 "EHLO
	mail-pd0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752110AbbGaQyb (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 31 Jul 2015 12:54:31 -0400
Content-Disposition: inline
In-Reply-To: <20150731101525.GA7811@sudip-pc>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

On Fri, Jul 31, 2015 at 03:45:25PM +0530, Sudip Mukherjee wrote:
> On Thu, Jul 30, 2015 at 09:53:23AM -0700, Dmitry Torokhov wrote:
> > Hi Sudip,
> Hi Dmitry,
> > 
> > On Thu, Jul 30, 2015 at 07:36:34PM +0530, Sudip Mukherjee wrote:
> > > Modify db9 driver to use the new Parallel Port device model.
> > > 
> > > Signed-off-by: Sudip Mukherjee <sudip@vectorindia.org>
> > > ---
> > > 
> > > It will generate a checkpatch warning about long line but I have not
> > > changed it as it was only 2 char more and for 2 char it is more readable
> > > now.
> > 
> > You can also write it as
> > 
> > 	if (!have_dev)
> > 		return -ENODEV;
> > 
> > 	return parport_register_driver(...);
> sure.
> > 
> > 
> > Could you please tell me how you tested this change? With these devices
> > becoming exceedingly rare just compile-tested changes may introduce
> > regressions that are not easily noticed.
> I dont have the device. It was just tested with module loading,
> unloading, bind and unbind and checking that it is getting attached
> properly. Also checked that with lp loaded, this driver fails to load.
> Since the modification is only in the init, exit and probe
> section so that should not affect the working of the driver. After the
> driver loads and gets access to the parport and binds to it then these
> sections have done their part. After that the db9_open and other old
> functions will be responsible and since I have not touched those
> functions so theoretically there should not be any regressions.
> > 
> <snip>
> > > 
> > > +
> > > +	for (i = 0; i < DB9_MAX_PORTS; i++) {
> > > +		if (db9_cfg[i].nargs == 0 ||
> > > +		    db9_cfg[i].args[DB9_ARG_PARPORT] < 0)
> > > +			continue;
> > > +
> > > +		if (db9_cfg[i].nargs < 2) {
> > > +			pr_warn("db9.c: Device type must be specified.\n");
> > > +			return;
> > > +		}
> > > +
> > > +		if (db9_cfg[i].args[DB9_ARG_PARPORT] == pp->number)
> > > +			break;
> > > +	}
> > > +
> > > +	if (i == DB9_MAX_PORTS) {
> > > +		pr_debug("Not using parport%d.\n", pp->number);
> > > +		return;
> > > +	}
> > 
> > Why do we validate module options in attach() instead of how we did this
> > in module init function? By doing this here we losing the ability to
> > abort module loading when parameters are invalid.
> It is there in the module_init. The same check was added here also.
> we can remove the check for db9_cfg[i].nargs < 2 from here.
> But the other one will be required to check for the port to which we
> need to register.
> > 
> > > +
> <snip>
> > >  
> > > -	parport_put_port(pp);
> > > -	return db9;
> > > +	db9_base[i] = db9;
> > 
> > Instead of using static array maybe store db9 in pardevice's private
> > pointer? Given that we are using parport exclusively on detach we can
> > just get the first pardevice and get db9 from it.
> Well, yes... Actually I wanted to do this with the minimum possible code
> change so that any chance of regression can be avoided. This should not
> have any problem, but I am a bit hesitant as this can not be tested on
> real hardware. If you confirm then I will make it this way in v2.
> By any chance, do you have the hardware?

No, unfortunately I do not.

Since neither of us can test the change what is the benefit of doing the
conversion? What will be gained by doing it? Are there plans for parport
subsystem to remove the old style initialization?

Thanks.

-- 
Dmitry
