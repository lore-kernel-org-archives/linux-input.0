From: Walter Lozano <walter-30ULvvUtt6G51wMPkGsGjgyUoB5FGQPZ@public.gmane.org>
Subject: Re: [PATCH 2/2] Input: adxl34x - add device tree documentation
Date: Thu, 8 Jan 2015 17:15:09 -0300
Message-ID: <CABxpGwCG56zmKYC8mGun9DYkgR4xS1L0F0fhF7Ze_0oHCxA4AA@mail.gmail.com>
References: <1420599537-28740-1-git-send-email-walter@vanguardiasur.com.ar>
	<1420599537-28740-2-git-send-email-walter@vanguardiasur.com.ar>
	<CAMuHMdVfqzTf034vyDPEYrnZ7+3iE+h2H+7Cs-ifJrePDrw-rg@mail.gmail.com>
	<CABxpGwDw_bE+UxypWGz3scxh3zVuxZ-1TTG2o-hEgT_mvwVatQ@mail.gmail.com>
	<CAMuHMdWwVmjkg-4pNvHgtBtc34+FzMKtF6e77YMqM4uRYfS+eg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAMuHMdWwVmjkg-4pNvHgtBtc34+FzMKtF6e77YMqM4uRYfS+eg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Cc: michael.hennerich-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-input@vger.kernel.org

On Thu, Jan 8, 2015 at 3:51 PM, Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org> wrote:
> On Thu, Jan 8, 2015 at 6:40 PM, Walter Lozano
> <walter-30ULvvUtt6G51wMPkGsGjgyUoB5FGQPZ@public.gmane.org> wrote:
>> On Wed, Jan 7, 2015 at 6:42 AM, Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org> wrote:
>>> On Wed, Jan 7, 2015 at 3:58 AM, Walter Lozano
>>> <walter-30ULvvUtt6G51wMPkGsGjgyUoB5FGQPZ@public.gmane.org> wrote:
>>>> diff --git a/Documentation/devicetree/bindings/input/adxl34x.txt b/Documentation/devicetree/bindings/input/adxl34x.txt
>>>> new file mode 100644
>>>> index 0000000..0774f7e
>>>> --- /dev/null
>>>> +++ b/Documentation/devicetree/bindings/input/adxl34x.txt
>>>> @@ -0,0 +1,53 @@
>>>> +Device Tree bindings for adxl34x digital accelerometer, both spi and i2c.
>>>> +
>>>> +Depending on the interface this node should be a child of a spi or i2c bus.
>>>> +
>>>> +Required properties:
>>>> +- compatible: "adxl34x"
>>>
>>> "adi,adxl34x"?
>>
>> Great, thanks for your feedback.
>
> BTW, did you see "[PATCH] input: adxl34x: Add OF match support"
> (http://www.spinics.net/lists/linux-i2c/msg18107.html)?

Yes, I have already seen it. Thanks for you time.

Regards,

Walter

-- 
Walter Lozano, VanguardiaSur
www.vanguardiasur.com.ar
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
