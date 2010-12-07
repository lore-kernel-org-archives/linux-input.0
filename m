From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [RFC][PATCH] input: Introduce device information ioctl
Date: Tue, 7 Dec 2010 08:48:12 -0800
Message-ID: <20101207164811.GA25344@core.coreip.homeip.net>
References: <1291706726-8835-1-git-send-email-rydberg@euromail.se>
 <20101207162222.GA32237@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:38088 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750916Ab0LGQs2 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 7 Dec 2010 11:48:28 -0500
Content-Disposition: inline
In-Reply-To: <20101207162222.GA32237@kroah.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Greg KH <greg@kroah.com>
Cc: Henrik Rydberg <rydberg@euromail.se>, Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Ping Cheng <pingc@wacom.com>, Chris Bagwell <chris@cnpbagwell.com>

On Tue, Dec 07, 2010 at 08:22:22AM -0800, Greg KH wrote:
> On Tue, Dec 07, 2010 at 08:25:26AM +0100, Henrik Rydberg wrote:
> >  /**
> > + * struct input_devinfo - device information via EVIOCGDEVINFO ioctl
> > + * @types: bitmask of types (DEVTYPE_*) matching this device
> > + * @capabilities: bitmask of capabilities (DEVCAPS_*) of this device
> > + *
> > + * This struct provides information about the device needed for
> > + * automatic setup in userspace, such as if the device is direct
> > + * (touchscreen) or indirect (touchpad), and if there are other
> > + * special considerations, such as the touchpad also being a button.
> > + */
> > +struct input_devinfo {
> > +	__u32 types;
> > +	__u32 capabilities;
> > +};
> 
> Why use an ioctl for this at all?  It's just 2 simple values that don't
> need to be atomically read at the same time.  What's wrong with 2 more
> sysfs files?
> 

Because if you already dealing with a file descriptor ioctl is much more
convenient. Sysfs can be nice (and that is why we'll add it as well) but
it is not a recipe for the world peace.

-- 
Dmitry
