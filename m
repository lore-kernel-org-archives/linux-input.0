From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v2 3/3] Input: qt1070 - Add OF device ID table
Date: Thu, 23 Mar 2017 14:45:59 -0700
Message-ID: <20170323214559.GB11818@dtor-ws>
References: <20170222144005.23447-1-javier@osg.samsung.com>
 <20170222144005.23447-3-javier@osg.samsung.com>
 <387639b5-01f4-2ba7-3065-5679571c08db@osg.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-io0-f196.google.com ([209.85.223.196]:35857 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755317AbdCWVqE (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Thu, 23 Mar 2017 17:46:04 -0400
Content-Disposition: inline
In-Reply-To: <387639b5-01f4-2ba7-3065-5679571c08db@osg.samsung.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Javier Martinez Canillas <javier@osg.samsung.com>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

On Thu, Mar 23, 2017 at 04:14:56PM -0300, Javier Martinez Canillas wrote:
> Hello Dmitry,
> 
> On 02/22/2017 11:40 AM, Javier Martinez Canillas wrote:
> > The driver doesn't have a struct of_device_id table but supported devices
> > are registered via Device Trees. This is working on the assumption that a
> > I2C device registered via OF will always match a legacy I2C device ID and
> > that the MODALIAS reported will always be of the form i2c:<device>.
> > 
> > But this could change in the future so the correct approach is to have an
> > OF device ID table if the devices are registered via OF.
> > 
> > The compatible strings don't have a vendor prefix because that's how it's
> > used currently, and changing this will be a Device Tree ABI break.
> > 
> > Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
> > ---
> > 
> 
> What's your decision about this patch series?

OK, I queued them for -next. Could you also make a patch to update
binding docs for silead?

Thanks!

-- 
Dmitry
