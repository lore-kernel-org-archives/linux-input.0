From: Boszormenyi Zoltan <zboszor@pr.hu>
Subject: Re: [PATCH] Add support for the egalax serial touchscreen driver
Date: Tue, 15 Dec 2015 20:18:59 +0100
Message-ID: <567067A3.8080905@pr.hu>
References: <1450178672-26885-1-git-send-email-zboszormenyi@sicom.com>
 <20151215200630.0a8b5479@heffalump.sk2.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail9.pr.hu ([87.242.0.9]:50499 "EHLO mail9.pr.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751259AbbLOTTK (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 15 Dec 2015 14:19:10 -0500
In-Reply-To: <20151215200630.0a8b5479@heffalump.sk2.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Stephen Kitt <steve@sk2.org>, =?UTF-8?B?QsO2c3rDtnJtw6lueWkgWm9sdMOhbg==?= <zboszormenyi@sicom.com>
Cc: Vojtech Pavlik <vojtech@suse.com>, linuxconsole-dev@lists.sourceforge.net, linux-input@vger.kernel.org

Hi,

2015-12-15 20:06 keltez=C3=A9ssel, Stephen Kitt =C3=ADrta:
> Hi,
>
> Thanks for submitting this. I have just a couple of questions...
>
> On Tue, 15 Dec 2015 12:24:32 +0100, B=C3=B6sz=C3=B6rm=C3=A9nyi Zolt=C3=
=A1n
> <zboszormenyi@sicom.com> wrote:
>> +static int egalax_init(int fd, unsigned long *id, unsigned long *ex=
tra) {
>> +	unsigned char packet_alive_query[3] =3D { 0x0a, 0x01, 'A' };
>> +	unsigned char packet_fw_ver[3] =3D { 0x0a, 0x01, 'D' };
>> +	unsigned char packet_ctrl_type[3] =3D { 0x0a, 0x01, 'E' };
>> +	unsigned char response[128];
>> +
>> +	if (check_egalax_response(fd, packet_alive_query, sizeof(packet_al=
ive_query), response))
>> +		return -1;
>> +
>> +	if (check_egalax_response(fd, packet_fw_ver, sizeof(packet_fw_ver)=
, response))
>> +		return -1;
>> +
>> +	response[(unsigned char)response[1] + 2] =3D '\0';
>> +	printf("EETI eGalaxTouch firmware: %s\n", &response[3]);
> inputattach is generally silent when everything goes well. I can see =
how this
> kind of info would be useful though; would you mind simply commenting=
 the
> printf() lines out, and I'll add a verbose mode later on?

Sure, I'll put it under #ifdef 0.

>
>> +
>> +	if (check_egalax_response(fd, packet_ctrl_type, sizeof(packet_ctrl=
_type), response))
>> +		return -1;
>> +
>> +	response[(unsigned char)response[1] + 2] =3D '\0';
>> +	printf("EETI eGalaxTouch controller type: %s\n", &response[3]);
> As above.
>
>> +#ifdef SERIO_HAMPSHIRE
>> +{ "--hampshire",   "-ham",         "Hampshire touchscreen",
>> +	B9600, CS8,
>> +	SERIO_HAMPSHIRE,	0x00,   0x00,   0,  NULL },
>> +#endif
> Is this intentional? If so, could you mention it in the commit messag=
e?

Yes, it is intentional. I noticed that the SERIO_HAMPSHIRE support
is also missing from inputattach. I don't currently know if the
Hampshire touchscreen needs an init function or not, so it is a
placeholder at the moment. Also, the SERIO_HAMPSHIRE value is
smaller than SERIO_PS2MULT which is unconditionally enabled,
so maybe it doesn't need the #ifdef SERIO_HAMPSHIRE ... #endif
cover at all. I will mention it in the commit message for the v2 patch,
which I will send tomorrow.

Best regards,
Zolt=C3=A1n B=C3=B6sz=C3=B6rm=C3=A9nyi

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
