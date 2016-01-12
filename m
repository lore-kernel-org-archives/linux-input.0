From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 2/2] input: gpio-keys: add support to name the gpio-keys
Date: Tue, 12 Jan 2016 09:23:58 -0600
Message-ID: <CAL_Jsq+ZLVNXVnQX+fYGjhqAx6aFrPNgBBXbPGTKrWoY52vMvw@mail.gmail.com>
References: <1452598370-28509-1-git-send-email-ldewangan@nvidia.com>
 <1452598370-28509-2-git-send-email-ldewangan@nvidia.com> <20160112144301.GA30932@rob-hp-laptop>
 <569513E6.60608@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <569513E6.60608-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Laxman Dewangan <ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Bjorn Andersson <bjorn.andersson-/MT0OVThwyLZJqsBc5GL+g@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-input@vger.kernel.org

On Tue, Jan 12, 2016 at 8:55 AM, Laxman Dewangan <ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org> wrote:
>
> On Tuesday 12 January 2016 08:13 PM, Rob Herring wrote:
>>
>> On Tue, Jan 12, 2016 at 05:02:50PM +0530, Laxman Dewangan wrote:
>>>
>>> Add support from DT to name the gpio-keys driver to have
>>> desired key name for this input system.
>>>
>>> This helps userspace code to get name and perform proper
>>> event to key mapping in some of cases. In android, the
>>> user space map the key code to application code using
>>> key character layout and for this it uses the name of
>>> input system.
>>
>> Why is specifying the key code not enough?
>
>
> This is the name for input system instead of individual keys.
> In android system, the key mapping is done in user space. By having name
> offers to specifying the customized key character layout instead of generic
> one form android which is fall-back.

Okay, got it.

>>> Signed-off-by: Laxman Dewangan <ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
>>> ---
>>>   Documentation/devicetree/bindings/input/gpio-keys.txt | 1 +
>>>   drivers/input/keyboard/gpio_keys.c                    | 2 ++
>>>   2 files changed, 3 insertions(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/input/gpio-keys.txt
>>> b/Documentation/devicetree/bindings/input/gpio-keys.txt
>>> index cf1333d..2e6bcd2 100644
>>> --- a/Documentation/devicetree/bindings/input/gpio-keys.txt
>>> +++ b/Documentation/devicetree/bindings/input/gpio-keys.txt
>>> @@ -4,6 +4,7 @@ Required properties:
>>>         - compatible = "gpio-keys";
>>>     Optional properties:
>>> +       - gpio-keys,name: String, name of the gpio-keys input system.
>>
>> gpio-keys is not a vendor.
>>
>> Would "label" work for you instead?
>
>
> "label" means node name?

No, the standard label property. See gpio-leds for an example.

>> Either way, I'm concerned this doesn't work for other key bindings
>> which have multiple keys.
>>
>>
>
> This is not for the individual keys, its for input system like
> /sys/class/input/input0/name.

So label is exactly for this purpose of defining user meaningful names.

Rob
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
