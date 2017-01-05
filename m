From: Grant Grundler <grundler@google.com>
Subject: Re: Remove DRIVER_LICENSE?
Date: Thu, 5 Jan 2017 09:29:43 -0800
Message-ID: <CANEJEGtfNC4VJOp6fDOXCSZhHUdQM4op+BVEHEdc0ragh4=XCw@mail.gmail.com>
References: <CANEJEGvTnSk5kU7LKVLBS73hLM1a_oTKj8tBegFWa+S2MCLpJw@mail.gmail.com>
 <CAE_wzQ975aiGGdF78bXxqOTNFg-p3HUOsxicq_a1OS8NcdJROw@mail.gmail.com>
 <CAE_wzQ8SdhAUv1TLzKE_gt1qgb9SuPJt30m2pyw01kTE4gqbRg@mail.gmail.com> <alpine.LSU.2.20.1701051118450.28985@cbobk.fhfr.pm>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wm0-f50.google.com ([74.125.82.50]:37780 "EHLO
        mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758927AbdAER6g (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Thu, 5 Jan 2017 12:58:36 -0500
Received: by mail-wm0-f50.google.com with SMTP id t79so494121041wmt.0
        for <linux-input@vger.kernel.org>; Thu, 05 Jan 2017 09:58:35 -0800 (PST)
In-Reply-To: <alpine.LSU.2.20.1701051118450.28985@cbobk.fhfr.pm>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>
Cc: Dmitry Torokhov <dtor@chromium.org>, linux-input <linux-input@vger.kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Ping Cheng <pinglinux@gmail.com>

On Thu, Jan 5, 2017 at 2:19 AM, Jiri Kosina <jikos@kernel.org> wrote:
> On Wed, 4 Jan 2017, Dmitry Torokhov wrote:
>
>> [ let's add a few people ]
>>
>> On Wed, Jan 4, 2017 at 10:12 AM, Dmitry Torokhov <dtor@chromium.org> wrote:
>> > On Wed, Jan 4, 2017 at 9:58 AM, Grant Grundler <grundler@google.com> wrote:
>> >> I'm researching MODULE_LICENSE uses/declarations and AFAICT
>> >> DRIVER_LICENSE is only obfuscating the programatically declared
>> >> license. e.g.:
>> >>
>> >> drivers/hid/hid-core.c:#define DRIVER_LICENSE "GPL"
>> >> drivers/hid/hid-core.c:MODULE_LICENSE(DRIVER_LICENSE);
>> >> drivers/hid/usbhid/usbmouse.c:#define DRIVER_LICENSE "GPL"
>> >> drivers/hid/usbhid/usbmouse.c:MODULE_LICENSE(DRIVER_LICENSE);
>> >> drivers/hid/usbhid/usbkbd.c:#define DRIVER_LICENSE "GPL"
>> >> drivers/hid/usbhid/usbkbd.c:MODULE_LICENSE(DRIVER_LICENSE);
>> >> drivers/hid/wacom.h:#define DRIVER_LICENSE "GPL"
>> >> drivers/hid/wacom_sys.c:MODULE_LICENSE(DRIVER_LICENSE);
>> >>
>> >> Any objection to removing those uses in drivers/hid?
>
> Nope, let's do it. Grant, will you send me a patch?

Yes. It's a trivial patch. I'll prep that right now and send once I've
at least compiled the kernel with it.

cheers,
grant
