From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 01/15] Input: synaptics-rmi4 - fix checkpatch.pl, sparse
 and GCC warnings
Date: Wed, 5 Feb 2014 17:09:39 -0800
Message-ID: <20140206010938.GA27770@core.coreip.homeip.net>
References: <1390521623-6491-1-git-send-email-courtney.cavin@sonymobile.com>
 <1390521623-6491-2-git-send-email-courtney.cavin@sonymobile.com>
 <52F172DC.5090900@synaptics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pb0-f45.google.com ([209.85.160.45]:63983 "EHLO
	mail-pb0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754196AbaBFBJn (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 5 Feb 2014 20:09:43 -0500
Received: by mail-pb0-f45.google.com with SMTP id un15so1080763pbc.18
        for <linux-input@vger.kernel.org>; Wed, 05 Feb 2014 17:09:42 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <52F172DC.5090900@synaptics.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Christopher Heiny <cheiny@synaptics.com>
Cc: Courtney Cavin <courtney.cavin@sonymobile.com>, linux-input@vger.kernel.org

On Tue, Feb 04, 2014 at 03:08:12PM -0800, Christopher Heiny wrote:
> On 01/23/2014 04:00 PM, Courtney Cavin wrote:
> >Cc: Christopher Heiny <cheiny@synaptics.com>
> >Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> >Signed-off-by: Courtney Cavin <courtney.cavin@sonymobile.com>
> >---
> >  drivers/input/rmi4/rmi_bus.c    |  4 ++--
> >  drivers/input/rmi4/rmi_bus.h    |  2 +-
> >  drivers/input/rmi4/rmi_driver.c | 17 ++++++++++++-----
> >  drivers/input/rmi4/rmi_f11.c    |  4 +++-
> >  4 files changed, 18 insertions(+), 9 deletions(-)
> >
> >diff --git a/drivers/input/rmi4/rmi_bus.c b/drivers/input/rmi4/rmi_bus.c
> >index 96a76e7..8a939f3 100644
> >--- a/drivers/input/rmi4/rmi_bus.c
> >+++ b/drivers/input/rmi4/rmi_bus.c
> >@@ -37,7 +37,7 @@ static void rmi_release_device(struct device *dev)
> >  	kfree(rmi_dev);
> >  }
> >
> >-struct device_type rmi_device_type = {
> >+static struct device_type rmi_device_type = {
> >  	.name		= "rmi_sensor",
> >  	.release	= rmi_release_device,
> >  };
> 
> This struct is used by diagnostic modules to identify sensor
> devices, so it cannot be static.

Then we need to declare it somewhere or provide an accessor function.

Thanks.

-- 
Dmitry
