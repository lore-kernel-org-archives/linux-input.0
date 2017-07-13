From: Olof Johansson <olof@lixom.net>
Subject: Re: Regression during 4.13 merge window: Mouse not working (under X)
Date: Wed, 12 Jul 2017 17:08:27 -0700
Message-ID: <CAOesGMg0Fzbe9WcnQ1X+vpPCjiRBBE5B1L=tf=-yYLRLNm31BQ@mail.gmail.com>
References: <CAOesGMheE95s75AAz7+H5SPSF068XxAZudWOrEi_FQj_Krkffg@mail.gmail.com>
 <20170712215517.GA22123@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ua0-f194.google.com ([209.85.217.194]:34522 "EHLO
        mail-ua0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750755AbdGMAI3 (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Wed, 12 Jul 2017 20:08:29 -0400
Received: by mail-ua0-f194.google.com with SMTP id l38so3095194uaf.1
        for <linux-input@vger.kernel.org>; Wed, 12 Jul 2017 17:08:29 -0700 (PDT)
In-Reply-To: <20170712215517.GA22123@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Wed, Jul 12, 2017 at 2:55 PM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> On Wed, Jul 12, 2017 at 02:45:18PM -0700, Olof Johansson wrote:
>> Dmitry,
>>
>> I installed current mainline (as of 3b06b1a744) on a z840 here, and
>> lost the mouse.
>>
>> Bisecting down, it seems like "HID: usbhid: remove custom locking from
>> usbhid_open/close" (e399396a6b0) is at fault, and if I revert that and
>> 283a21da1239 I get a working system again. Userspace is Ubuntu 16.04.
>
> Olof, does the patch below work for you?

Yup! Thanks!

> --
> Dmitry
>
> HID: usbhid: fix "always poll" quirk
>
> From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
>
> Even though the IO for devices with "always poll" quirk is already running,
> we still need to set HID_OPENED bit in usbhid->iofl so the interrupt
> handler does not ignore the data coming from the device.
>
> Reported-by: Olof Johansson <olof@lixom.net>
> Fixes: e399396a6b0 ("HID: usbhid: remove custom locking from usbhid_open...")
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Tested-by: Olof Johansson <olof@lixom.net>
