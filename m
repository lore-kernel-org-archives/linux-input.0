From: Artem Bityutskiy <dedekind1@gmail.com>
Subject: RE: [PATCH 4/4] input: dynamically allocate ABS information
Date: Wed, 21 Jul 2010 13:42:48 +0300
Message-ID: <1279708968.2306.11.camel@localhost>
References: <1274289757-2723-1-git-send-email-daniel@caiaq.de>
	 <1274289757-2723-5-git-send-email-daniel@caiaq.de>
	 <20100524160805.GO30801@buzzloop.caiaq.de>
	 <20100524161527.GC3182@core.coreip.homeip.net>
	 <20100616083903.GU17833@buzzloop.caiaq.de>
	 <20100721083048.GA21558@core.coreip.homeip.net>
	 <20100721083150.GB21558@core.coreip.homeip.net>
	 ,<20100721083216.GC21558@core.coreip.homeip.net>
	 <702744BC498BAE41B3AA631D95EC463058B3CFD798@NOK-EUMSG-01.mgdnok.nokia.com>
Reply-To: dedekind1@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:46098 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751005Ab0GUKt7 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 21 Jul 2010 06:49:59 -0400
In-Reply-To: <702744BC498BAE41B3AA631D95EC463058B3CFD798@NOK-EUMSG-01.mgdnok.nokia.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: ext-phil.2.carmody@nokia.com
Cc: dmitry.torokhov@gmail.com, daniel@caiaq.de, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

On Wed, 2010-07-21 at 11:22 +0200, ext-phil.2.carmody@nokia.com wrote:
> A tiny tiny nit...
>=20
> From: Dmitry Torokhov [dmitry.torokhov@gmail.com]
> ...
> +void input_alloc_absinfo(struct input_dev *dev)
> +{
> +       if (!dev->absinfo)
> +               dev->absinfo =3D kcalloc(ABS_CNT, sizeof(struct input=
_absinfo),
> +                                       GFP_KERNEL);
> +
> +       WARN(!dev->absinfo, "%s(): kzalloc() failed?\n", __func__);
>=20
> kcalloc failed, not kzalloc.

kmalloc and friends already print a warning with a stack dump when they
fail, unless this is overrided with __GFP_NOWARN, which is not the case
here. So in usually we do not print messages/warnigns when we fail to
allocate.

--=20
Best Regards,
Artem Bityutskiy (=D0=90=D1=80=D1=82=D1=91=D0=BC =D0=91=D0=B8=D1=82=D1=8E=
=D1=86=D0=BA=D0=B8=D0=B9)

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
