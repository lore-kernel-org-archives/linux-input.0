From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] input: adxl34x: Add OF match support
Date: Tue, 6 Jan 2015 14:28:12 +0100
Message-ID: <CAMuHMdXyo7BHJ-Jk3xKrCiCEVDF1M+-Sz9tBWibXc4pNYvdDeA@mail.gmail.com>
References: <1418868923-13411-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
	<1492007.8cQN1myWLD@avalon>
	<CAMuHMdXcfe0JQhZzGSAoqjKR346-QJrvyi=afHF7cAaHKa56pw@mail.gmail.com>
	<10011053.aypz0IuTJG@avalon>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <10011053.aypz0IuTJG@avalon>
Sender: linux-sh-owner@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>, Linux I2C <linux-i2c@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

Hi Laurent, Wolfram,

On Thu, Dec 18, 2014 at 8:23 PM, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
> On Thursday 18 December 2014 14:03:18 Geert Uytterhoeven wrote:
>> On Thu, Dec 18, 2014 at 1:49 PM, Laurent Pinchart wrote:
>> > There are three compatible strings defined for the ADXL345 and ADXL346 in
>> > Documentation/devicetree/bindings/i2c/trivial-devices.txt: "adi,adxl345",
>> > "adi,adxl346", "adi,adxl34x". Given that the last one is a fallback for
>> > the first two I don't see a need to add the specific compatible strings to
>> > the driver for now. If a new totally incompatible chip named ADXL347 comes
>> > out we will need a new driver which won't be allowed to use the
>> > "adi,adxl34x" compatible string.
>>
>> FWIW, I'm the evil person who added the adxl entries to that file...
>
> git-blame had already reported you.
>
> Do you think we should remove that compatible string ?

Remove it from trivial-devices.txt, or from the .dts?

Can't we just fix i2c_device_match(), to consider all compatible values
of the device's node instead of just the first one when doing a legacy match?

For now, I'd remove the "adi,adxl345" entry from sh73a0-kzm9g.dts,
until matching is fixed.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
