From: Mike Frysinger <vapier.adi@gmail.com>
Subject: Re: [Uclinux-dist-devel] [PATCH v3] input/misc: new ADXL345/346
	driver
Date: Wed, 21 Jul 2010 09:50:12 -0400
Message-ID: <AANLkTikI3ps5u30x235VOtQgAN0KdMGRNotKjLYSTpCc@mail.gmail.com>
References: <1255517680-30733-1-git-send-email-vapier@gentoo.org>
	<1256028039-15044-1-git-send-email-vapier@gentoo.org> <20100625071425.GA631@core.coreip.homeip.net>
	<544AC56F16B56944AEC3BD4E3D5917712E66DFEF69@LIMKCMBX1.ad.analog.com>
	<20100701075316.GA14696@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:38984 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753670Ab0GUNud convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 21 Jul 2010 09:50:33 -0400
Received: by gxk23 with SMTP id 23so3561381gxk.19
        for <linux-input@vger.kernel.org>; Wed, 21 Jul 2010 06:50:32 -0700 (PDT)
In-Reply-To: <20100701075316.GA14696@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: "Hennerich, Michael" <Michael.Hennerich@analog.com>, Luotao Fu <l.fu@pengutronix.de>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "uclinux-dist-devel@blackfin.uclinux.org" <uclinux-dist-devel@blackfin.uclinux.org>, Chris Verges <chrisv@cyberswitching.com>

On Thu, Jul 1, 2010 at 03:53, Dmitry Torokhov wrote:
> Input: adxl34 - make enable/disable separate from suspend/resume

this should be "adxl34x" i think to match the style we've used in the
past and the actual driver name

> -void adxl34x_enable(struct adxl34x *ac)
> +void adxl34x_resume(struct adxl34x *ac)
> =C2=A0{
> =C2=A0 =C2=A0 =C2=A0 =C2=A0mutex_lock(&ac->mutex);
> - =C2=A0 =C2=A0 =C2=A0 __adxl34x_enable(ac);
> +
> + =C2=A0 =C2=A0 =C2=A0 if (ac->suspended && !ac->disabled && ac->open=
ed)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 __adxl34x_enable(a=
c);
> +
> + =C2=A0 =C2=A0 =C2=A0 ac->suspended=3D false;

ERROR: spaces required around that '=3D' (ctx:VxW)
#191: FILE: drivers/input/misc/adxl34x.c:435:
+       ac->suspended=3D false;

> =C2=A0}
>
> -EXPORT_SYMBOL_GPL(adxl34x_enable);
> +EXPORT_SYMBOL_GPL(adxl34x_resume);

while you're here, might want to delete the newline after the brace to
avoid the checkpatch warning:
-mike
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
