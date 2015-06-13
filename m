From: Roman Volkov <rvolkov@v1ros.org>
Subject: Re: [PATCH v3 5/5] i8042: Add i8042_dt.h glue for DT support
Date: Sat, 13 Jun 2015 20:57:35 +0300
Message-ID: <20150613205735.0df89c32@v1ron-s7>
References: <1423857173-16432-6-git-send-email-v1ron@v1ros.org>
	<1424034707-15723-1-git-send-email-v1ron@v1ros.org>
	<1424034707-15723-6-git-send-email-v1ron@v1ros.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from v1ros.org ([109.234.34.72]:33644 "EHLO smtp.v1ros.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750749AbbFMSAA convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 13 Jun 2015 14:00:00 -0400
In-Reply-To: <1424034707-15723-6-git-send-email-v1ron@v1ros.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Grant Likely <grant.likely@linaro.org>, Hans de Goede <hdegoede@redhat.com>, Jiri Kosina <jkosina@suse.cz>, Wolfram Sang <wsa@the-dreams.de>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, Tony Prisk <linux@prisktech.co.nz>, rvolkov@v1ros.org

Something prevents me from following the thread, replying to myself.

> =D0=92 Sat, 14 Mar 2015 20:20:38 -0700
> Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:
>  =20
> >=20
> > Hi Roman,
> >=20
> > On Mon, Feb 16, 2015 at 12:11:43AM +0300, Roman Volkov wrote:   =20
> > > Documentation for 'intel,8042' DT compatible node.
> > >=20
> > > Signed-off-by: Tony Prisk <linux@prisktech.co.nz>
> > > Signed-off-by: Roman Volkov <v1ron@v1ros.org>
> > > ---
> > >  .../devicetree/bindings/input/intel-8042.txt       | 26
> > > ++++++++++++++++++++++ 1 file changed, 26 insertions(+)
> > >  create mode 100644
> > > Documentation/devicetree/bindings/input/intel-8042.txt
> > >=20
> > > diff --git
> > > a/Documentation/devicetree/bindings/input/intel-8042.txt
> > > b/Documentation/devicetree/bindings/input/intel-8042.txt new file
> > > mode 100644 index 0000000..ab8a3e0 --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/input/intel-8042.txt
> > > @@ -0,0 +1,26 @@
> > > +Intel 8042 Keyboard Controller
> > > +
> > > +Required properties:
> > > +- compatible: should be "intel,8042"
> > > +- regs: memory for keyboard controller
> > > +- interrupts: usually, two interrupts should be specified
> > > (keyboard and aux).
> > > +	However, only one interrupt is also allowed in case of
> > > absence of the
> > > +	physical port in the controller. The i8042 driver must be
> > > loaded with
> > > +	nokbd/noaux option in this case.
> > > +- interrupt-names: interrupt names corresponding to numbers in
> > > the list.
> > > +	"kbd" is the keyboard interrupt and "aux" is the
> > > auxiliary (mouse)
> > > +	interrupt.
> > > +- command-reg: offset in memory for command register
> > > +- status-reg: offset in memory for status register
> > > +- data-reg: offset in memory for data register
> > > +
> > > +Example:
> > > +	i8042@d8008800 {
> > > +		compatible =3D "intel,8042";
> > > +		regs =3D <0xd8008800 0x100>;
> > > +		interrupts =3D <23>, <4>;
> > > +		interrupt-names =3D "kbd", "aux";
> > > +		command-reg =3D <0x04>;
> > > +		status-reg =3D <0x04>;
> > > +		data-reg =3D <0x00>;
> > > +	};   =20
> >=20
> > No, we already have existing OF bindings for i8042 on sparc and
> > powerpc, I do not think we need to invent a brand new one.
> >=20
> > Thanks.
> >=20

I have looked more into that header (i8042-sparcio.h). Probably 8042 is
broken for SPARCs, because there is the platform_driver registered twic=
e
with the same name "i8042". One driver is registered by
platform_create_bundle() from i8042.c and another from
platform_driver_register() from the i8042_sparcio.h. Kernel prints a
message "Error: Driver 'i8042' is already registered, aborting...".

I have not tested SPARC version of the kernel, just used the same code
for ARM, to rewrite my patch set.

There is no bindings at all for i8042, because a binding requires
the 'compatible' property to be defined, according to ePAPR. In the
SPARC header there is an ancient surrogate with searching by name
instead of the 'compatible' property (I understand, no standards were
defined for that hardware those days).

Regards,
Roman
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
