From: Nikolaus Rath <Nikolaus@rath.org>
Subject: Re: [PATCH 1/2] Alps HID I2C T4 device support
Date: Thu, 06 Apr 2017 15:59:36 -0700
Message-ID: <87shll6t2f.fsf@thinkpad.rath.org>
References: <20170330025317.4093-2-masaki.ota@jp.alps.com>
        <87zifw7tti.fsf_-_@vostro.rath.org>
        <KAWPR01MB10924EBEDC42F952DFFBD205C70B0@KAWPR01MB1092.jpnprd01.prod.outlook.com>
        <8760ik6qy1.fsf@thinkpad.rath.org>
        <KAWPR01MB1092EE6D26740FE088F89872C70B0@KAWPR01MB1092.jpnprd01.prod.outlook.com>
        <87lgrfu4cv.fsf@vostro.rath.org>
        <KAWPR01MB109235DA12BFF132058A6CDDC70B0@KAWPR01MB1092.jpnprd01.prod.outlook.com>
        <87inmju3i4.fsf@vostro.rath.org>
        <KAWPR01MB1092AFEC7B63554AFE009570C70A0@KAWPR01MB1092.jpnprd01.prod.outlook.com>
        <87pogq3do4.fsf@thinkpad.rath.org>
        <KAWPR01MB1092576DDBDAB7B58F3F2FEAC70D0@KAWPR01MB1092.jpnprd01.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-input-owner@vger.kernel.org>
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:33473 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753083AbdDFW7j (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Thu, 6 Apr 2017 18:59:39 -0400
In-Reply-To: <KAWPR01MB1092576DDBDAB7B58F3F2FEAC70D0@KAWPR01MB1092.jpnprd01.prod.outlook.com>
        (Masaki Ota's message of "Thu, 6 Apr 2017 01:07:51 +0000")
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Masaki Ota <masaki.ota@jp.alps.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

Dear Masaki,

Thanks! I think I figured out the problem - it was on my side.

After I installed your patch, I ran "make localmodconfig". However, I
think prior to your patch my touchpad was handled by hid_generic - so
hid_alps was not loaded and the patched module thus never
build. However, your patch still prevented hid_generic from taking
control of the touchpad. After I explicitly enabled the hid_alps module,
my touchpad is now working again and, thanks to your patch, can now also
be configured.

Thanks again! Feel free to add a:

Tested-By: Nikolaus Rath <Nikolaus@rath.org

Best,
-Nikolaus

On Apr 06 2017, Masaki Ota <masaki.ota@jp.alps.com> wrote:
> Hi, Nikolaus,
>
> Could you add below debug message to hid-alps.c, and check it?
> This device is "HID_DEVICE_ID_ALPS_T4_BTNLESS"(0x120C).
> If the device is UNKNOWN, this device does not work completely.
> And if the system does not call here, it has nothing to do with my patch.
>
> static int alps_probe()
> { ...
> ...
> ...
> printk("=3D=3D=3D=3D> ALPS Debug Log: (%x) \n", hdev->product);
> 	switch (hdev->product) {
> 	case HID_DEVICE_ID_ALPS_T4_BTNLESS:
> 		data->dev_type =3D T4;
> 		break;
> 	case HID_DEVICE_ID_ALPS_U1_DUAL:
> 		data->dev_type =3D U1;
> 		break;
> 	default:
> 		data->dev_type =3D UNKNOWN;
> 	}=20
>
> Best Regards,
> Masaki Ota
> -----Original Message-----
> From: Nikolaus Rath [mailto:Nikolaus@rath.org]=20
> Sent: Thursday, April 06, 2017 3:36 AM
> To: =E5=A4=AA=E7=94=B0 =E7=9C=9F=E5=96=9C Masaki Ota <masaki.ota@jp.alps.=
com>
> Cc: linux-kernel <linux-kernel@vger.kernel.org>; linux-input@vger.kernel.=
org
> Subject: Re: [PATCH 1/2] Alps HID I2C T4 device support
>
> Hi Masaki,
>
> Could you be a little more specific about what you need? I don't like
> executing scripts containing several instances of 'sudo rm -rf
> [something]'.
>
> It seems that the script is meant to install debugging versions of
> some modules. Could you simply send me a patch against the official
> kernel that includes your debugging code? I'm perfectly able to
> compile it and load the modules on my own :-).
>
> Thanks,
> -Nikolaus
>
> On Apr 05 2017, Masaki Ota <masaki.ota@jp.alps.com> wrote:
>> Hi, Nikolaus,
>>
>> If you have a time, please try below debug method.
>>
>> Download below file, copy it to your system and unpack.
>> https://www.filesanywhere.com/fs/v.aspx?v=3D8b716a8e5b6773baa799
>>
>> Procedure ex:
>> #cd Desktop/LinuxModDebug
>> #sudo chmod 755 linux_kr_rebuild_tool_hid.sh #sudo=20
>> ./linux_kr_rebuild_tool_hid.sh /init linux-4.10.tar.gz #sudo=20
>> ./linux_kr_rebuild_tool_hid.sh /build DebugSrc
>>
>> After that Touchpad all features should work.
>> If Touchpad does not work, something error appears on dmesg.
>>
>> Best Regards,
>> Masaki Ota
>> -----Original Message-----
>> From: Nikolaus Rath [mailto:Nikolaus@rath.org]
>> Sent: Wednesday, April 05, 2017 9:01 AM
>> To: =E5=A4=AA=E7=94=B0 =E7=9C=9F=E5=96=9C Masaki Ota <masaki.ota@jp.alps=
.com>
>> Cc: linux-kernel <linux-kernel@vger.kernel.org>;=20
>> linux-input@vger.kernel.org
>> Subject: Re: [PATCH 1/2] Alps HID I2C T4 device support
>>
>> Hi Masaki,
>>
>> Well, I'd be pleasently surprised if every bug always came together=20
>> with an associated error message :-). No matter if there's a dmesg=20
>> entry or not, at the moment this patch will make life much worse for=20
>> at least some EliteBook owners.
>>
>> Is there anything I can do to help you debug this?
>>
>> Best,
>> -Nikolaus
>>
>>
>> On Apr 04 2017, Masaki Ota <masaki.ota@jp.alps.com> wrote:
>>> Hi, Nikolaus,
>>>
>>> Um, but demesg log does not have any error of this Touchpad.
>>> It's a strange.
>>>
>>> Best Regards,
>>> Masaki Ota
>>> -----Original Message-----
>>> From: Nikolaus Rath [mailto:Nikolaus@rath.org]
>>> Sent: Wednesday, April 05, 2017 8:43 AM
>>> To: =E5=A4=AA=E7=94=B0 =E7=9C=9F=E5=96=9C Masaki Ota <masaki.ota@jp.alp=
s.com>
>>> Cc: linux-kernel <linux-kernel@vger.kernel.org>;=20
>>> linux-input@vger.kernel.org
>>> Subject: Re: [PATCH 1/2] Alps HID I2C T4 device support
>>>
>>> Hi Masaki,
>>>
>>> Yes, without your patch the touchpad is mostly working - I just can't c=
onfigure it.
>>>
>>> Please take a look at https://bugs.freedesktop.org/show_bug.cgi?id=3D10=
0345.
>>>
>>> Best,
>>> -Nikolaus
>>>
>>> On Apr 04 2017, Masaki Ota <masaki.ota@jp.alps.com> wrote:
>>>> Hi, Nikolaus,
>>>>
>>>> There is no 044E:120C device, but it looks like Alps Touchpad is detec=
ted as PS/2 Touchpad.
>>>>
>>>> Actually, this Touchpad has two interfaces. One is I2C, the other is P=
S/2.
>>>> Default setting is I2C, and if the system does not support I2C, Touchp=
ad works as PS/2.
>>>>
>>>> However, both of interface should work properly on Linux.
>>>> I tested it on Ubuntu +4.10 kernel.
>>>>
>>>> If you don't apply my patch, does device work as I2C? (044E:120C
>>>> appears?)
>>>>
>>>> Best Regards,
>>>> Masaki Ota
>>>> -----Original Message-----
>>>> From: Nikolaus Rath [mailto:Nikolaus@rath.org]
>>>> Sent: Wednesday, April 05, 2017 2:09 AM
>>>> To: =E5=A4=AA=E7=94=B0 =E7=9C=9F=E5=96=9C Masaki Ota <masaki.ota@jp.al=
ps.com>
>>>> Cc: linux-kernel <linux-kernel@vger.kernel.org>;=20
>>>> linux-input@vger.kernel.org
>>>> Subject: Re: [PATCH 1/2] Alps HID I2C T4 device support
>>>>
>>>> Hi Masaki,
>>>>
>>>> Yes, I think I have a 044E:120C. Is there a way to find out for sure?
>>>> It's not listed by e.g. lspci.
>>>>
>>>> The touchpad is definitely not reacting to anything. evemu-record does=
 not show any events either.
>>>>
>>>> I have attached the dmesg output.
>>>>
>>>> Best,
>>>> -Nikolaus
>>>>
>>>>
>>>> On Apr 04 2017, Masaki Ota <masaki.ota@jp.alps.com> wrote:
>>>>> Hi, Nikolaus,
>>>>>
>>>>> Your Touchpad is 044E:120C, right?
>>>>>
>>>>> PATCH 1/2 supports 044E:120C Touchpad device.
>>>>> I think you can use all features of this Touchpad.
>>>>>
>>>>> PATCH 2/2 supports 044E:1215 Touchpad device.
>>>>> You don't need to care about this.
>>>>>
>>>>> If Touchpad does not work completely, there is something an error.
>>>>> What does dmesg show?
>>>>>
>>>>> Best Regards,
>>>>> Masaki Ota
>>>>> -----Original Message-----
>>>>> From: Nikolaus Rath [mailto:Nikolaus@rath.org]
>>>>> Sent: Tuesday, April 04, 2017 12:09 PM
>>>>> To: =E5=A4=AA=E7=94=B0 =E7=9C=9F=E5=96=9C Masaki Ota <masaki.ota@jp.a=
lps.com>; linux-kernel=20
>>>>> <linux-kernel@vger.kernel.org>; linux-input@vger.kernel.org
>>>>> Subject: Re: [PATCH 1/2] Alps HID I2C T4 device support
>>>>>
>>>>> Hi Ota,
>>>>>
>>>>>> -Support Alps HID I2C T4 Touchpad device.
>>>>>> -Laptop names that use this Touchpad:HP Zbook Studio, Elitebook=20
>>>>>> Folio G1, Elitebook 1030 G1, Elitebook 1040 G3
>>>>>>
>>>>>> Signed-off-by: Masaki Ota <masaki.ota@xxxxxxxxxxx>
>>>>>> ---
>>>>>>  drivers/hid/hid-alps.c | 500 ++++++++++++++++++++++++++++++++++++++=
+----------
>>>>>>  drivers/hid/hid-core.c |   3 +-
>>>>>>  drivers/hid/hid-ids.h  |   1 +
>>>>>>  3 files changed, 403 insertions(+), 101 deletions(-)
>>>>>=20=20
>>>>> I tried your patch on an HP Elitebook, but with rather limited=20
>>>>> success. Before, I was able to use the touchpad in limited fashion=20
>>>>> (https://bugs.freedesktop.org/show_bug.cgi?id=3D100345). With your=20
>>>>> patch (applied on top of 4.10), the touchpad no longer reacts at all.
>>>>>
>>>>> That said, I didn't find a patch 2/2 anywhere.. is there something mi=
ssing?
>>>>>
>>>>> Thanks,
>>>>> -Nikolaus
>>>>>
>>>>> --
>>>>> GPG Fingerprint: ED31 791B 2C5C 1613 AF38 8B8A D113 FCAC 3C4E 599F
>>>>>
>>>>>              =C2=BBTime flies like an arrow, fruit flies like a Banan=
a.=C2=AB
>>>>
>>>>
>>>> --
>>>> GPG Fingerprint: ED31 791B 2C5C 1613 AF38 8B8A D113 FCAC 3C4E 599F
>>>>
>>>>              =C2=BBTime flies like an arrow, fruit flies like a Banana=
.=C2=AB
>>>
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
