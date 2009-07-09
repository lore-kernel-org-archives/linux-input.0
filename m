From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v2] input:Add clk api support for w90p910 touchscreen
Date: Thu, 9 Jul 2009 01:54:36 -0700
Message-ID: <20090709085436.GE14516@dtor-d630.eng.vmware.com>
References: <4A555B9E.8060508@gmail.com> <20090709051143.GA14516@dtor-d630.eng.vmware.com> <4A557CBC.3000507@gmail.com> <20090709062929.GD14516@dtor-d630.eng.vmware.com> <20090709073703.GA1785@jasper.tkos.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.230]:64665 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751596AbZGIIym (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 9 Jul 2009 04:54:42 -0400
Received: by rv-out-0506.google.com with SMTP id f6so2968rvb.1
        for <linux-input@vger.kernel.org>; Thu, 09 Jul 2009 01:54:41 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20090709073703.GA1785@jasper.tkos.co.il>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Baruch Siach <baruch@tkos.co.il>
Cc: Wan ZongShun <mcuos.com@gmail.com>, linux-arm-kernel <linux-arm-kernel@lists.arm.linux.org.uk>, linux-input@vger.kernel.org, Trilok Soni <soni.trilok@gmail.com>

On Thu, Jul 09, 2009 at 10:37:03AM +0300, Baruch Siach wrote:
> Hi Dmitry,
>=20
> On Wed, Jul 08, 2009 at 11:29:29PM -0700, Dmitry Torokhov wrote:
> > On Thu, Jul 09, 2009 at 01:14:36PM +0800, Wan ZongShun wrote:
> > > Dmitry Torokhov =E5=86=99=E9=81=93:
> > > > Hi Wan,
> > > >=20
> > > > On Thu, Jul 09, 2009 at 10:53:18AM +0800, Wan ZongShun wrote:
> > > >> @@ -311,6 +309,9 @@ static int __devexit w90x900ts_remove(stru=
ct platform_device *pdev)
> > > >>  	del_timer_sync(&w90p910_ts->timer);
> > > >>  	iounmap(w90p910_ts->ts_reg);
> > > >> =20
> > > >> +	clk_disable(w90p910_ts->clk);
> > > >=20
> > > > This disable is unneeded since we already disable clock in clos=
e(). I
> > > > will fix locally and apply, there is no need to resubmit. I wil=
l also
> > > > fix pxa27 driver.
> > >=20
> > > Okay, got it, thanks for your help!
> > >=20
> >=20
> > Umm, one more thing - we need to add "depends on" to Kconfig since
> > clk API is not implemented on every platform. Any ideas what is the
> > most wide dependency is?
>=20
> The most wide dependency for the clk API is HAVE_CLK.
>=20

Cool, thanks.

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
