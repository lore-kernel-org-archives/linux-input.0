From: Gregor Riepl <onitake@gmail.com>
Subject: Re: [PATCH v2] Input: silead - Do not try to directly access the GPIO
 when using ACPI pm
Date: Tue, 14 Mar 2017 19:12:26 +0100
Message-ID: <6b94161d-5495-b5fc-576e-b200e14ea6f0@gmail.com>
References: <20170201174257.GE40045@dtor-ws>
 <20170202104130.GJ2053@lahna.fi.intel.com>
 <8e91084e-e0ea-b055-5c62-67a4e0e56df4@redhat.com>
 <20170202121018.GN2053@lahna.fi.intel.com>
 <20170202123206.GP2053@lahna.fi.intel.com>
 <d4a9ad28-d6a8-5714-ddae-510c1f61f3c6@redhat.com>
 <20170202131251.GQ2053@lahna.fi.intel.com>
 <cf8dab24-7aeb-07f1-2018-a96cc3dfc37e@redhat.com>
 <20170202134439.GS2053@lahna.fi.intel.com>
 <b9a6a4d7-a6c9-ca0e-41d3-98039352471c@redhat.com>
 <20170202141803.GW2053@lahna.fi.intel.com>
 <8786dd51-de5d-3042-2620-5124eec83359@gmail.com>
 <CACRpkdbkUGcR7bd5bP18yPYH4FeDmMj6+=kdX4bEtnTQWq24tg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wr0-f193.google.com ([209.85.128.193]:35495 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750801AbdCNSMc (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Tue, 14 Mar 2017 14:12:32 -0400
Received: by mail-wr0-f193.google.com with SMTP id u108so24908253wrb.2
        for <linux-input@vger.kernel.org>; Tue, 14 Mar 2017 11:12:31 -0700 (PDT)
In-Reply-To: <CACRpkdbkUGcR7bd5bP18yPYH4FeDmMj6+=kdX4bEtnTQWq24tg@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, Hans de Goede <hdegoede@redhat.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, "russianneuromancer @ ya . ru" <russianneuromancer@ya.ru>, Linux Input <linux-input@vger.kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> Isn't that just defeating the whole purpose of ACPI (or any other
> hardware description)?
> 
> Isn't the idea to describe all this in ACPI tables, and that is what the
> vendor should be doing rather than compiling in hardcoded things
> into drivers?
> 
> I just see this as another sign that the ACPI "ecosystem" is not
> really working because vendors choose to arbitrarily bypass it like
> this.

I hear you...

If you want my opinion - in this case it wasn't just a chip manufacturer that
didn't understand or care about the ecosystem, it was also OEMs that didn't
give a shit and Intel that failed to grasp the problem and counteract.

But there's no point in arguing about it, it is how it is and we have to deal
with the fallout.

What we can do is provide better guidance for inexperienced Chinese
manufacturers and lobby Intel so they take more responsibility for their
platforms. A single person can't do much, but I do think that a vital open
source project like the Linux kernel has some leverage.
