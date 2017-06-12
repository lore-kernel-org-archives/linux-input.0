From: Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: Re: [PATCH 2/2] Input: pm8941-pwrkey: Introduce reboot mode support
Date: Mon, 12 Jun 2017 16:32:03 -0700
Message-ID: <20170612233203.GT12920@tuxbook>
References: <20170527065130.3456-1-bjorn.andersson@linaro.org>
 <20170527065130.3456-2-bjorn.andersson@linaro.org>
 <20170530025324.GD32841@dtor-ws>
 <20170530044711.GP12920@tuxbook>
 <20170608163243.j4dfpa6swoz27ofd@earth>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pg0-f41.google.com ([74.125.83.41]:34680 "EHLO
        mail-pg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752795AbdFLXcJ (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Mon, 12 Jun 2017 19:32:09 -0400
Received: by mail-pg0-f41.google.com with SMTP id v18so51501669pgb.1
        for <linux-input@vger.kernel.org>; Mon, 12 Jun 2017 16:32:08 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20170608163243.j4dfpa6swoz27ofd@earth>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh@kernel.org>, John Stultz <john.stultz@linaro.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org

On Thu 08 Jun 09:32 PDT 2017, Sebastian Reichel wrote:

> Hi,
> 
> On Mon, May 29, 2017 at 09:47:11PM -0700, Bjorn Andersson wrote:
> > On Mon 29 May 19:53 PDT 2017, Dmitry Torokhov wrote:
> > 
> > > On Fri, May 26, 2017 at 11:51:30PM -0700, Bjorn Andersson wrote:
> > > > In some Qualcomm platforms the magic for informing LK which mode to
> > > > reboot into is stored in the PON_SOFT_RB_SPARE register. Register with
> > > > the reboot mode helpers to expose this to the user.
> > > 
> > > Hmm, is the power key driver the best place to have this? WHy isn't this
> > > a driver in its own right?
> > > 
> > 
> > The functionality is part of the "PON" block in the Qualcomm PMICs,
> > other functionality from this block relates to configuration and
> > handling related to power-key and reset-key.
> > 
> > Several of these properties are intermingled, so I do believe it's best
> > to handle them in a single driver; that said, it might no longer be
> > correct to name the driver "pwrkey" or that it is a "misc input" driver.
> 
> I merged patch 1 and provided an immutable branch, so
> that this could go through the input subsystem.
> 

Thanks

> To me it doesn't look that intermingled, though. I think
> the reboot and reboot-mode parts could go into their own
> driver in drivers/power/reset.
> 

I did reach out to Rob regarding this and the single hardware block
should be described by a single node in DeviceTree.

As such if we split the non-input related handling into another driver
we would need to make the input driver create a subdevice during probe -
or create a new pon-driver with a new compatible that internally spawns
the pwrkey driver. Neither seems desirable to me...


The features of the PON block not yet shown on LKML are status registers
to indicate the reason for powering up the PMIC and a watchdog (which I
don't believe is used or exposed today).

Regards,
Bjorn
