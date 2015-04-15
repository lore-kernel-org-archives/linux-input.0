From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 1/2] Input: atmel_mxt_ts - add support for Google Pixel 2
Date: Wed, 15 Apr 2015 15:43:26 -0700
Message-ID: <20150415224326.GA1119@dtor-ws>
References: <1428452770-20767-1-git-send-email-dmitry.torokhov@gmail.com>
 <552E8A8C.6000900@collabora.co.uk>
 <552ED615.5020301@gmail.com>
 <552EE4C7.4010001@collabora.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ie0-f194.google.com ([209.85.223.194]:33414 "EHLO
	mail-ie0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752916AbbDOWnb (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 15 Apr 2015 18:43:31 -0400
Content-Disposition: inline
In-Reply-To: <552EE4C7.4010001@collabora.co.uk>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Cc: Benjamin Tissoires <benjamin.tissoires@gmail.com>, linux-input <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Nick Dyer <nick.dyer@itdev.co.uk>, Yufeng Shen <miletus@chromium.org>, Benson Leung <bleung@chromium.org>, Daniel Kurtz <djkurtz@chromium.org>, Sjoerd Simons <sjoerd.simons@collabora.co.uk>, Olof Johansson <olof@lixom.net>

On Thu, Apr 16, 2015 at 12:23:03AM +0200, Javier Martinez Canillas wrote:
> Hello Benjamin,
> 
> On 04/15/2015 11:20 PM, Benjamin Tissoires wrote:
> > Hi guys,
> > 
> > On Wed, Apr 15, 2015 at 11:58 AM, Javier Martinez Canillas <javier.martinez@collabora.co.uk> wrote:
> >> Hello Dmitry,
> >>
> >> On 04/08/2015 02:26 AM, Dmitry Torokhov wrote:
> >>> This change allows atmel_mxt_ts to bind to ACPI-enumerated devices in
> >>> Google Pixel 2 (2015).
> >>>
> >>> While newer version of ACPI standard allow use of device-tree-like
> >>> properties in device descriptions, the version of ACPI implemented in
> >>> Google BIOS does not support them, and we have to resort to DMI data to
> >>> specify exact characteristics of the devices (touchpad vs. touchscreen,
> >>> GPIO to button mapping, etc).
> >>>
> >>> Pixel 1 continues to use i2c devices and platform data created by
> >>> chromeos-laptop driver, since ACPI does not enumerate them.
> >>>
> >>> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> >>> ---
> > [snipped]
> >>
> >> Patch looks good to me and I've tested it in a Pixel2 Chromebook using
> >> evtest:
> >>
> >> Reviewed-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
> >> Tested-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
> >>
> > 
> > Hmm, this is weird. I tried to apply the 2 patches of this series to a 
> > 4.0 fedora kernel[1], and the touch{pad|screen} are desperately muted.
> 
> Yes, is not going to work with just 4.0, I tested with today's -next.
> 
> > The abs_X/Y max shows up as 0, so there is something wrong with either 
> > my touchpad (which works fine on ChromeOS) or with the driver.
> > There are no differences between 4.0-rcX and the final 4.0 so I suspect 
> > there must be something else.
> > I also copied the 2 samus-* config files from the ChromeOS root to
> > /lib/firmware but this does not change anything.
> > 
> > In [3], I enabled the debug output of atmel_mxt, and it seems that the 
> > table of functions is missing the T9 one, which is the multitouch one... :(
> > 
> 
> The atmel_mxt error message is somehow misleading. The problem is not
> that the T9 multitouch object is missing (in fact that's the only one
> supported by the driver in 4.0) but that the atmel chip in the pixel2
> uses another multitouch object (T100).
> 
> So the driver tries to initialize the input device assuming that is a
> T9 one and fails showing the "Invalid object type T9" error.
> 
> > Any help would be greatly appreciated so we can fix [2] and support 
> > those laptops in Fedora directly.
> >
> 
> Patches to add proper T100 support are already in Linus' tree but did
> not make it to 4.0. So you need to cherry-pick commits:
> 
> b23157dc7427 ("Input: atmel_mxt_ts - implement support for T100 touch object") [0]
> b6d2d3289f84 ("Input: atmel_mxt_ts - split out touchpad initialisation logic") [1].
> 
> Dmitry mentioned that he used a 4.0+ kernel with Fedora's config so I
> guess he also was testing with linux-next or latest Linus' master.

I usually test with my internal tree that consists of mainline (either
at X.0 or at ToT past rc3-rc4 of the current release) + my "for-linus"
branch + my "next" branch + some work in progress that has not made into
for-linus/next but should have no effect on the patches as posted.

Thanks.

-- 
Dmitry
