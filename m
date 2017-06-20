From: Bastien Nocera <hadess@hadess.net>
Subject: Re: [PATCH v3] HID: apple: Use country code to detect ISO keyboards
Date: Tue, 20 Jun 2017 20:00:53 +0200
Message-ID: <1497981653.2559.28.camel@hadess.net>
References: <20170602152839.7810-1-alexhenrie24@gmail.com>
         <alpine.LSU.2.20.1706081402540.30709@cbobk.fhfr.pm>
         <20170617185602.GA6348@wunner.de> <1497959693.2559.20.camel@hadess.net>
         <CAMMLpeQ2PaP3hySi-wukzkxdk=fSvGyOsPqTPZmof=U5s9=8Vg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:59030 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751108AbdFTSA7 (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Tue, 20 Jun 2017 14:00:59 -0400
In-Reply-To: <CAMMLpeQ2PaP3hySi-wukzkxdk=fSvGyOsPqTPZmof=U5s9=8Vg@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Alex Henrie <alexhenrie24@gmail.com>
Cc: Lukas Wunner <lukas@wunner.de>, Jiri Kosina <jikos@kernel.org>, benjamin.tissoires@redhat.com, jirislaby@gmail.com, stefan@glasen-hardt.de, ryan@finnie.org, Johannes Thumshirn <morbidrsa@gmail.com>, dan@pwienterprises.com, Andreas Krist <andreas.krist@gmail.com>, rydberg@bitmath.org, John Horan <Knasher@gmail.com>, linux-input@vger.kernel.org

On Tue, 2017-06-20 at 11:18 -0600, Alex Henrie wrote:
> 
<snip>
> > Does this patch mean we can assume that the hardware model is
> > "pc105"
> > instead of various flavours of "mac" in xkeyboard-config's X
> > keymaps?
> 
> I use the pc105 keymap with my Macbook 12,1 and don't have any
> problems, so for me at least, the answer is yes.

Yay! This was a long-standing "wouldn't it be nice" bug from when I
still used a MacBook Air on a daily basis:
https://bugzilla.gnome.org/show_bug.cgi?id=650379
https://bugzilla.gnome.org/show_bug.cgi?id=650772
https://bugs.freedesktop.org/show_bug.cgi?id=37446

> > Does this also work with older Apple USB keyboards? (Most of the
> > older
> > ones triggered the "press those 2 buttons so we can figure out
> > which
> > type of keyboard you have", under macOS)
> 
> The oldest Apple ISO keyboard I could find information on is the
> "Apple Geyser3 ISO", USB ID 05ac:0218. In 2008 an Arch Linux forum
> user posted the output of `lsusb -v` which shows that bCountryCode is
> set to 13 on this keyboard:
> https://bbs.archlinux.org/viewtopic.php?pid=328653#p328653
> 
> Do you have any old Apple ISO keyboards? If you find one that doesn't
> fill in bCountryCode, we could bring back the APPLE_ISO_KEYBOARD
> quirk
> for that model.

I have a 2011 MacBook Pro on which I could test this (I honestly don't
remember the cut-off for ADB/BIOS keyboards to USB), but no external
ones.

I also wonder whether that data is exported for Bluetooth and the newer
I2C keyboards.
