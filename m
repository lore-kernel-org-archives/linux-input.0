From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 4/4] Input: auo_pixcir_ts - add devicetree support
Date: Mon, 25 Feb 2013 23:05:30 -0800
Message-ID: <20130226070530.GC18407@core.coreip.homeip.net>
References: <201302231255.23772.heiko@sntech.de>
 <201302241058.01412.heiko@sntech.de>
 <20130225030641.GA18433@core.coreip.homeip.net>
 <201302251447.18385.heiko@sntech.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f51.google.com ([209.85.220.51]:46566 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756077Ab3BZHFc (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 26 Feb 2013 02:05:32 -0500
Received: by mail-pa0-f51.google.com with SMTP id hz1so2250703pad.38
        for <linux-input@vger.kernel.org>; Mon, 25 Feb 2013 23:05:32 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <201302251447.18385.heiko@sntech.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Heiko =?iso-8859-1?Q?St=FCbner?= <heiko@sntech.de>
Cc: Grant Likely <grant.likely@secretlab.ca>, Rob Herring <rob.herring@calxeda.com>, linux-input@vger.kernel.org, devicetree-discuss@lists.ozlabs.org

On Mon, Feb 25, 2013 at 02:47:17PM +0100, Heiko St=FCbner wrote:
> Am Montag, 25. Februar 2013, 04:06:41 schrieb Dmitry Torokhov:
> > On Sun, Feb 24, 2013 at 10:58:00AM +0100, Heiko St=FCbner wrote:
> > > Hi Dmitry,
> > >=20
> > > Am Sonntag, 24. Februar 2013, 09:00:15 schrieb Dmitry Torokhov:
> > > > Hi Heiko,
> > > >=20
> > > > On Sat, Feb 23, 2013 at 12:58:16PM +0100, Heiko St=FCbner wrote=
:
> > > > > +static struct auo_pixcir_ts_platdata *auo_pixcir_parse_dt(st=
ruct
> > > > > device *dev) +{
> > > > > +	struct auo_pixcir_ts_platdata *pdata =3D NULL;
> > > > > +
> > > > > +#ifdef CONFIG_OF
> > > > > +	struct device_node *np =3D dev->of_node;
> > > > > +
> > > > > +	if (!np)
> > > > > +		return NULL;
> > > > > +
> > > > > +	pdata =3D devm_kzalloc(dev, sizeof(*pdata), GFP_KERNEL);
> > > > > +	if (!pdata) {
> > > > > +		dev_err(dev, "failed to allocate platform data\n");
> > > > > +		return NULL;
> > > > > +	}
> > > >=20
> > > > I disike #ifdefs in the middle of the code, also it would be ni=
ce if we
> > > > signal the proper error instead of always using -EINVAL when th=
ere are
> > > > issues with platform/DT data.
> > > >=20
> > > > How about the version of the patch below?
> > >=20
> > > I tested it and everything of course still works :-) .
> >=20
> > OK, great, then I will queue these for the next merge window.
> >=20
> > Could you also try this patch (it however needs attached patch enha=
ncing
> > devres to support custom actions).
> >=20
> > Thanks.
>=20
> In general looks really nice and also works. I have some small nitpic=
ks (patch=20
> desc, reset gpio naming) and it will also need to use=20
> devm_request_threaded_irq to get the irq correctly freed on removal. =
[all also=20
> marked at the corresponding places below]
>=20
> Otherwise:
>=20
> Tested-by: Heiko Stuebner <heiko@sntech.de>

Thank you Heiko, I made the changes you mentioned and queued with the
rest of the patches for 3.10.

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
