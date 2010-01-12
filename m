From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH] Support for Acer T230H multitouch panel
Date: Tue, 12 Jan 2010 15:45:40 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1001121545040.30977@pobox.suse.cz>
References: <20100110195805.D573F951DC@smtp.lii-enac.fr> <A97BB4B1-3D8D-4F90-BC97-675CABA950AB@enac.fr>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:36840 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753424Ab0ALOpl (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 12 Jan 2010 09:45:41 -0500
In-Reply-To: <A97BB4B1-3D8D-4F90-BC97-675CABA950AB@enac.fr>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?ISO-8859-15?Q?St=E9phane_Chatty?= <chatty@enac.fr>
Cc: linux-input@vger.kernel.org, cedric <berthiec@gmail.com>, jerom3@free.fr, Dmitry Torokhov <dmitry.torokhov@gmail.com>

On Mon, 11 Jan 2010, St=E9phane Chatty wrote:

> > Added support for the Acer T230H multitouch panel.
>=20
> I just found out that the touch panel in the T230H, built by Quanta, =
is also
> in some HP displays. Same VendorID/ProductID. I'm wondering, now: sho=
uld we
> rename the driver?

Well, vendor ID 0x0408 seems to be officially owned by Quanta Computer,=
=20
Inc.

So probably this should be reflected in the driver name.

Thanks,

--=20
Jiri Kosina
SUSE Labs, Novell Inc.
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
