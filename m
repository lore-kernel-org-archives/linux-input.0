From: =?utf-8?B?5buW5bSH5qau?= <kt.liao@emc.com.tw>
Subject: RE: [PATCH] Input: elan_i2c - +200 ms delay before setting to ABS mode
Date: Tue, 28 Jun 2016 09:41:13 +0800
Message-ID: <003401d1d0de$27b8e1c0$772aa540$@emc.com.tw>
References: <1465306449-28256-1-git-send-email-chiu@endlessm.com>	<20160620174251.GC22426@dtor-ws>	<008601d1cbba$124c2230$36e46690$@emc.com.tw> <CAD8Lp44NHiSfPjzYkPCm1jX1Jb2E071WY4_OdCpJv0H7ivEoSg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from emcscan.emc.com.tw ([192.72.220.5]:25745 "EHLO
	emcscan.emc.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751942AbcF1BlR convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 27 Jun 2016 21:41:17 -0400
In-Reply-To: <CAD8Lp44NHiSfPjzYkPCm1jX1Jb2E071WY4_OdCpJv0H7ivEoSg@mail.gmail.com>
Content-Language: zh-tw
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: 'Daniel Drake' <drake@endlessm.com>
Cc: 'Dmitry Torokhov' <dmitry.torokhov@gmail.com>, 'Chris Chiu' <chiu@endlessm.com>, 'Charlie Mooney' <charliemooney@chromium.org>, 'Michele Curti' <michele.curti@gmail.com>, 'Krzysztof Kozlowski' <k.kozlowski@samsung.com>, 'Benson Leung' <bleung@chromium.org>, linux-input@vger.kernel.org, 'Linux Kernel' <linux-kernel@vger.kernel.org>, 'Linux Upstreaming Team' <linux@endlessm.com>, =?utf-8?B?J+m7g+S4lum1rCDntpPnkIYn?= <phoenix@emc.com.tw>, 'jimmy_yang' <jimmy_yang@emc.com.tw>, 'Miller_Wang' <miller_wang@emc.com.tw>

Hi Daniel, Chris

-----Original Message-----
=46rom: Daniel Drake [mailto:drake@endlessm.com]=20
Sent: Tuesday, June 21, 2016 10:42 PM
To: =E5=BB=96=E5=B4=87=E6=A6=AE
Cc: Dmitry Torokhov; Chris Chiu; Charlie Mooney; Michele Curti; Krzyszt=
of Kozlowski; Benson Leung; linux-input@vger.kernel.org; Linux Kernel; =
Linux Upstreaming Team; =E9=BB=83=E4=B8=96=E9=B5=AC =E7=B6=93=E7=90=86
Subject: Re: [PATCH] Input: elan_i2c - +200 ms delay before setting to =
ABS mode

On Tue, Jun 21, 2016 at 6:40 AM, =E5=BB=96=E5=B4=87=E6=A6=AE <kt.liao@e=
mc.com.tw> wrote:
> KT, is this feasible?
> [KT] After internal discussion, we don't agree this patch.
>     It's a work-around to fix firmware bug for specific touchpad and=20
> not tested by other device.

=46or better or worse, Linux often takes on the responsibility of worki=
ng around firmware bugs. This is a real issue that affects multiple Asu=
s laptops; you'll have no touchpad input upon reboot from any OS that d=
rives the touchpad in "generic hid" mode (e.g. older version of Linux, =
some embedded OS, etc).

If the sleep is really that controversial, we could make it specific to=
 the ELAN1000 model that is the one in question here?

[KT] : I list all ASUS models with firmware issue which cause TP no fun=
ction in Endless OOB , please focuses on below types only
     Ic_type : 14
     Product_id : 0x14, 0x15, 0x16, 0x25, 0x18, 0x29, 0x2c, 0x31, 0x32,=
 0x35

	 You can add if branch in "__elan_initialize", something like that

	 if(data->ic_ytpe =3D=3D 14 &&=20
		(data->product_id =3D=3D 0x14 || data->product_id =3D=3D 0x15 || data=
->product_id =3D=3D 0x16 ||=20
		data->product_id =3D=3D 0x25 || data->product_id =3D=3D 0x18 || data-=
>product_id =3D=3D 0x29 ||=20
		data->product_id =3D=3D 0x2c || data->product_id =3D=3D 0x31 || data-=
>product_id =3D=3D 0x32 || data->product_id =3D=3D 0x35))
	 { //flow for Endless}
	 Else {//original flow}
    =20
   =20

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
