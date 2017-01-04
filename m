From: Dmitry Torokhov <dtor@chromium.org>
Subject: Re: Remove DRIVER_LICENSE?
Date: Wed, 4 Jan 2017 10:12:20 -0800
Message-ID: <CAE_wzQ975aiGGdF78bXxqOTNFg-p3HUOsxicq_a1OS8NcdJROw@mail.gmail.com>
References: <CANEJEGvTnSk5kU7LKVLBS73hLM1a_oTKj8tBegFWa+S2MCLpJw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qt0-f176.google.com ([209.85.216.176]:34424 "EHLO
        mail-qt0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1031661AbdADSMX (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Wed, 4 Jan 2017 13:12:23 -0500
Received: by mail-qt0-f176.google.com with SMTP id d45so275794896qta.1
        for <linux-input@vger.kernel.org>; Wed, 04 Jan 2017 10:12:22 -0800 (PST)
Received: from mail-qk0-f173.google.com (mail-qk0-f173.google.com. [209.85.220.173])
        by smtp.gmail.com with ESMTPSA id 32sm15857076qtz.26.2017.01.04.10.12.21
        for <linux-input@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 04 Jan 2017 10:12:21 -0800 (PST)
Received: by mail-qk0-f173.google.com with SMTP id n21so408826279qka.3
        for <linux-input@vger.kernel.org>; Wed, 04 Jan 2017 10:12:21 -0800 (PST)
In-Reply-To: <CANEJEGvTnSk5kU7LKVLBS73hLM1a_oTKj8tBegFWa+S2MCLpJw@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Grant Grundler <grundler@google.com>
Cc: linux-input <linux-input@vger.kernel.org>, Dmitry Torokhov <dtor@chromium.org>

On Wed, Jan 4, 2017 at 9:58 AM, Grant Grundler <grundler@google.com> wrote:
> I'm researching MODULE_LICENSE uses/declarations and AFAICT
> DRIVER_LICENSE is only obfuscating the programatically declared
> license. e.g.:
>
> drivers/hid/hid-core.c:#define DRIVER_LICENSE "GPL"
> drivers/hid/hid-core.c:MODULE_LICENSE(DRIVER_LICENSE);
> drivers/hid/usbhid/usbmouse.c:#define DRIVER_LICENSE "GPL"
> drivers/hid/usbhid/usbmouse.c:MODULE_LICENSE(DRIVER_LICENSE);
> drivers/hid/usbhid/usbkbd.c:#define DRIVER_LICENSE "GPL"
> drivers/hid/usbhid/usbkbd.c:MODULE_LICENSE(DRIVER_LICENSE);
> drivers/hid/wacom.h:#define DRIVER_LICENSE "GPL"
> drivers/hid/wacom_sys.c:MODULE_LICENSE(DRIVER_LICENSE);
>
> Any objection to removing those uses in drivers/hid?

Sounds good to me.

Thanks.

-- 
Dmitry
