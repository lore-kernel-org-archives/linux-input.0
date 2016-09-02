From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: wdt87xx_i2c - support new body WDT8752
Date: Thu, 1 Sep 2016 23:40:25 -0700
Message-ID: <CAKdAkRRH=2ifEs0O8WjNqYUKOcLS6Nigiw=vq2SAB-XKF_7v7g@mail.gmail.com>
References: <1470219398-10892-1-git-send-email-hn.chen@weidahitech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ua0-f181.google.com ([209.85.217.181]:34663 "EHLO
        mail-ua0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751166AbcIBGk1 (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Fri, 2 Sep 2016 02:40:27 -0400
In-Reply-To: <1470219398-10892-1-git-send-email-hn.chen@weidahitech.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: HungNien Chen <hn.chen@weidahitech.com>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>

Hi HN,

On Wed, Aug 3, 2016 at 3:16 AM, HungNien Chen <hn.chen@weidahitech.com> wrote:
>
> Considering to be compatible with i2c-hid, WDT8752 has the same way in
> enumerating device.

If it is a HID device then I think you should write a HID driver for
it (unless existing driver, such as hid-multitouch can already handle
it, possibly with some changes). I'm addng Benjamin to he can comment
as well.

> And also modify the part of FW update to be more
> efficiency. The main modification is that reducing the amount of data
> transmitted and using polling for time comsuming operation.
>
> Flash erase will wait 50ms for the operation complete in last driver.
> Extend it to 200ms since the spec says the typical is 30ms but the max
> is 200ms.

This should be split into a separate patch please.

Thanks.

-- 
Dmitry
