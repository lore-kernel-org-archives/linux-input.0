From: Michal =?ISO-8859-1?Q?Mal=FD?= <madcatxster@devoid-pointer.net>
Subject: Re: [PATCH v4 00/24] input: Introduce ff-memless-next as an improved replacement for ff-memless
Date: Mon, 12 May 2014 11:26:21 +0200
Message-ID: <10531507.qTZk3SL8f1@sigyn>
References: <1398524543-15012-1-git-send-email-madcatxster@devoid-pointer.net> <alpine.LNX.2.00.1405121112520.5813@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from prifuk.cz ([31.31.77.140]:51804 "EHLO smtp.devoid-pointer.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750762AbaELJ0b convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 12 May 2014 05:26:31 -0400
In-Reply-To: <alpine.LNX.2.00.1405121112520.5813@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, dmitry.torokhov@gmail.com, elias.vds@gmail.com, anssi.hannula@iki.fi, simon@mungewell.org

On Monday 12 of May 2014 11:14:42 Jiri Kosina wrote:
> On Sat, 26 Apr 2014, Michal Mal=FD wrote:
> > ff-memless-next (MLNX) is a largely improved version of the current
> > ff-memless (FFML) driver. MLNX supports all force feedback effects
> > currently available in the Linux force feedback userspace API. All
> > effects are handled in accordance with Microsoft's DirectInput/XInp=
ut.
> > Most notable changes include support for conditional effects, prope=
r
> > handling of all periodic waveforms and improved emulation of rumble
> > effects through periodic effects. MLNX also uses its own kernel API=
 to
> > pass processed effects to hardware-specific drivers instead of abus=
ing
> > "ff_effect" struct. The API is documented in the respective header =
file.
> >=20
> > MLNX has been expanded to be a direct replacement for FFML.
> >=20
> > Support for FF_PERIODIC and FF_RAMP has been added to all devices t=
hat
> > support FF_CONSTANT as a part of the port to the new API.
> >=20
> > This patch series:
> > 1) Adds "ff-memless-next" module [1]
> > 2) Ports all hardware-specific drivers to MLNX's API [2-23]
> > 3) Removes FFML and replaces it with MLNX [24]
>=20
> Dmitry,
>=20
> what are your plans with this, please?
>=20
> I personally don't really completely like having two implementations =
of FF
> in the kernel; can't it be really done as an extension to ff-memless?

There will be no duplication. This patchset fully replaces "ff-memless"=
 with=20
"ff-memless-next". Even though "ff-memless-next" is basically an extend=
ed=20
version of "ff-memless", the extent of the changes makes it look very m=
uch like=20
a rewrite.

If you are concerned about any confusion due to the "ff-memless" -> "ff=
-memless-
next" name change I can modify the code to make it look like "ff-memles=
s" if=20
you think that'd be more appropriate. However, given the scope of the c=
hanges=20
I considered it a better idea to implement this as a new driver to make=
 it=20
clear that ff-memless-next behaves differently from the HW-specific dri=
vers'=20
perspective.

Michal
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
