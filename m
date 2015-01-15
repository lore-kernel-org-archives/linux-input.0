From: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Subject: Re: [PATCH v2 1/2] DT: i2c: Deprecate adi,adxl34x compatible string
Date: Thu, 15 Jan 2015 18:51:26 +0100
Message-ID: <CAMuHMdUwHde0EvbCD574L2tW6qqxLCtZwAb+0M-4QCjB9V6fmQ@mail.gmail.com>
References: <1421333655-31029-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
	<1421333655-31029-2-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
	<20150115170209.GA6342@katana>
	<CAMuHMdW7ETcFGSPiE9BWA2dAE93477fzoyF-+_EaiPSDT9WMWA@mail.gmail.com>
	<20150115174333.GC6342@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150115174333.GC6342@katana>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: Laurent Pinchart <laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, "linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux-sh list <linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-input@vger.kernel.org

On Thu, Jan 15, 2015 at 6:43 PM, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org> wrote:
> On Thu, Jan 15, 2015 at 06:32:31PM +0100, Geert Uytterhoeven wrote:
>> On Thu, Jan 15, 2015 at 6:02 PM, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org> wrote:
>> >> --- a/Documentation/devicetree/bindings/i2c/trivial-devices.txt
>> >> +++ b/Documentation/devicetree/bindings/i2c/trivial-devices.txt
>> >> @@ -18,8 +18,7 @@ adi,adt7475         +/-1C TDM Extended Temp Range I.C
>> >>  adi,adt7476          +/-1C TDM Extended Temp Range I.C
>> >>  adi,adt7490          +/-1C TDM Extended Temp Range I.C
>> >>  adi,adxl345          Three-Axis Digital Accelerometer
>> >> -adi,adxl346          Three-Axis Digital Accelerometer
>> >> -adi,adxl34x          Three-Axis Digital Accelerometer
>> >> +adi,adxl346          Three-Axis Digital Accelerometer (backward-compatibility value "adi,adxl345" must be listed too)
>> >
>> > I'd rather drop 346 because there is no compatible for that one anywhere.
>> > No need to resend, I can fix it here...
>>
>> If you drop adi,adxl346, checkpatch will start complaining if it encounters
>> it in a .dts.
>
> Boah, this is annoying. That means we need an 346 entry even if it is
> not different from 345 (which is fine by me).

To be clear: you need the entry in the documentation. It can be omitted
from the driver if it's not (yet) used for matching.

> If checkpatch does it this way, that means the rule of thumb is to
> *always* have a dedicated compatible entry? Can someone confirm this?

All compatible values that are in use must be documented.
Checkpatch just greps in Documentation/devicetree/bindings/.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
