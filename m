From: Bastien Nocera <hadess@hadess.net>
Subject: Re: [PATCH v2] HID: udraw: Add support for the uDraw tablet for PS3
Date: Sat, 12 Nov 2016 18:25:57 +0100
Message-ID: <1478971557.2497.17.camel@hadess.net>
References: <1478274223-3633-1-git-send-email-hadess@hadess.net>
         <alpine.LNX.2.00.1611081422170.29400@cbobk.fhfr.pm>
         <1478611807.2497.2.camel@hadess.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:35486 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966401AbcKLR0C (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Sat, 12 Nov 2016 12:26:02 -0500
In-Reply-To: <1478611807.2497.2.camel@hadess.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, 2016-11-08 at 14:30 +0100, Bastien Nocera wrote:
> On Tue, 2016-11-08 at 14:23 +0100, Jiri Kosina wrote:
> > 
<snip>
> > Hi Bastien,
> > 
> > overall the driver looks ok to me, thanks. Probably the only
> > concern
> > I'd 
> > have -- traditionally, we've always been naming drivers by the
> > vendor, as 
> > it turned out that over time they get extended by adding support
> > for 
> > multiple devices with the same vendor, and usually there is quite
> > some 
> > overlap in shared code.
> 
> In that particular case, I'd rather it got renamed to "hid-udraw-ps3"
> in this case. The XBox 360 and Wii versions use completely different
> protocols:
> http://brandonw.net/udraw/
> 
> The XBox 360 version is more likely to be integrated in with other
> XBox
> pads, and the Wii version along with other Wii Bluetooth remotes.
> 
> > Hence I'd propose to call this driver hid-thq (if that's really
> > the 
> > vendor's proper name, doesn't seem to be present in latest usb.ids 
> > release).
> 
> THQ went under in 2012, as a result of making too many of those
> drawing
> tablets:
> https://en.wikipedia.org/wiki/THQ
> 
> I'm fine with it either way. Just let me know which one you prefer.

So, any preference? The sooner you make that choice, the sooner I can
send an updated patch and push this into my distribution's kernel. I
have a machine waiting on the hardware driver for control :)

Cheers
