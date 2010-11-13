From: Greg KH <gregkh@suse.de>
Subject: Re: [PATCH 2/2] HID: roccat: using new sysfs_create_bin_group() in
 kone driver
Date: Fri, 12 Nov 2010 16:52:32 -0800
Message-ID: <20101113005232.GA20865@suse.de>
References: <1289585921.2629.13.camel@neuromancer>
 <AANLkTik4qPyBtKgJwHVnhkTASNORoKrWms6gk8NirYeU@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:45146 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752845Ab0KMAxz (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 12 Nov 2010 19:53:55 -0500
Content-Disposition: inline
In-Reply-To: <AANLkTik4qPyBtKgJwHVnhkTASNORoKrWms6gk8NirYeU@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Eric Biederman <ebiederm@aristanetworks.com>
Cc: Stefan Achatz <stefan_achatz@web.de>, "Serge E. Hallyn" <serue@us.ibm.com>, Tejun Heo <tj@kernel.org>, Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Benjamin Thery <benjamin.thery@bull.net>

On Fri, Nov 12, 2010 at 04:21:45PM -0800, Eric Biederman wrote:
> On Fri, Nov 12, 2010 at 10:18 AM, Stefan Achatz <stefan_achatz@web.de> wrote:
> > hid-roccat-kone now uses new group functions for creating binary
> > sysfs attributes.
> 
> Looking at this, I have a problem with the way this works.
> You are still doing this the hard and racy way.
> 
> sysfs attributes that are only added when we initialize the hardware and
> are only removed when we remove the driver should use the device layer
> functions to create their attributes.
> 
> This achieves two things.  The code is easier to write because there
> is less of it.
> The notification to user space happens after the attributes appear so
> that you don't
> have strange hotplug races.
> 
> If there a chance you can look at implementing this in the simpler
> race free way?

Good point, just attach this attribute group to the device and the
driver core will automatically create the files for you.

thanks,

greg k-h
