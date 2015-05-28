From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: PROBLEM: Touchpad works just like a mouse
Date: Thu, 28 May 2015 16:56:32 +0200
Message-ID: <55672CA0.4040900@redhat.com>
References: <552C4E6C.4070102@klo.es>	<552F6AC9.6020005@klo.es>	<CAN+gG=ENP5Uf06S1cdXKsGNmLDfGKOt3mP9iOeoxyqSzuDMoKA@mail.gmail.com>	<55320164.5010905@klo.es>	<553D5E91.2080704@klo.es> <CAN+gG=EUXJzCoPzPji0Uv_WMO0rKznHU6qcbTqtcksAOADFTjw@mail.gmail.com> <553F2EF1.9000106@redhat.com> <553FFB10.6010005@klo.es> <554089DF.7040803@redhat.com> <5541BEEC.70905@klo.es> <5541E9F1.5090902@redhat.com> <554A77AE.5030801@klo.es> <5559BC95.1010304@redhat.com> <55662A8D.9010709@klo.es> <5566DB7A.9050205@redhat.com> <55672C57.2090606@klo.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:60903 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754134AbbE1O4f (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 28 May 2015 10:56:35 -0400
In-Reply-To: <55672C57.2090606@klo.es>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?UTF-8?B?RGF2aWQgWmFmcmEgR8OzbWV6?= <dezeta@klo.es>, Benjamin Tissoires <benjamin.tissoires@gmail.com>
Cc: linux-input <linux-input@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Duson Lin <dusonlin@emc.com.tw>, Jiri Kosina <jkosina@suse.cz>

Hi,

On 28-05-15 16:55, David Zafra G=C3=B3mez wrote:
> OK Hans.
>
> Could you please tell me what kernel version will this patch be inclu=
ded in?

That is hard to predict, I would expect it to make 4.3 for certain,
hopefully also 4.2 and a 4.1.x bugfix release.

Regards,

Hans

>
> Regards,
>
> David
>
> El 28/05/2015 a las 11:10, Hans de Goede escribi=C3=B3:
>> Hi,
>>
>> On 27-05-15 22:35, David Zafra G=C3=B3mez wrote:
>>> It worked like a charm!!
>>>
>>> Ubuntu support team helped me to build the patched kernel. Now I ca=
n use all advanced touchpad features.
>>>
>>> Thank you very much to Hans and Benjamin!!
>>
>> Thanks for testing the patch, now that it has been tested I've
>> submitted it for inclusion into the upstream kernel.
>>
>> Regards,
>>
>> Hans
>>
>>
>>>
>>> El 18/05/15 a las 12:19, Hans de Goede escribi=C3=B3:
>>>> Hi,
>>>>
>>>> On 06-05-15 22:21, David Zafra G=C3=B3mez wrote:
>>>>> Hi Hans
>>>>>
>>>>> Sorry for the delay.
>>>>>
>>>>> I'm afraid I haven't built a kernel before, so I need some help.
>>>>>
>>>>> I've found this link I think describes what I have to do
>>>>> https://www.kernel.org/doc/Documentation/applying-patches.txt
>>>>> I suppose it's right.
>>>>>
>>>>> I've installed kernel 4.0.0-040000rc6.201503291935. So I suppose =
I have to
>>>>> download sources for this kernel.
>>>>>
>>>>> Once downloaded, I have to change to the kernel source dir and ru=
n:
>>>>> $ patch -p1 < ../0001-elantech-Fix-detection-of-touchpads-where-t=
he-revisi.patch
>>>>>
>>>>> Is all that right?
>>>>
>>>> Yes that is correct.
>>>>
>>>>> If yes, should I compile this patched kernel? How can I do it?
>>>>
>>>> Usually your distro will have a wikipage with instructions on how =
to build
>>>> your own kernel, and it is best to follow your distros instruction=
s.
>>>>
>>>> If you're using Fedora I can build a test kernel for you to instal=
l.
>>>>
>>>> Regards,
>>>>
>>>> Hans
>>>>
>>>>
>>>>>
>>>>> Thanks in advance.
>>>>>
>>>>> David Zafra
>>>>>
>>>>> El 30/04/15 a las 10:38, Hans de Goede escribi=C3=B3:
>>>>>> Hi,
>>>>>>
>>>>>> On 30-04-15 07:34, David Zafra G=C3=B3mez wrote:
>>>>>>> Hi everyone
>>>>>>>
>>>>>>> El 29/04/15 a las 09:35, Hans de Goede escribi=C3=B3:
>>>>>>>> Hi,
>>>>>>>>
>>>>>>>> On 28-04-15 23:26, David Zafra G=C3=B3mez wrote:
>>>>>>>>> [    0.257439] pnp 00:06: Plug and Play ACPI device, IDs ETD0=
108
>>>>>>>>> SYN0a00 SYN0002 PNP0f03 PNP0f13 PNP0f12 (active)
>>>>>>>>
>>>>>>>> Ok, so the "ETD0108" here means that you have an elantech ps/2=
 touchpad.
>>>>>>> Great! You got it.
>>>>>>>>
>>>>>>>> This also stands out in the log:
>>>>>>>>
>>>>>>>> > [    0.958323] i8042: [49] MUX error, status is 75, data is =
fe
>>>>>>>>
>>>>>>>> So the first thing to try is to boot with i8042.nomux=3D1 on t=
he kernel
>>>>>>>> commandline.
>>>>>>> I have done it. The touchpad issue hasn't been solved. Do you w=
ant me to send
>>>>>>> dmesg output?
>>>>>>
>>>>>> I've taken another look at the traces you've posted before and I=
 think that
>>>>>> I've found the problem. Can you build a kernel with the attached=
 patch
>>>>>> and let us know if that fixes things ?
>>>>>>
>>>>>> Regards,
>>>>>>
>>>>>> Hans
>>>>>>
>>>>>>
>>>>>> -----
>>>>>> No se encontraron virus en este mensaje.
>>>>>> Comprobado por AVG -www.avg.com
>>>>>> Versi=C3=B3n: 2015.0.5863 / Base de datos de virus: 4339/9659 - =
=46echa de publicaci=C3=B3n: 04/29/15
>>>>>
>>>>
>>>>
>>>> -----
>>>> No se encontraron virus en este mensaje.
>>>> Comprobado por AVG - www.avg.com
>>>> Versi=C3=B3n: 2015.0.5941 / Base de datos de virus: 4347/9819 - Fe=
cha de publicaci=C3=B3n: 05/19/15
>>>>
>>>>
>>>
>>
>>
>> -----
>> No se encontraron virus en este mensaje.
>> Comprobado por AVG - www.avg.com
>> Versi=C3=B3n: 2015.0.5961 / Base de datos de virus: 4354/9886 - Fech=
a de publicaci=C3=B3n: 05/28/15
>>
>>
>
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
