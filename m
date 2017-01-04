From: Grant Grundler <grundler@google.com>
Subject: Remove DRIVER_LICENSE?
Date: Wed, 4 Jan 2017 09:58:24 -0800
Message-ID: <CANEJEGvTnSk5kU7LKVLBS73hLM1a_oTKj8tBegFWa+S2MCLpJw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wm0-f43.google.com ([74.125.82.43]:38902 "EHLO
        mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936760AbdADSHG (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Wed, 4 Jan 2017 13:07:06 -0500
Received: by mail-wm0-f43.google.com with SMTP id k184so267863019wme.1
        for <linux-input@vger.kernel.org>; Wed, 04 Jan 2017 10:07:05 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input <linux-input@vger.kernel.org>
Cc: Dmitry Torokhov <dtor@chromium.org>

I'm researching MODULE_LICENSE uses/declarations and AFAICT
DRIVER_LICENSE is only obfuscating the programatically declared
license. e.g.:

drivers/hid/hid-core.c:#define DRIVER_LICENSE "GPL"
drivers/hid/hid-core.c:MODULE_LICENSE(DRIVER_LICENSE);
drivers/hid/usbhid/usbmouse.c:#define DRIVER_LICENSE "GPL"
drivers/hid/usbhid/usbmouse.c:MODULE_LICENSE(DRIVER_LICENSE);
drivers/hid/usbhid/usbkbd.c:#define DRIVER_LICENSE "GPL"
drivers/hid/usbhid/usbkbd.c:MODULE_LICENSE(DRIVER_LICENSE);
drivers/hid/wacom.h:#define DRIVER_LICENSE "GPL"
drivers/hid/wacom_sys.c:MODULE_LICENSE(DRIVER_LICENSE);

Any objection to removing those uses in drivers/hid?

cheers,
grant
