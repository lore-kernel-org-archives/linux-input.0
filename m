From: Jean Delvare <jdelvare@suse.de>
Subject: Re: Dependencies in the HID subsystem
Date: Thu, 13 Jun 2013 09:11:46 +0200
Message-ID: <1371107506.4289.25.camel@chaos.site>
References: <1369855174.4306.198.camel@chaos.site>
	 <alpine.LNX.2.00.1305292245090.30576@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kbuild-owner@vger.kernel.org>
In-Reply-To: <alpine.LNX.2.00.1305292245090.30576@pobox.suse.cz>
Sender: linux-kbuild-owner@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Michal Marek <mmarek@suse.cz>, linux-input@vger.kernel.org, linux-kbuild <linux-kbuild@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

Hi Jiri,

Sorry for the late reply.

Le Wednesday 29 May 2013 =C3=A0 22:52 +0200, Jiri Kosina a =C3=A9crit :
> On Wed, 29 May 2013, Jean Delvare wrote:
>=20
> > I am worried and confused by some Kconfig dependencies in the HID
> > subsystem.
> >=20
> > There are 11 HID device drivers which are defined in drivers/hid/Kc=
onfig
> > with:
> >=20
> > 	tristate "..." if EXPERT
> > 	default !EXPERT
> >=20
> > Unless EXPERT is enabled (and that's not the default), these driver
> > entries are hidden and automatically selected. If CONFIG_HID=3Dm, t=
hey are
> > selected as modules. If CONFIG_HID=3Dy, they are built into the ker=
nel. So
> > it is impossible to have CONFIG_HID=3Dy and build these device driv=
ers as
> > modules - as device drivers typically are.
> >=20
> > I would like to understand the reasoning behind this complexity. Wh=
at is
> > so special about these 11 drivers, that we can't just let the (kern=
el
> > configuring) user chose if he/she wants them and in what form?
>=20
> That's quite a old story with some history behind. Linus himself=20
> originally requested it, then much later asked the same question you =
did.=20
> See some background here:
>=20
> 	https://lkml.org/lkml/2010/5/20/227

This explains it all, thank you.

>> (...)
> > Put in short, I don't like the way things are today and would welco=
me
> > changes in this area.
>=20
> As things have changed a lot since 2.6.28, we can try to put things m=
ore=20
> in line now for 3.11 or so.

This is great news. Will it just happen, or is some contribution
expected from me? That's not my area, but if you want me to write some
patches or test things, just ask and I'll do my best.

Thanks,
--=20
Jean Delvare
Suse L3

--
To unsubscribe from this list: send the line "unsubscribe linux-kbuild"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
