From: "Simon Wood" <simon@mungewell.org>
Subject: Re: RFC: Backport HID-logitech to 3.10?
Date: Fri, 2 Sep 2016 08:59:12 -0600
Message-ID: <604ed54f1e9e0262501a8fb53a41bcb9.squirrel@mungewell.org>
References: <8d56b91cd89e3da158940e53db67b993.squirrel@mungewell.org>
    <CAN+gG=FjjBFxNAKiXPu9xJQsZNOg1pOmo1_-MsvTQV4J11e6vw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from host18.canaca.com ([66.49.204.205]:48704 "EHLO
        host18.canaca.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932111AbcIBO7R (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Fri, 2 Sep 2016 10:59:17 -0400
In-Reply-To: <CAN+gG=FjjBFxNAKiXPu9xJQsZNOg1pOmo1_-MsvTQV4J11e6vw@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Cc: Simon Wood <simon@mungewell.org>, linux-input <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Fri, September 2, 2016 3:32 am, Benjamin Tissoires wrote:
> On Thu, Sep 1, 2016 at 2:56 AM, Simon Wood <simon@mungewell.org> wrote:
>> After copying the HEAD 'hid-lg.[ch]' and 'hid-lg4ff.[ch]' from 4.7,
>> there is a minimal patch (example attached) required to get the build
>> working.
>
> Don't you need hid-logitech-hidpp too?

Hi Benjamin,
Nope, the 'hid-logitech-hidpp.ko' driver is separate and (for wheels) only
has support for the G920 wheel. Other Logitech wheels are handled by
'hid-logitech.ko'.

> Not sure I understand exactly what you want from us here.

A puppy. ;-)

> The stable rules are detailed in
> Documentation/stable_kernel_rules.txt. And unfortunately, I don't
> think adding these patches will be acceptable for upstream 3.10.

After reading through these I would agree with you, that this is a
nice-to-have not a need-to-have. So, the patch is here if anyone wants to
use it personally or for a distribution.

Thank you for your comments,
Simon.

