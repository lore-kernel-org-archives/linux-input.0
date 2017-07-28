From: Jason Gerecke <killertofu@gmail.com>
Subject: Re: [PATCH] HID: wacom: add USB_HID dependency
Date: Fri, 28 Jul 2017 08:15:28 -0700
Message-ID: <CANRwn3QGovTdAhbVtc1MYzogEir+P3niiRCUPDG80XQH6eHxKg@mail.gmail.com>
References: <20170728131826.180483-1-arnd@arndb.de> <6C9C978F-447D-42A5-9245-894577F2944D@gmail.com>
 <CAK8P3a3S_1LMXrQ_m5N3Cu4XQvcDAyQFGMEwcRCtYBwBaajdYg@mail.gmail.com>
 <CANRwn3TcLOgW9E=Sauj8-14d834FKegUXO7cw_ekJNhyLVR7=g@mail.gmail.com> <CAK8P3a2NP=mTO9z8_wtbjExAfGsPaGhaa=srEuR4hA9HbPNUFg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ua0-f196.google.com ([209.85.217.196]:36400 "EHLO
        mail-ua0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751975AbdG1PPa (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Fri, 28 Jul 2017 11:15:30 -0400
In-Reply-To: <CAK8P3a2NP=mTO9z8_wtbjExAfGsPaGhaa=srEuR4hA9HbPNUFg@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Jiri Kosina <jikos@kernel.org>, Jason Gerecke <jason.gerecke@wacom.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Fri, Jul 28, 2017 at 7:29 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Fri, Jul 28, 2017 at 4:24 PM, Jason Gerecke <killertofu@gmail.com> wrote:
>> On Fri, Jul 28, 2017 at 7:18 AM, Arnd Bergmann <arnd@arndb.de> wrote:
>>> On Fri, Jul 28, 2017 at 4:07 PM, Jason Gerecke <killertofu@gmail.com> wrote:
>
>>> #ifdef CONFIG_USB_HID
>>> extern bool hid_is_using_usb_driver(struct hid_device *hdev)
>>> #else
>>> static inline bool hid_is_using_usb_driver(struct hid_device *hdev)
>>> {
>>>        return false;
>>> }
>>> #endif
>>>
>>> but is it worth it to avoid the dependency?
>>>
>>>        Arnd
>>
>> I was thinking something more along the lines of the following since
>> the idea of per-transport helper functions was dismissed earlier:
>>
>> #ifdef CONFIG_USB_HID
>>                 if (hid_is_using_ll_driver(wacom->hdev, &usb_hid_driver)) {
>
> I would consider that rather ugly, a driver shouldn't really use
> #ifdef like this, but you can hide stuff like this in a header. The method
> I proposed also has the advantage of avoiding exporting the
> usb_hid_driver object. Drivers shouldn't really need to access this,
> and wacom_sys.c is the only remaining user of the export.
>
>       Arnd

The exports and hid_is_using_ll_driver were actually introduced in the
patch immediately preceding the change to wacom_sys.c which triggered
this error (making it the "first", not "last" user).

That said, after reading through the patch discussion[1] again, I see
that my memory is faulty: per-transport functions were *not*
dismissed. Rather, a more-generic function that is fed the
hid_ll_driver of interest was suggested instead. Given that these
exports are liable to cause this same issue for future users, perhaps
providing per-transport functions is the better option after all.

I could accept either the strict dependency you originally suggested
or a modified header, but don't see much reason for the former.
Checking if a HID device is using a particular transport shouldn't
require that that transport even be available IMO, but that's
ultimately not my call...

Jiri? Benjamin?

[1]: https://patchwork.kernel.org/patch/9815539/

Jason
