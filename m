From: Bastien Nocera <hadess@hadess.net>
Subject: Re: [PATCH v2] HID: udraw: Add support for the uDraw tablet for PS3
Date: Tue, 08 Nov 2016 14:30:07 +0100
Message-ID: <1478611807.2497.2.camel@hadess.net>
References: <1478274223-3633-1-git-send-email-hadess@hadess.net>
         <alpine.LNX.2.00.1611081422170.29400@cbobk.fhfr.pm>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:37841 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751802AbcKHNaM (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Tue, 8 Nov 2016 08:30:12 -0500
In-Reply-To: <alpine.LNX.2.00.1611081422170.29400@cbobk.fhfr.pm>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, 2016-11-08 at 14:23 +0100, Jiri Kosina wrote:
> On Fri, 4 Nov 2016, Bastien Nocera wrote:
> 
> > This adds support for the THQ uDraw tablet for the PS3, as
> > 4 separate device nodes, so that user-space can easily consume
> > events coming from the hardware.
> > 
> > Note that the touchpad two-finger support is fairly unreliable,
> > and a right-click can only be achieved with a two-finger tap
> > with the two fingers slightly apart (about 1cm should be enough).
> > 
> > Tested-by: Bastien Nocera <hadess@hadess.net>
> > Signed-off-by: Bastien Nocera <hadess@hadess.net>
> 
> Hi Bastien,
> 
> overall the driver looks ok to me, thanks. Probably the only concern
> I'd 
> have -- traditionally, we've always been naming drivers by the
> vendor, as 
> it turned out that over time they get extended by adding support for 
> multiple devices with the same vendor, and usually there is quite
> some 
> overlap in shared code.

In that particular case, I'd rather it got renamed to "hid-udraw-ps3"
in this case. The XBox 360 and Wii versions use completely different
protocols:
http://brandonw.net/udraw/

The XBox 360 version is more likely to be integrated in with other XBox
pads, and the Wii version along with other Wii Bluetooth remotes.

> Hence I'd propose to call this driver hid-thq (if that's really the 
> vendor's proper name, doesn't seem to be present in latest usb.ids 
> release).

THQ went under in 2012, as a result of making too many of those drawing
tablets:
https://en.wikipedia.org/wiki/THQ

I'm fine with it either way. Just let me know which one you prefer.

Cheers
