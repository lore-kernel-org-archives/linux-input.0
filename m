From: Bastien Nocera <hadess@hadess.net>
Subject: Re: [PATCH v3] HID: apple: Use country code to detect ISO keyboards
Date: Tue, 20 Jun 2017 13:54:53 +0200
Message-ID: <1497959693.2559.20.camel@hadess.net>
References: <20170602152839.7810-1-alexhenrie24@gmail.com>
         <alpine.LSU.2.20.1706081402540.30709@cbobk.fhfr.pm>
         <20170617185602.GA6348@wunner.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:40465 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751046AbdFTLzC (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Tue, 20 Jun 2017 07:55:02 -0400
In-Reply-To: <20170617185602.GA6348@wunner.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Lukas Wunner <lukas@wunner.de>, Jiri Kosina <jikos@kernel.org>
Cc: Alex Henrie <alexhenrie24@gmail.com>, benjamin.tissoires@redhat.com, jirislaby@gmail.com, stefan@glasen-hardt.de, ryan@finnie.org, morbidrsa@gmail.com, dan@pwienterprises.com, andreas.krist@gmail.com, rydberg@bitmath.org, linux-input@vger.kernel.org

On Sat, 2017-06-17 at 20:56 +0200, Lukas Wunner wrote:
> On Thu, Jun 08, 2017 at 02:03:14PM +0200, Jiri Kosina wrote:
> > On Fri, 2 Jun 2017, Alex Henrie wrote:
> > > At least on newer laptops, Apple uses the same USB ID for both
> > > ISO and
> > > ANSI keyboards. However, they have been good about filling in the
> > > bCountryCode field in the HID descriptor on all of their
> > > keyboards. A
> > > value of 13 indicates an ISO layout and other values indicate
> > > various
> > > country-specific ANSI layouts.
> > > 
> > > With this patch, users of Apple US keyboards will no longer have
> > > to run
> > > `echo 0 > /sys/module/hid_apple/parameters/iso_layout` to get a
> > > working
> > > tilde key.
> > > 
> > > Please test this patch and send feedback if you have a Macbook or
> > > an
> > > Apple keyboard.
> > > 
> > > Signed-off-by: Alex Henrie <alexhenrie24@gmail.com>
> > 
> > Applied to for-4.13/apple. Thanks,
> 
> Sorry, I'm late to the party, just wanted to report that I've been
> carrying this patch on my development branch for a while now and
> have not noticed any adverse effects.  This is on a MacBookPro9,1
> with a German ISO keyboard (USB_DEVICE_ID_APPLE_WELLSPRING5A_ISO),
> HID bCountryCode = 0x0d.
> 
> So, FWIW,
> Tested-by: Lukas Wunner <lukas@wunner.de>

Does this patch mean we can assume that the hardware model is "pc105"
instead of various flavours of "mac" in xkeyboard-config's X keymaps?

Does this also work with older Apple USB keyboards? (Most of the older
ones triggered the "press those 2 buttons so we can figure out which
type of keyboard you have", under macOS)

Cheers
