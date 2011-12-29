From: Rob Herring <robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] Input: keyboard - add device tree bindings for simple
 key matrixes
Date: Thu, 29 Dec 2011 13:28:30 -0600
Message-ID: <4EFCBF5E.8030700@gmail.com>
References: <1325112771-31941-1-git-send-email-olof@lixom.net> <74CDBE0F657A3D45AFBB94109FB122FF17755DC8D2@HQMAIL01.nvidia.com> <CAOesGMiNuW3mexN_8PtunZkaVX4Uph-OgZFr5zLhaB1nih_EEw@mail.gmail.com> <74CDBE0F657A3D45AFBB94109FB122FF17755DC8DB@HQMAIL01.nvidia.com> <CAOesGMjZoP+FsGWo9cWKvgs8KD9tT6KBHbK5qKX8NTGOY3HUjQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAOesGMjZoP+FsGWo9cWKvgs8KD9tT6KBHbK5qKX8NTGOY3HUjQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>
Cc: Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Kukjin Kim <kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, "devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Rakesh Iyer <riyer-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-input@vger.kernel.org

On 12/29/2011 01:06 AM, Olof Johansson wrote:
> On Wed, Dec 28, 2011 at 11:01 PM, Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org> wrote:
>> Olof Johansson wrote at Wednesday, December 28, 2011 11:34 PM:
>>> On Wed, Dec 28, 2011 at 10:16 PM, Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org> wrote:
>>>> Olof Johansson wrote at Wednesday, December 28, 2011 3:53 PM:
>>>>> From: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>>>>>
>>>>> This adds a basic device tree binding for simple key matrix data.
>>>>>
>>>>> Signed-off-by: Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>
>>>>> ---
>>>>>
>>>>> Based on email exchange this morning, this is a first cut at a shared
>>>>> definition and helper function to parse and fill in the keymap data.
>>>>>
>>>>> Instead of doing the direct parsing into the final keymap format, I
>>>>> chose to fill in the pdata-equivalent since that is how the OF pdata
>>>>> fillers work right now if code is to be kept common with the legacy
>>>>> platform_device probe interface.
>>>>>
>>>>> This is a prerequisite for a revised version of the tegra-kbc device
>>>>> tree support that I will repost separately once this interface is stable.
>>>> ...
>>>>> diff --git a/Documentation/devicetree/bindings/input/matrix-keymap.txt
>>>> ...
>>>>> +For simple keyboards with just a few buttons, you can specify each key
>>>>> +as a subnode of the keyboard controller, with the following
>>>>> +properties:
>>>>> +
>>>>> +- keypad,row: the row number to which the key is connected.
>>>>> +- keypad,column: the column number to which the key is connected.
>>>>> +- linux,code: the key-code to be reported when the key is pressed
>>>>> +  and released.
>>>>> +
>>>>> +Example:
>>>>> +
>>>>> +     key_1 {
>>>>> +             keypad,row = <0>;
>>>>> +             keypad,column = <3>;
>>>>> +             linux,code = <2>;
>>>>> +     };
>>>>> +
>>>>> +
>>>>> +For a more complex keyboard, such as a full laptop, a more compact
>>>>> +binding can be used instead, with the following property directly in
>>>>> +the keyboard controller node:
>>>>> +
>>>>> +- linux,keymap: an array of 3-cell entries containing the equivalent
>>>>> +  of the three separate properties above: row, column and linux
>>>>> +  key-code.
>>>>
>>>> Why allow two completely different bindings? Is there some deficiency
>>>> to the compact binding that means it isn't suitable for all cases?
>>>
>>> The main reason is that the samsung keyboard driver already implements
>>> the more verbose one, and allowing that binding to coexist while also
>>> providing a more compact one seems like the right thing to do.
>>
>> Can we deprecate the Samsung format, and only allow it for that Samsung
>> device (and allow both there), and require a single format for any other
>> keyboard?
> 
> I'm definitely ok with that. Thomas, Grant, Rob? The code in question
> is queued for 3.3, so it hasn't been out in a real release yet.
> 
> Adding Kukjin as well since it's getting merged through his tree.
> 

I think both can coexist because the Samsung version is really a
derivative of gpio-keys binding. I think we want to encourage your
keymap version, so only supporting it in the generic code should do that.

Rob
