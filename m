From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] ARM: shmobile: kzm9g dts: Add adxl345-specific compatible property
Date: Mon, 6 Jul 2015 12:49:50 +0200
Message-ID: <CAMuHMdWhSj5HZ+KYBkWbMpvUzFJGHS5-k8exhrxyCsAB+DJL3w@mail.gmail.com>
References: <1436176746-10995-1-git-send-email-geert+renesas@glider.be>
	<1980362.9qv8Mc7ut7@avalon>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1980362.9qv8Mc7ut7@avalon>
Sender: linux-sh-owner@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, Linux-sh list <linux-sh@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

On Mon, Jul 6, 2015 at 12:17 PM, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>> --- a/arch/arm/boot/dts/sh73a0-kzm9g.dts
>> +++ b/arch/arm/boot/dts/sh73a0-kzm9g.dts
>> @@ -206,7 +206,7 @@
>>       };
>>
>>       accelerometer@1d {
>> -             compatible = "adi,adxl34x";
>> +             compatible = "adi,adxl345", "adi,adxl34x";
>
> "adi,adxl34x" is deprecated and shouldn't be used in DT. You can just specify
> "adi,adxl345".

Right, we only care (sometimes ;-) about backward-compatibility,
not about forward-compatibility.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
