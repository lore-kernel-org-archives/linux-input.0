From: Lukas Wunner <lukas@wunner.de>
Subject: Re: [PATCH v3] HID: apple: Use country code to detect ISO keyboards
Date: Sat, 5 Aug 2017 19:09:22 +0200
Message-ID: <20170805170922.GA8872@wunner.de>
References: <20170602152839.7810-1-alexhenrie24@gmail.com>
 <alpine.LSU.2.20.1706081402540.30709@cbobk.fhfr.pm>
 <20170617185602.GA6348@wunner.de>
 <1497959693.2559.20.camel@hadess.net>
 <CAMMLpeQ2PaP3hySi-wukzkxdk=fSvGyOsPqTPZmof=U5s9=8Vg@mail.gmail.com>
 <1497981653.2559.28.camel@hadess.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailout1.hostsharing.net ([83.223.95.204]:56427 "EHLO
        mailout1.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751443AbdHERIy (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Sat, 5 Aug 2017 13:08:54 -0400
Content-Disposition: inline
In-Reply-To: <1497981653.2559.28.camel@hadess.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Bastien Nocera <hadess@hadess.net>
Cc: Alex Henrie <alexhenrie24@gmail.com>, Jiri Kosina <jikos@kernel.org>, benjamin.tissoires@redhat.com, jirislaby@gmail.com, stefan@glasen-hardt.de, ryan@finnie.org, Johannes Thumshirn <morbidrsa@gmail.com>, dan@pwienterprises.com, Andreas Krist <andreas.krist@gmail.com>, rydberg@bitmath.org, John Horan <Knasher@gmail.com>, linux-input@vger.kernel.org, Federico Lorenzi <florenzi@gmail.com>, Ronald =?iso-8859-1?Q?Tschal=E4r?= <ronald@innovation.ch>, Daniel Roschka <danielroschka@phoenitydawn.de>, Christoph Gysin <christoph.gysin@gmail.com>

On Tue, Jun 20, 2017 at 08:00:53PM +0200, Bastien Nocera wrote:
> On Tue, 2017-06-20 at 11:18 -0600, Alex Henrie wrote:
> > > Does this patch mean we can assume that the hardware model is
> > > "pc105"
> > > instead of various flavours of "mac" in xkeyboard-config's X
> > > keymaps?
> > 
> > I use the pc105 keymap with my Macbook 12,1 and don't have any
> > problems, so for me at least, the answer is yes.
> 
> Yay! This was a long-standing "wouldn't it be nice" bug from when I
> still used a MacBook Air on a daily basis:
> https://bugzilla.gnome.org/show_bug.cgi?id=650379
> https://bugzilla.gnome.org/show_bug.cgi?id=650772
> https://bugs.freedesktop.org/show_bug.cgi?id=37446
> 
> > > Does this also work with older Apple USB keyboards? (Most of the
> > > older
> > > ones triggered the "press those 2 buttons so we can figure out
> > > which
> > > type of keyboard you have", under macOS)
> > 
> > The oldest Apple ISO keyboard I could find information on is the
> > "Apple Geyser3 ISO", USB ID 05ac:0218. In 2008 an Arch Linux forum
> > user posted the output of `lsusb -v` which shows that bCountryCode is
> > set to 13 on this keyboard:
> > https://bbs.archlinux.org/viewtopic.php?pid=328653#p328653
> > 
> > Do you have any old Apple ISO keyboards? If you find one that doesn't
> > fill in bCountryCode, we could bring back the APPLE_ISO_KEYBOARD
> > quirk
> > for that model.
> 
> I have a 2011 MacBook Pro on which I could test this (I honestly don't
> remember the cut-off for ADB/BIOS keyboards to USB), but no external
> ones.
> 
> I also wonder whether that data is exported for Bluetooth and the newer
> I2C keyboards.

Good point, the folks working on the driver for SPI (not I2C) keyboards
have recently *added* a command line option to enable/disable the ISO
layout.  Ideally it should likewise be autosensed so I've opened this
issue:

https://github.com/cb22/macbook12-spi-driver/issues/44

Adding some of the SPI driver devs to cc.

Thanks,

Lukas
