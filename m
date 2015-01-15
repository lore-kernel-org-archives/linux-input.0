From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] input: adxl34x: Add OF match support
Date: Thu, 15 Jan 2015 14:03:16 +0100
Message-ID: <CAMuHMdXjB6-Fwk2+FLRNEynVgBXOm52n92QA-ZMTxsekPMtdsQ@mail.gmail.com>
References: <1418868923-13411-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
	<20141218082151.GA1038@katana>
	<1492007.8cQN1myWLD@avalon>
	<20150115125321.GD2549@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <20150115125321.GD2549@katana>
Sender: linux-sh-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>, Linux I2C <linux-i2c@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

On Thu, Jan 15, 2015 at 1:53 PM, Wolfram Sang <wsa@the-dreams.de> wrote:
>> There are three compatible strings defined for the ADXL345 and ADXL346 in
>> Documentation/devicetree/bindings/i2c/trivial-devices.txt: "adi,adxl345",
>> "adi,adxl346", "adi,adxl34x". Given that the last one is a fallback for the
>> first two I don't see a need to add the specific compatible strings to the
>> driver for now. If a new totally incompatible chip named ADXL347 comes out we
>> will need a new driver which won't be allowed to use the "adi,adxl34x"
>> compatible string.
>
> Been there, got bitten. We only found out too late, because one driver
> was in i2c and the other in GPIO (or LED even?), both using "953x" :(

Yep, pca953x => leds-pca953x

>> An option would be to remove "adi,adxl34x" from
>> Documentation/devicetree/bindings/i2c/trivial-devices.txt, in which case the
>> driver should match explicitly on "adi,adxl345" and "adi,adxl346". That might
>> clash with the DT ABI stability requirements though.
>
> I do prefer this:
>
> 1) add specific compatible values to the driver. We do those updates for
> new devices all the time
> 2) also add "34x" as a compatible but mark it as deprecateed
> 3) delete "34x" from trivial devices
>
> Everyone OK with that?

Sounds fine to me. Thanks!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
