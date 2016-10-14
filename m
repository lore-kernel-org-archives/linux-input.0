From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH 0/2] Tiny modification of i2c-hid
Date: Fri, 14 Oct 2016 15:55:21 +0200
Message-ID: <20161014135521.GN15950@mail.corp.redhat.com>
References: <1476351045-8829-1-git-send-email-benjamin.tissoires@redhat.com>
 <alpine.LNX.2.00.1610141549540.31629@cbobk.fhfr.pm>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:33078 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750917AbcJNNz0 (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Fri, 14 Oct 2016 09:55:26 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LNX.2.00.1610141549540.31629@cbobk.fhfr.pm>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, David Arcari <darcari@redhat.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Oct 14 2016 or thereabouts, Jiri Kosina wrote:
> On Thu, 13 Oct 2016, Benjamin Tissoires wrote:
> 
> > Hi Jiri,
> > 
> > David and I are facing an issue in RHEL with the HP Zbook 15 Studio mWS.
> > This laptops uses the pinctrl-sunrisepoint controller for the GPIOs and
> > it failed on RHEL. We found out what the issue was, but in the meantime
> > realized that part of the code we have in i2c-hid is not required anymore.
> > 
> > The actual issue is fixed here: https://lkml.org/lkml/2016/10/12/493
> > but it would be more convenient (for us) and cleaner (fo everybody) to just
> > remove the extra boiler-plate in i2c-hid and let i2c-core handling the
> > attributions of the IRQ.
> 
> I'd like things like this to go in only during mergw window. Is there any 
> principal reason why this should go in still for 4.9?

There is no particular rush from our side. As long as you take it in
your tree and we know it will be schedule for 4.10, that should be OK.

So do as you think is the best :)

Cheers,
Benjamin

