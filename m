From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v2] input:Add clk api support for w90p910 touchscreen
Date: Wed, 8 Jul 2009 23:29:29 -0700
Message-ID: <20090709062929.GD14516@dtor-d630.eng.vmware.com>
References: <4A555B9E.8060508@gmail.com> <20090709051143.GA14516@dtor-d630.eng.vmware.com> <4A557CBC.3000507@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-px0-f193.google.com ([209.85.216.193]:34795 "EHLO
	mail-px0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751784AbZGIG3g (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 9 Jul 2009 02:29:36 -0400
Received: by pxi31 with SMTP id 31so321274pxi.33
        for <linux-input@vger.kernel.org>; Wed, 08 Jul 2009 23:29:34 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4A557CBC.3000507@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Wan ZongShun <mcuos.com@gmail.com>
Cc: linux-arm-kernel <linux-arm-kernel@lists.arm.linux.org.uk>, linux-input@vger.kernel.org, Trilok Soni <soni.trilok@gmail.com>

On Thu, Jul 09, 2009 at 01:14:36PM +0800, Wan ZongShun wrote:
> Dmitry Torokhov =E5=86=99=E9=81=93:
> > Hi Wan,
> >=20
> > On Thu, Jul 09, 2009 at 10:53:18AM +0800, Wan ZongShun wrote:
> >> @@ -311,6 +309,9 @@ static int __devexit w90x900ts_remove(struct p=
latform_device *pdev)
> >>  	del_timer_sync(&w90p910_ts->timer);
> >>  	iounmap(w90p910_ts->ts_reg);
> >> =20
> >> +	clk_disable(w90p910_ts->clk);
> >=20
> > This disable is unneeded since we already disable clock in close().=
 I
> > will fix locally and apply, there is no need to resubmit. I will al=
so
> > fix pxa27 driver.
>=20
> Okay, got it, thanks for your help!
>=20

Umm, one more thing - we need to add "depends on" to Kconfig since
clk API is not implemented on every platform. Any ideas what is the
most wide dependency is?

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
