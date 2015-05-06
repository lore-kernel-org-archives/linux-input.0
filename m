From: =?windows-1252?Q?David_Zafra_G=F3mez?= <dezeta@klo.es>
Subject: Re: PROBLEM: Touchpad works just like a mouse
Date: Wed, 06 May 2015 22:33:56 +0200
Message-ID: <554A7AB4.1060600@klo.es>
References: <552C4E6C.4070102@klo.es>	<552F6AC9.6020005@klo.es>	<CAN+gG=ENP5Uf06S1cdXKsGNmLDfGKOt3mP9iOeoxyqSzuDMoKA@mail.gmail.com>	<55320164.5010905@klo.es>	<553D5E91.2080704@klo.es> <CAN+gG=EUXJzCoPzPji0Uv_WMO0rKznHU6qcbTqtcksAOADFTjw@mail.gmail.com> <553F2EF1.9000106@redhat.com> <553FFB10.6010005@klo.es> <554089DF.7040803@redhat.com> <5541BEEC.70905@klo.es> <5541E9F1.5090902@redhat.com> <554A77AE.5030801@klo.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from llsa735-a03.servidoresdns.net ([82.223.190.26]:40866 "EHLO
	llsa735-a03.servidoresdns.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751438AbbEFUeC (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 6 May 2015 16:34:02 -0400
Received: from [10.0.0.171] (34.Red-2-139-242.staticIP.rima-tde.net [2.139.242.34])
	by llsa735-a03.servidoresdns.net (Postfix) with ESMTPSA id 8323AE0AAA
	for <linux-input@vger.kernel.org>; Wed,  6 May 2015 22:33:59 +0200 (CEST)
In-Reply-To: <554A77AE.5030801@klo.es>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input <linux-input@vger.kernel.org>

Hi Hans

Sorry for the delay.

I'm afraid I haven't built a kernel before, so I need some help.

I've found this link I think describes what I have to do
https://www.kernel.org/doc/Documentation/applying-patches.txt
I suppose it's right.

I've installed kernel 4.0.0-040000rc6.201503291935. So I suppose I have=
=20
to download sources for this kernel.

Once downloaded, I have to change to the kernel source dir and run:
$ patch -p1 <=20
=2E./0001-elantech-Fix-detection-of-touchpads-where-the-revisi.patch

Is all that right?

If yes, should I compile this patched kernel? How can I do it?

Thanks in advance.

David Zafra

El 30/04/15 a las 10:38, Hans de Goede escribi=F3:
> Hi,
>
> On 30-04-15 07:34, David Zafra G=F3mez wrote:
>> Hi everyone
>>
>> El 29/04/15 a las 09:35, Hans de Goede escribi=F3:
>>> Hi,
>>>
>>> On 28-04-15 23:26, David Zafra G=F3mez wrote:
>>>> [    0.257439] pnp 00:06: Plug and Play ACPI device, IDs ETD0108
>>>> SYN0a00 SYN0002 PNP0f03 PNP0f13 PNP0f12 (active)
>>>
>>> Ok, so the "ETD0108" here means that you have an elantech ps/2=20
>>> touchpad.
>> Great! You got it.
>>>
>>> This also stands out in the log:
>>>
>>> > [    0.958323] i8042: [49] MUX error, status is 75, data is fe
>>>
>>> So the first thing to try is to boot with i8042.nomux=3D1 on the ke=
rnel
>>> commandline.
>> I have done it. The touchpad issue hasn't been solved. Do you want m=
e=20
>> to send dmesg output?
>
> I've taken another look at the traces you've posted before and I thin=
k=20
> that
> I've found the problem. Can you build a kernel with the attached patc=
h
> and let us know if that fixes things ?
>
> Regards,
>
> Hans
>
>
> -----
> No se encontraron virus en este mensaje.
> Comprobado por AVG -www.avg.com
> Versi=F3n: 2015.0.5863 / Base de datos de virus: 4339/9659 - Fecha de=
 publicaci=F3n: 04/29/15
>



--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
