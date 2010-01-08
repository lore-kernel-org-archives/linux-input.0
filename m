From: "Rick L. Vinyard, Jr." <rvinyard-qcTL/1vZYtiVc3sceRu5cw@public.gmane.org>
Subject: Re: [PATCH] Logitech G13 driver (fixed cc list --- ignore others)
Date: Fri, 8 Jan 2010 09:45:30 -0700
Message-ID: <afb1408fa27fc03b71f07d39513c2719.squirrel@intranet.cs.nmsu.edu>
References: <200912142122.nBELMW7d001243@mustang.cs.nmsu.edu>
    <45a44e481001041557t1f87f8d4i959abbbee0c4346@mail.gmail.com>
    <635ab1237a6a988656a2bf28e488f656.squirrel@intranet.cs.nmsu.edu>
    <4B473F64.2010203@debian.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4B473F64.2010203-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Giacomo A. Catenazzi" <cate-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org>
Cc: Jaya Kumar <jayakumar.lkml-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, krzysztof.h1-5tc4TXWwyLM@public.gmane.org, akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, oliver-GvhC2dPhHPQdnm+yROfE0A@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, jkosina-AlSwsSmVLrQ@public.gmane.org, linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

Hello,

Giacomo A. Catenazzi wrote:
> On 07.01.2010 16:59, Rick L. Vinyard, Jr. wrote:
>> Jaya Kumar wrote:
>>> On Tue, Dec 15, 2009 at 5:22 AM, Rick L. Vinyard Jr.
>>> <rvinyard-qcTL/1vZYtiVc3sceRu5cw@public.gmane.org>  wrote:
>>>> Additionally, this device contains a 160x43 monochrome LCD display.
>>>> A registered framebuffer device manages this display. The design
>>>> of this portion of the driver was based on the design of the
>>>> hecubafb driver with deferred framebuffer I/O since there is
>>>> no real memory to map.
>>>
>>> Hi Rick,
>>>
>>> Interesting work. I recommend CCing linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org too
>>> since it contains a fbdev interface.
>>>
>>
>> Thanks. Added.
>>
>>>> +config LOGITECH_G13
>>>> +       tristate "Logitech G13 gameboard support"
>>>> +       depends on HID_LOGITECH
>>>> +       depends on FB
>>>> +       select FB_SYS_FILLRECT
>>>> +       select FB_SYS_COPYAREA
>>>> +       select FB_SYS_IMAGEBLIT
>>>> +       select FB_SYS_FOPS
>
> Sorry to enter in this discussion so late.
>
> What about g15 keyboards and related keyboards?
>
> It would nice if your driver could handle also the other keyboards.
>

I don't have one to test. Technically _I_ don't even have a g13. The two I
currently have are borrowed.

> The package g15daemon handles such keyboards (or LCD screens):
>
> # Logitech g11 -- extra keys, no LCD
> # Logitech G15 (blue) -- extra keys and LCD
> # Logitech G15 v2 (orange) -- extra keys and LCD
> # Logitech Z10 -- extra keys and LCD, shared with audio, not a keyboard
> # Logitech G15 Gamepanel -- extra keys and LCD
>
> but using an daemon has it own problems, so I would like to
> move the support to the kernel.
>

I think the ideal approach is to use a split between a userspace daemon
and the kernel driver. I've exposed a lot of the driver to userspace
through sysfs to allow a great deal of control through a userspace daemon
for the G13.

In particular I think a similar approach with the framebuffer for those
devices would be particularly beneficial. It allows things such as the
cairo library to be used to draw on the LCD which opens up the possibility
for all kinds of userspace applets.

> Is it ok for you?
>

I don't have a problem with it, but I think there might be issues;
especially if the feature reports are different.

There is similar framebuffer code that could be shared even if the usbhid
reports differ since the LCD image format is the same.

But, I don't think the framebuffer code could be completely separated
since the G13 uses the same interrupt pipe for images and key reports.
That's why the framebuffer code (as minimal as it is) is inside the hid
driver.

> Could you use a more generic name for configuration?
> (e.g. CONFIG_LOGITECH_G_SERIES)
>

I don't have a problem with it, but my gut feeling is that they will be
separate drivers. So perhaps a menu option for the G series with the G
series drivers under it???

---

Rick


--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
