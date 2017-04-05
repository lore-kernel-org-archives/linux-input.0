From: Nikolaus Rath <Nikolaus@rath.org>
Subject: Re: [PATCH 1/2] Alps HID I2C T4 device support
Date: Tue, 04 Apr 2017 17:01:07 -0700
Message-ID: <87inmju3i4.fsf@vostro.rath.org>
References: <20170330025317.4093-2-masaki.ota@jp.alps.com>
        <87zifw7tti.fsf_-_@vostro.rath.org>
        <KAWPR01MB10924EBEDC42F952DFFBD205C70B0@KAWPR01MB1092.jpnprd01.prod.outlook.com>
        <8760ik6qy1.fsf@thinkpad.rath.org>
        <KAWPR01MB1092EE6D26740FE088F89872C70B0@KAWPR01MB1092.jpnprd01.prod.outlook.com>
        <87lgrfu4cv.fsf@vostro.rath.org>
        <KAWPR01MB109235DA12BFF132058A6CDDC70B0@KAWPR01MB1092.jpnprd01.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <KAWPR01MB109235DA12BFF132058A6CDDC70B0@KAWPR01MB1092.jpnprd01.prod.outlook.com>
        (Masaki Ota's message of "Tue, 4 Apr 2017 23:49:38 +0000")
Sender: linux-kernel-owner@vger.kernel.org
To: Masaki Ota <masaki.ota@jp.alps.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

Hi Masaki,

Well, I'd be pleasently surprised if every bug always came together with
an associated error message :-). No matter if there's a dmesg entry or
not, at the moment this patch will make life much worse for at least
some EliteBook owners.

Is there anything I can do to help you debug this?

Best,
-Nikolaus


On Apr 04 2017, Masaki Ota <masaki.ota@jp.alps.com> wrote:
> Hi, Nikolaus,
>
> Um, but demesg log does not have any error of this Touchpad.
> It's a strange.
>
> Best Regards,
> Masaki Ota
> -----Original Message-----
> From: Nikolaus Rath [mailto:Nikolaus@rath.org]=20
> Sent: Wednesday, April 05, 2017 8:43 AM
> To: =E5=A4=AA=E7=94=B0 =E7=9C=9F=E5=96=9C Masaki Ota <masaki.ota@jp.alps.=
com>
> Cc: linux-kernel <linux-kernel@vger.kernel.org>; linux-input@vger.kernel.=
org
> Subject: Re: [PATCH 1/2] Alps HID I2C T4 device support
>
> Hi Masaki,
>
> Yes, without your patch the touchpad is mostly working - I just can't con=
figure it.
>
> Please take a look at https://bugs.freedesktop.org/show_bug.cgi?id=3D1003=
45.
>
> Best,
> -Nikolaus
>
> On Apr 04 2017, Masaki Ota <masaki.ota@jp.alps.com> wrote:
>> Hi, Nikolaus,
>>
>> There is no 044E:120C device, but it looks like Alps Touchpad is detecte=
d as PS/2 Touchpad.
>>
>> Actually, this Touchpad has two interfaces. One is I2C, the other is PS/=
2.
>> Default setting is I2C, and if the system does not support I2C, Touchpad=
 works as PS/2.
>>
>> However, both of interface should work properly on Linux.
>> I tested it on Ubuntu +4.10 kernel.
>>
>> If you don't apply my patch, does device work as I2C? (044E:120C=20
>> appears?)
>>
>> Best Regards,
>> Masaki Ota
>> -----Original Message-----
>> From: Nikolaus Rath [mailto:Nikolaus@rath.org]
>> Sent: Wednesday, April 05, 2017 2:09 AM
>> To: =E5=A4=AA=E7=94=B0 =E7=9C=9F=E5=96=9C Masaki Ota <masaki.ota@jp.alps=
.com>
>> Cc: linux-kernel <linux-kernel@vger.kernel.org>;=20
>> linux-input@vger.kernel.org
>> Subject: Re: [PATCH 1/2] Alps HID I2C T4 device support
>>
>> Hi Masaki,
>>
>> Yes, I think I have a 044E:120C. Is there a way to find out for sure?
>> It's not listed by e.g. lspci.
>>
>> The touchpad is definitely not reacting to anything. evemu-record does n=
ot show any events either.
>>
>> I have attached the dmesg output.
>>
>> Best,
>> -Nikolaus
>>
>>
>> On Apr 04 2017, Masaki Ota <masaki.ota@jp.alps.com> wrote:
>>> Hi, Nikolaus,
>>>
>>> Your Touchpad is 044E:120C, right?
>>>
>>> PATCH 1/2 supports 044E:120C Touchpad device.
>>> I think you can use all features of this Touchpad.
>>>
>>> PATCH 2/2 supports 044E:1215 Touchpad device.
>>> You don't need to care about this.
>>>
>>> If Touchpad does not work completely, there is something an error.
>>> What does dmesg show?
>>>
>>> Best Regards,
>>> Masaki Ota
>>> -----Original Message-----
>>> From: Nikolaus Rath [mailto:Nikolaus@rath.org]
>>> Sent: Tuesday, April 04, 2017 12:09 PM
>>> To: =E5=A4=AA=E7=94=B0 =E7=9C=9F=E5=96=9C Masaki Ota <masaki.ota@jp.alp=
s.com>; linux-kernel=20
>>> <linux-kernel@vger.kernel.org>; linux-input@vger.kernel.org
>>> Subject: Re: [PATCH 1/2] Alps HID I2C T4 device support
>>>
>>> Hi Ota,
>>>
>>>> -Support Alps HID I2C T4 Touchpad device.
>>>> -Laptop names that use this Touchpad:HP Zbook Studio, Elitebook=20
>>>> Folio G1, Elitebook 1030 G1, Elitebook 1040 G3
>>>>
>>>> Signed-off-by: Masaki Ota <masaki.ota@xxxxxxxxxxx>
>>>> ---
>>>>  drivers/hid/hid-alps.c | 500 +++++++++++++++++++++++++++++++++++++++-=
---------
>>>>  drivers/hid/hid-core.c |   3 +-
>>>>  drivers/hid/hid-ids.h  |   1 +
>>>>  3 files changed, 403 insertions(+), 101 deletions(-)
>>>=20=20
>>> I tried your patch on an HP Elitebook, but with rather limited=20
>>> success. Before, I was able to use the touchpad in limited fashion=20
>>> (https://bugs.freedesktop.org/show_bug.cgi?id=3D100345). With your=20
>>> patch (applied on top of 4.10), the touchpad no longer reacts at all.
>>>
>>> That said, I didn't find a patch 2/2 anywhere.. is there something miss=
ing?
>>>
>>> Thanks,
>>> -Nikolaus
>>>
>>> --
>>> GPG Fingerprint: ED31 791B 2C5C 1613 AF38 8B8A D113 FCAC 3C4E 599F
>>>
>>>              =C2=BBTime flies like an arrow, fruit flies like a Banana.=
=C2=AB
>>
>>
>> --
>> GPG Fingerprint: ED31 791B 2C5C 1613 AF38 8B8A D113 FCAC 3C4E 599F
>>
>>              =C2=BBTime flies like an arrow, fruit flies like a Banana.=
=C2=AB
>
>
> --
> GPG Fingerprint: ED31 791B 2C5C 1613 AF38 8B8A D113 FCAC 3C4E 599F
>
>              =C2=BBTime flies like an arrow, fruit flies like a Banana.=
=C2=AB


--=20
GPG Fingerprint: ED31 791B 2C5C 1613 AF38 8B8A D113 FCAC 3C4E 599F

             =C2=BBTime flies like an arrow, fruit flies like a Banana.=C2=
=AB
