From: Rafi Rubin <rafi@seas.upenn.edu>
Subject: Re: IS_INPUT_APPLICATION and tablets
Date: Thu, 21 May 2009 04:46:06 -0400
Message-ID: <4A1514CE.6010600@seas.upenn.edu>
References: <33210D89-9534-4B12-B7C3-E7FAEA3C4A5D@enac.fr> <alpine.LNX.2.00.0905211038350.13917@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from LION.seas.upenn.edu ([158.130.12.194]:36875 "EHLO
	lion.seas.upenn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751459AbZEUIqU (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 21 May 2009 04:46:20 -0400
In-Reply-To: <alpine.LNX.2.00.0905211038350.13917@wotan.suse.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: =?ISO-8859-1?Q?St=E9phane_Chatty?= <chatty@enac.fr>, jirislaby@gmail.com, Greg KH <greg@kroah.com>, linux-input@vger.kernel.org

Is there any downside to letting hiddev to cover all devices, even thos=
e that are supported by the hid system?

I should point out that with the current settings, the n-trig digitizer=
s do in fact bind to both drivers.  Its been a useful
debugging tool.

Jiri Kosina wrote:
> On Wed, 20 May 2009, St=E9phane Chatty wrote:
>=20
>> I just saw a message in the linux-input ml about a USB tablet that i=
s=20
>> not registered in the input layer. Someone proposed that there might=
 be=20
>> no useful application in the HID report descriptors.
>>
>> There is an other possibility: the IS_INPUT_APPLICATION in hid.h mig=
ht=20
>> fail to capture a legitimate application. I am currently working on =
a=20
>> HID driver for a multitouch surface by Stantum that has application=20
>> usage 0x000d0004 (Digitizer / Touchscreen), and I had to change=20
>> IS_INPUT_APPLICATION to have it registered in the input layer. The=20
>> N-Trig surface is registered only because it declares two applicatio=
n=20
>> collections: a Pen and a Touchscreen.
>>
>> The comment that accompanies the definition of the macro looks very =
old.=20
>> Is there another reason why the definition of input applications is =
so=20
>> restrictive? I had in mind to add the range 0x000d0002-0x000d0006 at=
=20
>> least. Is there any contraindication to this?
>=20
> Hi Stephane,
>=20
> we definitely want to extend the IS_INPUT_APPLICATION() macro to refl=
ect=20
> the current hardware -- the contants used in the macro are quite old=20
> indeed.
>=20
> On the other hand we must be careful not to break any userspace drive=
rs --=20
> because currently hiddev node (which userspace drivers use) is create=
d=20
> when the device has at least one application which is not recognized =
as=20
> input application by IS_INPUT_APPLICATION macro.
>=20
> If we change semantics of this macro, it might happen that hiddev nod=
e=20
> would stop appearing for certain devices, thus breaking backwards=20
> compatibility for userspace drivers.
>=20
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
