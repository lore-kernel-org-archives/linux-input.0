From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH] hid: fix bug destroying hidraw device files after
 parent
Date: Tue, 18 Mar 2014 00:42:00 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1403180041100.3690@pobox.suse.cz>
References: <1393401084.4876.2.camel@nexus> <alpine.LNX.2.00.1402261101540.5466@pobox.suse.cz> <53266890.1040504@lab.ntt.co.jp>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:50479 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751292AbaCQXmD (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 17 Mar 2014 19:42:03 -0400
In-Reply-To: <53266890.1040504@lab.ntt.co.jp>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?ISO-8859-15?Q?Fernando_Luis_V=E1zquez_Cao?= <fernando_b1@lab.ntt.co.jp>
Cc: linux-input@vger.kernel.org, linux-usb@vger.kernel.org, Nestor Lopez Casado <nlopezcasad@logitech.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Tejun Heo <tj@kernel.org>

On Mon, 17 Mar 2014, Fernando Luis V=C3=A1zquez Cao wrote:

> > I have slightly modified the patch title to make sure that it's obv=
ious
> > that what it fixes is actually a WARN_ON() splat.
>=20
> Thank you.
>=20
> Any chance we can get this to Linus before 3.14 comes out?
> According to Linus, rc7 may be the last rc.

It will be in Linus' 3.14 final -- it went in post-rc7.

Thanks for taking care,

--=20
Jiri Kosina
SUSE Labs
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
