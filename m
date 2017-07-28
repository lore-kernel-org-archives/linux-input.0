From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] HID: wacom: add USB_HID dependency
Date: Fri, 28 Jul 2017 16:29:34 +0200
Message-ID: <CAK8P3a2NP=mTO9z8_wtbjExAfGsPaGhaa=srEuR4hA9HbPNUFg@mail.gmail.com>
References: <20170728131826.180483-1-arnd@arndb.de> <6C9C978F-447D-42A5-9245-894577F2944D@gmail.com>
 <CAK8P3a3S_1LMXrQ_m5N3Cu4XQvcDAyQFGMEwcRCtYBwBaajdYg@mail.gmail.com> <CANRwn3TcLOgW9E=Sauj8-14d834FKegUXO7cw_ekJNhyLVR7=g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-oi0-f51.google.com ([209.85.218.51]:35497 "EHLO
        mail-oi0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751761AbdG1O3f (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Fri, 28 Jul 2017 10:29:35 -0400
In-Reply-To: <CANRwn3TcLOgW9E=Sauj8-14d834FKegUXO7cw_ekJNhyLVR7=g@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jason Gerecke <killertofu@gmail.com>
Cc: Jiri Kosina <jikos@kernel.org>, Jason Gerecke <jason.gerecke@wacom.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Fri, Jul 28, 2017 at 4:24 PM, Jason Gerecke <killertofu@gmail.com> wrote:
> On Fri, Jul 28, 2017 at 7:18 AM, Arnd Bergmann <arnd@arndb.de> wrote:
>> On Fri, Jul 28, 2017 at 4:07 PM, Jason Gerecke <killertofu@gmail.com> wrote:

>> #ifdef CONFIG_USB_HID
>> extern bool hid_is_using_usb_driver(struct hid_device *hdev)
>> #else
>> static inline bool hid_is_using_usb_driver(struct hid_device *hdev)
>> {
>>        return false;
>> }
>> #endif
>>
>> but is it worth it to avoid the dependency?
>>
>>        Arnd
>
> I was thinking something more along the lines of the following since
> the idea of per-transport helper functions was dismissed earlier:
>
> #ifdef CONFIG_USB_HID
>                 if (hid_is_using_ll_driver(wacom->hdev, &usb_hid_driver)) {

I would consider that rather ugly, a driver shouldn't really use
#ifdef like this, but you can hide stuff like this in a header. The method
I proposed also has the advantage of avoiding exporting the
usb_hid_driver object. Drivers shouldn't really need to access this,
and wacom_sys.c is the only remaining user of the export.

      Arnd
