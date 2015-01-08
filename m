From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 2/2] Input: adxl34x - add device tree documentation
Date: Thu, 8 Jan 2015 19:51:40 +0100
Message-ID: <CAMuHMdWwVmjkg-4pNvHgtBtc34+FzMKtF6e77YMqM4uRYfS+eg@mail.gmail.com>
References: <1420599537-28740-1-git-send-email-walter@vanguardiasur.com.ar>
	<1420599537-28740-2-git-send-email-walter@vanguardiasur.com.ar>
	<CAMuHMdVfqzTf034vyDPEYrnZ7+3iE+h2H+7Cs-ifJrePDrw-rg@mail.gmail.com>
	<CABxpGwDw_bE+UxypWGz3scxh3zVuxZ-1TTG2o-hEgT_mvwVatQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CABxpGwDw_bE+UxypWGz3scxh3zVuxZ-1TTG2o-hEgT_mvwVatQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Walter Lozano <walter@vanguardiasur.com.ar>
Cc: michael.hennerich@analog.com, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

On Thu, Jan 8, 2015 at 6:40 PM, Walter Lozano
<walter@vanguardiasur.com.ar> wrote:
> On Wed, Jan 7, 2015 at 6:42 AM, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>> On Wed, Jan 7, 2015 at 3:58 AM, Walter Lozano
>> <walter@vanguardiasur.com.ar> wrote:
>>> diff --git a/Documentation/devicetree/bindings/input/adxl34x.txt b/Documentation/devicetree/bindings/input/adxl34x.txt
>>> new file mode 100644
>>> index 0000000..0774f7e
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/input/adxl34x.txt
>>> @@ -0,0 +1,53 @@
>>> +Device Tree bindings for adxl34x digital accelerometer, both spi and i2c.
>>> +
>>> +Depending on the interface this node should be a child of a spi or i2c bus.
>>> +
>>> +Required properties:
>>> +- compatible: "adxl34x"
>>
>> "adi,adxl34x"?
>
> Great, thanks for your feedback.

BTW, did you see "[PATCH] input: adxl34x: Add OF match support"
(http://www.spinics.net/lists/linux-i2c/msg18107.html)?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
