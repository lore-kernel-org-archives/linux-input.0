From: =?ISO-8859-1?Q?Richard_Sch=FCtz?= <r.schtz@t-online.de>
Subject: Re: [PATCH v5 1/1] HID: Add full support for Logitech Unifying receivers
Date: Thu, 29 Sep 2011 17:22:17 +0200
Message-ID: <4E848D29.4050405@t-online.de>
References: <1316018905-4175-1-git-send-email-nlopezcasad@logitech.com> <4E77A221.1060909@t-online.de> <CAN+gG=EcaMrz2w-cVL-cCwi2NNVJ-NXOpOQpbjyFdCwn5+Bn+w@mail.gmail.com> <4E7BA605.3020908@t-online.de> <CAN+gG=EaHAW504Bi7PDtdsCT0pfs0=BAW5Pt+pSKkkyS5DXfhw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailout04.t-online.de ([194.25.134.18]:40958 "EHLO
	mailout04.t-online.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932123Ab1I2PWh (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 29 Sep 2011 11:22:37 -0400
In-Reply-To: <CAN+gG=EaHAW504Bi7PDtdsCT0pfs0=BAW5Pt+pSKkkyS5DXfhw@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Nestor Lopez Casado <nlopezcasad@logitech.com>
Cc: Benjamin Tissoires <benjamin.tissoires@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, rtitmuss@logitech.com, ogay@logitech.com, jzanone@logitech.com

Am 23.09.2011 00:21, schrieb Benjamin Tissoires:
> On Thu, Sep 22, 2011 at 23:17, Richard Sch=FCtz<r.schtz@t-online.de> =
 wrote:
>> Am 22.09.2011 22:48, schrieb Benjamin Tissoires:
>>>
>>> Hi Richard,
>>>
>>> here, you'll find a small C program that allows you to do a pairing=
 of
>>> a new device to a receiver.
>>
>> Thanks.
>>
>> Could you also add the possibility to remove a pairing? It would be =
nice if
>> the program would print the product name of device detected during t=
he
>> pairing process, too.
>
> mmm... this would be more complicated:
> - the first problem is a NDA and political one. As I worked in
> Logitech, I had access to some internal (confidential) documentation.
> I was able to release this piece of code as it can be easily retrieve=
d
> by adding a spy on the usb stack when doing the pairing on windows.
> Discovering the command that removes devices is not so easy (to my
> mind), thus, I can not give it right now.  Please note that I asked
> them if I could release this magic sequence, and it went quite high i=
n
> the hierarchy (but this piece of code has nothing to do with Logitech=
,
> just to be clear).
> - the second problem is more a technical one. The removal of the
> device would require you two know which device you want to remove. So
> it would require the ability to know all the different devices and
> their pairing number. This information shows up somewhere in the log
> but there is no way to ask the receiver for this information with the
> current status of the driver (without knowing internal commands).
> Getting it from the list of devices would be quite complicated
> depending on the number of receivers you have plugged, etc...
> - Obtaining the name of the device can not be retrieved at the moment
> without knowing the different commands to send to the device. As it's
> confidential Logitech, I can not give them to you unless someone else
> does the retro-engineering.
>
> So, to sum up, I agree this would be better, but today, this has to b=
e
> done by someone else, either officially at Logitech, or by someone no=
t
> related to Logitech that does the retro-engineering.

So what do the Logitech guys think about this? Without userspace tools=20
for creating/removing pairings a Unifying receiver is quite useless for=
=20
Linux users.

--=20
Regards,
Richard Sch=FCtz
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
