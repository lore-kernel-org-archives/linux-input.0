From: Boszormenyi Zoltan <zboszor@pr.hu>
Subject: Re: [PATCH] Add eGalaxTouch serial touchscreen driver v3
Date: Wed, 16 Dec 2015 13:54:01 +0100
Message-ID: <56715EE9.9080303@pr.hu>
References: <1450269798-13928-1-git-send-email-zboszor@pr.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail9.pr.hu ([87.242.0.9]:53378 "EHLO mail9.pr.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932775AbbLPMyN (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 16 Dec 2015 07:54:13 -0500
In-Reply-To: <1450269798-13928-1-git-send-email-zboszor@pr.hu>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, =?UTF-8?B?QsO2c3rDtnJtw6lueWkgWm9sdMOhbg==?= <zboszormenyi@sicom.com>

2015-12-16 13:43 keltez=C3=A9ssel, Zolt=C3=A1n B=C3=B6sz=C3=B6rm=C3=A9n=
yi =C3=ADrta:
> Signed-off-by: B=EF=BF=BDsz=EF=BF=BDrm=EF=BF=BDnyi Zolt=EF=BF=BDn <zb=
oszor@pr.hu>

this

> + * Copyright (c) 2015 Zolt=EF=BF=BDn B=EF=BF=BDsz=EF=BF=BDrm=EF=BF=BD=
nyi <zboszor@pr.hu>

this

> +MODULE_AUTHOR("Zolt=EF=BF=BDn B=EF=BF=BDsz=EF=BF=BDrm=EF=BF=BDnyi <z=
boszor@pr.hu>");

and this were in Latin-2 after you sent the patch back to me, my patch
was UTF-8 in the beginning.

Can you run the code through "recode latin2..utf-8" before committing o=
r
should I resend to fix this?

Thanks,
Zolt=C3=A1n B=C3=B6sz=C3=B6rm=C3=A9nyi

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
