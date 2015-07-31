From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: ALPS DualPoint double click bug
Date: Fri, 31 Jul 2015 10:12:05 +0200
Message-ID: <55BB2DD5.9040907@redhat.com>
References: <CANuv8QxKap=K=OoCufcM-Yxujmg+3sUOjWX2D9r7qf==EQoTFQ@mail.gmail.com>
 <20150722072116.GA22138@pali>
 <CAN+gG=Eonx4Fh1HccsLdCL_ONNDXb-QgUvhMPM2B6nAaTVDFLQ@mail.gmail.com>
 <55B0B48D.7010603@redhat.com>
 <CANuv8Qy3FAL0-iWF3usbN2y2VmR4+Si7DqbqwW5aK0ppE8B60Q@mail.gmail.com>
 <55B65EEA.5080404@redhat.com>
 <CANuv8QwPQ1aLvZkC522vmm+_kv7r+f3rwvc=SmjVOvx5XbQUzw@mail.gmail.com>
 <55BA31F3.3070807@redhat.com> <20150730144643.GG26714@pali>
 <55BA3C28.3080506@redhat.com> <20150730154927.GA12448@pali>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:49056 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751503AbbGaIMI (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 31 Jul 2015 04:12:08 -0400
In-Reply-To: <20150730154927.GA12448@pali>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali.rohar@gmail.com>
Cc: Douglas Christman <douglaschristman@gmail.com>, Benjamin Tissoires <benjamin.tissoires@gmail.com>, linux-input <linux-input@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, cpaul@redhat.com

Hi,

On 30-07-15 17:49, Pali Roh=C3=A1r wrote:
> On Thursday 30 July 2015 17:00:56 Hans de Goede wrote:
>> Hi,
>>
>> On 30-07-15 16:46, Pali Roh=C3=A1r wrote:
>>> What about introducing new flag ALPS_<something> instead calling
>>> dmi_name_in_vendors() function every time when we need to process
>>> packet?
>>
>> That is a good idea. Douglas can you test the attached version
>> instead of the previous one please ?
>>
>> Thanks & Regards,
>>
>> Hans
>
>> @@ -251,9 +253,9 @@ static void alps_process_packet_v1_v2(struct psm=
ouse *psmouse)
>>   		return;
>>   	}
>>
>> -	/* Non interleaved V2 dualpoint has separate stick button bits */
>> +	/* Dell non interleaved V2 dualpoint has separate stick button bit=
s */
>>   	if (priv->proto_version =3D=3D ALPS_PROTO_V2 &&
>> -	    priv->flags =3D=3D (ALPS_PASS | ALPS_DUALPOINT)) {
>> +	    priv->flags =3D=3D (ALPS_DELL | ALPS_PASS | ALPS_DUALPOINT)) {
>
> Hi again. Now I'm trying to understand what this condition means and =
you
> probably wanted to write... priv->flags is field and so =3D=3D compar=
ator is
> hard to decode and understood.

The =3D=3D operator was already being used before this patch, and it do=
es the job
just fine IMHO.

Regards,

Hans


  Now it means that priv->flags must have
> set ALPS_DELL, ALPS_PASS and ALPS_DUALPOINT and must not set ALPS_WHE=
EL,
> ALPS_FW_BK_1, ALPS_FW_BK_2, ALPS_FOUR_BUTTONS, ALPS_PS2_INTERLEAVED,
> ALPS_BUTTONPAD and all other future flags! With future flags this cod=
e
> is fragile and can be easy broken in future (by introducing new flags=
).
> Because of "Non interleaved" in description you probably wanted
> something like this?
>
>   if (priv->proto_version =3D=3D ALPS_PROTO_V2 &&
>       (priv->flags & (ALPS_DELL | ALPS_PASS | ALPS_DUALPOINT)) &&
>       !(priv->flags & ALPS_PS2_INTERLEAVED))
>
> (flags must contains ALPS_DELL, ALPS_PASS, ALPS_DUALPOINT and must no=
t
> ALPS_PS2_INTERLEAVED)
>
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
