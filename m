From: cheng wei Lin <dusonlin@emc.com.tw>
Subject: Re: [PATCH v2] Input: add i2c/smbus driver for elan touchpad
Date: Sat, 26 Jul 2014 02:05:02 +0800
Message-ID: <73E9FA09-55D6-409D-A902-29CC3F414CBF@emc.com.tw>
References: <1389064083-11018-1-git-send-email-dusonlin@emc.com.tw> <20140724180516.GA26752@core.coreip.homeip.net>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=big5
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from elanic.emc.com.tw ([192.72.220.188]:40379 "EHLO
	elanic.emc.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753079AbaGYSPE convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 25 Jul 2014 14:15:04 -0400
In-Reply-To: <20140724180516.GA26752@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, bleung@chromium.org, agnescheng@chromium.org, =?big5?B?IlNSRDEgJiM2NTUzMzvntr3uJiM2NTUzMzsmIzY1NTMzOz+zoyYj?= =?big5?B?NjU1MzM7JiM2NTUzMzsmIzY1NTMzOyYjNjU1MzM7Ig==?= <phoenix@emc.com.tw>, jeff.chuang@emc.com.tw

Hi Dmitry,

Sorry for late to reply you and thanks for your command

Yes, I also agree, it looks great than my original code.
So, should I modify this and upstream v3 patch for you?

thank you,
duson


Dmitry Torokhov <dmitry.torokhov@gmail.com> =A9=F3 2014/7/25 =A4W=A4=C8=
2:05 =BCg=B9D=A1G

> Hi,
>=20
> On Tue, Jan 07, 2014 at 11:08:03AM +0800, Duson Lin wrote:
>> +/*
>> + ******************************************************************
>> + * General functions
>> + ******************************************************************
>> + */
>> +/*
>> + * (value from firmware) * 10 + 790 =3D dpi
>> + * we also have to convert dpi to dots/mm (*10/254 to avoid floatin=
g point)
>> + */
>> +static unsigned int elan_convert_res(char val)
>> +{
>> +	int res;
>> +	if (val & 0x80) {
>> +		val =3D ~val + 1;
>> +		res =3D (790 - val * 10) * 10 / 254;
>> +	} else
>> +		res =3D (val * 10 + 790) * 10 / 254;
>> +	return res;
>> +}
>=20
> Why isn't this simply:
>=20
> 	res =3D ((int)val * 10 + 790) * 10 / 254;
>=20
> ?
>=20
> If high bit is 1 you basically do the 2 complement by hand to get to
> positive and then subtract. Which shoudl be the same as adding positi=
ve
> value.
>=20
> Thanks.
>=20
> --=20
> Dmitry
>=20

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
