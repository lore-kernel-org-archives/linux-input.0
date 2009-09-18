From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: make the CtrlR and CtrlL modifier output different keys
Date: Thu, 17 Sep 2009 23:10:17 -0700
Message-ID: <20090918061017.GE18668@core.coreip.homeip.net>
References: <4AB316ED.80005@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yx0-f199.google.com ([209.85.210.199]:33494 "EHLO
	mail-yx0-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756287AbZIRGKS (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 18 Sep 2009 02:10:18 -0400
Received: by yxe37 with SMTP id 37so606971yxe.33
        for <linux-input@vger.kernel.org>; Thu, 17 Sep 2009 23:10:22 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4AB316ED.80005@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Xiangfu Liu <xiangfu.z@gmail.com>
Cc: linux-input@vger.kernel.org

On Fri, Sep 18, 2009 at 01:13:17PM +0800, Xiangfu Liu wrote:
> Hi.
>=20
> I want make the CtrlR and CtrlL output different keys.
> like:
>=20
> CtrlR + U =3D 7
> CtrlR + U =3D Control + U.
>=20
> so I=E3=80=80modify the keyboard.c code. attach is the code.
>=20
> give me some feedback about this patch.
> thanks.

You should be able to do what you want by loading proper keymap; no nee=
d
to adjust the keyboard code (especially in a way that does not make
sense for other devices).

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
