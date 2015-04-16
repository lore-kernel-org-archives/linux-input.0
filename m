From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH -next] Input: zforce - remove duplicated include from
 zforce_ts.c
Date: Thu, 16 Apr 2015 13:37:45 -0700
Message-ID: <20150416203745.GA21887@dtor-ws>
References: <1429189899-24255-1-git-send-email-weiyj_lk@163.com>
 <1841566.UX5WXlFsPC@diego>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ig0-f180.google.com ([209.85.213.180]:36882 "EHLO
	mail-ig0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753827AbbDPUhy (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 16 Apr 2015 16:37:54 -0400
Received: by igblo3 with SMTP id lo3so61571848igb.0
        for <linux-input@vger.kernel.org>; Thu, 16 Apr 2015 13:37:50 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1841566.UX5WXlFsPC@diego>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Heiko =?iso-8859-1?Q?St=FCbner?= <heiko.stuebner@bq.com>
Cc: weiyj_lk@163.com, Henrik Rydberg <rydberg@bitmath.org>, Jingoo Han <jg1.han@samsung.com>, Wei Yongjun <yongjun_wei@trendmicro.com.cn>, linux-input@vger.kernel.org

On Thu, Apr 16, 2015 at 03:44:16PM +0200, Heiko St=FCbner wrote:
> Am Donnerstag, 16. April 2015, 21:11:39 schrieb weiyj_lk@163.com:
> > From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
> >=20
> > Remove duplicated include.
> >=20
> > Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
>=20
> Thanks for finding this
>=20
> Reviewed-by: Heiko Stuebner <heiko.stuebner@bq.com>

Applied, thank you.

>=20
>=20
> Heiko
>=20
> > ---
> >  drivers/input/touchscreen/zforce_ts.c | 1 -
> >  1 file changed, 1 deletion(-)
> >=20
> > diff --git a/drivers/input/touchscreen/zforce_ts.c
> > b/drivers/input/touchscreen/zforce_ts.c index 19880c7..f58a196 1006=
44
> > --- a/drivers/input/touchscreen/zforce_ts.c
> > +++ b/drivers/input/touchscreen/zforce_ts.c
> > @@ -30,7 +30,6 @@
> >  #include <linux/input/mt.h>
> >  #include <linux/platform_data/zforce_ts.h>
> >  #include <linux/regulator/consumer.h>
> > -#include <linux/delay.h>
> >  #include <linux/of.h>
> >  #include <linux/of_gpio.h>
>=20

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
