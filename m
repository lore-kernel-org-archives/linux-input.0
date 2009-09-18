From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: =?utf-8?B?W8KwXSBbwqhdIFvigqw=?=
	=?utf-8?Q?=5D?=  three characters in keyboard.
Date: Thu, 17 Sep 2009 23:17:53 -0700
Message-ID: <20090918061752.GF18668@core.coreip.homeip.net>
References: <4AB3159D.6050404@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yx0-f199.google.com ([209.85.210.199]:59433 "EHLO
	mail-yx0-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750950AbZIRGRx (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 18 Sep 2009 02:17:53 -0400
Received: by yxe37 with SMTP id 37so610881yxe.33
        for <linux-input@vger.kernel.org>; Thu, 17 Sep 2009 23:17:57 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4AB3159D.6050404@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Xiangfu Liu <xiangfu.z@gmail.com>
Cc: linux-input@vger.kernel.org

On Fri, Sep 18, 2009 at 01:07:41PM +0800, Xiangfu Liu wrote:
> Hi
>   I want make those three characters work in keyboard.
> I=E3=80=80change the defkeymap.map like[1].=20
> but it's not work. Since I am a Chinese. never use the
> euro keyboard. give me some tips.
>=20
>=20
> thanks.
>=20
> [1]=20
>=20
> part of defkeymap.map:
> keycode  30 =3D a
>         altgr   keycode  30 =3D F100
> keycode  31 =3D s
>         altgr   keycode  31 =3D F101
> keycode  32 =3D d
>         altgr   keycode  32 =3D F102
> ...

Use unicode notation:

altgr   keycode  30 =3D U+nnnn

where nnnn is UTF-8 code.

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
