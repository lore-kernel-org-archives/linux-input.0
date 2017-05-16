From: Dimitar Petrovski <dimeptr@gmail.com>
Subject: Re: add Fujitsu Lifebook E546 to force crc_enabled
Date: Tue, 16 May 2017 10:57:05 +0200
Message-ID: <CAKtuzf4pfGibW9GpyYpVedTzDUp2L5v_6A2NbT-b74GyEKZ-sg@mail.gmail.com>
References: <CAKtuzf7M0oGPA=vny7fO6dTiKcPiSTZ3Xn=_TqBuEp6hvu4DTA@mail.gmail.com>
 <20170515192404.z47o3z2loyw2vci3@beacon.debie>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qt0-f178.google.com ([209.85.216.178]:34880 "EHLO
        mail-qt0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751137AbdEPI50 (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Tue, 16 May 2017 04:57:26 -0400
Received: by mail-qt0-f178.google.com with SMTP id v27so99490676qtg.2
        for <linux-input@vger.kernel.org>; Tue, 16 May 2017 01:57:26 -0700 (PDT)
In-Reply-To: <20170515192404.z47o3z2loyw2vci3@beacon.debie>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: ulrik.debie-os@e2big.org
Cc: linux-input@vger.kernel.org

Hi Ulrik,

The firmware version is: 0x470f00
The Synaptics capabilities: 0x50, 0x12, 0x09

following is complete dmesg:
psmouse serio2: elantech: assuming hardware version 4 (with firmware
version 0x470f00)
psmouse serio2: elantech: Synaptics capabilities query result 0x50, 0x12, 0x09.
psmouse serio2: elantech: Elan sample query result 01, 27, 86
input: ETPS/2 Elantech Touchpad as /devices/platform/i8042/serio2/input/input10

The touchpad has two distinct left and right buttons.

cat /sys/devices/virtual/dmi/id/sys_vendor :
FUJITSU

cat /sys/devices/virtual/dmi/id/product_name :
LIFEBOOK E546

If you need me to test a patch I will gladly do it if I can find a way
to build just the module, not the whole kernel.

Regards,
Dimitar

On Mon, May 15, 2017 at 9:24 PM,  <ulrik.debie-os@e2big.org> wrote:
> Hi Dimitar,
>
> I just was busy preparing a patch for Lifebook e557.
>
> Can you please give the following information to make the patch complete ?
>
> - Look at dmesg:
>
>   * What number reports the driver as the firmware version of your touchpad?
>     (It looks like "with firmware version 0x??????")
>
>   * What is the Synaptics capabilities query result?
>     (Three numbers like 0x??, 0x??, 0x??)
>
> - What hardware buttons does your touchpad have? Two distinct left and right
>   buttons, or three, or can you click down on the whole touchpad (a so
>   called clickpad)?
>
> - What is the output of
>
>     cat /sys/devices/virtual/dmi/id/sys_vendor
>
> - What is the output of
>
>     cat /sys/devices/virtual/dmi/id/product_name
>
> Thanks,
> Ulrik
>
> On Sun, May 14, 2017 at 11:36:56AM +0200, Dimitar Petrovski wrote:
>> Date:   Sun, 14 May 2017 11:36:56 +0200
>> From: Dimitar Petrovski <dimeptr@gmail.com>
>> To: linux-input@vger.kernel.org
>> Subject: add Fujitsu Lifebook E546 to force crc_enabled
>> X-Mailing-List: linux-input@vger.kernel.org
>>
>> Hi,
>>
>> I have seen this messages https://patchwork.kernel.org/patch/9645671/
>> about adding Fujitsu Lifebook E547 to force crc_enabled.
>> I own Fujitsu Lifebook E546 and I have the same problem, I currently
>> force crc_enabled through rc.local, but I think it should also be
>> included in the kernel.
>>
>> Regards,
>> Dimitar
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-input" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
