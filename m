From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 06/18] Input: zforce - simplify function return logic
Date: Fri, 2 Oct 2015 11:15:31 -0700
Message-ID: <20151002181531.GK8437@dtor-ws>
References: <1443793229-22363-1-git-send-email-javier@osg.samsung.com>
 <1443793229-22363-7-git-send-email-javier@osg.samsung.com>
 <9921230.rYIRnnZOQ1@diego>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f47.google.com ([209.85.220.47]:34758 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751919AbbJBSPe (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 2 Oct 2015 14:15:34 -0400
Content-Disposition: inline
In-Reply-To: <9921230.rYIRnnZOQ1@diego>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Heiko =?iso-8859-1?Q?St=FCbner?= <heiko.stuebner@bq.com>
Cc: Javier Martinez Canillas <javier@osg.samsung.com>, linux-kernel@vger.kernel.org, Jingoo Han <jg1.han@samsung.com>, Dirk Behme <dirk.behme@de.bosch.com>, Wei Yongjun <yongjun_wei@trendmicro.com.cn>, linux-input@vger.kernel.org

On Fri, Oct 02, 2015 at 03:54:51PM +0200, Heiko St=FCbner wrote:
> Am Freitag, 2. Oktober 2015, 15:40:17 schrieb Javier Martinez Canilla=
s:
> > The invoked function already returns zero on success or a negative
> > errno code so there is no need to open code the logic in the caller=
=2E
> >=20
> > This also fixes the following make coccicheck warning:
> >=20
> > end returns can be simplified and declaration on line 602 can be dr=
opped
> >=20
> > Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
>=20
> I wonder what let me make that decision ... probably copy'n'paste fro=
m my auo-
> pixcir driver ... but how that got into this one is still a mystery t=
o me ;-)
> anyway
>=20
> Reviewed-by: Heiko Stuebner <heiko.stuebner@bq.com>

Applied, thank you.

>=20
>=20
> > ---
> >=20
> >  drivers/input/touchscreen/zforce_ts.c | 7 +------
> >  1 file changed, 1 insertion(+), 6 deletions(-)
> >=20
> > diff --git a/drivers/input/touchscreen/zforce_ts.c
> > b/drivers/input/touchscreen/zforce_ts.c index 781d0f83050a..9bbadaa=
f6bc3
> > 100644
> > --- a/drivers/input/touchscreen/zforce_ts.c
> > +++ b/drivers/input/touchscreen/zforce_ts.c
> > @@ -599,13 +599,8 @@ static irqreturn_t zforce_irq_thread(int irq, =
void
> > *dev_id) static int zforce_input_open(struct input_dev *dev)
> >  {
> >  	struct zforce_ts *ts =3D input_get_drvdata(dev);
> > -	int ret;
> >=20
> > -	ret =3D zforce_start(ts);
> > -	if (ret)
> > -		return ret;
> > -
> > -	return 0;
> > +	return zforce_start(ts);
> >  }
> >=20
> >  static void zforce_input_close(struct input_dev *dev)
>=20

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
