From: cheng wei Lin <dusonlin@emc.com.tw>
Subject: Re: [PATCH v2] Input: add i2c/smbus driver for elan touchpad
Date: Sat, 26 Jul 2014 16:12:58 +0800
Message-ID: <4BE637D2-E28B-4344-B77A-6260566F7CF6@emc.com.tw>
References: <1389064083-11018-1-git-send-email-dusonlin@emc.com.tw> <20140724180516.GA26752@core.coreip.homeip.net> <73E9FA09-55D6-409D-A902-29CC3F414CBF@emc.com.tw> <20140725182053.GA23356@core.coreip.homeip.net> <20140725200656.GA2827@core.coreip.homeip.net>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=big5
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from elanic.emc.com.tw ([192.72.220.188]:43680 "EHLO
	elanic.emc.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750774AbaGZINP convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 26 Jul 2014 04:13:15 -0400
In-Reply-To: <20140725200656.GA2827@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, bleung@chromium.org, agnescheng@chromium.org, =?big5?B?IlNSRDEgJiM2NTUzMzvntr3uJiM2NTUzMzsmIzY1NTMzOz+zoyYj?= =?big5?B?NjU1MzM7JiM2NTUzMzsmIzY1NTMzOyYjNjU1MzM7Ig==?= <phoenix@emc.com.tw>, jeff.chuang@emc.com.tw

Hi Dmitry,

Yes, we intend to do this. Could you help to keep the original code, th=
ank you.

Duson=20


Dmitry Torokhov <dmitry.torokhov@gmail.com> =A9=F3 2014/7/26 =A4W=A4=C8=
4:06 =BCg=B9D=A1G

> On Fri, Jul 25, 2014 at 11:20:53AM -0700, Dmitry Torokhov wrote:
>> Hi Duson,
>>=20
>> On Sat, Jul 26, 2014 at 02:05:02AM +0800, cheng wei Lin wrote:
>>> Hi Dmitry,
>>>=20
>>> Sorry for late to reply you and thanks for your command
>>>=20
>>> Yes, I also agree, it looks great than my original code.
>>=20
>> Thank you for confirming.
>>=20
>>> So, should I modify this and upstream v3 patch for you?
>>=20
>> No, that is fine, I'll fix it up on my end.
>=20
> Hmm, I am also looking at elan_get_x_resolution() and in case of SMB
> we'll never get negative result since we are doing
> "elan_convert_res(val[1] & 0x0F)". Was it intended as such, or do we
> need to extend sign here via
>=20
> 	(((char)(val[1] & 0x0F)) << 4) >> 4;
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
