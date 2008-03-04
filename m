From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <syrjala@sci.fi>
Subject: Re: [PATCH] ati_remote2 autorepeat and loadable keymap support
Date: Tue, 4 Mar 2008 21:53:20 +0200
Message-ID: <20080304195320.GD531@sci.fi>
References: <200802161622.43223.linux@dadeos.co.uk> <20080304124715.GK8473@sci.fi> <Pine.LNX.4.64.0803041412240.18589@twin.jikos.cz> <20080304134751.GA531@sci.fi> <Pine.LNX.4.64.0803041457200.15209@jikos.suse.cz> <20080304184004.GC531@sci.fi> <Pine.LNX.4.64.0803041949560.15209@jikos.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp4.pp.htv.fi ([213.243.153.38]:44419 "EHLO smtp4.pp.htv.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751722AbYCDTxW (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 4 Mar 2008 14:53:22 -0500
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0803041949560.15209@jikos.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Peter Stokes <linux@dadeos.co.uk>, linux-input@vger.kernel.org, dmitry.torokhov@gmail.com

On Tue, Mar 04, 2008 at 07:50:56PM +0100, Jiri Kosina wrote:
> On Tue, 4 Mar 2008, Ville Syrj=E4l=E4 wrote:
>=20
> > I've attached the bzipped log.
>=20
> Thanks. So between these two events:
<snip>=20
> you got autorepeated Key.LeftBtn?

I'm not sure actually. I made a new log and tried to actually
read it this time :)

When I press the button I see this:
drivers/hid/hid-core.c: report (size 6) (numbered)
drivers/hid/hid-core.c: report 17 (size 5) =3D  01 00 00 00 00
hid-debug: input Button.0001 =3D 1
hid-debug: input Button.0002 =3D 0
hid-debug: input Button.0003 =3D 0
hid-debug: input Button.0004 =3D 0
hid-debug: input Button.0005 =3D 0
hid-debug: input GenericDesktop.X =3D 0
hid-debug: input GenericDesktop.Y =3D 0
hid-debug: input GenericDesktop.Wheel =3D 0
hid-debug: input Consumer.HorizontalWheel =3D 0

When I release the button I get this:
drivers/hid/hid-core.c: report (size 6) (numbered)
drivers/hid/hid-core.c: report 17 (size 5) =3D  00 00 00 00 00
hid-debug: input Button.0001 =3D 0
hid-debug: input Button.0002 =3D 0
hid-debug: input Button.0003 =3D 0
hid-debug: input Button.0004 =3D 0
hid-debug: input Button.0005 =3D 0
hid-debug: input GenericDesktop.X =3D 0
hid-debug: input GenericDesktop.Y =3D 0
hid-debug: input GenericDesktop.Wheel =3D 0
hid-debug: input Consumer.HorizontalWheel =3D 0

In between I only see this report 5 + report 21 sequence constantly
repeated. But that sequence is constantly repeated even when I don't
touch the mouse at all. It makes inspecting the log somewhat annoying
since the amount of data grows fast. To add insult to injury this devic=
e
seems to take part in radio warfare against my normal mouse :(

--=20
Ville Syrj=E4l=E4
syrjala@sci.fi
http://www.sci.fi/~syrjala/
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
