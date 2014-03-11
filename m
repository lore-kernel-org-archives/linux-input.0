From: Lee Jones <lee.jones@linaro.org>
Subject: Re: Qualcomm PMIC8xxx keypad never worked?
Date: Tue, 11 Mar 2014 13:35:42 +0000
Message-ID: <20140311133542.GO21216@lee--X1>
References: <5887114.1jrNo21sGX@wuerfel>
 <20140311120056.GH21216@lee--X1>
 <8206209.oc1V5pPVYT@wuerfel>
 <20140311130609.GL21216@lee--X1>
 <20140311132013.GO18529@joshc.qualcomm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wg0-f52.google.com ([74.125.82.52]:53870 "EHLO
	mail-wg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752056AbaCKNfs (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 11 Mar 2014 09:35:48 -0400
Received: by mail-wg0-f52.google.com with SMTP id k14so10216142wgh.35
        for <linux-input@vger.kernel.org>; Tue, 11 Mar 2014 06:35:47 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20140311132013.GO18529@joshc.qualcomm.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Josh Cartwright <joshc@codeaurora.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Trilok Soni <tsoni@codeaurora.org>, Samuel Ortiz <sameo@linux.intel.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Stephen Boyd <sboyd@codeaurora.org>, linux-kernel@vger.kernel.org, Anirudh Ghayal <aghayal@codeaurora.org>, linux-input@vger.kernel.org, linux-arm-kernel@lists.infradead.org

> > > > > Something in the MFD_PM8XXX driver must have changed recently=
 that now allows
> > > > > the KEYBOARD_PMIC8XXX driver to be enabled. Unfortunately, it=
 does not build
> > > > > because of a dependency on the <linux/mfd/pm8xxx/gpio.h> head=
er file that
> > > > > does not exist.
> >=20
> > I think it's this commit that's causing your error:
> >=20
> >   https://lkml.org/lkml/2013/12/10/903
> >=20
> > ... but the MFD isn't broken, so I guess your solution is the most
> > elegant. If it's not fixed soon, I guess we should think about ripp=
ing
> > it out. It's obvoious that no-one cares, as it's been broken for
> > nearly 3 years.
>=20
> Stephen has a pending patchset to cleanup and actually make the pm8xx=
x
> input drivers work, but they have not been picked up yet:
>=20
> http://lkml.kernel.org/r/1393958088-1456-1-git-send-email-sboyd@codea=
urora.org

Ideal. Thanks for letting us know.

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
