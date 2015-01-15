From: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Subject: Re: [PATCH] input: adxl34x: Add OF match support
Date: Thu, 15 Jan 2015 15:23:50 +0100
Message-ID: <CAMuHMdWoUDW5Mt6P1G7+Zfqx9iejNUFs7EDiMV1Rw9AfrvxQ4w@mail.gmail.com>
References: <1418868923-13411-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
	<1492007.8cQN1myWLD@avalon>
	<20150115125321.GD2549@katana>
	<2054159.e1XeKNyynp@avalon>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <2054159.e1XeKNyynp@avalon>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, "linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux-sh list <linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-input@vger.kernel.org

On Thu, Jan 15, 2015 at 3:19 PM, Laurent Pinchart
<laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org> wrote:
>> > An option would be to remove "adi,adxl34x" from
>> > Documentation/devicetree/bindings/i2c/trivial-devices.txt, in which case
>> > the driver should match explicitly on "adi,adxl345" and "adi,adxl346".
>> > That might clash with the DT ABI stability requirements though.
>>
>> I do prefer this:
>>
>> 1) add specific compatible values to the driver. We do those updates for
>> new devices all the time
>
> Do you mean OF compatible values, or I2C match table entries ? I assume OF
> compatible values.
>
> As the ADXL346 is backward-compatible with the ADXL345, and as the driver
> doesn't support the ADXL346-specific features, how about adding only the
> adxl345 for now, and using compatible = "adi,adxl346", "adi,adxl345"; for the
> ADXL346 ?

Adxl34x is instantiated in:
arch/arm/boot/dts/sh73a0-kzm9g.dts
arch/arm/mach-shmobile/board-kzm9g.c
arch/arm/mach-shmobile/board-mackerel.c
arch/blackfin/mach-bf527/boards/tll6527m.c
arch/blackfin/mach-bf537/boards/stamp.c
arch/blackfin/mach-bf548/boards/ezkit.c
arch/blackfin/mach-bf609/boards/ezkit.c

The shmobile variants are all adxl345.
The tll6527m is also an adxl345.

For the remaining, it's not clear to me. I Googled a bit, but no luck.
So they'll have to live with adxl345, too ;-)

>> 2) also add "34x" as a compatible but mark it as deprecateed
>> 3) delete "34x" from trivial devices
>
> OK.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
