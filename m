From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] wm97xx-core: Report a phys for WM97xx touchscreens
Date: Thu, 22 May 2008 16:01:19 +0100
Message-ID: <20080522150119.GA25172@opensource.wolfsonmicro.com>
References: <1211456106-10882-1-git-send-email-broonie@opensource.wolfsonmicro.com> <20080522093759.ZZRA012@mailhub.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:40220 "EHLO
	opensource2.wolfsonmicro.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751896AbYEVPBV (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 22 May 2008 11:01:21 -0400
Content-Disposition: inline
In-Reply-To: <20080522093759.ZZRA012@mailhub.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, akpm@linux-foundation.org

On Thu, May 22, 2008 at 09:41:48AM -0400, Dmitry Torokhov wrote:
> On Thu, May 22, 2008 at 12:35:06PM +0100, Mark Brown wrote:

> > phys is displayed in various diagnostic output so ensure that it is set
> > to something sensible.

> Phys is used to describe the physical connection of a device that is
> ideally not changing between reboots so having it set up based on
> device's bus_id is not a best option I think.

It didn't seem terribly wonderful to me either but I saw that some other
drivers were doing the same thing so I assumed it was idiomatic.  A
quick survey of devices on my laptop suggets that it's getting filled in
with USB bus IDs for some devices.

For a WM97xx device it should actually be OK almost all the time - AC97
bus identifiers are fixed in hardware, there would only be a problem if
additional AC97 buses are added which is relatively unlikely, especially
in the embedded applications where the WM97xx devices get used.
However, if it's supposed to be OK to leave this null then that would be
better.

> What tools besides evbug use phys? They probably should display both
> phys and sysfs paths (I will be changing evbug soon).

It was actually evbug that prompted this - it prints a rather alarming
'Connected device: "foo", NULL' when phys is left empty.
