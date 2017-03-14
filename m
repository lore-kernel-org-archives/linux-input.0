From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v2] Input: silead - Do not try to directly access the
 GPIO when using ACPI pm
Date: Tue, 14 Mar 2017 15:09:19 +0200
Message-ID: <1489496959.20145.240.camel@linux.intel.com>
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:21401 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750876AbdCNNJX (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Tue, 14 Mar 2017 09:09:23 -0400
In-Reply-To: <CACRpkdbkUGcR7bd5bP18yPYH4FeDmMj6+=kdX4bEtnTQWq24tg@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>, Gregor Riepl <onitake@gmail.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, Hans de Goede <hdegoede@redhat.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, "russianneuromancer @ ya . ru" <russianneuromancer@ya.ru>, Linux Input <linux-input@vger.kernel.org>

On Tue, 2017-03-14 at 11:21 +0100, Linus Walleij wrote:
> On Thu, Feb 2, 2017 at 3:24 PM, Gregor Riepl <onitake@gmail.com>
> wrote:
> 
> > > I suppose the Windows driver just works everywhere, right?
> > 
> > Not really, no.
> > AFAIK every vendor builds their own driver using a special
> > configuration
> > utility from Silead.
> > All the device-specific data, including panel parameters and
> > calibration
> > data, is compiled into this driver.
> 
> Isn't that just defeating the whole purpose of ACPI (or any other
> hardware description)?
> 
> Isn't the idea to describe all this in ACPI tables, and that is what
> the
> vendor should be doing rather than compiling in hardcoded things
> into drivers?

> I just see this as another sign that the ACPI "ecosystem" is not
> really working because vendors choose to arbitrarily bypass it like
> this.
> 
> Is it too hard for them to use ACPI or is ACPI lacking the right
> parameters to tweak or what is the real problem?

With _DSD is possible to enhance ACPI tables to cover almost everything,
but there is another issue(s):

a) we still have to cope with old firmwares,

b) Windows is doing things differently, and

c) some vendors are abusing ACPI (existing!) standards.

Here is a dilemma: make user's life miserable with hardware they bought,
or make developers' life miserable to support all that. And the winner
is... vendor which is abusing whatever it wants to!

One recent example I found is a Kontron xBTI x86 board (Linux
compatible!) where they abused ACPI by creating a table that even iasl
can't decode (not a major issue, the table name is just non-standard,
but nevertheless).

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
