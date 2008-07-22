From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] hid: wellspring device quirks
Date: Tue, 22 Jul 2008 09:54:16 -0400
Message-ID: <20080722095311.ZZRA012@mailhub.coreip.homeip.net>
References: <1215963466.12757.0.camel@alnilam> <alpine.LNX.1.10.0807221504380.3037@jikos.suse.cz> <4885E13E.1010607@euromail.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.246]:40725 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750770AbYGVNyW (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 22 Jul 2008 09:54:22 -0400
Received: by an-out-0708.google.com with SMTP id d40so443217and.103
        for <linux-input@vger.kernel.org>; Tue, 22 Jul 2008 06:54:19 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4885E13E.1010607@euromail.se>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, robfitz@273k.net, akpm@osdl.org, Vojtech Pavlik <vojtech@suse.cz>, dmonakhov@openvz.org

On Tue, Jul 22, 2008 at 03:31:42PM +0200, Henrik Rydberg wrote:
> Jiri Kosina wrote:
> > On Sun, 13 Jul 2008, Henrik Rydberg wrote:
> > 
> >> This patch adds the HID_QUIRK_IGNORE_MOUSE quirk for the Apple USB
> >> multitouch devices based on BCM5974, aka Wellspring. These devices
> >> will instead be picked up by the new bcm5974 driver.
> > 
> > Hi Henrik,
> > 
> > is the mouse not working at all with standard HID driver?
> > 
> 
> Yes, it is working out-of-the-box, only poorly.
> 
> > I'd prefer to postpone merging this patch until bcm5974 hits mainline if
> > the device works in a limited way with standard HID driver, so that we
> > don't introduce regression.
> > 
> 
> Absolutely, this patch should be applied together with the bcm5974 driver,
> or not be applied. The driver patch is here:
> 
> http://userweb.kernel.org/~akpm/mmotm/broken-out/input-bcm5974-055-smoother-motion-irq-simplification.patch
> 
> > If the device doesn't work with HID driver at all though, it is probably
> > perfectly fine to merge it right away. Please let me know, I have no
> > knowledge about this particular device.
> 
> It is fine to leave it, but I would of course prefer to have the driver included together with this patch.

Jiri,

Should I take the quirks patch through my tree when I'm ready to apply
bcm5974?

-- 
Dmitry
