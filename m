From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 2/4] s3c24xx_ts: report touch only when stylus is down
Date: Sun, 21 Feb 2010 02:28:07 -0800
Message-ID: <20100221102807.GE18298@core.coreip.homeip.net>
References: <1266510750-9846-1-git-send-email-anarsoul@gmail.com>
 <201002211105.30079.anarsoul@gmail.com>
 <20100221094151.GC18298@core.coreip.homeip.net>
 <201002211210.12306.anarsoul@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yx0-f193.google.com ([209.85.210.193]:37711 "EHLO
	mail-yx0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755029Ab0BUK2M (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 21 Feb 2010 05:28:12 -0500
Received: by yxe31 with SMTP id 31so316836yxe.21
        for <linux-input@vger.kernel.org>; Sun, 21 Feb 2010 02:28:11 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <201002211210.12306.anarsoul@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Vasily Khoruzhick <anarsoul@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, ben-linux@fluff.org, linux-input@vger.kernel.org

On Sun, Feb 21, 2010 at 12:10:08PM +0200, Vasily Khoruzhick wrote:
> =D0=92 =D1=81=D0=BE=D0=BE=D0=B1=D1=89=D0=B5=D0=BD=D0=B8=D0=B8 =D0=BE=D1=
=82 21 =D1=84=D0=B5=D0=B2=D1=80=D0=B0=D0=BB=D1=8F 2010 11:41:51 =D0=B0=D0=
=B2=D1=82=D0=BE=D1=80 Dmitry Torokhov =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=
=B0=D0=BB:
> > > Timer is used to avoid reporting input events in interrupt contex=
t
> > > (select callback is called from s3c_adc_try and from s3c_adc_irq)=
,
> > ??? This is quite a novel concept for me...
>=20
> I think so, as I don't see any other reasons to use timer :)
>=20
> > > Anyway, driver
> > > doesn't work for me with this patch (it works as mouse, but it do=
esn't as
> > > touchscreen through tslib)
> >=20
> > Hmm, does evtest utility report all expected events?
>=20
> evtest shows that driver starts event flood on first touch, i.e. it d=
oesn't=20
> stop to emit event when stylus is up.
>=20

While flooding does it report BTN_TOUCH as up or down? I might have mes=
sed
s3c24xx_ts_check_pen_down()...

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
