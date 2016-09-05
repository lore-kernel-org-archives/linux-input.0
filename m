From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH] Input: wdt87xx_i2c - support new body WDT8752
Date: Mon, 5 Sep 2016 15:55:45 +0200
Message-ID: <20160905135545.GL21864@mail.corp.redhat.com>
References: <1470219398-10892-1-git-send-email-hn.chen@weidahitech.com>
 <CAKdAkRRH=2ifEs0O8WjNqYUKOcLS6Nigiw=vq2SAB-XKF_7v7g@mail.gmail.com>
 <22498D53301C4D4A8FFA8F02C7C3C7C06DDD7D42@mail02.WHT.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:42344 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933148AbcIENzu (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Mon, 5 Sep 2016 09:55:50 -0400
Content-Disposition: inline
In-Reply-To: <22498D53301C4D4A8FFA8F02C7C3C7C06DDD7D42@mail02.WHT.local>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Hn Chen <hn.chen@weidahitech.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>

Hi HN,

On Sep 05 2016 or thereabouts, Hn Chen wrote:
> Hi Dmitry,
> 
> >> Considering to be compatible with i2c-hid, WDT8752 has the same way in 
> >> enumerating device.
> >If it is a HID device then I think you should write a HID driver for it (unless existing driver, such as hid-multitouch can already handle it, possibly >with some changes). I'm addng Benjamin to he can comment as well.
> The device can be handled by i2c-hid driver (HID over I2C) already but this proprietary driver still is a must-have for more features.

Then what are those must-have features? From what I can read, only the
reflashing firmware is part of it. Unless there is something else, I
really don't understand why you can't have a hid-weidatech driver that
could handle the specific bits while leaving the rest to i2c-hid.

Also, I am not sure if your driver doesn't interfere with i2c-hid as you
are claiming the device through the ACPI ID "WDHT0001" but there should
be some PNP IDs "PNP0C50" if it were declared as i2c-hid. If both are
set, then the fact your driver is picked up seems to be pure luck: there
will be a race between the probe of your driver and i2c-hid, which is
not something you want.

If there are some issues with i2c-hid, I'd like also to know them
because if we fix them for you there  is a high chance other vendors
will benefit from those fixes too.

Cheers,
Benjamin

> 
> >> And also modify the part of FW update to be more efficiency. The main 
> >> modification is that reducing the amount of data transmitted and using 
> >> polling for time comsuming operation.
> >>
> >> Flash erase will wait 50ms for the operation complete in last driver.
> >> Extend it to 200ms since the spec says the typical is 30ms but the max 
> >> is 200ms.
> >This should be split into a separate patch please.
> Ok, I will resubmit the part of possible-issue fixing and then the driver patch for supporting WDT8752 again.
> Please ignore this submission.
> 
> Hn.chen
