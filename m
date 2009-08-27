From: Richie Ward <richies@gmail.com>
Subject: Re: Sanmos TWIN SHOCK gamepad Force Feedback
Date: Thu, 27 Aug 2009 13:09:15 +0100
Message-ID: <6b33c0ac0908270509l3f0baaebl1f27636d3f17f40e@mail.gmail.com>
References: <4a951f67850716.14823285@wp.pl>
	 <6b33c0ac0908270505h13121788j5b492ac385893f27@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-fx0-f217.google.com ([209.85.220.217]:50292 "EHLO
	mail-fx0-f217.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752296AbZH0MJP convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 27 Aug 2009 08:09:15 -0400
Received: by fxm17 with SMTP id 17so870412fxm.37
        for <linux-input@vger.kernel.org>; Thu, 27 Aug 2009 05:09:15 -0700 (PDT)
In-Reply-To: <6b33c0ac0908270505h13121788j5b492ac385893f27@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Perhaps the usb id needs to be added in the kernel?

> 2009/8/26 Alfred Broda <guaranga@wp.pl>:
>> Hello!
>> =C2=A0 =C2=A0I have a Sanmos TWIN SHOCK gamepad (6 axes, 12 buttons,=
 labeled as
>> "Tracer"). It works great using the default driver, (generic-usb
>> 0003:11C0:5400.000D: input,hidraw0: USB HID v1.00 Joystick [Sanmos T=
WIN
>> SHOCK gamepad]), but has no force feedback function that is availabl=
e
>> with the Windows driver. It has two motors (left, right) with an
>> adjustable strength rumble function. Can anyone point me at a simmil=
iar
>> driver?
>> =C2=A0 =C2=A0I tried altering the GreenAsia driver, with no luck - I=
 can't get at the
>> debug info from the hid driver either (compiled into the kernel). I
>> think it doesn't even probe the device (no output to dmesg), does th=
e
>> generic-usb driver lock the device somehow?
>> PS I've done a few USB snoops of the Windows driver so I can attach =
one
>> if that helps.
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pozdrawiam, Alfred Broda
>>
>> ----------------------------------------------------
>> Wiem, =C5=BCe masz fajne pomys=C5=82y na komponowanie dodatk=C3=B3w =
;)
>> Pode=C5=9Blij ciekaw=C4=85 propozycj=C4=99!
>> http://klik.wp.pl/?adr=3Dhttp%3A%2F%2Fcorto.www.wp.pl%2Fas%2Fbloogdo=
datki.html&sid=3D842
>>
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-inpu=
t" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.h=
tml
>>

--
Thanks, Richie Ward
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
