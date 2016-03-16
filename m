From: Julien Chauveau <chauveau.julien@gmail.com>
Subject: Re: [PATCH v2] Documentation: devicetree: Clean up gpio-keys example
Date: Wed, 16 Mar 2016 22:55:53 +0100
Message-ID: <F1BB73D3-C592-4476-91A9-0529B51C2156@gmail.com>
References: <1458129209-15449-1-git-send-email-afaerber@suse.de> <CABxcv=kSax5=5mOWT7ktavFQHvdp=sxZNcJaqc=nRQN-DejnVA@mail.gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 9.2 \(3112\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CABxcv=kSax5=5mOWT7ktavFQHvdp=sxZNcJaqc=nRQN-DejnVA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Javier Martinez Canillas <javier@dowhile0.org>
Cc: =?utf-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>, linux-input@vger.kernel.org, Heiko Stuebner <heiko@sntech.de>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Linux Kernel <linux-kernel@vger.kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>
List-Id: linux-input@vger.kernel.org


> Le 16 mars 2016 =C3=A0 15:47, Javier Martinez Canillas <javier@dowhil=
e0.org> a =C3=A9crit :
>=20
> Hello Andreas,
>=20
> On Wed, Mar 16, 2016 at 8:53 AM, Andreas F=C3=A4rber <afaerber@suse.d=
e> wrote:
>> Drop #address-cells and #size-cells, which are not required by the
>> gpio-keys binding documentation, as button sub-nodes are not devices=
=2E
>>=20
>> Rename sub-nodes to avoid new dtc unit address warnings when copied.
>>=20
>> While at it, adopt the dashes convention for the node name.
>>=20
>> Reported-by: Julien Chauveau <chauveau.julien@gmail.com>
>> Cc: Julien Chauveau <chauveau.julien@gmail.com>
>> Cc: Javier Martinez Canillas <javier@dowhile0.org>
>> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
>> Signed-off-by: Andreas F=C3=A4rber <afaerber@suse.de>
>> ---
>=20
> Patch looks good to me.
>=20
> Reviewed-by: Javier Martinez Canillas <javier@osg.samsung.com>

I agree.

Reviewed-by: Julien Chauveau <chauveau.julien@gmail.com>
