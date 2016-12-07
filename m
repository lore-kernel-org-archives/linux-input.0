From: Cameron Gutman <aicommander@gmail.com>
Subject: Re: Method to power off HID device from driver?
Date: Tue, 6 Dec 2016 19:20:06 -0800
Message-ID: <D5A9B8BF-4720-4BB4-826E-CCA150D2976F@gmail.com>
References: <CANndSKn1JE0Fnxgn9rpUyR1fUv7GM_Y4xwpfevSUiOYnVSYYig@mail.gmail.com>
 <CANndSK=-V0DXWh=XCr=GUAyWvQ0ZKrRfDdkvhFMbVWTj57+uiQ@mail.gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 10.1 \(3251\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pg0-f68.google.com ([74.125.83.68]:32911 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751266AbcLGDUI (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Tue, 6 Dec 2016 22:20:08 -0500
Received: by mail-pg0-f68.google.com with SMTP id 3so21869063pgd.0
        for <linux-input@vger.kernel.org>; Tue, 06 Dec 2016 19:20:08 -0800 (PST)
In-Reply-To: <CANndSK=-V0DXWh=XCr=GUAyWvQ0ZKrRfDdkvhFMbVWTj57+uiQ@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Roderick Colenbrander <roderick@gaikai.com>
Cc: linux-input@vger.kernel.org

Hi,

> On Dec 6, 2016, at 4:25 PM, Roderick Colenbrander =
<roderick@gaikai.com> wrote:
>=20
> Hi,
>=20
> I looked a bit deeper and found EV_PWR, though it isn't clearly
> defined, but it is used in some places for purposes like this. Would
> this be an acceptable method?
>=20

I am interested in this too. I recently implemented the ability to
turn off wireless Xbox 360 controllers in [0], but there is no way
to activate this functionality without suspending the whole system.
Some folks [1] have asked for this ability in other scenarios.

[0]: Commit f712a5a05228058f6b74 ("Input: xpad - power off wireless
                                   360 controllers on suspend")
[1]: https://github.com/paroj/xpad/issues/52

> Thanks,
> Roderick
>=20
> On Thu, Dec 1, 2016 at 6:05 PM, Roderick Colenbrander
> <roderick@gaikai.com> wrote:
>> Hi,
>>=20
>> Some of the devices I'm dealing with have methods to disconnect the
>> device through HID reports. This is mostly useful for wireless =
devices
>> to save battery and power them off e.g. when no activity in a wihle =
or
>> user wants to turn device off (some devices don't have a power off
>> button).
>>=20
>> I was trying to figure out if it there is some generic way without
>> inventing a driver specific method. So far I haven't found anything =
on
>> the HID side. The use case is not that common often a user would
>> unplug a cable, but for some devices there is no real other way.
>>=20
>> The closest thing I found was 'poweroff' as supported by device power
>> management spec:
>> https://www.kernel.org/doc/Documentation/power/devices.txt. The HID
>> drivers only support a subset of this so far.
>>=20
>> Does anyone have a good suggestion for handling this?
>>=20
>> Thanks,
>> Roderick
>=20
>=20
>=20
> --=20
> Roderick Colenbrander
> Senior Manager of Software Engineering
> Gaikai, a Sony Interactive Entertainment Company
> roderick@gaikai.com
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

