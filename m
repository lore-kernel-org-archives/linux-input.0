From: "Xu, Even" <even.xu@intel.com>
Subject: RE: [PATCH 7/7] misc: intel-ish-client: add intel ishtp clients
 driver
Date: Thu, 5 Jan 2017 05:38:19 +0000
Message-ID: <9577C59DB499174B9340876B077C2E9569B9A890@SHSMSX101.ccr.corp.intel.com>
References: <1482456149-4841-1-git-send-email-even.xu@intel.com>
 <1482456149-4841-7-git-send-email-even.xu@intel.com>
 <20170104130316.GA8378@kroah.com> <1483549894.4497.55.camel@linux.intel.com>
 <20170104171853.GA23715@kroah.com>
 <1483555286.4497.87.camel@linux.intel.com> <20170104194046.GA25268@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga07.intel.com ([134.134.136.100]:15572 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753322AbdAEFjH (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Thu, 5 Jan 2017 00:39:07 -0500
In-Reply-To: <20170104194046.GA25268@kroah.com>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Greg KH <gregkh@linuxfoundation.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: "jikos@kernel.org" <jikos@kernel.org>, "benjamin.tissoires@redhat.com" <benjamin.tissoires@redhat.com>, "arnd@arndb.de" <arnd@arndb.de>, "Shevchenko, Andriy" <andriy.shevchenko@intel.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

Hi, Greg,

Thanks for your review and suggestion, I will rework my patch based on your suggestion and then submit again.

Best Regards,
Even Xu

-----Original Message-----
From: Greg KH [mailto:gregkh@linuxfoundation.org] 
Sent: Thursday, January 5, 2017 3:41 AM
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: Xu, Even <even.xu@intel.com>; jikos@kernel.org; benjamin.tissoires@redhat.com; arnd@arndb.de; Shevchenko, Andriy <andriy.shevchenko@intel.com>; linux-input@vger.kernel.org; linux-kernel@vger.kernel.org
Subject: Re: [PATCH 7/7] misc: intel-ish-client: add intel ishtp clients driver

On Wed, Jan 04, 2017 at 10:41:26AM -0800, Srinivas Pandruvada wrote:
> On Wed, 2017-01-04 at 18:18 +0100, Greg KH wrote:
> > On Wed, Jan 04, 2017 at 09:11:34AM -0800, Srinivas Pandruvada wrote:
> > > 
> > > On Wed, 2017-01-04 at 14:03 +0100, Greg KH wrote:
> > > > 
> > > > On Fri, Dec 23, 2016 at 09:22:29AM +0800, Even Xu wrote
> > > > > 
> [...]
> 
> > debug should not require a char device node, use debugfs, that is 
> > what it is there for.
> > 
> > For "calibration", why not use configfs or even sysfs?
> 
> We will check on this. There is some legacy with the deployed user 
> space tools.

Um, you do know that's not a good reason/excuse at all to take incorrect kernel code, right?  Please don't use that as any kind of excuse.

> > > Basically the ISH provided a standalone low power processor to 
> > > developers and manufacturers  to do download some custom 
> > > algorithms for sensors, which may not be compliant to USB HID 
> > > sensor specifications (mostly for IOT space). In that case the 
> > > user space for those can communicate using misc driver interface, 
> > > without adding new kernel drivers.
> > 
> > So you hide it behind a char device node?  That's not very 
> > descriptive or easy to understand :)
> We added several new sensors to IIO and in process of adding new 
> sensors to standardize ABI for sensors defined in HID sensor spec.
> 
> Customers can develop and download some algorithm which uses output of 
> several sensors and come up with some fusion sensor to detect some 
> activity. Either some kernel driver needs to read this and pass this 
> event to user space or directly let the user space communicate with 
> the firmware using character device.
> Is there any better way to handle this?
> 
> We want customers to use upstream kernel without out of tree kernel 
> drivers.

Why are you somehow claiming this is an either/or kind of situation?
What out-of-tree kernel modules are there?  Why can't they just be merged if they are somewhere?

Having an interface to add new types of "functionality" is great, and fine, but why you think a char device node is that type of api is confusing to me when I already pointed out an number of other potential solutions.  Have you tried them out and found they do not work?  If so, great, please explain what is lacking and we can go from there.

If not, please do some basic research first before trying to claim that a char device is the only possible solution.

You have run this code through the internal Intel kernel developer review process on their mailing list, correct?  What did they say about your current design?  If not, why have you not taken advantage of this resource?

thanks,

greg k-h
