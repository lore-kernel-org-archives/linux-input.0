From: M K <m.kolesinski@gmail.com>
Subject: Re: ELAN0732 I2C Touchscreen Driver
Date: Tue, 21 Mar 2017 22:30:43 -0500
Message-ID: <CALLvBipA1K6jaK9LzDaxwRqoGZMK7jZMSk6rTbgoucgskFWFpQ@mail.gmail.com>
References: <CALLvBir2m6iuq1ntwZU+ZTahCeHXZQ5DNUb7nPe9jSUXL-AOLA@mail.gmail.com>
 <CAKdAkRTnqwyjGcQjmmHxAOkWSMnADtO5WnyyndkwqP9wo_FcWw@mail.gmail.com>
 <002101d2a206$d5212b70$7f638250$@emc.com.tw> <20170321170100.GA32539@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-vk0-f66.google.com ([209.85.213.66]:34068 "EHLO
        mail-vk0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758579AbdCVDbv (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Tue, 21 Mar 2017 23:31:51 -0400
Received: by mail-vk0-f66.google.com with SMTP id y16so8977372vky.1
        for <linux-input@vger.kernel.org>; Tue, 21 Mar 2017 20:30:44 -0700 (PDT)
In-Reply-To: <20170321170100.GA32539@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: =?UTF-8?B?5YqJ5ZiJ6ae/?= <scott.liu@emc.com.tw>, =?UTF-8?B?5buW5bSH5qau?= <kt.liao@emc.com.tw>, linux-input@vger.kernel.org, james.chen@emc.com.tw

Hi Dmitry,

What do you mean by DTSD?

Also, in my quest for answers I came across a bug report from a
different user who happens to have this exact same laptop model.  They
attached all kinds of debugging logs.

However, I'm not having any of these issues (I checked journalctl and dmesg=
):
https://patchwork.kernel.org/patch/9318703/




On Tue, Mar 21, 2017 at 12:01 PM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> On Tue, Mar 21, 2017 at 01:48:57PM +0800, =E5=8A=89=E5=98=89=E9=A7=BF wro=
te:
>> As far as I known, It is hidi2c device and not be supported by elants_i2=
c module.
>> elants_i2c module is for chrome i2c device.
>>
>> I supposed hidi2c driver can support this device but don't know why it d=
oesn't work?
>
> i2c-hid driver binds to ACPI0C50 or PNP0C50 devices. MK, could you
> please post snippet of your DTSD with ELAN0732 device?
>
>>
>> Thanks,
>> Scott
>>
>> -----Original Message-----
>> From: Dmitry Torokhov [mailto:dmitry.torokhov@gmail.com]
>> Sent: Tuesday, March 21, 2017 12:45 PM
>> To: M K; =E5=BB=96=E5=B4=87=E6=A6=AE
>> Cc: linux-input@vger.kernel.org; ELAN =E5=8A=89=E5=98=89=E9=A7=BF
>> Subject: Re: ELAN0732 I2C Touchscreen Driver
>>
>> On Sun, Mar 19, 2017 at 11:26 PM, M K <m.kolesinski@gmail.com> wrote:
>> > Is there a compatible driver for this device?  I've tried loading
>> > various modules with no success (elants_i2c, hid_multitouch, etc.).
>> >
>> > The device shows up under /sys/bus/i2c/devices/i2c-ELAN0732:00
>>
>> You would need to add "ELAN0732" to elants_i2c_id table for elants_i2c t=
o load and bind to the device.
>>
>> >
>> > However, xinput does not list it at all.
>> >
>> > This is an HP m6-ar004dx laptop (Envy x360) with touchscreen display,
>> > and AMD FX-9800P processor.
>> >
>> > Scott Liu suggested I try posting here.
>>
>> Hmm, I'd expect Scott to know if elants_i2c could theoretically drive th=
is device. KT, do you know by chance?
>>
>> Thanks.
>>
>> --
>> Dmitry
>>
>
> --
> Dmitry
