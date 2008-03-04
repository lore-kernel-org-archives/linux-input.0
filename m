From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <syrjala@sci.fi>
Subject: Re: [PATCH] ati_remote2 autorepeat and loadable keymap support
Date: Tue, 4 Mar 2008 23:21:05 +0200
Message-ID: <20080304212105.GG531@sci.fi>
References: <20080304124715.GK8473@sci.fi> <Pine.LNX.4.64.0803041412240.18589@twin.jikos.cz> <20080304134751.GA531@sci.fi> <Pine.LNX.4.64.0803041457200.15209@jikos.suse.cz> <20080304184004.GC531@sci.fi> <Pine.LNX.4.64.0803041949560.15209@jikos.suse.cz> <20080304195320.GD531@sci.fi> <Pine.LNX.4.64.0803042126360.15209@jikos.suse.cz> <20080304203212.GE531@sci.fi> <Pine.LNX.4.64.0803042138050.15209@jikos.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp4.pp.htv.fi ([213.243.153.38]:49410 "EHLO smtp4.pp.htv.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762000AbYCDVVH (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 4 Mar 2008 16:21:07 -0500
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0803042138050.15209@jikos.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Peter Stokes <linux@dadeos.co.uk>, linux-input@vger.kernel.org, dmitry.torokhov@gmail.com

On Tue, Mar 04, 2008 at 09:42:22PM +0100, Jiri Kosina wrote:
> On Tue, 4 Mar 2008, Ville Syrj=E4l=E4 wrote:
>=20
> > > Actually, this is the very same issue we discussed with respect t=
o=20
> > > ati_remote2 changes ... this device has Keyboard usages as well a=
s=20
> > > Mouse/Pointer. As we set the EV_REP (because of the Keyboard usag=
e),=20
> > > this inputdevice-wide flag applies also to the mouse button event=
s and=20
> > > they get repeated.
> > Except this device does actually register two input devices since t=
he
> > endpoints for the keyboard and mouse are separate, and here it even
> > makes sense since they are physically separate devices.
>=20
> Yes, but unfortunately both interfaces contain Keyboard usage in thei=
r=20
> report descriptor -- please see the debug output you sent me. The fir=
st=20
> interface's descriptor states to send Keyboard usages in Field(1) of =
INPUT=20
> report, the second one presents it in Field(1) of INPUT[1] report.
>=20
> I guess that one of the report descriptors contains redundant informa=
tion,=20
> not both interfaces are actually sending Keyboard/Consumer/etc events=
,=20
> right?

I suppose not. HID is more or less gibberish to me but at least I haven=
't
seen any extra keyboard events from the mouse or anything like that. Th=
e
mouse has just two buttons and a vertical wheel. The keyboard has the n=
ormal
keys, volume and playback control keys and some 10 extra keys like slee=
p,
mail, web etc. It also has an f-lock key which I suppose has something =
to
do with the fact that they've re-labeled the function keys with some
web/email/whatever texts and the F<number> is printed on the side
of the key.

I've used the device so little that I honestly didn't even notice that
the mouse claims to support pretty much every kind of event there is.
Maybe they were just lazy when making this device and didn't want to th=
ink
about the actual features of the device and instead just added every
possible thing to the descriptors.

--=20
Ville Syrj=E4l=E4
syrjala@sci.fi
http://www.sci.fi/~syrjala/
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
