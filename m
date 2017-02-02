From: Gregor Riepl <onitake@gmail.com>
Subject: Re: [PATCH v2] Input: silead - Do not try to directly access the GPIO
 when using ACPI pm
Date: Thu, 2 Feb 2017 15:24:38 +0100
Message-ID: <8786dd51-de5d-3042-2620-5124eec83359@gmail.com>
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
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wj0-f196.google.com ([209.85.210.196]:34056 "EHLO
        mail-wj0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751143AbdBBOYl (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Thu, 2 Feb 2017 09:24:41 -0500
Received: by mail-wj0-f196.google.com with SMTP id ip10so1177369wjb.1
        for <linux-input@vger.kernel.org>; Thu, 02 Feb 2017 06:24:40 -0800 (PST)
In-Reply-To: <20170202141803.GW2053@lahna.fi.intel.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>, Hans de Goede <hdegoede@redhat.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, "russianneuromancer @ ya . ru" <russianneuromancer@ya.ru>, linux-input@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> I suppose the Windows driver just works everywhere, right?

Not really, no.
AFAIK every vendor builds their own driver using a special configuration 
utility from Silead.
All the device-specific data, including panel parameters and calibration data, 
is compiled into this driver.

