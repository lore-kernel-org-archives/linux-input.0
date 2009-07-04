From: guo jerry <mimi0213kimo@gmail.com>
Subject: Re: X window don't read my input device automatically
Date: Sun, 5 Jul 2009 01:12:29 +0800
Message-ID: <e715744d0907041012x293b656eue405eac4a4fc438c@mail.gmail.com>
References: <e715744d0906181955h646e5941y4d54056b1ea4d27e@mail.gmail.com>
	 <20090630023139.GA10652@dtor-d630.eng.vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-px0-f190.google.com ([209.85.216.190]:45984 "EHLO
	mail-px0-f190.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750702AbZGDRM0 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sat, 4 Jul 2009 13:12:26 -0400
Received: by pxi28 with SMTP id 28so2744033pxi.33
        for <linux-input@vger.kernel.org>; Sat, 04 Jul 2009 10:12:30 -0700 (PDT)
In-Reply-To: <20090630023139.GA10652@dtor-d630.eng.vmware.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org

thanks for your corrections :)

2009/6/30 Dmitry Torokhov <dmitry.torokhov@gmail.com>:
> On Fri, Jun 19, 2009 at 10:55:20AM +0800, guo jerry wrote:
>> Hi all,
>> =A0=A0=A0=A0=A0=A0=A0 I have written my multi-touch panel device dri=
ver and register
>> two input devices.
>> =A0=A0=A0=A0=A0=A0=A0 they appear in /dev/input/event7 & /dev/input/=
event8. The
>> problem is that why
>> =A0=A0=A0=A0=A0=A0=A0 X window can read other mouse devices automati=
cally and work under X
>> =A0=A0=A0=A0=A0=A0=A0 environment but the device driver written by m=
y own cannot.
>> =A0=A0=A0=A0=A0=A0=A0 I guess that if the evbit and keybit which I s=
et is not correctly.
>> =A0=A0=A0=A0=A0=A0=A0 I set my evbit & keybit as following:
>>
>> =A0=A0=A0=A0=A0=A0=A0 input->evbit[0] =3D BIT_MASK(EV_KEY) || BIT_MA=
SK(EV_ABS);
>
> I don't think you want 'logical or' here but rather a bitwise one.
>
> --
> Dmitry
>
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
