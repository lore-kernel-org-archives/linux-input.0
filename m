From: Alex Henrie <alexhenrie24@gmail.com>
Subject: Re: [PATCH v3] HID: apple: Use country code to detect ISO keyboards
Date: Tue, 20 Jun 2017 11:18:36 -0600
Message-ID: <CAMMLpeQ2PaP3hySi-wukzkxdk=fSvGyOsPqTPZmof=U5s9=8Vg@mail.gmail.com>
References: <20170602152839.7810-1-alexhenrie24@gmail.com> <alpine.LSU.2.20.1706081402540.30709@cbobk.fhfr.pm>
 <20170617185602.GA6348@wunner.de> <1497959693.2559.20.camel@hadess.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-it0-f68.google.com ([209.85.214.68]:35639 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750823AbdFTRS6 (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Tue, 20 Jun 2017 13:18:58 -0400
Received: by mail-it0-f68.google.com with SMTP id f20so16200220itb.2
        for <linux-input@vger.kernel.org>; Tue, 20 Jun 2017 10:18:58 -0700 (PDT)
In-Reply-To: <1497959693.2559.20.camel@hadess.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Bastien Nocera <hadess@hadess.net>
Cc: Lukas Wunner <lukas@wunner.de>, Jiri Kosina <jikos@kernel.org>, benjamin.tissoires@redhat.com, jirislaby@gmail.com, stefan@glasen-hardt.de, ryan@finnie.org, Johannes Thumshirn <morbidrsa@gmail.com>, dan@pwienterprises.com, Andreas Krist <andreas.krist@gmail.com>, rydberg@bitmath.org, John Horan <Knasher@gmail.com>, linux-input@vger.kernel.org

2017-06-20 5:54 GMT-06:00 Bastien Nocera <hadess@hadess.net>:
> On Sat, 2017-06-17 at 20:56 +0200, Lukas Wunner wrote:
>> On Thu, Jun 08, 2017 at 02:03:14PM +0200, Jiri Kosina wrote:
>> > On Fri, 2 Jun 2017, Alex Henrie wrote:
>> > > At least on newer laptops, Apple uses the same USB ID for both
>> > > ISO and
>> > > ANSI keyboards. However, they have been good about filling in the
>> > > bCountryCode field in the HID descriptor on all of their
>> > > keyboards. A
>> > > value of 13 indicates an ISO layout and other values indicate
>> > > various
>> > > country-specific ANSI layouts.
>> > >
>> > > With this patch, users of Apple US keyboards will no longer have
>> > > to run
>> > > `echo 0 > /sys/module/hid_apple/parameters/iso_layout` to get a
>> > > working
>> > > tilde key.
>> > >
>> > > Please test this patch and send feedback if you have a Macbook or
>> > > an
>> > > Apple keyboard.
>> > >
>> > > Signed-off-by: Alex Henrie <alexhenrie24@gmail.com>
>> >
>> > Applied to for-4.13/apple. Thanks,
>>
>> Sorry, I'm late to the party, just wanted to report that I've been
>> carrying this patch on my development branch for a while now and
>> have not noticed any adverse effects.  This is on a MacBookPro9,1
>> with a German ISO keyboard (USB_DEVICE_ID_APPLE_WELLSPRING5A_ISO),
>> HID bCountryCode = 0x0d.
>>
>> So, FWIW,
>> Tested-by: Lukas Wunner <lukas@wunner.de>
>
> Does this patch mean we can assume that the hardware model is "pc105"
> instead of various flavours of "mac" in xkeyboard-config's X keymaps?

I use the pc105 keymap with my Macbook 12,1 and don't have any
problems, so for me at least, the answer is yes.

> Does this also work with older Apple USB keyboards? (Most of the older
> ones triggered the "press those 2 buttons so we can figure out which
> type of keyboard you have", under macOS)

The oldest Apple ISO keyboard I could find information on is the
"Apple Geyser3 ISO", USB ID 05ac:0218. In 2008 an Arch Linux forum
user posted the output of `lsusb -v` which shows that bCountryCode is
set to 13 on this keyboard:
https://bbs.archlinux.org/viewtopic.php?pid=328653#p328653

Do you have any old Apple ISO keyboards? If you find one that doesn't
fill in bCountryCode, we could bring back the APPLE_ISO_KEYBOARD quirk
for that model.

-Alex
