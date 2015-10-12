From: Bastien Nocera <hadess@hadess.net>
Subject: Re: [PATCH RFC V2 1/3] Input: goodix - add dt axis swapping and
 axis inversion support
Date: Mon, 12 Oct 2015 15:10:29 +0200
Message-ID: <1444655429.28661.85.camel@hadess.net>
References: <1444413352-24529-1-git-send-email-merker@debian.org>
	 <1444413352-24529-2-git-send-email-merker@debian.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1444413352-24529-2-git-send-email-merker@debian.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Karsten Merker <merker@debian.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Irina Tirdea <irina.tirdea@intel.com>, Aleksei Mamlin <mamlinav@gmail.com>, linux-input@vger.kernel.org, Ian Campbell <ijc+devicetree@hellion.org.uk>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Chen-Yu Tsai <wens@csie.org>
List-Id: linux-input@vger.kernel.org

On Fri, 2015-10-09 at 19:55 +0200, Karsten Merker wrote:
> Implement support for the following device-tree properties
> in the goodix touchscreen driver:
>=20
> =C2=A0- touchscreen-inverted-x:=C2=A0=C2=A0X axis is inverted (boolea=
n)
> =C2=A0- touchscreen-inverted-y:=C2=A0=C2=A0Y axis is inverted (boolea=
n)
> =C2=A0- touchscreen-swapped-x-y: X and Y axis are swapped (boolean)
>=20
> These are necessary on tablets which have a display in portrait
> format while the touchscreen is in landscape format, such as e.g.
> the MSI Primo 81.
>=20
> Signed-off-by: Karsten Merker <merker@debian.org>

Acked-by: Bastien Nocera <hadess@hadess.net>
