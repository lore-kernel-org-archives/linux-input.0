From: Xiangfu Liu <xiangfu.z@gmail.com>
Subject: Re: =?UTF-8?B?W8KwXSBbwqhdIFvigqxdICB0aHJlZSBjaGFyYWN0ZXJzIGluIGs=?=
 =?UTF-8?B?ZXlib2FyZC4=?=
Date: Fri, 18 Sep 2009 15:11:52 +0800
Message-ID: <4AB332B8.9080908@gmail.com>
References: <4AB3159D.6050404@gmail.com> <20090918061752.GF18668@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pz0-f179.google.com ([209.85.222.179]:57526 "EHLO
	mail-pz0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750950AbZIRHLz (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 18 Sep 2009 03:11:55 -0400
Received: by pzk9 with SMTP id 9so13171pzk.33
        for <linux-input@vger.kernel.org>; Fri, 18 Sep 2009 00:11:58 -0700 (PDT)
In-Reply-To: <20090918061752.GF18668@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org

Dmitry Torokhov wrote:
> On Fri, Sep 18, 2009 at 01:07:41PM +0800, Xiangfu Liu wrote:
>> Hi
>>   I want make those three characters work in keyboard.
>> I=E3=80=80change the defkeymap.map like[1].=20
>> but it's not work. Since I am a Chinese. never use the
>> euro keyboard. give me some tips.
>>
>>
>> thanks.
>>
>> [1]=20
>>
>> part of defkeymap.map:
>> keycode  30 =3D a
>>         altgr   keycode  30 =3D F100
>> keycode  31 =3D s
>>         altgr   keycode  31 =3D F101
>> keycode  32 =3D d
>>         altgr   keycode  32 =3D F102
>> ...
>=20
> Use unicode notation:
>=20
> altgr   keycode  30 =3D U+nnnn
>=20
> where nnnn is UTF-8 code.
>=20
it's work now. the value is form [1]
a:=E2=82=AC
s:=C2=A8
d:=C2=B0 =20

 keycode  30 =3D a
+       altgr   keycode  30 =3D U+00B0
 keycode  31 =3D s              =20
+       altgr   keycode  31 =3D U+00A8
 keycode  32 =3D d
+       altgr   keycode  32 =3D U+20AC

[1] http://slayeroffice.com/tools/unicode_lookup/

Best Regards
--=20
Xiangfu Liu
Email: xiangfu at qi-hardware dot com
Web: http://www.qi-hardware.com
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
