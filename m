From: Eric =?ISO-8859-1?B?QuluYXJk?= <eric@eukrea.com>
Subject: Re: [PATCHv9][ 3/3] ARM: dts: cpuimx35 Add touchscreen support.
Date: Thu, 21 Nov 2013 09:05:28 +0100
Message-ID: <20131121090528.41af72bd@e6520eb>
References: <1383916659-9988-1-git-send-email-denis@eukrea.com>
	<1383916659-9988-3-git-send-email-denis@eukrea.com>
	<20131121050922.GF18477@ns203013.ovh.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtpfb1-g21.free.fr ([212.27.42.9]:44283 "EHLO
	smtpfb1-g21.free.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751627Ab3KUIGd convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 21 Nov 2013 03:06:33 -0500
In-Reply-To: <20131121050922.GF18477@ns203013.ovh.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Cc: Denis Carikli <denis@eukrea.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-fbdev@vger.kernel.org, Shawn Guo <shawn.guo@linaro.org>, Sascha Hauer <kernel@pengutronix.de>, devicetree@vger.kernel.org, Rob Herring <rob.herring@calxeda.com>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Stephen Warren <swarren@wwwdotorg.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Grant Likely <grant.likely@linaro.org>, linux-arm-kernel@lists.infradead.org, Lothar Wa??mann <LW@KARO-electronics.de>

Le Thu, 21 Nov 2013 06:09:22 +0100,
Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com> a =E9crit :
> > +	tsc2007: tsc2007@48 {
> > +		compatible =3D "ti,tsc2007";
> > +		reg =3D <0x48>;
> > +		interrupt-parent =3D <&gpio3>;
> > +		interrupts =3D <0x2 0x8>;
> > +		gpios =3D <&gpio3 2 1>;
> as explain on the binding drop this gpios this is an IRQ not a gpio
>=20
> NACK
>=20
please read the tsc2007's code, in the patch there is :

+static int tsc2007_get_pendown_state_dt(struct tsc2007 *ts)
+{
+       return !gpio_get_value(ts->gpio);
+}
+

http://www.mail-archive.com/linux-input@vger.kernel.org/msg06765.html

Eric
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
