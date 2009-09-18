From: Xiangfu Liu <xiangfu.z@gmail.com>
Subject: =?UTF-8?B?W8KwXSBbwqhdIFvigqxdICB0aHJlZSBjaGFyYWN0ZXJzIGluIGtleWI=?=
 =?UTF-8?B?b2FyZC4g?=
Date: Fri, 18 Sep 2009 13:07:41 +0800
Message-ID: <4AB3159D.6050404@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yx0-f199.google.com ([209.85.210.199]:47792 "EHLO
	mail-yx0-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751154AbZIRFHr (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 18 Sep 2009 01:07:47 -0400
Received: by yxe37 with SMTP id 37so572690yxe.33
        for <linux-input@vger.kernel.org>; Thu, 17 Sep 2009 22:07:50 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Hi
  I want make those three characters work in keyboard.
I=E3=80=80change the defkeymap.map like[1].=20
but it's not work. Since I am a Chinese. never use the
euro keyboard. give me some tips.


thanks.

[1]=20

part of defkeymap.map:
keycode  30 =3D a
        altgr   keycode  30 =3D F100
keycode  31 =3D s
        altgr   keycode  31 =3D F101
keycode  32 =3D d
        altgr   keycode  32 =3D F102
=2E..
string F100 =3D "=C2=B0"
string F101 =3D "=C2=A8"
string F102 =3D "=E2=82=AC"


--=20
Xiangfu Liu
Email: xiangfu at qi-hardware dot com
Web: http://www.qi-hardware.com
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
