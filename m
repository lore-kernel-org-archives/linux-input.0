From: M K <m.kolesinski@gmail.com>
Subject: Re: ELAN0732 I2C Touchscreen Driver
Date: Tue, 28 Mar 2017 03:15:33 -0500
Message-ID: <CALLvBioysx1u3F8NUNMskM-CR5JO5CK7yT6WCt1WpwbH=5ZnWA@mail.gmail.com>
References: <CALLvBir2m6iuq1ntwZU+ZTahCeHXZQ5DNUb7nPe9jSUXL-AOLA@mail.gmail.com>
 <CAKdAkRTnqwyjGcQjmmHxAOkWSMnADtO5WnyyndkwqP9wo_FcWw@mail.gmail.com>
 <001201d2a207$b4e6c8a0$1eb459e0$@emc.com.tw> <044e01d2a770$54da63e0$fe8f2ba0$@emc.com.tw>
 <CALLvBiqmzKegjKt9r2wt3PBTvOdaCBA3cVR48majEZfdptRGMA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=001a11437e8865d55e054bc61024
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-vk0-f44.google.com ([209.85.213.44]:36309 "EHLO
        mail-vk0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754638AbdC1IQJ (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Tue, 28 Mar 2017 04:16:09 -0400
Received: by mail-vk0-f44.google.com with SMTP id s68so79486339vke.3
        for <linux-input@vger.kernel.org>; Tue, 28 Mar 2017 01:15:54 -0700 (PDT)
In-Reply-To: <CALLvBiqmzKegjKt9r2wt3PBTvOdaCBA3cVR48majEZfdptRGMA@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "Johnny.Chuang" <johnny.chuang@emc.com.tw>
Cc: =?UTF-8?B?5buW5bSH5qau?= <kt.liao@emc.com.tw>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, =?UTF-8?B?RUxBTiDlionlmInpp78=?= <scott.liu@emc.com.tw>

--001a11437e8865d55e054bc61024
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

And here's a screenshot of the device info in Windows:

On Tue, Mar 28, 2017 at 3:13 AM, M K <m.kolesinski@gmail.com> wrote:
> Hi Johnny,
>
> Did you mean to add the {.driver_data...} to a static in i2c-hid.c, or
> in hid-multitouch.c?  If so, where?  After downloading the kernel
> source and building these modules, it looks to me like
> hid-multitouch.c is its own module (part of the Makefile for
> "M=3Ddrivers/hid") separate from i2c-hid ("M=3Ddrivers/hid/i2c-hid")
>
> Also, the comments in hid-multitouch.c state that definitions for
> items using MT_CLS_DEFAULT don't do anything.  Finally, what device
> type should I use?  The code you provided won't compile, because the
> HID_DEVICE() macro expects another argument.  I presume this would be
> "HID_GROUP_MULTITOUCH" ?
>
> After trying the above, I recompiled the two modules and re-installed
> them in my kernel using modprobe.  However, I could find no evidence
> that the ELAN0732 device was actually detected as an input device (cat
> /proc/bus/input/devices, and xinput both don't show anything new).  I
> also tried rebooting (however, neither of these modules is in the
> standard initramfs for Arch Linux, so I don't think rebooting is
> necessary).
>
> Any other ideas?
>
> Also, here's a snippet of the DxDiag report from Windows..for this
> vendor ID, it lists 4 devices (0x2B28)...not sure if this is the same
> piece of hardware or not:
> "-------------------
> DirectInput Devices
> -------------------
>       Device Name: Mouse
>          Attached: 1
>     Controller ID: n/a
> Vendor/Product ID: n/a
>         FF Driver: n/a
>
>       Device Name: Keyboard
>          Attached: 1
>     Controller ID: n/a
> Vendor/Product ID: n/a
>         FF Driver: n/a
>
>       Device Name: HIDI2C Device
>          Attached: 1
>     Controller ID: 0x0
> Vendor/Product ID: 0x04F3, 0x2B28
>         FF Driver: n/a
>
>       Device Name: HIDI2C Device
>          Attached: 1
>     Controller ID: 0x0
> Vendor/Product ID: 0x04F3, 0x2B28
>         FF Driver: n/a
>
>       Device Name: HIDI2C Device
>          Attached: 1
>     Controller ID: 0x0
> Vendor/Product ID: 0x04F3, 0x2B28
>         FF Driver: n/a
>
>       Device Name: HIDI2C Device
>          Attached: 1
>     Controller ID: 0x0
> Vendor/Product ID: 0x04F3, 0x2B28
>         FF Driver: n/a
>
>       Device Name: HP Wireless Button Driver
>          Attached: 1
>     Controller ID: 0x0
> Vendor/Product ID: 0x0001, 0x0001
>         FF Driver: n/a
>
>       Device Name: ST_SENSOR_HUB
>          Attached: 1
>     Controller ID: 0x0
> Vendor/Product ID: 0x0483, 0x91D1
>         FF Driver: n/a
>
> Poll w/ Interrupt: No
>
> -----------"
>
>
>
>
> Thanks,
>
> MK
>
>
> On Mon, Mar 27, 2017 at 10:06 PM, Johnny.Chuang
> <johnny.chuang@emc.com.tw> wrote:
>> Hi Dmitry,
>>
>> Sorry for late response.
>>
>> ELAN0732 is hid over i2c touch screen device.
>> There is a compatible linux inbox driver which is drivers/hid/i2c-hid/i2=
c-hid.c.
>> Please make i2c-hid.c as build-in driver or module.
>>
>> And please also add VID/PID at hid-ids.h and hid-multitouch.c
>> drivers/hid/hid-ids.h
>>         #define USB_VENDOR_ID_ELAN      0x04f3
>>         #define USB_DEVICE_ID_ELAN_A    0x0732
>>         #define USB_DEVICE_ID_ELAN_B    0x000b
>> drivers/hid/hid-multitouch.c
>>         /* Elan i2c-hid TouchSystems panel */
>>         { .driver_data =3D MT_CLS_DEFAULT,
>>                 HID_DEVICE(BUS_I2C, USB_VENDOR_ID_ELAN,
>>                         USB_DEVICE_ID_ELAN_A) },
>>
>> Many thanks,
>> Johnny
>> -----Original Message-----
>> From: =E5=BB=96=E5=B4=87=E6=A6=AE [mailto:kt.liao@emc.com.tw]
>> Sent: Tuesday, March 21, 2017 1:55 PM
>> To: 'Dmitry Torokhov'; 'M K'
>> Cc: linux-input@vger.kernel.org; 'ELAN =E5=8A=89=E5=98=89=E9=A7=BF'; 'Jo=
hnny.Chuang'
>> Subject: RE: ELAN0732 I2C Touchscreen Driver
>>
>> Add Johnny who handle ELAN touchscreen in loop.
>>
>> -----Original Message-----
>> From: Dmitry Torokhov [mailto:dmitry.torokhov@gmail.com]
>> Sent: Tuesday, March 21, 2017 12:45 PM
>> To: M K; =E5=BB=96=E5=B4=87=E6=A6=AE
>> Cc: linux-input@vger.kernel.org; ELAN =E5=8A=89=E5=98=89=E9=A7=BF
>> Subject: Re: ELAN0732 I2C Touchscreen Driver
>>
>> On Sun, Mar 19, 2017 at 11:26 PM, M K <m.kolesinski@gmail.com> wrote:
>>> Is there a compatible driver for this device?  I've tried loading
>>> various modules with no success (elants_i2c, hid_multitouch, etc.).
>>>
>>> The device shows up under /sys/bus/i2c/devices/i2c-ELAN0732:00
>>
>> You would need to add "ELAN0732" to elants_i2c_id table for elants_i2c t=
o load and bind to the device.
>>
>>>
>>> However, xinput does not list it at all.
>>>
>>> This is an HP m6-ar004dx laptop (Envy x360) with touchscreen display,
>>> and AMD FX-9800P processor.
>>>
>>> Scott Liu suggested I try posting here.
>>
>> Hmm, I'd expect Scott to know if elants_i2c could theoretically drive th=
is device. KT, do you know by chance?
>> Hi Johnny,
>>         Could you help to check this TS issue
>> Thanks.
>>
>> --
>> Dmitry
>>

--001a11437e8865d55e054bc61024
Content-Type: image/png; name="elan_0732_info.png"
Content-Disposition: attachment; filename="elan_0732_info.png"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_j0t9owfx0

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
CTAAoG27CbDX/e4bnvhTT7/k0tfeeMvHU19FgL33/dffdc/9N992x/Ufuvn6Gz+8CbBP33r7XX90
48133TvLZ2LVr/5521+EfipMT2KdJ9Vi7OT03dCfhDyZPtyfhP6ZSh5OPDtxKysn/buwPQEGALRt
NwH2pje/5TGPf8J3/svv/qff9T0/+vgn5hL71P2f/cANH776fdfddc99t3z8zpReN9z0kSuufu8d
d9/70U98Mt268577d1hi1a/+edtfJIOd0D8wMakWYyen74b+JOTJxOG0qCbJ2CTL27GT1YFw6OGk
XMNRCTAAoG27/CeIf/pnf1aW2I887icfKbEHPvfBm2654ur3feKTn77t9rtTen3o5lvfdeU1t9/1
qY/fdc91N3w4ze/9zOfTyS/82UNfefgvv/HNb3ZvehTVr/55Wy6ymPR1t4sD3X7o3crFwYmzqnne
ZuU8yetyGMpbIbZJ3uZhTJK8jUVSrsPm4DkHQt7GIol50u0PO9yt4OgEGADQth3/j3B89Wtf/++v
+u3XvOEtb33HlU955bt/+lXvfuYLf/nCZ/xsLrF7PvP5D33ko+++6r133H3Pxz7xqes+eNNNH7kt
ldjHPvHJ2++6J4XZx+685877Pnf7vZ974At//tBXvt697z4QHnD+BBgA0LadBdgX/vefXv6HV117
4y3vvub9r33Dm5/99ru/95pvfMc7vvEPf+uLv3jVPW9959U/fMET4jOxaz5wY5TYzbfd/s4r3/Px
Oz+Vrutu+PBNt3z0XVdd85GPfeLOT382Bdhbr7ruGc990TeP9VHYiRBgcP4EGADQtt0E2Je+/BdP
f/6LL3r+S57y7Bf84q+8/Dv/xXc98xdecMHL3vIdL7vx0lv+z1s+dsdHbn/HbX/4ysf8ePevE3/g
h37s+b/40iixdN368TvfecU1H73j7lRl73rv9b/067/x1Kc/8xWXvvrT99/ffQHgdBBgAEDbdhNg
r/m933/ys56Xrsc+9emX/OZvveXt73r7u9/z+Cc++WnPeNa1N97yng9fe8V73371Gy9PJ7v/nti5
JXb1+2/40Mc++bo3v+uCJ134rJ9/ju6CU0uAAQBt202APebJ//mCC386vf7Mzz3nTz7/hYe//pf3
//Gf/O5b3v6MF7zkoue/5EnPfM4znvui33nz/+xOb6QS+/EnPe2Cp1z0U89+3qMuffx3f9+jfvCC
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
MGB2AgwAIAgwYHYCDAAgCDBgdgIMACAIMGB2AgwAIMwbYNX/SHrelossJmO6QxvdaKMbnRWTuJX1
5wdHz+pPkhgCOyHAAADCyQdYLJLp7Bk72X9qbJLn1YHqLrBzAgwAIKwowJKJCjr0rUrlsH/y0EeA
3RJgAABBgHUGh8BOCDAAgDB7gFXyvFqEalsaO5kWWUySwXV/UUrDrBsBOyLAAABCm5+AJTEv704/
MvY+wPkTYAAAQYB1xt4HOH8CDAAgrCjAphNo7OTEU9WtvB2cT7wPcJ4EGABAOPkAy2Iypju00Y02
utFZ3XRjYrs52+lPkhgCOyHAAADCvAEGkAgwAICwxgDrPoQqdDeA/STAAACCT8CA2QkwAIAgwIDZ
CTAAgCDAgNkJMACAIMCA2QkwAIAgwIDZCTAAgCDAgNkJMACAIMCA2QkwAIAgwIDZCTAAgCDAgNkJ
MACAIMCA2QkwAIAgwIDZCTAAgCDAgNkJMACAIMCA2QkwAIAgwIDZCTAAgCDAgNkJMACAIMCA2Qkw
AIAgwIDZCTAAgCDAgNkJMACAIMCA2QkwAIAgwIDZCTAAgCDAgNkJMACAIMCA2QkwAIAgwIDZCTAA
gCDAgNkJMACAIMCA2QkwAIAgwIDZCTAAgCDAgNkJMACAIMCA2QkwAIAgwIDZCTAAgCDAgNkJMACA
IMCA2QkwAIAgwIDZCTAAgCDAgNkJMACAIMCA2QkwAIAgwIDZCTAAgCDAgNkJMACAIMCA2QkwAIAg
wIDZCTAAgCDAgNkJMACAIMCA2QkwAIAgwIDZCTAAgCDAgNkJMACAIMCA2QkwAIAgwIDZCTAAgCDA
gNkJMACAIMCA2QkwAIAgwIDZCTAAgCDAgNkJMACAIMCA2QkwAIAgwIDZCTAAgCDAgNkJMACAIMCA
2QkwAIAgwIDZCTAAgCDAgNkJMACAIMCA2QkwAIAgwIDZCTAAgCDAgNkJMACAIMCA2QkwAIAgwIDZ
CTAAgCDAgNkJMACAIMCA2QkwAIAgwIDZCTAAgCDAgNkJMACAIMCA2QkwAIAgwIDZCTAAgCDAgNkJ
MACAIMCA2QkwAIAgwIDZCTAAgCDAgNkJMACAIMCA2QkwAIAgwIDZCTAAgCDAgNkJMACAIMCA2Qkw
AIAgwIDZCTAAgCDAgNkJMACAIMCA2QkwAIAgwIDZCTAAgCDAgNkJMACAIMCA2QkwAIAgwIDZCTAA
gCDAgNkJMACAIMCA2QkwAIAgwIDZCTAAgCDAgNkJMACAIMCA2QkwAIAgwIDZCTAAgCDAgNkJMACA
IMCA2QkwAIAgwIDZCTAAgCDAgNkJMACAIMCA2QkwAIAgwIDZCTAAgCDAgNkJMACAIMCA2QkwAIAg
wIDZCTAAgCDAgNkJMACAIMCA2QkwAIAgwIDZCTAAgCDAgNkJMACAIMCA2QkwAIAgwIDZCTAAgCDA
gNkJMACAIMCA2QkwAIAgwIDZCTAAgCDAgNkJMACAIMCA2QkwAIAgwIDZCTAAgCDAgNkJMACAIMCA
2QkwAIAgwIDZCTAAgCDAgNkJMACAIMCAhQgwAIDdBJjL5XJtc3V/a4wTYABA23YQYAC7IsAAgLYJ
MGBFBBgA0DYBBqyIAAMA2ibAgBURYABA2wQYsCICDABomwADVkSAAQBtE2DAiggwAKBtAgxYEQEG
ALRNgAErIsAAgLYJMGBFBBgA0DYBBqyIAAMA2ibAgBURYABA2wQYsCICDABomwADVkSAAQBtGw0w
gBPR/TXUI8AAgAYMBxjA2ggwAKABAgzYDwIMAGiAAAP2gwADABogwID9IMAAgAYIMGA/CDAAoAEC
DNgPAgwAaIAAA/aDAAMAGiDAgP0gwACABggwGnHmBfe1enU/Yc8729X9hOcSYABAAwQYjaiipaWr
+wl7Uqg82CIBBgA0TIDRiGiV7lf4VgiwkgADABogwGiEAGuGAAMAGibAaIQAa4YAAwAaJsBohABr
hgADABomwGjErAF2ptCNNsNude56h+YOsM0P1OlGO3I+byjAAICGCTAaMV+AVS2Rt/3Fzs0aYGM/
106cz7sJMACgYQKMRpxUgO22WypLBthunc+bCzAAoGECjEacSIBVt3buRAIsfq4kb/MwJklsk24/
8tTxCDAAoGECjEYIsKM69JuPA5uf8pEfOb+GbSZHJcAAgIYJMBpxIgFWbudwIgGW5llsY570J+Hg
aCEmcesYBBgA0DABRiNOKsDKxc4tH2DlMNbTk7DNZHsCDABomACjEScYYMn59MaEJQMstv0f6vwn
RyXAAICGCTAaMV+AJSknsm7Ua4xquxOzBliy+YE63ag3jNeQ15ubB2KbdPviQCyOQYABAA0TYDRi
1gA7KXMH2DoJMACgYQKMRgiwZggwAKBhAoxGCLBmCDAAoGECjEYIsGYIMACgYQKMRkSrNHl1P2GP
AAMA2DsCjEZU0dLS1f2EPSlUWtX9hOcSYABAAwQYsB8EGADQAAEG7AcBBgA0QIAB+0GAAQANEGDA
fhBgAEADBBiwHwQYANAAAQbsBwEGADRAgAH7QYABAA0QYMB+EGAAQAMOAszlcrn24ur+3gIA2Ftn
uv8XAACAmQkwAACAhQgwAACAhQgwAACAhQgwAACAhQgwAACAhQgwAACAhQgwAACAhQgwAACAhQgw
AACAhQgwAACAhQgwAACAhQgwAACAhQgwAACAhQgwAACAhQgwAACAhQgwAACAhQgwAACAhQgwAACA
hQgwAACAhQgwAACAhQgwAACAhQgwAACAhQgwAACAhQgwAACAhQgwAACAhQgwAACAhQgwAACAhQgw
AACAhQgwAACAhQgwAACAhQgwAACAhQgwAACAhQgwAACAhQgwAACAhQgwAACAhQgwAACAhQgwAACA
hQgwAACAhQgwAACAhQgwAACAhQgwAACAhQgwAACAhQgwAACAhQgwAACAhQgwAACAhQgwAACAhQgw
AACAhQgwAACAhQgwAACAhQgwAACAhQgwAACAhQgwAACAhQgwAACAhQgwAACAhQgwAACAhQgwAACA
hQgwAACAhQgwAACAhQgwAACAhQgwAACAhQgwAACAhQgwAACAhQgwAACAhQgwAACAhQgwAACAhQgw
AACAhQgwAACAhQgwAACAhQgwAACAhQgwAACAhQgwAACAhQgwAACAhQgwAACAhQgwAACAhQgwAACA
hQgwAACAhQgwAACAhQgwAACAhQgwAACAhQgwAACAhQgwAACAhQgwAACAhQgwAACAhQgwAACAhQgw
AACAhQgwAACAhQgwAACAhQgwAACAhQgwAACAhQgwAACAhQgwAACAhQgwAACAhQgwAACAhQgwAACA
hQgwAACAhQgwAACAhQgwAACAhQgwAACAhQgwAACAhQgwAACAhQgwAACAhQgwAACAhQgwAACAhQgw
AACAhQgwAACAhQgwAACAhQgwAACAhQgwAACAhQgwAACAhQgwAACAhQgwAACAhQgwAACAhQgwAACA
hQgwAACAhQgwAACAhQgwAACAhQgwAACAhQgwAACAhQgwAACAhQgwAACAhQgwAACAhQgwAACAhQgw
AACAhQgwAACAhQgwAACAhQgwAACAhQgwAACAhQgwAACAhQgwAACAhQgwAACAhQgwAACAhQgwAACA
hQgwAACAhQgwAACAhQgwAACAhQgwAACAhQgwAACAhQgwAACAhQgwAACAhQgwAACAhQgwAACAhQgw
AACAhQgwAACAhQgwAACAhQgwAACAhQgwAACAhQgwAACAhQgwAACAhQgwAACAhQgwAACAhQgwAACA
hQgwAACAhQgwAACAhQgwAACAhQgwAACAhQgwAACAhQgwAACAhQgwAACAhQgwAACAhQgwAACAhQgw
AACAhQgwAACAhQgwAACAhQgwAACAhQgwAACAhQgwAACAhQgwAACAhQgwAACAhQgwAACAhQgwAACA
hQgwAACAhQgwAACAhQgwAACAhQgwAACAhQgwAACAhQgwAACAhQgwAACAhQgwAACAhQgwAACAhQgw
AACAhQgwAACAhQgwAACAhQgwAACAhQgwAACAhQgwAACAhQgwAACAhQgwAACAhQgwAACAhQgwAACA
hQgwAACAhQgwAACAhQgwAACARXz72/8fCwmBVL4qMsYAAAAASUVORK5CYII=
--001a11437e8865d55e054bc61024--
