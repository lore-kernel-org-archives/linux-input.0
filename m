From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v2] Documentation: devicetree: Clean up gpio-keys example
Date: Thu, 31 Mar 2016 13:09:39 -0700
Message-ID: <20160331200939.GM39098@dtor-ws>
References: <1458129209-15449-1-git-send-email-afaerber@suse.de>
 <CABxcv=kSax5=5mOWT7ktavFQHvdp=sxZNcJaqc=nRQN-DejnVA@mail.gmail.com>
 <F1BB73D3-C592-4476-91A9-0529B51C2156@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f175.google.com ([209.85.192.175]:34335 "EHLO
	mail-pf0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752826AbcCaUJo (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 31 Mar 2016 16:09:44 -0400
Content-Disposition: inline
In-Reply-To: <F1BB73D3-C592-4476-91A9-0529B51C2156@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Julien Chauveau <chauveau.julien@gmail.com>
Cc: Javier Martinez Canillas <javier@dowhile0.org>, Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>, linux-input@vger.kernel.org, Heiko Stuebner <heiko@sntech.de>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Linux Kernel <linux-kernel@vger.kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>

On Wed, Mar 16, 2016 at 10:55:53PM +0100, Julien Chauveau wrote:
>=20
> > Le 16 mars 2016 =E0 15:47, Javier Martinez Canillas <javier@dowhile=
0.org> a =E9crit :
> >=20
> > Hello Andreas,
> >=20
> > On Wed, Mar 16, 2016 at 8:53 AM, Andreas F=E4rber <afaerber@suse.de=
> wrote:
> >> Drop #address-cells and #size-cells, which are not required by the
> >> gpio-keys binding documentation, as button sub-nodes are not devic=
es.
> >>=20
> >> Rename sub-nodes to avoid new dtc unit address warnings when copie=
d.
> >>=20
> >> While at it, adopt the dashes convention for the node name.
> >>=20
> >> Reported-by: Julien Chauveau <chauveau.julien@gmail.com>
> >> Cc: Julien Chauveau <chauveau.julien@gmail.com>
> >> Cc: Javier Martinez Canillas <javier@dowhile0.org>
> >> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> >> Signed-off-by: Andreas F=E4rber <afaerber@suse.de>
> >> ---
> >=20
> > Patch looks good to me.
> >=20
> > Reviewed-by: Javier Martinez Canillas <javier@osg.samsung.com>
>=20
> I agree.
>=20
> Reviewed-by: Julien Chauveau <chauveau.julien@gmail.com>

Applied, thank you.

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
