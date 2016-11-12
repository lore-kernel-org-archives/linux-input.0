From: Chris Diamand <chris@diamand.org>
Subject: Re: [PATCH] Input: byd - use DMI detection
Date: Sat, 12 Nov 2016 14:48:14 +0000
Message-ID: <20161112144814.wt3yct4iztil6a3e@peridot.local.diamand.org>
References: <20161111235759.11988-1-chris@diamand.org>
 <58270744.cf3fc20a.1e77d.30f0@mx.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wm0-f54.google.com ([74.125.82.54]:38041 "EHLO
        mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S938787AbcKLOsT (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Sat, 12 Nov 2016 09:48:19 -0500
Received: by mail-wm0-f54.google.com with SMTP id f82so26271078wmf.1
        for <linux-input@vger.kernel.org>; Sat, 12 Nov 2016 06:48:18 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <58270744.cf3fc20a.1e77d.30f0@mx.google.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
Cc: Richard Pospesel <pospeselr@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org

Hi, and thanks for your reply.

> Hi! This looks very fragile. We really cannot test presence of some device
> by DMI string "To Be Filled By O.E.M." or by "WhiteTip Mountain1 Fab2".
> Look at other dmi detection code. We match full device and vendor.

Do you think it's likely to match too many or too few machines? I can match
the device and vendor instead, but I think that would have more false
positives (DMI_SYS_VENDOR and DMI_PRODUCT_NAME are "Intel Corporation" and
"Sharkbay Platform").

Here are all the DMI fields we can use, with their values on my (former) BYD
machine. As you can see, none of them are particularly helpful. However, I
*hope* that most other manufacturers fill them in, so I'd be surprised if
there are many false positives.

DMI_BIOS_VENDOR: American Megatrends Inc.
DMI_BIOS_VERSION: 5.6.5
DMI_BIOS_DATE: 06/30/2015
DMI_SYS_VENDOR: Intel Corporation
DMI_PRODUCT_NAME: Sharkbay Platform
DMI_PRODUCT_VERSION: 0.1
DMI_PRODUCT_SERIAL: System Serial Number
DMI_PRODUCT_UUID: 03000200-0400-0500-0006-000700080009
DMI_BOARD_VENDOR: Topstar
DMI_BOARD_NAME: WhiteTip Mountain1 Fab2
DMI_BOARD_VERSION: Fab2
DMI_BOARD_SERIAL: 1
DMI_BOARD_ASSET_TAG: Base Board Asset Tag
DMI_CHASSIS_VENDOR: To Be Filled By O.E.M.
DMI_CHASSIS_TYPE: Laptop
DMI_CHASSIS_VERSION: To Be Filled By O.E.M.
DMI_CHASSIS_SERIAL: To Be Filled By O.E.M.
DMI_CHASSIS_ASSET_TAG: To Be Filled By O.E.M.

> If we really have a problem when byd detect incorrect detect some non-byd
> device as byd, we either needs:
>
> 1) extend detect code to include also parts of init sequence (this should
>    fix problem on wrongly detected non-byd devices, but init code on them
>    will take longer)

I agree. What I am trying to achieve with this patch is to fix 99% of cases
where we wrongly detect a non-BYD device. There may still be a few false
positives, but for those we can apply Richard's patch, which moves the
whole init sequence to byd_detect().
http://www.spinics.net/lists/linux-input/msg45539.html

This will slow down detection of normal mice, but if my DMI patch is also
applied, it will only affect a tiny fraction of users.

Also, Richard's patch would fix the even rarer case of someone trying to use
a mis-detected mouse on an actual BYD device.

> 2) or use another detection technique, which will address above problem (
>    your "To Be Filled By O.E.M." is not good; maybe looking at ACPI?)

That could also work, but I wouldn't be able to write such a patch as I no
longer have access to the device.

Anyway, in summary; the ideal solution seems to be DMI matching + extended
detection sequence - this patch is the first part.

Cheers!
Chris
