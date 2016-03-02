From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: How to use ACPI for touchscreen
Date: Wed, 2 Mar 2016 13:19:49 -0800
Message-ID: <20160302211949.GD4318@dtor-ws>
References: <CA+V1LzqohgdNChrBUO+VqUiPD-9gPGvSCiu0t3L7aUk5dRyD1w@mail.gmail.com>
 <56D568C7.20203@gmail.com>
 <CA+V1LzohZr1ryibyS+YQ75D8-txQaiYU5qo2CNWTKS2kwn53dg@mail.gmail.com>
 <CA+V1Lzp8pEtiwH-EWJiDCu=oFpXO9N2SEM5UbSqi5-mxgwsiTg@mail.gmail.com>
 <20160302175232.GC4318@dtor-ws>
 <CA+V1LzoiheCTZRv9xS=f_aTLkb27vw0aha=otYy=eiwOPB52+Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f180.google.com ([209.85.192.180]:36842 "EHLO
	mail-pf0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750785AbcCBVTx (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 2 Mar 2016 16:19:53 -0500
Received: by mail-pf0-f180.google.com with SMTP id 63so931401pfe.3
        for <linux-input@vger.kernel.org>; Wed, 02 Mar 2016 13:19:52 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CA+V1LzoiheCTZRv9xS=f_aTLkb27vw0aha=otYy=eiwOPB52+Q@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: sergk sergk2mail <sergk.admin@gmail.com>
Cc: Gregor Riepl <onitake@gmail.com>, linux-input@vger.kernel.org

On Wed, Mar 02, 2016 at 06:13:27PM +0000, sergk sergk2mail wrote:
> "Why do you think that mlsfw in modalias string has anything to do with
> loading firmware? I must have misunderstood your statement..."
> 
> Hi Dmitriy,
>   Its rather guessing based on such disovering: On Chuwi Vi10 rev 11
> under Android the only touch related module that is loaded is
> atmel_mxt_ts while I exactly know (and have firmware too) that in this
> tablet there is Chipone icn8528.h.   (drivers from Windows + dmesg
> provs this).
> When you rmmod atmel_mxt_ts the touch still continues to work! I guess
> someone just used atmel_mxt_ts probably as prototype for detecting
> (wake uping) chip and loading its firmware and after - no need in any
> module. According specs of Chipone icn85xx it looks that it even has
> corresponding mode - to be initialized from firmware and work after
> with it. It looks weird, but this is the clevest explanation that I
> could provide - I never seen before such behaviour in Android when
> there is no dedicated driver for touch screen.

I find this hard to believe. If you inspect /proc/bus/input/devices you
should be able to see the parent device for the touchscreen (via sysfs
entry) and if you inspect sysfs you should be able to see the driver
that is connected to the device (unless they use i2c dev from userspace
but then they'd have to resort to polling and their battery life would
be abysmal).

> 
> In anyway - this is only curiousity, the main goal is simple - to
> create a driver for icn85xx that wakeup it and loads firmware.
> I have specs, I have firmware, there is for arm open source drivers
> (including firmware in .h file):
> https://github.com/bbelos/rk3188-kernel/blob/master/drivers/input/touchscreen/ICN8503/icn85xx.c

Just so we are clear: the driver above is not an open source driver.
Even though it has MODULE_LICENSE("GPL") to circumvent kernel module
loading policies the actual copyright notice in the sources say that the
code is proprietary.

If any code is taken from it the resulting driver should not be
submitted for inclusion in mainline Linux kernel unless it is done by
ChipOne themselves.

Thanks.

-- 
Dmitry
