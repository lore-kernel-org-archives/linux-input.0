From: Dmitry Torokhov <dtor@chromium.org>
Subject: Re: Remove DRIVER_LICENSE?
Date: Wed, 4 Jan 2017 10:14:02 -0800
Message-ID: <CAE_wzQ8SdhAUv1TLzKE_gt1qgb9SuPJt30m2pyw01kTE4gqbRg@mail.gmail.com>
References: <CANEJEGvTnSk5kU7LKVLBS73hLM1a_oTKj8tBegFWa+S2MCLpJw@mail.gmail.com>
 <CAE_wzQ975aiGGdF78bXxqOTNFg-p3HUOsxicq_a1OS8NcdJROw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qt0-f182.google.com ([209.85.216.182]:35433 "EHLO
        mail-qt0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751225AbdADSme (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Wed, 4 Jan 2017 13:42:34 -0500
Received: by mail-qt0-f182.google.com with SMTP id c47so498723586qtc.2
        for <linux-input@vger.kernel.org>; Wed, 04 Jan 2017 10:42:33 -0800 (PST)
Received: from mail-qk0-f173.google.com (mail-qk0-f173.google.com. [209.85.220.173])
        by smtp.gmail.com with ESMTPSA id q88sm35990155qkq.21.2017.01.04.10.14.03
        for <linux-input@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 04 Jan 2017 10:14:03 -0800 (PST)
Received: by mail-qk0-f173.google.com with SMTP id n21so408874898qka.3
        for <linux-input@vger.kernel.org>; Wed, 04 Jan 2017 10:14:03 -0800 (PST)
In-Reply-To: <CAE_wzQ975aiGGdF78bXxqOTNFg-p3HUOsxicq_a1OS8NcdJROw@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Grant Grundler <grundler@google.com>
Cc: linux-input <linux-input@vger.kernel.org>, Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Ping Cheng <pinglinux@gmail.com>

[ let's add a few people ]

On Wed, Jan 4, 2017 at 10:12 AM, Dmitry Torokhov <dtor@chromium.org> wrote:
> On Wed, Jan 4, 2017 at 9:58 AM, Grant Grundler <grundler@google.com> wrote:
>> I'm researching MODULE_LICENSE uses/declarations and AFAICT
>> DRIVER_LICENSE is only obfuscating the programatically declared
>> license. e.g.:
>>
>> drivers/hid/hid-core.c:#define DRIVER_LICENSE "GPL"
>> drivers/hid/hid-core.c:MODULE_LICENSE(DRIVER_LICENSE);
>> drivers/hid/usbhid/usbmouse.c:#define DRIVER_LICENSE "GPL"
>> drivers/hid/usbhid/usbmouse.c:MODULE_LICENSE(DRIVER_LICENSE);
>> drivers/hid/usbhid/usbkbd.c:#define DRIVER_LICENSE "GPL"
>> drivers/hid/usbhid/usbkbd.c:MODULE_LICENSE(DRIVER_LICENSE);
>> drivers/hid/wacom.h:#define DRIVER_LICENSE "GPL"
>> drivers/hid/wacom_sys.c:MODULE_LICENSE(DRIVER_LICENSE);
>>
>> Any objection to removing those uses in drivers/hid?
>
> Sounds good to me.
>
> Thanks.
>
> --
> Dmitry
