From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v2] input: gpio-beeper: Simplify GPIO handling
Date: Mon, 28 Apr 2014 20:22:32 -0700
Message-ID: <20140429032232.GC7672@core.coreip.homeip.net>
References: <1398491214-14936-1-git-send-email-shc_work@mail.ru>
 <20140429022104.GA7672@core.coreip.homeip.net>
 <1398740149.14014937@f348.i.mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pd0-f173.google.com ([209.85.192.173]:62881 "EHLO
	mail-pd0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751726AbaD2DWe (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 28 Apr 2014 23:22:34 -0400
Received: by mail-pd0-f173.google.com with SMTP id p10so6103890pdj.4
        for <linux-input@vger.kernel.org>; Mon, 28 Apr 2014 20:22:34 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1398740149.14014937@f348.i.mail.ru>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Alexander Shiyan <shc_work@mail.ru>
Cc: linux-input@vger.kernel.org

On Tue, Apr 29, 2014 at 06:55:49AM +0400, Alexander Shiyan wrote:
> Mon, 28 Apr 2014 19:21:04 -0700 =D0=BE=D1=82 Dmitry Torokhov <dmitry.=
torokhov@gmail.com>:
> > Hi Alexander,
> >=20
> > On Sat, Apr 26, 2014 at 09:46:54AM +0400, Alexander Shiyan wrote:
> > > +	beep->desc =3D devm_gpiod_get(&pdev->dev, NULL);
> > > +	if (!beep->desc)
> > > +		return -EINVAL;
> >=20
> > As far as I can see devm_gpiod_get() never returns NULL, but either=
 a
> > valid pointer or ERR_PTR-encoded error. Why do we check for NULL?
> >=20
> > I can drop the check myself, no need to resubmit.
>=20
> OK.
>=20
> ...
>=20
> One issue you keep value argument for gpio_beeper_toggle() as bool.
> It should be "int" as in original patch, as well as "beeping" value i=
n
> private struct.

Not really, value of gpio_set_value_cansleep() is a boolean, even thoug=
h
the type is int. I guess using 'int' is historical.  One can't really
set gpio value to let's say 5.=20

Thanks.

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
