From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 01/15] Input: synaptics-rmi4 - fix checkpatch.pl, sparse
 and GCC warnings
Date: Wed, 12 Feb 2014 22:36:11 -0800
Message-ID: <20140213063611.GB15260@core.coreip.homeip.net>
References: <1390521623-6491-1-git-send-email-courtney.cavin@sonymobile.com>
 <1390521623-6491-2-git-send-email-courtney.cavin@sonymobile.com>
 <52F172DC.5090900@synaptics.com>
 <20140206010938.GA27770@core.coreip.homeip.net>
 <52F2E709.5060007@synaptics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pb0-f48.google.com ([209.85.160.48]:42294 "EHLO
	mail-pb0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751348AbaBMGhA (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 13 Feb 2014 01:37:00 -0500
Received: by mail-pb0-f48.google.com with SMTP id rr13so10329191pbb.21
        for <linux-input@vger.kernel.org>; Wed, 12 Feb 2014 22:37:00 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <52F2E709.5060007@synaptics.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Christopher Heiny <cheiny@synaptics.com>
Cc: Courtney Cavin <courtney.cavin@sonymobile.com>, linux-input@vger.kernel.org

On Wed, Feb 05, 2014 at 05:36:09PM -0800, Christopher Heiny wrote:
> On 02/05/2014 05:09 PM, Dmitry Torokhov wrote:
> >On Tue, Feb 04, 2014 at 03:08:12PM -0800, Christopher Heiny wrote:
> >>>On 01/23/2014 04:00 PM, Courtney Cavin wrote:
> >>>> >Cc: Christopher Heiny<cheiny@synaptics.com>
> >>>> >Cc: Dmitry Torokhov<dmitry.torokhov@gmail.com>
> >>>> >Signed-off-by: Courtney Cavin<courtney.cavin@sonymobile.com>
> >>>> >---
> >>>> >  drivers/input/rmi4/rmi_bus.c    |  4 ++--
> >>>> >  drivers/input/rmi4/rmi_bus.h    |  2 +-
> >>>> >  drivers/input/rmi4/rmi_driver.c | 17 ++++++++++++-----
> >>>> >  drivers/input/rmi4/rmi_f11.c    |  4 +++-
> >>>> >  4 files changed, 18 insertions(+), 9 deletions(-)
> >>>> >
> >>>> >diff --git a/drivers/input/rmi4/rmi_bus.c b/drivers/input/rmi4/rmi_bus.c
> >>>> >index 96a76e7..8a939f3 100644
> >>>> >--- a/drivers/input/rmi4/rmi_bus.c
> >>>> >+++ b/drivers/input/rmi4/rmi_bus.c
> >>>> >@@ -37,7 +37,7 @@ static void rmi_release_device(struct device *dev)
> >>>> >  	kfree(rmi_dev);
> >>>> >  }
> >>>> >
> >>>> >-struct device_type rmi_device_type = {
> >>>> >+static struct device_type rmi_device_type = {
> >>>> >  	.name		= "rmi_sensor",
> >>>> >  	.release	= rmi_release_device,
> >>>> >  };
> >>>
> >>>This struct is used by diagnostic modules to identify sensor
> >>>devices, so it cannot be static.
> >
> >Then we need to declare it somewhere or provide an accessor function.
> 
> Currently it's in a header not included in the patches.  We'll move
> it to rmi_bus.h.

Hmm, we do have rmi_is_physical_device() to identify whether it is a
sensor or a function, so I believe we should mark all structures static
to avoid anyone poking at them.

Thanks.

-- 
Dmitry
