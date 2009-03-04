From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 1/2] input: misc: add twl4030-pwrbutton driver
Date: Wed, 4 Mar 2009 01:00:27 -0800
Message-ID: <20090304090026.GC7394@dtor-d630.eng.vmware.com>
References: <1235762883-20870-1-git-send-email-me@felipebalbi.com> <20090228141725.ZZRA012@mailhub.coreip.homeip.net> <20090301003014.GA22673@frodo> <20090228165156.ZZRA012@mailhub.coreip.homeip.net> <20090301144018.GA23581@frodo>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from qw-out-2122.google.com ([74.125.92.26]:58365 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754482AbZCDJAh (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 4 Mar 2009 04:00:37 -0500
Content-Disposition: inline
In-Reply-To: <20090301144018.GA23581@frodo>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Felipe Balbi <me@felipebalbi.com>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Felipe Balbi <felipe.balbi@nokia.com>, David Brownell <dbrownell@users.sourceforge.net>, Samuel Ortiz <sameo@openedhand.com>

On Sun, Mar 01, 2009 at 04:40:19PM +0200, Felipe Balbi wrote:
> On Sat, Feb 28, 2009 at 04:58:01PM -0800, Dmitry Torokhov wrote:
> > On Sun, Mar 01, 2009 at 02:30:18AM +0200, Felipe Balbi wrote:
> > > On Sat, Feb 28, 2009 at 02:23:03PM -0800, Dmitry Torokhov wrote:
> > > > Hi Felipe,
> > > > 
> > > > On Fri, Feb 27, 2009 at 09:28:02PM +0200, Felipe Balbi wrote:
> > > > > From: Felipe Balbi <felipe.balbi@nokia.com>
> > > > > 
> > > > > This is part of the twl4030 multifunction device driver.
> > > > > 
> > > > > With this driver we add support for reporting KEY_POWER
> > > > > events via the input layer.
> > > > 
> > > > ...
> > > 
> > > thanks for reviewing, how about the version below:
> > > 
> > 
> > Looks good, couple more items...
> 
> Fixed the extra comments and also got rid of the global input_dev
> structure. It could be fetched by passing it to request_irq() and
> platform_set/get_drvdata():
> 

Cool, I will keep it in my tree pending the threaded IRQ issue
resolution.

-- 
Dmitry
