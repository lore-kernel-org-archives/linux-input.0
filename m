From: Lothar =?UTF-8?B?V2HDn21hbm4=?= <LW@KARO-electronics.de>
Subject: Re: [PATCHv4 2/5] Input: edt-ft5x06: Add DT support
Date: Thu, 20 Mar 2014 13:05:49 +0100
Message-ID: <20140320130549.3bc2925e@ipc1.ka-ro>
References: <1395234563-11034-1-git-send-email-LW@KARO-electronics.de>
	<1395234563-11034-3-git-send-email-LW@KARO-electronics.de>
	<20140320093719.GB14420@e106331-lin.cambridge.arm.com>
	<20140320124055.53d469e7@ipc1.ka-ro>
	<532AD571.9000907@kernelconcepts.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <532AD571.9000907@kernelconcepts.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Simon Budig <simon.budig@kernelconcepts.de>
Cc: Mark Rutland <mark.rutland@arm.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Fugang Duan <B38611@freescale.com>, "grant.likely@linaro.org" <grant.likely@linaro.org>, Henrik Rydberg <rydberg@euromail.se>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Jingoo Han <jg1.han@samsung.com>, Kumar Gala <galak@codeaurora.org>, Pawel Moll <Pawel.Moll@arm.com>, Rob Herring <robh+dt@kernel.org>, Rob Landley <rob@landley.net>, Sachin Kamat <sachin.kamat@linaro.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

Hi,

Simon Budig wrote:
> On 20/03/14 12:40, Lothar Wa=C3=9Fmann wrote:
> > The FT5x06 datasheet lists 3 variants for different panel sizes.
> > I'll add distinct compatible strings for those chips, though their =
SW
> > interface is (currently) identical:
> > |Required properties:
> > | - compatible:  "edt,edt-ft5206", "edt,edt-ft5x06"
> > |           or:  "edt,edt-ft5306", "edt,edt-ft5x06"
> > |           or:  "edt,edt-ft5406", "edt,edt-ft5x06"
>=20
> Please note that the M09 variants of the polytouch family will use th=
e
> same chips, but a different sw protocol (see Patch 5/5).
>=20
The firmware version can be detected by SW, thus there is no need to
distinguish it via DT.

> I don't know anything about the naming scheme used in the device tree=
,
> but I am not sure if the chip-ID is actually useful here.
>=20
Since the chip variants handle different panel sizes, it might be usefu=
l
to be able to distinguish them.


Lothar Wa=C3=9Fmann
--=20
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra=C3=9Fe 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch=C3=A4ftsf=C3=BChrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info@karo-electronics.de
___________________________________________________________
