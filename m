From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: Re: [PATCH] Input: drivers/joystick: use parallel port device model
Date: Sat, 1 Aug 2015 18:13:48 +0530
Message-ID: <20150801124348.GA10147@sudip-pc>
References: <1438265194-20366-1-git-send-email-sudipm.mukherjee@gmail.com>
 <20150730165323.GC13165@dtor-ws>
 <20150731101525.GA7811@sudip-pc>
 <20150731165427.GB5613@dtor-ws>
 <20150731173426.GA23126@sudip-pc>
 <20150731203618.GA24494@kroah.com>
 <20150731204306.GM5613@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f50.google.com ([209.85.220.50]:33667 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751180AbbHAMol (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sat, 1 Aug 2015 08:44:41 -0400
Content-Disposition: inline
In-Reply-To: <20150731204306.GM5613@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Greg KH <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

On Fri, Jul 31, 2015 at 01:43:06PM -0700, Dmitry Torokhov wrote:
> On Fri, Jul 31, 2015 at 01:36:18PM -0700, Greg KH wrote:
> > On Fri, Jul 31, 2015 at 11:04:26PM +0530, Sudip Mukherjee wrote:
> > > On Fri, Jul 31, 2015 at 09:54:27AM -0700, Dmitry Torokhov wrote:
> > > > On Fri, Jul 31, 2015 at 03:45:25PM +0530, Sudip Mukherjee wrote:
> > > > > On Thu, Jul 30, 2015 at 09:53:23AM -0700, Dmitry Torokhov wrote:
> > > > > > Hi Sudip,
> > > > > Hi Dmitry,
> > > > > > 
> > > > > > On Thu, Jul 30, 2015 at 07:36:34PM +0530, Sudip Mukherjee wrote:
<snip>
> > > > 
> > > > No, unfortunately I do not.
> > > > 
> > > > Since neither of us can test the change what is the benefit of doing the
> > > > conversion? What will be gained by doing it? Are there plans for parport
> > > > subsystem to remove the old style initialization?
> > > Yes, that is the plan. Well, if you are not comfortable with introducing
> > > attach and detach functions then this can be done in another way where
> > > there will be very minimum change in the code. But I will prefer to have
> > > attach and detach then it can take advantage of the hotplug feature.
> > > Adding Greg in To: list for his comments.
> > 
> > Converting to the "new" api is the end goal here, no need to keep the
> > old one around anymore.
> 
> OK, then I guess we can do the conversion right (dropping db9_base
> module-global) and see if anyone screams at us.
I am working on it now to remove db9_base. But in the detach callback we
will get struct parport * and from parport to get a pardevice we need to
get it from port->physport->devices. Since it is having PARPORT_FLAG_EXCL
it is ok, but should we really depend on and work with the internal data
structures of the parport rather than working with the exported api?

regards
sudip
