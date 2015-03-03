From: Darren Hart <dvhart@infradead.org>
Subject: Re: [ibm-acpi-devel] [PATCH 1/7] thinkpad_acpi: Remember adaptive
 kbd presence
Date: Tue, 3 Mar 2015 08:52:25 -0800
Message-ID: <20150303165225.GD83894@vmdeb7>
References: <1424443450.22910.13.camel@hadess.net>
 <20150226061814.GC7331@fury.dvhart.com>
 <1425035130.1995042.233191101.57145444@webmail.messagingengine.com>
 <1425035779.2000837.233193809.65561A3E@webmail.messagingengine.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <platform-driver-x86-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1425035779.2000837.233193809.65561A3E@webmail.messagingengine.com>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: Bastien Nocera <hadess@hadess.net>, Jiri Kosina <jkosina@suse.cz>, linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org, ibm-acpi-devel@lists.sourceforge.net, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Fri, Feb 27, 2015 at 08:16:19AM -0300, Henrique de Moraes Holschuh wrote:
> On Fri, Feb 27, 2015, at 08:05, Henrique de Moraes Holschuh wrote:
> > On Thu, Feb 26, 2015, at 03:18, Darren Hart wrote:
> > > On Fri, Feb 20, 2015 at 03:44:10PM +0100, Bastien Nocera wrote:
> > > > Rather than checking on each suspend and resume whether the laptop
> > > > has an adaptive keyboard, check when the driver is initialised.
> > > 
> > > Bastien, am I awaiting another version of this from you to address
> > > comments from
> > > Henrique?
> > > 
> > > Henrique, when you're satisfied, please provide a Reviewed-by for the
> > > series.
> > 
> > I usually provide a signed-off-by, as I am the thinkpad-acpi driver
> > maintainer... reviewed-by is implied in that case.
> 
> Or an Acked-by, for that matter.  Which is what I'd use for this series,
> since there is no reason to gatekeep it and it is being sent to you
> directly.
> 

Henrique, I believe I may have overstepped with thinkpad-acpi and dealt with it
like the other drivers in platform/drivers/x86, when instead I should have been
leaving it to you. My apologies, it was not intentional.

Do you typically send pull-requests for the thinkpad-acpi driver
directly to Linus? Geeze, I see that the tree listed in MAINTAINERS is not even
mine. Ugh, my sincere apologies.

I would be more than happy to basically ignore anything to thinkpad-acpi until
after you have provided a review. I can also roll up pull requests from you if
you prefer to integrate into the platform-drivers-x86 tree as the path to Linus.

How do you want to handle your driver?

-- 
Darren Hart
Intel Open Source Technology Center
