From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 1/1] Input: ab8500-ponkey: Make the distinction between
 DT and non-DT boots
Date: Mon, 6 Aug 2012 16:37:52 +0100
Message-ID: <20120806153750.GI10524@gmail.com>
References: <1344256323-10484-1-git-send-email-lee.jones@linaro.org>
 <20120806081915.GA4518@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ee0-f46.google.com ([74.125.83.46]:53146 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755546Ab2HFPh6 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 6 Aug 2012 11:37:58 -0400
Received: by eeil10 with SMTP id l10so890396eei.19
        for <linux-input@vger.kernel.org>; Mon, 06 Aug 2012 08:37:57 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20120806081915.GA4518@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, STEricsson_nomadik_linux@list.st.com, linus.walleij@stericsson.com, arnd@arndb.de, linux-input@vger.kernel.org

On Mon, Aug 06, 2012 at 01:19:15AM -0700, Dmitry Torokhov wrote:
> > -	ponkey->irq_dbf =3D ab8500_irq_get_virq(ab8500, irq_dbf);
> > -	ponkey->irq_dbr =3D ab8500_irq_get_virq(ab8500, irq_dbr);
> > +
> > +	ponkey->irq_dbf =3D (np) ? ab8500_irq_get_virq(ab8500, irq_dbf) :=
 irq_dbf;
> > +	ponkey->irq_dbr =3D (np) ? ab8500_irq_get_virq(ab8500, irq_dbr) :=
 irq_dbr;
>=20
> Why this isn't done inside ab8500_irq_get_virq()?

There's no reason why it can't be.

My first version of the patch did just that in fact.

Would that be your preference?

--=20
Lee Jones
Linaro ST-Ericsson Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
