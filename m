From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [Uclinux-dist-devel] [PATCH v2] Input: ad7879: split bus logic
 out
Date: Tue, 19 Jan 2010 00:51:57 -0800
Message-ID: <20100119085156.GE19338@core.coreip.homeip.net>
References: <1263742686-22305-1-git-send-email-vapier@gentoo.org>
 <1263876764-6464-1-git-send-email-vapier@gentoo.org>
 <20100119082652.GA19338@core.coreip.homeip.net>
 <8bd0f97a1001190046jcb51d1bs6275ef317b43739@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-px0-f182.google.com ([209.85.216.182]:46665 "EHLO
	mail-px0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754968Ab0ASIwC (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 19 Jan 2010 03:52:02 -0500
Received: by pxi12 with SMTP id 12so4315133pxi.33
        for <linux-input@vger.kernel.org>; Tue, 19 Jan 2010 00:52:02 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <8bd0f97a1001190046jcb51d1bs6275ef317b43739@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mike Frysinger <vapier.adi@gmail.com>
Cc: uclinux-dist-devel@blackfin.uclinux.org, Michael Hennerich <michael.hennerich@analog.com>, linux-input@vger.kernel.org

On Tue, Jan 19, 2010 at 03:46:20AM -0500, Mike Frysinger wrote:
> On Tue, Jan 19, 2010 at 03:26, Dmitry Torokhov wrote:
> > On Mon, Jan 18, 2010 at 11:52:44PM -0500, Mike Frysinger wrote:
> >> =A0struct ad7879 {
> >> - =A0 =A0 bus_device =A0 =A0 =A0 =A0 =A0 =A0 =A0*bus;
> >> + =A0 =A0 struct ad7879_bus_ops =A0 bops;
> >
> > Could you change it to 'const struct ad7879_bus_ops *bops;' and add=
 a
> > separate pointer to private transport data so that bus ops are trul=
y
> > shared between instances (if any).
>=20
> i can make the struct containing only the funcs const, but not the
> struct that contains the irq/client since i dynamically assign the
> contents in the probe func

Maybe it should be 2 structs? One for the ops and one opaque to the
ad7879 core containing transport-private data?

>=20
> > Also I dont see the reason for having the following typedefs:
>=20
> it made sense in the other drivers i copied this format from, and in
> an earlier version of the code, but they arent needed anymore, so i'l=
l
> drop em
>=20
> >> +typedef int (ad7879_read_t) (void *bus_data, u8 reg);
> >> +typedef int (ad7879_multi_read_t) (void *bus_data, u8 first_reg, =
u8 count, u16 *buf);
> >> +typedef int (ad7879_write_t) (void *bus_data, u8 reg, u16 val);
> >> +
> >> +struct ad7879_bus_ops {
> >> + =A0 =A0 void *bus_data;
> >> + =A0 =A0 int irq;
> >> + =A0 =A0 ad7879_read_t *read;
> >> + =A0 =A0 ad7879_multi_read_t *multi_read;
> >> + =A0 =A0 ad7879_write_t *write;
> >> +};
> >> +
> >> +int ad7879_disable(struct device *dev);
> >> +int ad7879_enable(struct device *dev);
> >> +int ad7879_probe(struct device *dev, struct ad7879_bus_ops *bops,=
 u8 devid, u16 bustype);
> >> +int ad7879_remove(struct device *dev);
> >
> > Hmm, I liked when these accepted "struct ad7879" better.
>=20
> i toyed with that a bit, but the generated code was worse because the
> drvdata helpers are externals

Hm, it would only make overall difference when you have both transports
loaded, right? Oh well, I don't really have strong preference either
way.

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
