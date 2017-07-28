From: Jason Gerecke <killertofu@gmail.com>
Subject: Re: [PATCH] HID: wacom: add USB_HID dependency
Date: Fri, 28 Jul 2017 07:24:26 -0700
Message-ID: <CANRwn3TcLOgW9E=Sauj8-14d834FKegUXO7cw_ekJNhyLVR7=g@mail.gmail.com>
References: <20170728131826.180483-1-arnd@arndb.de> <6C9C978F-447D-42A5-9245-894577F2944D@gmail.com>
 <CAK8P3a3S_1LMXrQ_m5N3Cu4XQvcDAyQFGMEwcRCtYBwBaajdYg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ua0-f194.google.com ([209.85.217.194]:36562 "EHLO
        mail-ua0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751761AbdG1OY1 (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Fri, 28 Jul 2017 10:24:27 -0400
In-Reply-To: <CAK8P3a3S_1LMXrQ_m5N3Cu4XQvcDAyQFGMEwcRCtYBwBaajdYg@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Jiri Kosina <jikos@kernel.org>, Jason Gerecke <jason.gerecke@wacom.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Fri, Jul 28, 2017 at 7:18 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Fri, Jul 28, 2017 at 4:07 PM, Jason Gerecke <killertofu@gmail.com> wrote:
>> On July 28, 2017 6:18:00 AM PDT, Arnd Bergmann <arnd@arndb.de> wrote:
>>>The driver has gained a compile-time dependency that we should
>>>express in Kconfig to avoid this link error:
>>>
>>
>> Would conditional compilation be an acceptable alternative to adding
>> a dependency? The USB_HID code is only used to check if the driver
>> is working with a USB device. With USB_HID disabled, there's no need
>> for the check so there's no need for the dependency.
>
> I think that should work, e.g. you could replace the hid_is_using_ll_driver
> and 'extern' defintions with a helper per ll-driver like
>
> #ifdef CONFIG_USB_HID
> extern bool hid_is_using_usb_driver(struct hid_device *hdev)
> #else
> static inline bool hid_is_using_usb_driver(struct hid_device *hdev)
> {
>        return false;
> }
> #endif
>
> but is it worth it to avoid the dependency?
>
>        Arnd

I was thinking something more along the lines of the following since
the idea of per-transport helper functions was dismissed earlier:

#ifdef CONFIG_USB_HID
                if (hid_is_using_ll_driver(wacom->hdev, &usb_hid_driver)) {
[...]
                }
#endif

Jason
